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
  public static class MockUtil
  {
    /// <summary>Exposes a <see cref="IEnumerator{T}"/> as an <see cref="IEnumerable{T}"/> for convenience.</summary>
    public static IEnumerable<T> AsEnumerable<T>(this IEnumerator<T> enumerator)
    {
      while (enumerator.MoveNext())
        yield return enumerator.Current;
    }

    /// <summary>
    /// Exposes an <see cref="IEnumerable{T}"/> as readonly sequence by wrapping it within another <see cref="IEnumerable{T}"/>
    /// so that the original object cannot be obtained via a cast.
    /// </summary>
    public static IEnumerable<T> AsReadOnlyEnumerable<T>(this IEnumerable<T> enumerable)
    {
      return enumerable.GetEnumerator().AsEnumerable();
    }

    /// <summary>Appends an item to an <see cref="IEnumerable{T}"/>.</summary>
    public static IEnumerable<T> Append<T>(this IEnumerable<T> seq, T item)
    {
      return seq.Concat(new T[] { item });
    }

    /// <summary>Converts a byte array into a string of 1's and 0's.</summary>
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

    /// <summary>Converts a <see cref="ulong"/> into a string of 1's and 0's.</summary>
    /// <remarks>Uses the same endianness as BitConverter.</remarks>
    public static string ToBinaryString(this ulong v)
    {
      return BitConverter.GetBytes(v).ToBinaryString();
    }

    /// <summary>Converts the four least-significant-bits of a byte into a four-character string of 1's and 0's.</summary>
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

    /// <summary>
    /// Converts the data (<see cref="NetFPGA_Data.tdata"/>) into a binary string, with a title,
    /// and each ulong on a new line.
    /// </summary>
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

    /// <summary>
    /// Converts the data (<see cref="NetFPGA_Data.tdata"/>) into a hex string, with a title,
    /// and each ulong on a new line.
    /// </summary>
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

    /// <summary>
    /// Transforms a raw frame (i.e., byte sequence) into the abstraction we use for NetFPGA's data+metadata, and sets in the input port metadata to a specific port number.
    /// </summary>
    /// <param name="tdata_e">The raw frame data</param>
    /// <param name="intfNumber">The 0-based port number the frame is arriving on</param>
    /// <remarks>
    /// Note that this involves copying the data (into a ulong array).
    /// </remarks>
    public static NetFPGA_Data CreateData(IEnumerable<byte> tdata_e, int intfNumber)
    {
      var d = new NetFPGA_Data();

      var tdata_b = tdata_e.ToArray();
      var length = (int)Math.Ceiling(tdata_b.Length / 8.0);
      Buffer.BlockCopy(tdata_b, 0, d.tdata, 0, tdata_b.Length);

      var tkeep = Enumerable.Repeat((byte)0xff, length - 1).Append((byte)~(~0 << tdata_b.Length % 8)).ToArray();
      Array.Copy(tkeep, d.tkeep, tkeep.Length);

      var tlast = Enumerable.Repeat(false, length - 1).Append(true).ToArray();
      Array.Copy(tlast, d.tlast, tlast.Length);

      var tuser_hi = Enumerable.Repeat(0uL, length).ToArray();
      Array.Copy(tuser_hi, d.tuser_hi, tuser_hi.Length);

      var tuser_low = Enumerable.Repeat(((1uL << (intfNumber * 2)) << 16) | (byte)tdata_b.Length, length).ToArray();
      Array.Copy(tuser_low, d.tuser_low, tuser_low.Length);

      return d;
    }
  }
}
