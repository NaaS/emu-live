/*
Pearson hashing.
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE filev

Lifts PearsonHash.v
*/

using System;
using KiwiSystem;

public class PearsonHash
{

   [Kiwi.OutputBitPort("PH_write_enable")]
   protected static bool write_enable;
   [Kiwi.OutputBitPort("PH_encipher_enable")]
   protected static bool encipher_enable;
   [Kiwi.OutputBitPort("PH_init_hash_enable")]
   protected static bool init_hash_enable;
   [Kiwi.OutputBitPort("PH_block_enable")]
   protected static bool block_enable;
   [Kiwi.InputBitPort("PH_block_ready")]
   protected static bool block_ready;
   [Kiwi.InputBitPort("PH_init_hash_ready")]
   protected static bool init_hash_ready;
   [Kiwi.InputBitPort("PH_write_ready")]
   protected static bool write_ready;
   [Kiwi.InputBitPort("PH_encipher_ready")]
   protected static bool encipher_ready;

   [Kiwi.OutputWordPort(7, 0, "PH_idx_in")]
   protected static byte idx_in;
   [Kiwi.OutputWordPort(7, 0, "PH_key_byte_in")]
   protected static byte key_byte_in;
   [Kiwi.OutputWordPort(7, 0, "PH_data_in")]
   protected static byte data_in;
   [Kiwi.OutputWordPort(63/*FIXME variable*/, 0, "PH_block_in")]
   protected static ulong block_in;

   [Kiwi.OutputWordPort(7, 0, "PH_cipher_out")]
   protected static byte cipher_out;
   [Kiwi.OutputWordPort(7, 0, "PH_block_hash")]
   protected static byte block_hash;

   public static void SetTable(byte idx_in, byte key_byte_in)
   {
     while (write_ready) { Kiwi.Pause(); }
     PearsonHash.idx_in = idx_in;
     PearsonHash.key_byte_in = key_byte_in;
     write_enable = true;
     Kiwi.Pause();
     while (!write_ready) { Kiwi.Pause(); }
     Kiwi.Pause();
     write_enable = false;
     Kiwi.Pause();
   }

   public static byte StreamHash(byte data_in)
   {
     byte result;
     while (encipher_ready) { Kiwi.Pause(); }
     PearsonHash.data_in = data_in;
     encipher_enable = true;
     Kiwi.Pause();
     while (!encipher_ready) { Kiwi.Pause(); }
     Kiwi.Pause();
     encipher_enable = false;
     result = cipher_out;
     Kiwi.Pause();
     return result;
   }

   public static void Seed(byte data_in)
   {
     while (init_hash_ready) { Kiwi.Pause(); }
     PearsonHash.data_in = data_in;
     init_hash_enable = true;
     Kiwi.Pause();
     while (!init_hash_ready) { Kiwi.Pause(); }
     Kiwi.Pause();
     init_hash_enable = false;
     Kiwi.Pause();
   }

   public static byte BlockHash(ulong block_in)
   {
     byte result;
     while (block_ready) { Kiwi.Pause(); }
     PearsonHash.block_in = block_in;
     block_enable = true;
     Kiwi.Pause();
     while (!block_ready) { Kiwi.Pause(); }
     Kiwi.Pause();
     block_enable = false;
     result = block_hash;
     Kiwi.Pause();
     return result;
   }
}
