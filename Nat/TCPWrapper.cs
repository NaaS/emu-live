/*
Class to provide typed access to TCP fields from an array of uint64s

Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab, August 2016

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;

using EmuUtil;

namespace Emu.Nat
{
  sealed class TCPWrapper
  {
    public readonly ulong[] data;
    public /*readonly*/ int Offset;
    public/* readonly*/ int Length;
    public int PayloadOffset { get { return Offset + (DataOffset * 4); } }
    public int PayloadLength { get { return Length - (DataOffset * 4); } }

    public ushort SourcePort            { get { return        data.Get16(Offset +  0); }
                                          set {               data.Set16(Offset +  0, value); } }

    public ushort DestinationPort       { get { return        data.Get16(Offset +  2); }
                                          set {               data.Set16(Offset +  2, value); } }

    public uint   SequenceNumber        { get { return        data.Get32(Offset +  4); } }

    public uint   AcknowledgmentNumber  { get { return        data.Get32(Offset +  8); } }

    public byte   DataOffset            { get { return (byte)(data.Get8 (Offset + 12) >> 4); } } // NOTE in 32-bit words

    public Flag   Flags                 { get { return (Flag)(data.Get16(Offset + 12) & 0xFF01); } } // NOTE mask endianness

    public ushort WindowSize            { get { return        data.Get16(Offset + 14); } }

    public ushort Checksum              { get { return        data.Get16(Offset + 16); }
                                          set {               data.Set16(Offset + 16, value); } }

    public ushort UrgentPointer         { get { return        data.Get16(Offset + 18); } }

    // TODO options

    public TCPWrapper(ulong[] data/*, int offset, int length*/)
    {
      this.data = data;
      /*this.Offset = offset;
      this.Length = length;*/
    }

    public bool HasFlag(Flag flag) // Use this instead of Flags.HasFlag for Kiwi
    {
      return (Flags | flag) != 0;
    }

    [Flags]
    public enum Flag
    {
      // NOTE endianness
      NS  = 0x0001,
      Fin = 0x0100,
      Syn = 0x0200,
      Rst = 0x0400,
      Psh = 0x0800,
      Ack = 0x1000,
      Urg = 0x2000,
      Ece = 0x4000,
      Cwr = 0x8000
    }
  }
}
