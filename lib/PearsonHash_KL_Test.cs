/*
Pearson hashing.
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

Testbench Kiwi-style.
*/


using System;
using KiwiSystem;

class PearsonHash_KL_Test : PearsonHash
{
   [Kiwi.HardwareEntryPoint()]
   static void Main()
   {
     Kiwi.Pause();
     PearsonHash.Seed((byte)(10));
     Kiwi.Pause();

     // FIXME these loops seem to give rise to infinite behaviour by Kiwi.
     //       Perhaps related to use of "byte"?
     /*
     for (byte i = 0; i <= 255; i++) {
       PearsonHash.SetTable(i, (byte)(255 - i));
       Kiwi.Pause();
     }
     */
     for (int i = 0; i < 256; i++) {
       PearsonHash.SetTable((byte)i, (byte)(255 - i));
       Kiwi.Pause();
     }

     PearsonHash.SetTable(10, 20);
     PearsonHash.SetTable(20, 10);

     PearsonHash.StreamHash(0);
     PearsonHash.StreamHash(1);
     PearsonHash.StreamHash(2);
     PearsonHash.StreamHash(3);

     PearsonHash.Seed((byte)(8));

     // FIXME these loops seem to give rise to infinite behaviour by Kiwi.
     //       Perhaps related to use of "byte"?
     /*
     for (byte i = 0; i <= 255; i++) {
       PearsonHash.StreamHash(i);
       Kiwi.Pause();
     }
     */
     for (int i = 0; i < 256; i++) {
       PearsonHash.StreamHash((byte)i);
       Kiwi.Pause();
     }

     PearsonHash.BlockHash(901242);
     PearsonHash.BlockHash(10);
     PearsonHash.BlockHash(901242);
     PearsonHash.BlockHash(10);
   }
}
