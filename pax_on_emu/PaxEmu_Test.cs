/*
Example of using the Pax wrapper for the Emu library/workflow.
Nik Sultana, Cambridge University Computer Lab, July 2016

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using KiwiSystem;
using Emu;

// NOTE this class is entirely boilerplate except for the class being used
//      i.e., Frame_Processor currently.
class PaxEmu_Test
{
   [Kiwi.HardwareEntryPoint()]
   static int EntryPoint()
   {
      var hub = new Frame_Processor();

      while (true) {
        hub.Processor_Loop();
        Kiwi.Pause();
      }
   }

  static int Main()
  {
     System.Console.WriteLine("Use Pax to run this on the host");
     return -1;
  }
}
