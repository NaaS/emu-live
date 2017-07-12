/*
NetFPGA_Util : utility/helper functionality for working with the NetFPGA_Data class
Jonny Shipton, Cambridge University Computer Lab, August 2016

This software was developed by the University of Cambridge,
Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using Emu;
using System;

namespace EmuUtil
{
  public static class NetFPGA_Util
  {
    public static byte GetReceiveIntf(this NetFPGA_Data data)
    {
      return (byte)((data.tuser_low[0]) >> NetFPGA_Data.tuser_low_source_port);
    }
    public static byte GetSendIntf(this NetFPGA_Data data)
    {
        return (byte)((data.tuser_low[0]) >> NetFPGA_Data.tuser_low_destination_port);
    }
    public static ushort GetFrameSize(this NetFPGA_Data data)
    {
      return (ushort)((data.tuser_low[0]) >> NetFPGA_Data.tuser_low_frame_size);
    }
    public static int GetOutputPortNumber(this NetFPGA_Data data)
    {
      byte output = data.GetSendIntf();
      if ((output & 0x01) != 0) return 0;
      else if ((output & 0x04) != 0) return 1;
      else if ((output & 0x10) != 0) return 2;
      else if ((output & 0x40) != 0) return 3;
      else return -1; // Drop - no (physical) output port specified
    }

    public static int GetKeepLength(this NetFPGA_Data data)
    {
      // Get the length in terms of whole ulongs
      int len64 = 0;
      for (int i = 0; i < data.tlast.Length; i++)
      {
        if (data.tlast[i])
        {
          len64 = i;
          break;
        }
      }

      // Get the number of bytes used in the last ulong
      int used_in_last_ulong = 8;
      if (len64 < data.tdata.Length)
      {
        byte tkeep = data.tkeep[len64];
        for (int i = 0; i < 8; i++)
        {
          if (((0x01 << i) & tkeep) == 0)
          {
            used_in_last_ulong = i;
            break;
          }
        }
      }

      return len64 * 8 + used_in_last_ulong;
    }

    public static NetFPGA_Data DeepClone(this NetFPGA_Data src, NetFPGA_Data target = null)
    {
      target = target ?? new NetFPGA_Data();
      Array.Copy(src.tdata, target.tdata, src.tdata.Length);
      Array.Copy(src.tkeep, target.tkeep, src.tkeep.Length);
      Array.Copy(src.tlast, target.tlast, src.tlast.Length);
      Array.Copy(src.tuser_hi, target.tuser_hi, src.tuser_hi.Length);
      Array.Copy(src.tuser_low, target.tuser_low, src.tuser_low.Length);
      return target;
    }

    public static ulong GetBytes(this ulong[] data, int offset, int length = 8)
    {
#if DEBUG
      if (data == null) throw new ArgumentNullException(nameof(data));
      if (offset < 0 || offset + length > data.Length * 8) throw new ArgumentOutOfRangeException(nameof(offset));
      if (length < 0 || length > 8) throw new ArgumentOutOfRangeException(nameof(length));
#endif

#if !KIWI
      // FIXME Is this okay for Kiwi?
      unsafe
      {
        fixed (ulong* bsu = data)
        {
          // Get a pointer to the offset and value
          byte* dataPtr = (byte*)bsu + offset;
          ulong value = 0;
          byte* valuePtr = (byte*)&value;
          // Copy the bytes
          for (int i = 0; i < length; i++)
            *valuePtr++ = * dataPtr++;
          return value;
        }
      }
#else
      int length1 = length * 8;
      int index = offset / 8;
      int offset8 = offset % 8;
      int offset1 = (offset8) * 8;

      // Mask to constrain data to specified length
      ulong mask = (~0uL) >> (64 - length1);
      // Get data from first ulong and shift it to the right
      ulong data1 = (data[index] >> offset1) & mask;

      // Check whether we need to get more data from a second ulong
      if (offset / 8 == (offset + length - 1) / 8) // In a single ulong
        return data1;
      else // Across two ulongs
      {
        // Get the data from the second ulong and shift to left of data1
        ulong data2 = data[index + 1] << (64 - offset1);
        // Or data1 and data2 together (and mask to correct length)
        return (data2 | data1) & mask;
      }
#endif
    }
    public static byte Get8(this ulong[] data, int offset)
    {
      return (byte)data.GetBytes(offset, 1);
    }
    public static ushort Get16(this ulong[] data, int offset)
    {
      return (ushort)data.GetBytes(offset, 2);
    }
    public static uint Get32(this ulong[] data, int offset)
    {
      return (uint)data.GetBytes(offset, 4);
    }

    public static void SetBytes(this ulong[] data, int offset, ulong val, int length = 8)
    {
#if DEBUG
      if (data == null) throw new ArgumentNullException(nameof(data));
      if (offset < 0 || offset + length > data.Length * 8) throw new ArgumentOutOfRangeException(nameof(offset));
      if (length < 0 || length > 8) throw new ArgumentOutOfRangeException(nameof(length));
#endif

#if !KIWI
      // FIXME Is this okay for Kiwi?
      unsafe
      {
        fixed(ulong* bsu = data)
        {
          // Get a pointer to the offset and value
          byte* dataPtr = (byte*)bsu + offset;
          byte* valuePtr = (byte*)&val;
          // Copy the bytes
          for (int i = 0; i < length; i++)
            *dataPtr++ = *valuePtr++;
        }
      }
#else
      int length1 = length * 8;
      int index = offset / 8;
      int offset8 = offset % 8;
      int offset1 = (offset8) * 8;

      // Mask to constrain data to specified length
      ulong mask = (~0uL) >> (64 - length1);
      ulong value = val & mask;
      // Mask out where the data will go
      ulong maskOut = ~(mask << offset1);
      // Set the bits in the first ulong
      data[index] = (data[index] & maskOut) | (value << offset1);

      // Check whether we need to set any bits in a second ulong
      if (offset / 8 == (offset + length - 1) / 8) // In a single ulong
        return;
      else // Across two ulongs
      {
        // Calculate the offset within the second ulong
        int shl = length1 + offset1 - 64;
        // Mask out where the data will go
        maskOut = ~0uL << shl;
        // Set the bits in the second ulong
        data[index + 1] = (data[index + 1] & maskOut) | (value >> (64 - offset1));
      }
#endif
    }
    public static void Set8(this ulong[] data, int offset, byte value)
    {
      data.SetBytes(offset, value, 1);
    }
    public static void Set16(this ulong[] data, int offset, ushort value)
    {
      data.SetBytes(offset, value, 2);
    }
    public static void Set32(this ulong[] data, int offset, uint value)
    {
      data.SetBytes(offset, value, 4);
    }
  }
}
