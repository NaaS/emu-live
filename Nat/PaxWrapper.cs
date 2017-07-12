/*
Wrapper class to allow the NAT implementation to be run on Pax

Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab, August 2016

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using System.Net;
using PacketDotNet;
using Pax;
using EmuUtil;

#if !KIWI

namespace Emu.Nat
{
  public class PaxNatPacketProcessor : Pax.IPacketProcessor
  {
    public PaxNatPacketProcessor(ulong? nf0_mac = null, ulong? nf1_mac = null, ulong? nf2_mac = null, ulong? nf3_mac = null,
      ulong? nf0_next_hop_mac = null, ulong? nf1_next_hop_mac = null, ulong? nf2_next_hop_mac = null, ulong? nf3_next_hop_mac = null,
      IPAddress nat_inside_ip = null, IPAddress nat_outside_ip = null,
      ushort? tcp_start_port = null)
    {
      // Configure via ctor parameters
      if (nf0_mac.HasValue) NAT.nf0Mac = nf0_mac.Value;
      if (nf1_mac.HasValue) NAT.nf1Mac = nf1_mac.Value;
      if (nf2_mac.HasValue) NAT.nf2Mac = nf2_mac.Value;
      if (nf3_mac.HasValue) NAT.nf3Mac = nf3_mac.Value;
      if (nf0_next_hop_mac.HasValue) NAT.nf0NextHopMac = nf0_next_hop_mac.Value;
      if (nf1_next_hop_mac.HasValue) NAT.nf1NextHopMac = nf1_next_hop_mac.Value;
      if (nf2_next_hop_mac.HasValue) NAT.nf2NextHopMac = nf2_next_hop_mac.Value;
      if (nf3_next_hop_mac.HasValue) NAT.nf3NextHopMac = nf3_next_hop_mac.Value;
      if (nat_inside_ip  != null) NAT.myInsideIP  = ToUint(nat_inside_ip);
      if (nat_outside_ip != null) NAT.myOutsideIP = ToUint(nat_outside_ip);
      if (tcp_start_port.HasValue) NAT.nextPort = tcp_start_port.Value;


      // Send frames on intf
      var controller = new MockFrameController();
      controller.OnSendFrame += (sender, e) =>
      {
        // NAT has sent frame - send on physical interface
#if DEBUG
        Console.WriteLine("TX packet");
#endif

        // Check which output port
        int out_port = e.Frame.Data.GetOutputPortNumber();
#if DEBUG
        Console.WriteLine("Out port: {0} SendIntf: 0x{1:x2}", out_port, e.Frame.Data.GetSendIntf());
#endif
        if (out_port >= 0)
        {
          // Swap endianness
          //e.Frame.SwapTdataEndianness();

#if DEBUG
          // Print tdata
          Console.WriteLine("tdata");
          Console.WriteLine("======");
          for (int i = 0; i < e.Frame.Data.tdata.Length; i++)
          {
            Console.WriteLine("<><><>> {0:x16}", e.Frame.Data.tdata[i]);
            if (e.Frame.Data.tlast[i])
              break;
          }
          Console.WriteLine("<><><>> tuser_low {0:x}", e.Frame.Data.tuser_low[0]);
          Console.WriteLine();
#endif

          // Copy data to byte array
          int length = e.Frame.Data.GetKeepLength(); // Length in bytes
          byte[] data = new byte[length];
          Buffer.BlockCopy(e.Frame.Data.tdata, 0, data, 0, length); // FIXME not great for performance to copy twice :/

#if DEBUG
          // Update checksums for mininet testing.
          var pkt = Packet.ParsePacket(LinkLayers.Ethernet, data);
          if (pkt.PayloadPacket is IpPacket)
          {
            var ip = (IPv4Packet)pkt.PayloadPacket;
            if (ip.Checksum != ip.CalculateIPChecksum())
              Console.WriteLine("! IP Checksum incorrect ({0:x4} != {1:x4})", ip.Checksum, ip.CalculateIPChecksum());
          }
          if (pkt.PayloadPacket.PayloadPacket is TcpPacket)
          {
            var tcp = (TcpPacket)pkt.PayloadPacket.PayloadPacket;
            if (tcp.Checksum != tcp.CalculateTCPChecksum())
              Console.WriteLine("! TCP Checksum incorrect ({0:x4} != {1:x4})", tcp.Checksum, tcp.CalculateTCPChecksum());
          }

          Console.WriteLine("Sending packet length {0}", length);
#endif

          // Send the frame
          var device = Pax.PaxConfig.deviceMap[out_port];
          device.SendPacket(data);
        }
      };

      NAT.FrameController = controller;
      controller.Start();
    }

    private uint ToUint(IPAddress addr)
    {
      // Get address bytes for packing
      byte[] b = addr.GetAddressBytes();
      if (b.Length != 4)
        throw new Exception("Address must be IPv4");

      // Change endianness
      for (int i = 0; i*2 < b.Length; i++)
      {
        byte t = b[i];
        b[i] = b[b.Length - i - 1];
        b[b.Length - i - 1] = t;
      }

      // Return address bytes packed into uint
      return BitConverter.ToUInt32(addr.GetAddressBytes(), 0);
    }

    private System.Threading.Thread natThread;
    public void packetHandler(object sender, SharpPcap.CaptureEventArgs e)
    {
      // Start NAT on first call
      if (natThread == null)
      {
        natThread = new System.Threading.Thread(() => NAT.EntryPoint());
        natThread.Start();
      }

#if DEBUG
      Console.WriteLine("RX packet {0:x16}", BitConverter.ToUInt64(e.Packet.Data, 0));
#endif

#if MININET
      // Update checksums for mininet testing.
      var pkt = Packet.ParsePacket(e.Packet.LinkLayerType, e.Packet.Data);
      if (pkt.PayloadPacket is IpPacket)
      {
        var ip = (IPv4Packet)pkt.PayloadPacket;
        if (ip.Checksum != ip.CalculateIPChecksum())
          Console.WriteLine("! IP Checksum incorrect ({0:x4} != {1:x4})", ip.Checksum, ip.CalculateIPChecksum());
        ip.UpdateIPChecksum();
      }
      if (pkt.PayloadPacket.PayloadPacket is TcpPacket)
      {
        var tcp = (TcpPacket)pkt.PayloadPacket.PayloadPacket;
        if (tcp.Checksum != tcp.CalculateTCPChecksum())
          Console.WriteLine("! TCP Checksum incorrect ({0:x4} != {1:x4})", tcp.Checksum, tcp.CalculateTCPChecksum());
        tcp.UpdateTCPChecksum();
      }
#endif

      // Create data object (NOTE this involves copy the data)
      int intfNumber = PaxConfig.rdeviceMap[e.Device.Name];
      var data = MockUtil.CreateData(e.Packet.Data, intfNumber);

      // Change endianness
      var frame = new FrameInfo(data, TimeSpan.Zero);
      //frame.SwapTdataEndianness(); // FIXME this doesn't seem to be needed? Look into ways to avoid copying then

      // Queue the frame for processing
      NAT.FrameController.QueueReceiveFrame(frame);
    }

    public ForwardingDecision process_packet(int in_port, ref Packet packet)
    {
      throw new NotImplementedException(); // Intentional
    }
  }
}

#endif
