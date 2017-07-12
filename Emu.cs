/*
 Emu framework to run Kiwi-compiled code on the NetFPGA platform.
 Copyright (C) 2016 Nik Sultana, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

#if Kiwi_Current && Kiwi_Extension
#error Cannot be both Kiwi_Current and Kiwi_Extension.
#endif

using System;
using KiwiSystem;

namespace Emu
{
  public enum Endianness {Little, Big};

  // FIXME currently the BitConverter class isn't supported by Kiwi.
  //       Could get around this by writing my own version of BitConverter.GetBytes(ulong).
  public static class Emu
  {
    //FIXME naming isn't great.
    public const uint MIN_IDX = 0;
    public const uint MAX_IDX = 7;

    public static ulong Extract_Bytes(this ulong value, Endianness eness = Endianness.Big,
                                      uint from_byte = 0, byte length = 8)
    {
        // FIXME should assert (length >= 0)
        // FIXME should assert (from_byte+length <= MAX_IDX+1)
        if (length == 0) {
            return 0;
        }

        return Extract_Bytes(value, eness, from_byte,
                             until_byte: (uint)(from_byte + (length - 1)));
    }

    // Extract_Bytes involves first running Keep_Bytes then shifting the bytes to
    // the lowest position (consistent with the endianness being used).
    // We start counting from the least significant byte.
    // For example, Extract_Bytes(ABCDEFGH, Endianness.Little, 2, 5) = CDEF0000.
    public static ulong Extract_Bytes(this ulong value, Endianness eness = Endianness.Big,
                                      uint from_byte = 0, uint until_byte = 7)
    {
        // FIXME should assert (until_byte <= MAX_IDX)
        // FIXME should assert (from_byte <= until_byte)

        value = Keep_Bytes(value, eness, from_byte, until_byte);

        switch (eness) {
            case Endianness.Big:
                // Shift to the right by from_byte elements.
                value = value >> (int)from_byte; // NOTE this cast is acceptable since 0 <= from_byte <= MAX_IDX
                break;
            case Endianness.Little:
                // Shift to the left by from_byte elements.
                value = value << (int)from_byte; // NOTE this cast is acceptable since 0 <= from_byte <= MAX_IDX
                break;
        }

        return value;
    }

    // Keep a range of bytes in a ulong, zeroing out all other bytes.
    // We start counting from the least significant byte.
    // For example, Keep_Bytes(ABCDEFGH, Endianness.Little, 2, 5) = 00CDEF00.
    public static ulong Keep_Bytes(this ulong value, Endianness eness = Endianness.Big,
                                   uint from_byte = 0, uint until_byte = 7)
    {
        // FIXME should assert (until_byte <= MAX_IDX)
        // FIXME should assert (from_byte <= until_byte)
        if (from_byte == MIN_IDX && until_byte == MAX_IDX)
        {
            return value;
        }

        byte[] value_bytes = new byte[8];
        value_bytes = BitConverter.GetBytes(value);

        switch (until_byte < 0) {
            case true: // Copy until the end.
                switch (from_byte == 0) {
                    case true: // Copy from the start.
                        // Leave the result as it is.
                        break;
                    case false:
                        switch (eness) {
                            case Endianness.Big:
                                // We need to zero-out the last from_byte+1 bytes.
                                for (uint i = MAX_IDX - (from_byte + 1); i <= MAX_IDX; i++) {
                                    value_bytes[i] = 0;
                                }
                                break;
                            case Endianness.Little:
                                // We need to zero-out the first from_byte+1 bytes.
                                for (uint i = MIN_IDX; i <= from_byte + 1; i++) {
                                    value_bytes[i] = 0;
                                }
                                break;
                        }
                        break;
                }
                break;
            case false:
                switch (from_byte == 0) {
                    case true: // Copy from the start, but not until the end.
                        switch (eness) {
                            case Endianness.Big:
                                // We need to zero-out the first MAX_IDX-until_byte bytes.
                                for (uint i = MIN_IDX; i <= MAX_IDX - until_byte; i++) {
                                    value_bytes[i] = 0;
                                }
                                break;
                            case Endianness.Little:
                                // We need to zero-out the last MAX_IDX-until_byte bytes.
                                for (uint i = MAX_IDX - until_byte; i <= MAX_IDX; i++) {
                                    value_bytes[i] = 0;
                                }
                                break;
                        }
                        break;
                    case false:
                        // This is the most complicated case: we need to copy from some non-start
                        // byte until some non-end byte. We break this into two loops, each of
                        // which zeroes a range of bytes.
                        for (uint i = MIN_IDX; i < from_byte; i++) {
                            value_bytes[i] = 0;
                        }
                        for (uint i = until_byte; i <= MAX_IDX; i++) {
                            value_bytes[i] = 0;
                        }
                        break;
                }
                break;
        }

#if Kiwi_Current
#warning Not sure if BitConverter.ToUInt64 is currently handled by Kiwi.
#endif
      return BitConverter.ToUInt64(value_bytes, 0);
    }

      public static ulong Switch_Endian(ulong value)
      {
          byte[] value_bytes = new byte[8];
#if Kiwi_Current
#warning BitConverter.GetBytes(ulong) is currently not handled by Kiwi.
#endif
          value_bytes = BitConverter.GetBytes(value);
          Array.Reverse(value_bytes);
#if Kiwi_Current
#warning Not sure if BitConverter.ToUInt64 is currently handled by Kiwi.
#endif
          return BitConverter.ToUInt64(value_bytes, 0);
      }

      public static void Ulong_To_Bytes(ulong value, out byte[] value_bytes)
      {
#if Kiwi_Current
#warning BitConverter.GetBytes(ulong) is currently not handled by Kiwi.
#endif
          value_bytes = BitConverter.GetBytes(value);
          return;
      }

    /// Extract up to a ulong's worth of bytes from an array of ulongs.
    /// </summary>
    public static ulong Extract_Bytes(this ulong[] value, Endianness eness = Endianness.Big,
                                      uint from_byte = 0, byte length = 8)
    {
        ulong result = 0;

        // FIXME should assert that from_byte <= frame size.
        //       FIXME we currently don't have the frame size in context to refer to?
        // FIXME should assert (length <= MAX_IDX+1)
        if (length == 0) {
            // FIXME assert (result == 0)
            return result;
        }

        // Find the offsets in value[] that contains the initial and final byte.
        uint startbyte_offset = from_byte / (Emu.MAX_IDX + 1); // Integer division
        uint endbyte_offset = (from_byte + length) / (Emu.MAX_IDX + 1); // Integer division
        // Find the offset of the initial and final bytes within the ulongs that contain them.
        from_byte = from_byte % (Emu.MAX_IDX + 1);

        if (startbyte_offset == endbyte_offset) {
            // Computation reduces to extracting bytes from a single offset in the array.
            result = Emu.Extract_Bytes(value[startbyte_offset], eness, from_byte, length);
        } else {
            // We need to extract bytes from two (adjacent) offsets in the array.
            ulong result_1 =
                (Emu.Extract_Bytes(value[startbyte_offset], eness,
                                   // Extract from the required byte until the end of the ulong.
                                   from_byte, until_byte: Emu.MAX_IDX));
            // How much to shift the first part of the result
            uint lshift = length - Emu.MAX_IDX + from_byte;
            ulong result_2 =
                (Emu.Extract_Bytes(value[startbyte_offset], eness,
                                   // Extract from the beginning until the required length.
                                   Emu.MIN_IDX, lshift));
            // NOTE (int) cast should be fine since lshift can't be that large.
            result = (result_1 << (int)lshift) | result_2;
        }

        return result;
    }
  }
}
