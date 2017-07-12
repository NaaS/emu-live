/*
FIFO queue where arbitrary nodes can be sent to the back of the queue (just as if they were naughty).
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

Lifts NaughtyQ.v
*/

using System;
using KiwiSystem;

public class NaughtyQ
{
   protected enum op_code {Nothing = 0, Enlist = 1, BackOfQ = 2, Read = 3}

   [Kiwi.OutputBitPort("NQ_enable")]
   protected static bool enable;
   [Kiwi.InputBitPort("NQ_ready")]
   protected static bool ready;
   [Kiwi.InputBitPort("NQ_crashed")]
   protected static bool crashed;

   [Kiwi.OutputWordPort(3, 0, "NQ_command")]
   protected static byte command;

   [Kiwi.InputWordPort(3, 0, "NQ_idx_out")]
   protected static ulong idx_out;
   [Kiwi.InputWordPort(7, 0, "NQ_data_out")]
   protected static ulong data_out;

   [Kiwi.OutputWordPort(3, 0, "NQ_idx_in")]
   protected static ulong idx_in;
   [Kiwi.OutputWordPort(7, 0, "NQ_data_in")]
   protected static ulong data_in;

   // Nonvolatile copies of outputs.
   public static ulong idx_out_nv;
   public static ulong data_out_nv;

   public static ulong Enlist(ulong data_in)
   {
     while (ready) { Kiwi.Pause(); }
     command = (byte)op_code.Enlist;
     NaughtyQ.data_in = data_in;
     enable = true;
     Kiwi.Pause();
     while (!ready) { Kiwi.Pause(); }
     Kiwi.Pause();
     idx_out_nv = idx_out;
     data_out_nv = data_out;
     enable = false;
     Kiwi.Pause();
     return idx_out_nv;
   }

   public static void BackOfQ(ulong idx_in)
   {
     while (ready) { Kiwi.Pause(); }
     command = (byte)op_code.BackOfQ;
     NaughtyQ.idx_in = idx_in;
     enable = true;
     Kiwi.Pause();
     while (!ready) { Kiwi.Pause(); }
     enable = false;
     Kiwi.Pause();
   }

   public static ulong Read(ulong idx_in)
   {
     while (ready) { Kiwi.Pause(); }
     command = (byte)op_code.Read;
     NaughtyQ.idx_in = idx_in;
     enable = true;
     Kiwi.Pause();
     while (!ready) { Kiwi.Pause(); }
     Kiwi.Pause();
     data_out_nv = data_out;
     enable = false;
     Kiwi.Pause();
     return data_out_nv;
   }

   [Kiwi.HardwareEntryPoint()]
   public static void Main()
   {
     while (true) {
       Kiwi.Pause();
     }

     Enlist(NaughtyQ.data_in);
     BackOfQ(NaughtyQ.idx_in);
     Read(NaughtyQ.idx_in);
   }
}
