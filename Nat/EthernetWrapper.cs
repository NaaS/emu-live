/*
Class to provide typed access to Ethernet fields from an array of uint64s

Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab, August 2016

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using EmuUtil;

namespace Emu.Nat
{
  sealed class EthernetWrapper
  {
    private readonly ulong[] data;
    // This is a layer 2 ethernet packet
    public const int Offset = 0;
    public const int HeaderLength = 14;
    public const int PayloadOffset = Offset + HeaderLength;

    public ulong      DestinationMac  { get { return            data.GetBytes  (Offset +  0, 6); }
                                          set {                 data.SetBytes  (Offset +  0, value, 6); } }

    public ulong      SourceMac       { get { return            data.GetBytes  (Offset +  6, 6); }
                                          set {                 data.SetBytes  (Offset +  6, value, 6); } }

    public EtherType  Ethertype       { get { return (EtherType)data.Get16(Offset + 12); } }

    public EthernetWrapper(ulong[] data)
    {
      this.data = data;
    }


    public enum EtherType : ushort
    {
      // NOTE endianness
      IPv4 = 0x0008,
      ARP  = 0x0608,
      IPv6 = 0xDD86
    }
  }
}
