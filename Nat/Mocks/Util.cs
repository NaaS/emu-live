/*
 A helper class for mocking and testing.

 Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Emu
{
  public static class Util
  {
    public static IEnumerable<T> AsEnumerable<T>(this IEnumerator<T> enumerator)
    {
      while (enumerator.MoveNext())
        yield return enumerator.Current;
    }
    public static IEnumerable<T> AsReadOnlyEnumerable<T>(this IEnumerable<T> enumerable)
    {
      return enumerable.GetEnumerator().AsEnumerable();
    }
    public static string ToBinaryString(this byte[] arr)
    {
      StringBuilder sb = new StringBuilder(arr.Length * 8);
      foreach (byte b in arr)
      {
        sb.Append(NibbleString((byte)(b >> 4)));
        sb.Append(NibbleString(b));
      }
      return sb.ToString();
    }
    public static string ToBinaryString(this ulong v)
    {
      return BitConverter.GetBytes(v).ToBinaryString();
    }
    private static string NibbleString(byte nibble)
    {
      switch (nibble & 0x0F)
      {
        case 0x00: return "0000";
        case 0x01: return "0001";
        case 0x02: return "0010";
        case 0x03: return "0011";
        case 0x04: return "0100";
        case 0x05: return "0101";
        case 0x06: return "0110";
        case 0x07: return "0111";
        case 0x08: return "1000";
        case 0x09: return "1001";
        case 0x0A: return "1010";
        case 0x0B: return "1011";
        case 0x0C: return "1100";
        case 0x0D: return "1101";
        case 0x0E: return "1110";
        case 0x0F: return "1111";
        default: throw new Exception("Programming error - this should be unreachable");
      }
    }

    public static NetFPGA_Data DeepClone(this NetFPGA_Data src)
    {
      var r = new NetFPGA_Data();
      Array.Copy(src.tdata, r.tdata, src.tdata.Length);
      Array.Copy(src.tkeep, r.tkeep, src.tkeep.Length);
      Array.Copy(src.tlast, r.tlast, src.tlast.Length);
      Array.Copy(src.tuser_hi, r.tuser_hi, src.tuser_hi.Length);
      Array.Copy(src.tuser_low, r.tuser_low, src.tuser_low.Length);
      return r;
    }

    public static string ToBinaryString(this NetFPGA_Data d)
    {
      StringBuilder sb = new StringBuilder();

      sb.AppendLine("tdata:");
      for (int i = 0; i < d.tdata.Length && !d.tlast[i]; i++)
      {
        sb.Append("  ");
        sb.AppendLine(d.tdata[i].ToBinaryString());
      }

      return sb.ToString();
    }
    public static string ToHexString(this NetFPGA_Data d)
    {
      StringBuilder sb = new StringBuilder();

      sb.AppendLine("tdata:");
      for (int i = 0; i < d.tdata.Length; i++)
      {
        sb.Append("  ");
        sb.AppendLine(d.tdata[i].ToString("X16"));
        if (d.tlast[i])
          break;
      }

      return sb.ToString();
    }

    public static void Write16(this NetFPGA_Data dataplane, ushort v, int offset)
    {
      int index64 = offset / 8;
      int offset1 = offset % 8 * 8;

      ulong data1 = (ulong)v << offset1;
      ulong mask1 = ~(0x000000000000FFFFuL << offset1);
      dataplane.tdata[index64] = (dataplane.tdata[index64] & mask1) | data1;

      index64++;
      offset1 = 64 - offset1;
      ulong data2 = offset1 >= 64 ? 0 : (ulong)v >> offset1;
      ulong mask2 = offset1 >= 64 ? ~0uL : ~(0x000000000000FFFFuL >> offset1);
      dataplane.tdata[index64] = (dataplane.tdata[index64] & mask2) | data2;
    }
    public static void Write32(this NetFPGA_Data dataplane, uint v, int offset)
    {
      int index64 = offset / 8;
      int offset1 = offset % 8 * 8;

      ulong data1 = v << offset1;
      ulong mask1 = ~(0x00000000FFFFFFFFuL << offset1);
      dataplane.tdata[index64] = (dataplane.tdata[index64] & mask1) | data1;

      index64++;
      offset1 = 64 - offset1;
      ulong data2 = offset1 >= 64 ? 0 : (ulong)v >> offset1;
      ulong mask2 = offset1 >= 64 ? ~0uL : ~(0x00000000FFFFFFFFuL >> offset1);
      dataplane.tdata[index64] = (dataplane.tdata[index64] & mask2) | data2;
    }
    public static void Write48(this NetFPGA_Data dataplane, ulong v, int offset)
    {
      int index64 = offset / 8;
      int offset1 = offset % 8 * 8;

      ulong data1 = v << offset1;
      ulong mask1 = ~(0x0000FFFFFFFFFFFFuL << offset1);
      dataplane.tdata[index64] = (dataplane.tdata[index64] & mask1) | data1;

      index64++;
      offset1 = 64 - offset1;
      ulong data2 = offset1 >= 64 ? 0 : v >> offset1;
      ulong mask2 = offset1 >= 64 ? ~0uL : ~(0x0000FFFFFFFFFFFFuL >> offset1);
      dataplane.tdata[index64] = (dataplane.tdata[index64] & mask2) | data2;
    }
  }
}
