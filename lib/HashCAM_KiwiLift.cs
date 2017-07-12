/*
A (binary) CAM that relies on an external 8-bit hash function.
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

Lifts HashCAM.v
*/

using System;
using KiwiSystem;

public class HashCAM
{
   [Kiwi.OutputBitPort("HC_write_enable")]
   protected static bool write_enable;
   [Kiwi.InputBitPort("HC_write_ready")]
   protected static bool write_ready;

   [Kiwi.OutputBitPort("HC_lookup_enable")]
   protected static bool lookup_enable;
   [Kiwi.InputBitPort("HC_lookup_ready")]
   protected static bool lookup_ready;

   [Kiwi.InputBitPort("HC_match")]
   protected static bool match;
   [Kiwi.InputBitPort("HC_full")]
   protected static bool full;

   [Kiwi.OutputWordPort(15/*FIXME variable*/, 0, "HC_key_in")]
   protected static ulong key_in;
   [Kiwi.OutputWordPort(7/*FIXME variable*/, 0, "HC_value_in")]
   protected static ulong value_in;
   [Kiwi.InputWordPort(7/*FIXME variable*/, 0, "HC_value_out")]
   protected static ulong value_out;

   public static bool matched = false;
   public static bool is_full = false;

   public static ulong Read(ulong key_in)
   {
     ulong result = 0;
     while (lookup_ready) { Kiwi.Pause(); }
     HashCAM.key_in = key_in;
     lookup_enable = true;
     Kiwi.Pause();
     while (!lookup_ready) { Kiwi.Pause(); }
     Kiwi.Pause();
     matched = match;
     result = value_out;
     lookup_enable = false;
     Kiwi.Pause();
     return result;
   }

   public static ulong Write(ulong key_in, ulong value_in)
   {
     ulong result = 0;
     while (write_ready) { Kiwi.Pause(); }
     HashCAM.key_in = key_in;
     HashCAM.value_in = value_in;
     write_enable = true;
     Kiwi.Pause();
     while (!write_ready) { Kiwi.Pause(); }
     Kiwi.Pause();
     matched = match;
     result = value_out;
     is_full = full;
     write_enable = false;
     Kiwi.Pause();
     return result;
   }

   [Kiwi.HardwareEntryPoint()]
   public static void Main()
   {
     while (true) {
       Kiwi.Pause();
     }

     Read(HashCAM.key_in);
     Write(HashCAM.key_in, HashCAM.value_in);
   }
}
