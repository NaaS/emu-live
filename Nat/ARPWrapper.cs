/*
Class to provide typed access to ARP fields from an array of uint64s

Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab, August 2016

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using EmuUtil;

namespace Emu.Nat
{
  // NOTE this is for IPv4/Ethernet
  sealed class ARPWrapper
  {
    private readonly ulong[] data;
    public const int Offset = EthernetWrapper.PayloadOffset;
    public const int Length = 28;

    public HwType HardwareType          { get { return (HwType) data.Get16(Offset +  0); } }

    public ushort ProtocolType          { get { return          data.Get16(Offset +  2); } }

    public byte   HardwareAddressLength { get { return          data.Get8 (Offset +  4); } }

    public byte   ProtocolAddressLength { get { return          data.Get8 (Offset +  5); } }

    public Op     Operation             { get { return (Op)     data.Get16(Offset +  6); }
                                          set {                 data.Set16(Offset +  6, (ushort)value); } }

    public ulong  SenderHardwareAddress { get { return          data.GetBytes  (Offset +  8, 6); }
                                          set {                 data.SetBytes  (Offset +  8, value, 6); } }

    public uint   SenderProtocolAddress { get { return          data.Get32(Offset + 14); }
                                          set {                 data.Set32(Offset + 14, value); } }

    public ulong  TargetHardwareAddress { get { return          data.GetBytes  (Offset + 18, 6); }
                                          set {                 data.SetBytes  (Offset + 18, value, 6); } }

    public uint   TargetProtocolAddress { get { return          data.Get32(Offset + 24); }
                                          set {                 data.Set32(Offset + 24, value); } }

    public ARPWrapper(ulong[] data)
    {
      this.data = data;
    }

    public enum Op : ushort
    {
      // NOTE endianness
      Request = 0x0100,
      Reply   = 0x0200
    }

    public enum HwType : ushort
    {
      // NOTE endianness
      Ethernet = 0x0100
    }
  }
}
