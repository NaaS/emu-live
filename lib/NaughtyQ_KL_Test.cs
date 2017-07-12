/*
FIFO queue where arbitrary nodes can be sent to the back of the queue (just as if they were naughty).
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

Testbench Kiwi-style.
*/

using System;
using KiwiSystem;

public class NaughtyQ_KL_Test : NaughtyQ
{
   [Kiwi.HardwareEntryPoint()]
   static void Main()
   {
     for (ulong i = 0; i < 20; i++) {
       Kiwi.Pause();
       NaughtyQ.Enlist(i);
       Kiwi.Pause();
     }

     NaughtyQ.BackOfQ(5);

     NaughtyQ.BackOfQ(10);

     NaughtyQ.BackOfQ(5);
     NaughtyQ.BackOfQ(5);

     for (ulong i = 0; i < 20; i++) {
       NaughtyQ.Read(i);
       Kiwi.Pause();
     }
   }
}
