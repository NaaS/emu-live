/*
Class to provide typed access to IPv4 fields from an array of uint64s

Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab, August 2016

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using EmuUtil;

namespace Emu.Nat
{
  sealed class IPv4Wrapper
  {
    private readonly ulong[] data;
    public const int Offset = EthernetWrapper.PayloadOffset;
    public int PayloadOffset { get { return Offset + (InternetHeaderLength * 4); } }
    public int PayloadLength { get { return TotalLength - (InternetHeaderLength * 4); } }

    public byte       Version               { get { return (byte)(      data.Get8 (Offset +  0) >> 4); } }

    public byte       InternetHeaderLength  { get { return (byte)(      data.Get8 (Offset +  0) & 0x0F); } } // NOTE in 32-bit words

    public byte       DSCP                  { get { return (byte)(      data.Get8 (Offset +  1) >> 2); } }

    public byte       ECN                   { get { return (byte)(      data.Get8 (Offset +  1) & 0x03); } }

    public ushort     TotalLength           { get { return              data.Get16(Offset +  2); } }

    public ushort     Identification        { get { return              data.Get16(Offset +  4); } }

    public byte       Flags                 { get { return (byte)(      data.Get8 (Offset +  6) >> 5); } }

    public ushort     FragmentOffset        { get { return (ushort)(    data.Get16(Offset +  6) & 0xFF1F); } } // NOTE mask endianness

    public byte       TimeToLive            { get { return              data.Get8 (Offset +  8); } }

    public IPProtocol Protocol              { get { return (IPProtocol) data.Get8 (Offset +  9); } }

    public ushort     HeaderChecksum        { get { return              data.Get16(Offset + 10); }
                                              set {                     data.Set16(Offset + 10, value); } }

    public uint       SourceAddress         { get { return              data.Get32(Offset + 12); }
                                              set {                     data.Set32(Offset + 12, value); } }

    public uint       DestinationAddress    { get { return              data.Get32(Offset + 16); }
                                              set {                     data.Set32(Offset + 16, value); } }

    // TODO options

    public IPv4Wrapper(ulong[] data)
    {
      this.data = data;
    }

    public enum IPProtocol : byte
    {
      ICMP = 0x01,
      TCP  = 0x06,
      UDP  = 0x11
    }
  }
}
