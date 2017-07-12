/*
BitUtil : utility/helper functionality for working with bits
Jonny Shipton, Cambridge University Computer Lab, August 2016

This software was developed by the University of Cambridge,
Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using KiwiSystem;
using System;

namespace EmuUtil
{
  public static class BitUtil
  {
    public static ulong Get48(ulong src, int offset)
    {
#if DEBUG
      if (offset < 0 || offset + 6 > 8) throw new ArgumentOutOfRangeException(nameof(offset));
#endif
      return (src >> (offset * 8)) & 0x0000FFFFFFFFFFFF;
    }
    public static uint Get32(ulong src, int offset)
    {
#if DEBUG
      if (offset < 0 || offset + 4 > 8) throw new ArgumentOutOfRangeException(nameof(offset));
#endif
      return (uint)(src >> (offset * 8));
    }
    public static ushort Get16(ulong src, int offset)
    {
#if DEBUG
      if (offset < 0 || offset + 2 > 8) throw new ArgumentOutOfRangeException(nameof(offset));
#endif
      return (ushort)(src >> (offset * 8));
    }
    public static byte Get8(ulong src, int offset)
    {
#if DEBUG
      if (offset < 0 || offset + 1 > 8) throw new ArgumentOutOfRangeException(nameof(offset));
#endif
      return (byte)(src >> (offset * 8));
    }

    public static void Set48(ref ulong dst, int offset, ulong val)
    {
#if DEBUG
      if (offset < 0 || offset + 6 > 8) throw new ArgumentOutOfRangeException(nameof(offset));
      if ((val & 0xFFFF000000000000uL) != 0) throw new ArgumentException("Value wider than 48 bits", nameof(val));
#endif
      // Clear the bits
      dst &= ~(0x0000FFFFFFFFFFFFuL << (offset * 8));
      dst |= val << (offset * 8);
    }
    public static void Set32(ref ulong dst, int offset, uint val)
    {
#if DEBUG
      if (offset < 0 || offset + 4 > 8) throw new ArgumentOutOfRangeException(nameof(offset));
      if ((val & 0xFFFFFFFF00000000uL) != 0) throw new ArgumentException("Value wider than 32 bits", nameof(val));
#endif
      // Clear the bits
      dst &= ~(0x00000000FFFFFFFFuL << (offset * 8));
      dst |= (ulong)val << (offset * 8);
    }
    public static void Set16(ref ulong dst, int offset, ushort val)
    {
#if DEBUG
      if (offset < 0 || offset + 2 > 8) throw new ArgumentOutOfRangeException(nameof(offset));
      if ((val & 0xFFFFFFFFFFFF0000uL) != 0) throw new ArgumentException("Value wider than 16 bits", nameof(val));
#endif
      // Clear the bits
      dst &= ~(0x000000000000FFFFuL << (offset * 8));
      dst |= (ulong)val << (offset * 8);
    }
    public static void Set8(ref ulong dst, int offset, byte val)
    {
#if DEBUG
      if (offset < 0 || offset + 1 > 8) throw new ArgumentOutOfRangeException(nameof(offset));
      if ((val & 0xFFFFFFFFFFFFFF00uL) != 0) throw new ArgumentException("Value wider than 8 bits", nameof(val));
#endif
      // Clear the bits
      dst &= ~(0x00000000000000FFuL << (offset * 8));
      dst |= (ulong)val << (offset * 8);
    }

    public static ushort SwitchEndianness(ushort val)
    {
      return (ushort)((val << 8) | ((val >> 8) & 0x00FF));
    }

    // FIXME these can go? signed right shift should be fixed now
    /// <summary>Emulate arithmetic right shift for Kiwi</summary>
    public static int sshr(int v, int i)
    {
      uint uv = (uint)v;
      return sshr(uv, i);
    }
    /// <summary>Emulate arithmetic right shift for Kiwi</summary>
    public static int sshr(uint uv, int i)
    {
      // FIXME use C# operator instead when not on kiwi for fairness
      bool neg = (uv & (1 << 63)) != 0;
      uint r = uv >> i;
      if (neg)
      {
        uint sigbits = i >= 32 ? 0u : (0xFFFFFFFFu << (32 - i));
        r = r | sigbits;
      }
      return (int)r;
    }

    /// <summary>Add a new value to the working value for a incremental checksum change.</summary>
    public static void AddToChecksum(uint val, ref int checksum)
    {
      checksum += (int)(val & 0xFFFF) + sshr(val, 16);
    }
    /// <summary>Add a new value to the working value for a incremental checksum change.</summary>
    public static void AddToChecksum(ushort val, ref int checksum)
    {
      checksum += val;
    }
    /// <summary>Remove an old value from the working value for a incremental checksum change.</summary>
    public static void RemoveFromChecksum(uint val, ref int checksum)
    {
      checksum -= (int)(val & 0xFFFF) + sshr(val, 16);
    }
    /// <summary>Remove an old value from the working value for a incremental checksum change.</summary>
    public static void RemoveFromChecksum(ushort val, ref int checksum)
    {
      checksum -= val;
    }
    /// <summary>Change a value, removing the old and adding the new to the working value for a incremental checksum change.</summary>
    /// <returns>The new value</returns>
    public static uint ChangeValueInChecksum(uint oldVal, uint newVal, ref int checksum)
    {
      RemoveFromChecksum(oldVal, ref checksum);
      AddToChecksum(newVal, ref checksum);
      Kiwi.Pause();
      return newVal;
    }
    /// <summary>Change a value, removing the old and adding the new to the working value for a incremental checksum change.</summary>
    /// <returns>The new value</returns>
    public static ushort ChangeValueInChecksum(ushort oldVal, ushort newVal, ref int checksum)
    {
      RemoveFromChecksum(oldVal, ref checksum);
      AddToChecksum(newVal, ref checksum);
      Kiwi.Pause();
      return newVal;
    }
    /// <summary>Change a value, removing the old and adding the new to both of the working values for an incremental checksum change that affects two checksums.</summary>
    /// <returns>The new value</returns>
    /// <remarks>
    /// This has the effect of calling <see cref="ChangeValueInChecksum(uint, uint, ref int)"/> twice, specifying <paramref name="checksum"/>
    /// the first time, and <paramref name="checksum2"/> the second.
    /// </remarks>
    public static uint ChangeValueInChecksum(uint oldVal, uint newVal, ref int checksum, ref int checksum2)
    {
      RemoveFromChecksum(oldVal, ref checksum);
      RemoveFromChecksum(oldVal, ref checksum2);
      AddToChecksum(newVal, ref checksum);
      AddToChecksum(newVal, ref checksum2);
      Kiwi.Pause();
      return newVal;
    }
    /// <summary>Change a value, removing the old and adding the new to both of the working values for an incremental checksum change that affects two checksums.</summary>
    /// <returns>The new value</returns>
    /// <remarks>
    /// This has the effect of calling <see cref="ChangeValueInChecksum(ushort, ushort, ref int)"/> twice, specifying <paramref name="checksum"/>
    /// the first time, and <paramref name="checksum2"/> the second.
    /// </remarks>
    public static ushort ChangeValueInChecksum(ushort oldVal, ushort newVal, ref int checksum, ref int checksum2)
    {
      RemoveFromChecksum(oldVal, ref checksum);
      RemoveFromChecksum(oldVal, ref checksum2);
      AddToChecksum(newVal, ref checksum);
      AddToChecksum(newVal, ref checksum2);
      Kiwi.Pause();
      return newVal;
    }

    /// <summary>Add the carry bits in a checksum working value and return the resulting checksum value.</summary>
    public static ushort GetChecksum(int checksum)
    {
      int rv = checksum;
      rv = (rv & 0xFFFF) + sshr(rv, 16);
      rv = (rv & 0xFFFF) + sshr(rv, 16);
      return (ushort)(~rv & 0xFFFF);
    }
  }
}
