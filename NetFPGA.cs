/*
 Emu framework to run Kiwi-compiled code on the NetFPGA platform.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>
                       Nik Sultana, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using System.Diagnostics;

namespace Emu
{
  /// <summary>
  ///   Data and metadata that is passed to us (the "Output Logic") by the "Input Arbiter",
  ///   and that we pass on to the "Output Queue". (The quoted expressions are modules within
  ///   NetFPGA's data plane.
  /// </summary>
  public class NetFPGA_Data
  {
     public const byte NET_PORTS = 4; // Number of network ports.
     // NOTE the maximum-sized frames we can handle is BUF_SIZE * BUS_SIZE, where BUS_SIZE
     //      is implicitly 64-bits --- it's the width of the bus we have with the IA, which
     //      is currently mediated by a 256-to-64-bit converter (this should be removed in the
     //      future). We can increased BUF_SIZE to handle larger frames.
     public const uint BUF_SIZE = 30;
     // The actual frame's contents, segmented into BUF_SIZE units.
     public ulong[] tdata     = new ulong[BUF_SIZE];
     // Metadata: how much of the last segment to keep.
     public byte[]  tkeep     = new byte[BUF_SIZE];
     // Metadata: whether this is the last segment.
     public bool[]  tlast     = new bool[BUF_SIZE];
     // Metadata: tuser specifies the input port, output port, and frame size.
     // NOTE we don't use tuser_hi
     // FIXME we only seem to use tuser_low[0] in application code.
     public ulong[] tuser_hi  = new ulong[BUF_SIZE];
     // Structure of tuser_low: 2 bytes for frame size, 1 byte for source port,
     // and 1 byte for destination port.
     public const byte tuser_low_destination_port = 24;
     public const byte tuser_low_source_port = 16;
     public const byte tuser_low_frame_size = 0;
     // The structure of source/destination port (in bits) is as follows:
     //   DMA NF3 DMA NF2 DMA NF1 DMA NF0
     // where "DMA" means that the data is sourced/destined from DMA,
     // and "NFx" refers to port "x".
     public ulong[] tuser_low = new ulong[BUF_SIZE];

     // By default we destine a frame to all output ports (NF0-NF3)
     // to broadcast it. This results in the following bit mask.
     public const ulong default_oqs = (ulong)0x0000000000550000;
  }

  public class NetFPGA
  {
#if ON_HOST // It's useful to enclose this away at compile-time to avoid confusing Kiwi with unbound arrays or complex functions.
    // Extract how many bytes we are keeping from a given (8 byte) segment as
    // identified by an offset.
    // This involves looking up the tkeep[offset] value and carrying out
    // the one-hot decoding.
    // NOTE we expect that the bits indicating which bits to keep are
    //      contiguous. We currently don't check this.
    public static int to_keep (NetFPGA_Data src, int offset)
    {
      byte tkeep = src.tkeep[offset];
      int keeping = 0;
      const int bits_in_a_byte = 8;
      for (int i = 0; i < bits_in_a_byte; i++)
      {
        tkeep = (byte)(tkeep >> i);
        if ((tkeep & 0x1) == 1)
        {
          keeping++;
        } else {
          break;
        }
      }

      return keeping;
    }

    // Carry out the one-hot encoding given a byte ("width") indicating
    // how many (out of 8) bytes we want to keep.
    public static byte one_hot_encode (byte width)
    {
      const int bits_in_a_byte = 8; // FIXME DRY principle
      Debug.Assert(width <= bits_in_a_byte);
      byte tkeep = 0;
      for (int i = width; i > 0; i--)
      {
        tkeep = (byte)(tkeep << 1);
        tkeep |= 0x1;
      }

      return tkeep;
    }

    // Extract the frame from NetFPGA_Data into a byte array.
    public static void Get_Frame (NetFPGA_Data src, ref byte[] dst)
    {
      // FIXME we don't check the bounds of dst.
      // FIXME we don't null unused locations in dst.
      int offset = 0;
      for (int i = 0; i < src.tdata.Length; i++)
      {
        byte[] bs = BitConverter.GetBytes(src.tdata[i]);
        for (int j = 0; j < bs.Length; j++)
        {
          if (src.tlast[i] && NetFPGA.to_keep (src, i) > j)
          {
            break;
          }

          dst[offset] = bs[j];
          offset++;
        }

        if (src.tlast[i])
        {
          break;
        }
      }
    }
#endif

    // Move the contents of a byte array into the frame field in NetFPGA_Data.
    public static void Set_Frame (byte[] src, ref NetFPGA_Data dst)
    {
      // If not ulong (8-byte) aligned then we indicate this using
      // NetFPGA_Data.tkeep. We indicate the end of the frame by setting
      // NetFPGA_Data.tlast.
      int i = 0;
      int max = dst.tdata.Length / sizeof(ulong);

      byte[] buf = new byte[sizeof(long)];

      for (i = 0; i < max; i++)
      {
        for (int j = 0; j < sizeof(long); j++)
        {
          buf[j] = src[i + j];
        }

        dst.tdata[i * sizeof(long)] = BitConverter.ToUInt32(buf, 0);

        dst.tlast[i] = false;
      }

      // Now we handle the last word.
      dst.tlast[i] = true;
      byte to_keep = (byte)(dst.tdata.Length % sizeof(ulong));
      dst.tkeep[i] = one_hot_encode(to_keep);

      // Copy remaining bytes.
      int k = 0;
      for (k = 0; k < to_keep; k++)
      {
        buf[k] = src[i + k];
      }
      // Zero-out the bytes until the word boundary.
      for (; k < sizeof(ulong); k++)
      {
        buf[k] = 0;
      }

      dst.tdata[i * sizeof(long)] = BitConverter.ToUInt32(buf, 0);
    }

    /// <summary>
    ///  Set the input port (i.e., port on which we received the frame).
    /// </summary>
    public static void Set_Input_Port (ref NetFPGA_Data dataplane, ulong value)
    {
      // "value" indicates network port index, starting with 0.
      Debug.Assert (value < NetFPGA_Data.NET_PORTS);

      // Map value into a bit-based encoding as described for source/destination
      // ports in NetFPGA_Data.
      ulong encoded_in_port = 1;
      for (int i = (int)value; i > 0; i--)
      {
        encoded_in_port = encoded_in_port << 2;
      }

      // Move into position, in preparation for OR-ing.
      encoded_in_port = encoded_in_port << NetFPGA_Data.tuser_low_source_port;
      // Erase any existing input port.
      dataplane.tuser_low[0] = (ulong)(0xFF00FFFF & dataplane.tuser_low[0]);
      // Write the new input port.
      dataplane.tuser_low[0] = (ulong)(encoded_in_port | dataplane.tuser_low[0]);
    }

    /// <summary>
    ///  Read the input port (i.e., port on which we received the frame).
    /// </summary>
    public static uint Read_Input_Port (NetFPGA_Data dataplane)
    {
      uint encoded_in_port = (uint)(dataplane.tuser_low[0] >> NetFPGA_Data.tuser_low_source_port);
      encoded_in_port &= 0x00FF; // Zero out the destination port.

      uint in_port = 0;
      while ((encoded_in_port & 1) == 0) {
        in_port++;
        encoded_in_port = encoded_in_port >> 2;
      }

      // "in_port" indicates network port index, starting with 0.
      Debug.Assert (in_port < NetFPGA_Data.NET_PORTS);

      return in_port;
    }

    /// <summary>
    ///   Set the output port to a specific value.
    ///   (i.e., the port to which we are forwarding the frame.)
    /// </summary>
    public static void Set_Output_Port (ref NetFPGA_Data dataplane, ulong value)
    {
      // FIXME we currently don't one-hot encode "value"
      value = value << NetFPGA_Data.tuser_low_destination_port;
      dataplane.tuser_low[0] = (ulong)(value | dataplane.tuser_low[0]);
      return;
    }

    /// <summary>
    ///   Read the output ports that are currently set in the metadata.
    ///   (i.e., the port(s) to which we are forwarding the frame.)
    /// </summary>
    public static byte Get_Output_Ports (ref NetFPGA_Data dataplane,
        ref int[] output_ports, int? max_ports = null)
    {
      ulong value = dataplane.tuser_low[0];
      value = (value >> NetFPGA_Data.tuser_low_destination_port);
      bool nf0 = (value & 0x01L) > 0;
      bool nf1 = (value & 0x04L) > 0;
      bool nf2 = (value & 0x10L) > 0;
      bool nf3 = (value & 0x40L) > 0;

      // FIXME code in this function is a bit dirty -- can be tidied up?

      byte dim = 0;
      if (nf0) dim++;
      if (nf1 && max_ports.HasValue && max_ports.Value > 1) dim++;
      if (nf2 && max_ports.HasValue && max_ports.Value > 2) dim++;
      if (nf3 && max_ports.HasValue && max_ports.Value > 3) dim++;

      Debug.Assert(dim == output_ports.Length);

      int i = 0;
      if (nf0)
      {
        output_ports[i] = 0;
        i++;
      }
      if (nf1)
      {
        output_ports[i] = 1;
        i++;
      }
      if (nf2)
      {
        output_ports[i] = 2;
        i++;
      }
      if (nf3)
      {
        output_ports[i] = 3;
        i++;
      }

      return dim;
    }

    /// <summary>
    ///   Update the metadata to broadcast the frame (to all ports except the
    ///   one that the frame was received on).
    /// </summary>
    public static void Broadcast (ref NetFPGA_Data dataplane)
    {
      ulong broadcast_ports = ((dataplane.tuser_low[0] ^ NetFPGA_Data.default_oqs) >> 8) << 16 | dataplane.tuser_low[0];
      dataplane.tuser_low[0] = (ulong)(broadcast_ports | dataplane.tuser_low[0]);
      return;
    }
  }
}
