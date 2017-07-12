/*
A NAT implementation for Emu.

Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using KiwiSystem;

using EmuUtil;

namespace Emu.Nat
{
  public class NAT : Transceiver
  {
#if !KIWI
    public static ulong
#else
    const ulong
#endif
      nf0Mac = 0x665544332212uL, // 12:22:33:44:55:66
      nf1Mac = 0x665544332222uL, // 22:22:33:44:55:66
      nf2Mac = 0x665544332232uL, // 32:22:33:44:55:66
      nf3Mac = 0x665544332242uL, // 42:22:33:44:55:66
      nf0NextHopMac = 0xf6e5d4c3b2a2uL, // a2:b2:c3:d4:e5:f6
      nf1NextHopMac = 0xf6e5d4c3b2b2uL, // b2:b2:c3:d4:e5:f6
      nf2NextHopMac = 0xf6e5d4c3b2c2uL, // c2:b2:c3:d4:e5:f6
      nf3NextHopMac = 0xf6e5d4c3b2d2uL; // d2:b2:c3:d4:e5:f6

#if !KIWI
    public static uint
#else
    const uint
#endif
      myInsideIP = (192u << 0) | (168u << 8) | (1u << 16) | (1u << 24), // 192.168.1.1
      myOutsideIP = (10u << 0) | (0u << 8) | (0u << 16) | (1u << 24); // 10.0.0.1

    const byte outsidePort = 0x01; // 00000001 - nf0 is outside
    const byte insidePorts = 0x54; // 01010100 - nf3, nf2, nf1 are inside

    public static ushort nextPort = 1025;
    const uint ENTRY_COUNT = 16;
    static uint nextEntry = 0;

    static PortConnectionEntry entry = new PortConnectionEntry(ENTRY_COUNT);

    static uint pkt_size;

    [Kiwi.HardwareEntryPoint()]
    public static void EntryPoint()
    {
      // Have to instantiate the wrappers outside of the loop for Kiwi
      var eth = new EthernetWrapper(dataplane.tdata);
      var ip = new IPv4Wrapper(dataplane.tdata);
      var tcp = new TCPWrapper(dataplane.tdata);
      var arp = new ARPWrapper(dataplane.tdata);

      Kiwi.Pause();

      while (true)
      {
        pkt_size = ReceiveFrame();

        Kiwi.Pause();

        DebugPrintData();

#if !KIWI
        eth = new EthernetWrapper(dataplane.tdata);
        ip = new IPv4Wrapper(dataplane.tdata);
        tcp = new TCPWrapper(dataplane.tdata);
        arp = new ARPWrapper(dataplane.tdata);
#endif

        Kiwi.Pause();

        if (eth.Ethertype == EthernetWrapper.EtherType.IPv4)
        {
          switch (ip.Protocol)
          {
            case IPv4Wrapper.IPProtocol.TCP:
              // Handle the TCP packet
              tcp.Offset = ip.PayloadOffset;
              tcp.Length = ip.PayloadLength;
              Kiwi.Pause();
              TCP(eth, ip, tcp);
              break;
            case IPv4Wrapper.IPProtocol.UDP:
              break;
            case IPv4Wrapper.IPProtocol.ICMP:
              break;
            default:
#if DEBUG
              Console.WriteLine("<><><>> Unknown protocol {0:X}", (byte)ip.Protocol);
#endif
              break;
          }
        }
        else if (eth.Ethertype == EthernetWrapper.EtherType.ARP)
        {
          if (arp.Operation == ARPWrapper.Op.Request
            && arp.HardwareType == ARPWrapper.HwType.Ethernet
            && arp.ProtocolType == (ushort)EthernetWrapper.EtherType.IPv4
            && arp.HardwareAddressLength == 6
            && arp.ProtocolAddressLength == 4)
          {
            Kiwi.Pause(); // Reduces Kiwi compile time
            if (arp.TargetProtocolAddress == myInsideIP || arp.TargetProtocolAddress == myOutsideIP) // Request for a MAC I own
            {
              Kiwi.Pause();

              uint intfIp = arp.TargetProtocolAddress;
              ulong intfMac = macOfIntf(dataplane.GetReceiveIntf());

              // Update arp packet to use as response
              arp.Operation = ARPWrapper.Op.Reply;
              Kiwi.Pause();
              arp.TargetHardwareAddress = arp.SenderHardwareAddress;
              Kiwi.Pause();
              arp.TargetProtocolAddress = arp.SenderProtocolAddress;
              Kiwi.Pause();
              arp.SenderHardwareAddress = intfMac;
              Kiwi.Pause();
              arp.SenderProtocolAddress = intfIp;
              Kiwi.Pause();

              // Update ethernet fields
              eth.DestinationMac = arp.TargetHardwareAddress;
              Kiwi.Pause();
              eth.SourceMac = intfMac;

              Kiwi.Pause();

              // Send reply
              SetSendIntf(dataplane.GetReceiveIntf());
              SendFrame(pkt_size);
            }
          }
        }
        Kiwi.Pause();
      }
    }

    static void TCP(EthernetWrapper eth, IPv4Wrapper ip, TCPWrapper tcp)
    {
#if DEBUG
      Console.WriteLine("<><><>> TCP packet rcx. startByte {0:x}; length {1:X}", tcp.Offset, tcp.Length);

      Console.WriteLine("<><><>> Address d: {0:X} {1:X} {2:X}", eth.DestinationMac, ip.DestinationAddress, tcp.DestinationPort);
      Console.WriteLine("<><><>> Address s: {0:X} {1:X} {2:X}", eth.SourceMac, ip.SourceAddress, tcp.SourcePort);
      Console.WriteLine("<><><>> dataOffset8 {0:X}; payloadOffset8 {1:X}, payloadLength8 {2:X}", tcp.DataOffset * 4, tcp.PayloadOffset, tcp.PayloadLength);
      Kiwi.Pause();
#endif

      // Get which intf the packet arrived on
      byte incoming = dataplane.GetReceiveIntf();
      bool isOutsideIntf = IsOutsideIntf(incoming) && ip.DestinationAddress == myOutsideIP;
      bool isInsideIntf = IsInsideIntf(incoming);
#if DEBUG
      Console.WriteLine("<><><>> incoming {0:x}  isOutsideIntf {1}  isInsideIntf {2}", incoming, isOutsideIntf, isInsideIntf);
#endif
      Kiwi.Pause();

      if (isInsideIntf || isOutsideIntf)
      {
        // Find a matching entry if one exists
        bool found = LookupTcp(eth, ip, tcp, isOutsideIntf);

        // Track incremental updates to the checksum as we change data
        int ipChecksum = ~ip.HeaderChecksum & 0xFFFF;
        int tcpChecksum = ~tcp.Checksum & 0xFFFF;
#if DEBUG
        Console.WriteLine("<><><>> 169 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif

        Kiwi.Pause();

        if (isInsideIntf) // Packet going from inside to outside
        {
#if DEBUG
          Console.WriteLine("<><><>> Packet outbound");
#endif
          // If the packet is outbound and there is no existing entry, create one if it's a Syn packet
          if (!found && tcp.HasFlag(TCPWrapper.Flag.Syn))
          {
#if DEBUG
            Console.WriteLine("<><><>> Syn");
#endif
            // 'Allocate' new entry
            entry.Load(nextEntry); // FIXME find an unallocated index

            // Increment nextEntry pointer
            nextEntry++;
            if (nextEntry >= ENTRY_COUNT) // FIXME wrap :S
              nextEntry = 0;
            Kiwi.Pause();

            // Save details //FIXME save MACs?
            entry.SourceIPAddress = ip.SourceAddress;
            Kiwi.Pause();
            entry.DestinationIPAddress = ip.DestinationAddress;
            Kiwi.Pause();
            entry.SourcePort = tcp.SourcePort;
            Kiwi.Pause();
            entry.DestinationPort = tcp.DestinationPort;
            Kiwi.Pause();
            entry.MasqueradePort = BitUtil.SwitchEndianness(nextPort++);
            Kiwi.Pause();
            entry.InsideIntf = dataplane.GetReceiveIntf();
            Kiwi.Pause();
            entry.OutsideIntf = NAT.outsidePort; // NOTE this also marks it as allocated
            Kiwi.Pause();
            entry.Save();
            Kiwi.Pause();
            found = true;
#if DEBUG
            Console.WriteLine("<><><>> New entry allocated");
#endif
          }

          Kiwi.Pause();

          if (found)
          {
#if DEBUG
            Console.WriteLine("<><><>> Changing packet fields");
            Console.WriteLine("<><><>> entry d: {0:X} {1:X}", entry.DestinationIPAddress, entry.DestinationPort);
            Console.WriteLine("<><><>> entry s: {0:X} {1:X}", entry.SourceIPAddress, entry.SourcePort);
            Console.WriteLine("<><><>> entry i: {0:X} {1:X}", entry.InsideIntf, entry.OutsideIntf);
            Console.WriteLine("<><><>> entry m: {0:X}", entry.MasqueradePort);
#endif
            // Change destination MAC
            eth.DestinationMac = nextHopMacOfIntf(entry.OutsideIntf);
            Kiwi.Pause();
            // Change source MAC
            eth.SourceMac = macOfIntf(entry.OutsideIntf);
            Kiwi.Pause();

            // Change source IP address
#if DEBUG
            Console.WriteLine("<><><>> 226 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif
            ip.SourceAddress = BitUtil.ChangeValueInChecksum(ip.SourceAddress, myOutsideIP, ref ipChecksum, ref tcpChecksum); // FIXME not particularly elegant
            Kiwi.Pause();
#if DEBUG
            Console.WriteLine("<><><>> 230 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif

            // Change source TCP port
#if DEBUG
            Console.WriteLine("<><><>> 235 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif
            tcp.SourcePort = BitUtil.ChangeValueInChecksum(tcp.SourcePort, entry.MasqueradePort, ref tcpChecksum);
            Kiwi.Pause();
#if DEBUG
            Console.WriteLine("<><><>> 239 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif

            // Forward on correct intf
            SetSendIntf(entry.OutsideIntf);
            Kiwi.Pause();
          }
        }
        else if (found) // isOutsideIntf // Packet going from outside to inside
        {
#if DEBUG
          Console.WriteLine("<><><>> Packet inbound");
          Console.WriteLine("<><><>> Changing packet fields");
          Console.WriteLine("<><><>> entry d: {0:X} {1:X}", entry.DestinationIPAddress, entry.DestinationPort);
          Console.WriteLine("<><><>> entry s: {0:X} {1:X}", entry.SourceIPAddress, entry.SourcePort);
          Console.WriteLine("<><><>> entry i: {0:X} {1:X}", entry.InsideIntf, entry.OutsideIntf);
          Console.WriteLine("<><><>> entry m: {0:X}", entry.MasqueradePort);
#endif
          // Change destination MAC
          eth.DestinationMac = nextHopMacOfIntf(entry.InsideIntf);
          Kiwi.Pause();
          // Change source MAC
          eth.SourceMac = macOfIntf(entry.InsideIntf);
          Kiwi.Pause();

          // Change destination IP address
#if DEBUG
          Console.WriteLine("<><><>> 263 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif
          ip.DestinationAddress = BitUtil.ChangeValueInChecksum(ip.DestinationAddress, entry.SourceIPAddress, ref ipChecksum, ref tcpChecksum);
          Kiwi.Pause();
#if DEBUG
          Console.WriteLine("<><><>> 267 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif

          // Change destination TCP port
#if DEBUG
          Console.WriteLine("<><><>> 272 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif
          tcp.DestinationPort = BitUtil.ChangeValueInChecksum(tcp.DestinationPort, entry.SourcePort, ref tcpChecksum);
          Kiwi.Pause();
#if DEBUG
          Console.WriteLine("<><><>> 276 checksums {0:x}/{1:x}", ipChecksum, tcpChecksum);
#endif

          // Forward on correct intf
          SetSendIntf(entry.InsideIntf);
          Kiwi.Pause();
        }

        Kiwi.Pause();

        if (found)
        {
          // Add carry bits and write new IP checksum value
          ip.HeaderChecksum = BitUtil.GetChecksum(ipChecksum);
          Kiwi.Pause();

          // Add carry bits and write new TCP checksum value
          tcp.Checksum = BitUtil.GetChecksum(tcpChecksum);
          Kiwi.Pause();

          Kiwi.Pause();
#if DEBUG
          Console.WriteLine("<><><>> Sending frame");
#if KIWI
          for (int i = 0; i < dataplane.tdata.Length; i++)
          {
            Console.WriteLine("<><><>>> {0:x}", dataplane.tdata[i]);
            if (dataplane.tlast[i])
              break;
            Kiwi.Pause();
          }
#endif
          Console.WriteLine();
#endif
          SendFrame(pkt_size);
        }
      }
    }

    static bool LookupTcp(EthernetWrapper eth, IPv4Wrapper ip, TCPWrapper tcp, bool isOutsideIntf)
    {
      // for now do a linear traversal >_> // FIXME perform CAM read???
      for (uint index = 0; index < ENTRY_COUNT; index++) // FIXME can Kiwi cope with a foreach instead? Would be nicer
      {
        entry.Load(index);
        if (!entry.IsAllocated)
          continue;
        Kiwi.Pause();

        if (isOutsideIntf)
        {
          if (entry.DestinationIPAddress == ip.SourceAddress
            && entry.DestinationPort == tcp.SourcePort
            && entry.MasqueradePort == tcp.DestinationPort)
          {
#if DEBUG
            Console.WriteLine("<><><>> Found matching entry");
#endif
            Kiwi.Pause();
            return true;
          }
#if DEBUG
          else
          {
            Console.WriteLine("<><><>> Entry {0} doesn't match", index);
            Console.WriteLine("<><><>>> {0:x} != {1:x}", entry.DestinationIPAddress, ip.SourceAddress);
            Console.WriteLine("<><><>>> {0:x} != {1:x}", entry.DestinationPort, tcp.SourcePort);
            Console.WriteLine("<><><>>> {0:x} != {1:x}", entry.MasqueradePort, tcp.DestinationPort);
          }
#endif
        }
        else // isInsideIntf
        {
          if (entry.SourceIPAddress == ip.SourceAddress
            && entry.SourcePort == tcp.SourcePort
            && entry.DestinationIPAddress == ip.DestinationAddress
            && entry.DestinationPort == tcp.DestinationPort)
          {
#if DEBUG
            Console.WriteLine("<><><>> Found matching entry");
#endif
            Kiwi.Pause();
            return true;
          }
#if DEBUG
          else
          {
            Console.WriteLine("<><><>> Entry {0} doesn't match", index);
            Console.WriteLine("<><><>>> {0:x} != {1:x}", entry.SourceIPAddress, ip.SourceAddress);
            Console.WriteLine("<><><>>> {0:x} != {1:x}", entry.SourcePort, tcp.SourcePort);
            Console.WriteLine("<><><>>> {0:x} != {1:x}", entry.DestinationIPAddress, ip.DestinationAddress);
            Console.WriteLine("<><><>>> {0:x} != {1:x}", entry.DestinationPort, tcp.DestinationPort);
          }
#endif
        }

        Kiwi.Pause();
      }
#if DEBUG
      Console.WriteLine("<><><>> Entry search finished with no result.");
#endif
      return false;
    }

    static void SetSendIntf(byte intf)
    {
      ulong tuser_low0 = dataplane.tuser_low[0];
      Kiwi.Pause();
      tuser_low0 &= 0xFFFFFFFF00FFFFFFuL;
      tuser_low0 |= ((ulong)intf << 24);
      dataplane.tuser_low[0] = tuser_low0;
      Kiwi.Pause();
    }

    static bool IsOutsideIntf(byte intf)
    {
      return (intf & outsidePort) != 0;
    }
    static bool IsInsideIntf(byte intf)
    {
      return (intf & insidePorts) != 0;
    }

    static ulong macOfIntf(byte intf)
    {
      switch (intf)
      {
        // FIXME provide actual MACs
        case (1 << 0) /*0b00000001*/: return nf0Mac;
        case (1 << 2) /*0b00000100*/: return nf1Mac;
        case (1 << 4) /*0b00010000*/: return nf2Mac;
        case (1 << 6) /*0b01000000*/: return nf3Mac;
#if !KIWI
        default: throw new Exception("This should be unreachable");
#else
        default: return 0; // FIXME this isn't okay
#endif
      }
    }
    static ulong nextHopMacOfIntf(byte intf)
    {
      switch (intf)
      {
        // FIXME provide actual MACs
        case (1 << 0) /*0b00000001*/: return nf0NextHopMac;
        case (1 << 2) /*0b00000100*/: return nf1NextHopMac;
        case (1 << 4) /*0b00010000*/: return nf2NextHopMac;
        case (1 << 6) /*0b01000000*/: return nf3NextHopMac;
#if !KIWI
        default: throw new Exception("This should be unreachable");
#else
        default: return 0; // FIXME this isn't okay
#endif
      }
    }

    static void DebugPrintData()
    {
#if DEBUG
      Console.WriteLine("<><><>> tdata");
      for (int i = 0; i < dataplane.tdata.Length; i++)
      {
#if !KIWI
        Console.WriteLine("<><><>> {0:x16}", dataplane.tdata[i]);
#else
          Console.WriteLine("<><><>> {0:x}", dataplane.tdata[i]);
#endif
        if (dataplane.tlast[i])
        {
          Console.WriteLine("<><><>> tkeep[{0}] = {1:x} (i tlast)", i, dataplane.tkeep[i]);
          break;
        }
        Kiwi.Pause();
      }
      Console.WriteLine("<><><>> tuser_hi (non-zero)");
      for (int i = 0; i < dataplane.tdata.Length; i++)
      {
        if (dataplane.tuser_hi[i] != 0)
          Console.WriteLine("<><><>> {0}: {1:x}", i, dataplane.tuser_hi[i]);
        Kiwi.Pause();
      }
      Console.WriteLine("<><><>> tuser_low {0:x}", dataplane.tuser_low[0]);
      Kiwi.Pause();
#endif
    }
  }
}
