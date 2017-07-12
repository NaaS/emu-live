/*
A (binary) CAM that relies on an external 8-bit hash function.
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

Testbench Kiwi-style.
*/

using System;
using KiwiSystem;

public class HashCAM_KL_Test : HashCAM
{
   [Kiwi.HardwareEntryPoint()]
   static void Main()
   {
     HashCAM.Read(10);
     HashCAM.Read(10);
     HashCAM.Write(10, 7);
     HashCAM.Read(10);
     HashCAM.Write(10, 7);
     HashCAM.Read(10);
     HashCAM.Write(10, 7);
     HashCAM.Read(10);

     HashCAM.Write(10, 8);
     HashCAM.Read(10);
     HashCAM.Write(10, 7);

     HashCAM.Read(11);
     HashCAM.Write(12, 9);

     for (int i = 0; i < 300; i++) {
       HashCAM.Write((ulong)i, 1);
       Kiwi.Pause();
     }
   }
}
