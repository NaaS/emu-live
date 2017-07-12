/*
 Emu framework to run Kiwi-compiled code on the NetFPGA platform.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>
                       Nik Sultana, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using KiwiSystem;

namespace Emu
{
  namespace Protocols
  {
    public class Memcached
    {
       // Constants for the Memcached header
       // Magic numbers
       public const byte REQUEST  = 0x80;
       public const byte RESPONSE = 0x81;
       // Opcodes
       public const byte GET_op    = 0x00;
       public const byte SET_op    = 0x01;
       public const byte DELETE_op = 0x04;
       // Error textual message
       public const ulong ERROR_MSG = //FIXME const
         0x313020524f525245; // ASCII = "10 RORRE" ~ "ERROR 01"

       public static byte Memcached_Opcode(Memory_Operation op)
       {
          switch (op)
          {
          case Memory_Operation.GET:
             return GET_op;

          case Memory_Operation.SET:
             return SET_op;

          case Memory_Operation.DELETE:
             return DELETE_op;
          }
          return GET_op; //FIXME fudge
       }

       public static Memory_Operation Memcached_Operation(byte op)
       {
          switch (op)
          {
          case GET_op:
             return Memory_Operation.GET;

          case SET_op:
             return Memory_Operation.SET;

          case DELETE_op:
             return Memory_Operation.DELETE;
          }
          return Memory_Operation.GET; //FIXME fudge
       }

       // This procedure creates the SET response packet
       static public uint Memcached_SET(ref ulong[] tdata,
                                        ulong IP_total_length, ulong UDP_total_length)
       {
          ulong tmp = 0x00, tmp2 = 0x00;

          // Set the correct IP packet length (little endianess)
          // SET - Fixed size of extras(8B) + key(6B) + value(8B)
          tmp = ((ulong)(ulong)((IP_total_length >> 8) | (IP_total_length << 8 & (ulong)0x00ff00)) - (ulong)22) & (ulong)0x00ffff;

          tmp2 = tdata[2] & (ulong)0xffffffffffff0000;
          Kiwi.Pause();
          tdata[2] = tmp2 | (tmp >> 8) | (tmp << 8 & (ulong)0x00ff00);
          Kiwi.Pause();

          // Set the checksum to 0x00, calculate later
          tmp = tdata[3] & (ulong)0xffffffffffff0000;
          Kiwi.Pause();
          tdata[3] = tmp;

          // Set the correct UDP packet length (little endianess)
          // SET - Fixed size of extras(8B) + key(6B) + value(8B)
          tmp = ((ulong)(ulong)((UDP_total_length >> 8) | (UDP_total_length << 8 & (ulong)0x00ff00)) - (ulong)22);

          tmp2 = tdata[4] & (ulong)0x0000ffffffffffff;
          Kiwi.Pause();
          tdata[4] = tmp2 | ((tmp & (ulong)0xff00) << 40) | (tmp << 56);
          Kiwi.Pause();

          // Reset the UDP checksum
          tmp = tdata[5];
          Kiwi.Pause();
          tdata[5] = tmp & ~(ulong)0x00ffff;
          Kiwi.Pause();

          tmp = tdata[6] & (ulong)0x00ffff;
          Kiwi.Pause();
          tdata[6] = (ulong)SET_op << 24 | (ulong)RESPONSE << 16 | tmp;
          Kiwi.Pause();

          // Set the opaque - SET response
          // SET response doesnt support error code
          tmp = tdata[7] & 0xffff000000000000;
          Kiwi.Pause();
          tdata[7] = tmp;
          Kiwi.Pause();

          tmp = tdata[8] & 0x000000000000ffff;
          Kiwi.Pause();
          tdata[8] = tmp;
          Kiwi.Pause();

          tdata[9] = (ulong)0x00;

          return 9U;
       }
    }
  }
}
