/*
 Emu framework to run Kiwi-compiled code on the NetFPGA platform.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>
                       Nik Sultana, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

 Version/additions
 -add code for receiving/transmiting, procedures/functions
 -add buffer to store the whole packet
 -move some code out of the receiving function. RX/TX functions are handling
  only the data and the control signals of the AXI4-Stream

 TODO:
 -need to take care of the tlast signal for tha last receiving frame
  not all the bytes are valid data
*/

using System;
using KiwiSystem;
using Emu;

public class Reference_Switch_Lite : Transceiver
{
   // Constants variables
   const uint LUT_SIZE = 16;

   // Lookup Table -- small one
   // Here we need to initialise (with something) the table with 0x01 instead of
   // 0x00 because in this case, in the simulation we get undefined values ('ZZ)
   // Format of the LUT entry ( 64bit )
   // |-	48bit	--	16bit	-|
   // |-	 MAC	--	port	-|
   static ulong[] LUT = new ulong[LUT_SIZE] { 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 };

   static ulong DEFAULT_oqs = (ulong)0x0000000000550000;

   override public NetFPGA_Data Get_Data()
   {
     return Reference_Switch_Lite.dataplane;
   }

   override public void Set_Data (NetFPGA_Data data)
   {
     Reference_Switch_Lite.dataplane = data;
   }

   // This method describes the operations required to forward the frames.
   override public void SwitchLogic()
   {
      uint pkt_size = 0;
#if !ON_HOST
      while (true) // Process packets indefinitely.
      {
         // Procedure call for receiving packet.
         pkt_size = ReceiveFrame();
#endif
         Kiwi.Pause();

      int  i        = 0, free = 0;
      bool exist    = false;

      bool LUT_hit = false;

      ulong tmp = 0, tmp2 = 0, dst_mac = 0, OQ = 0, broadcast_ports = 0;

         // #############################
         // # Switch Logic -- START
         // #############################

         // Once we have the destination MAC,
         // check the LUT if it exists in there
         // and set the appropriate metadata into the tuser field

         // Get the destination mac from the buffer
         dst_mac = dataplane.tdata[0] << 16;
         // Set the broadcasts ports if need for later, based on the metadata
         broadcast_ports = ((dataplane.tuser_low[0] ^ DEFAULT_oqs) >> 8) << 16 | dataplane.tuser_low[0];

         for (i = 0; i < LUT_SIZE; i++)
         {  // Get the mac address from LUT
            tmp = LUT[i] & (ulong)0xffffffffffff0000;
            // Get the output port from LUT
            tmp2 = LUT[i] & (ulong)0x000000000000ffff;
            Kiwi.Pause();
            // Compare with the one existed in the current packet
            if (tmp == dst_mac)
            {
               // Put the output port to the right offset
               OQ      = tmp2 << 24;
               LUT_hit = true;
               break;
            }
         }

         // If we have a hit set the appropriate output port in the metadata, otherwise broadcast.
         tmp = LUT_hit ? (ulong)(OQ | dataplane.tuser_low[0]) : (ulong)(broadcast_ports | dataplane.tuser_low[0]);
         Kiwi.Pause();
         // Configure the metadata.
         if ((dataplane.tdata[1] >> 32 & (ulong)0x00ffff) == (ulong)0x0008) { dataplane.tuser_low[0] = tmp; }
         Kiwi.Pause();

         // Once we have the source MAC,
         // If we had a hit in the previous stage-lookup, we skip this one
         // If we dint have a 'hit', then we need to store the source MAC and
         // the source port number

         //tmp = src_mac_hi | src_mac_low | src_port;
         tmp = ((dataplane.tdata[0] >> 48) << 16) | ((dataplane.tuser_low[0] >> 16) & 0xff);
         Kiwi.Pause();
         tmp |= (dataplane.tdata[1] << 32);

         // Check if we need to store a new entry into the LUT
         if (!LUT_hit)
         {
            LUT_hit = false;

            for (i = 0; i < LUT_SIZE; i++)
            {
               Kiwi.Pause();
               // Get rid off the oq, keep only the mac
               if (tmp == LUT[i])
               {
                  exist = true;
                  break;
               }
            }

            // Replace policy -- LIFO
            if (!exist)
            {
               LUT[free] = tmp;
               free = (free > (LUT_SIZE - 1)) ? 0 : free++;
            }
         }
         // #############################
         // # Switch Logic -- END
         // #############################

         // Procedure call for transmiting packet.
#if !ON_HOST
         SendFrame(pkt_size);
         //End of frame, ready for next frame.
      }
#endif
   }

   [Kiwi.HardwareEntryPoint()]
   static int EntryPoint()
   {
     var processor = new Reference_Switch_Lite();
     while (true) {
       processor.SwitchLogic();
       Kiwi.Pause();
     }
   }

  static int Main()
  {
     System.Console.WriteLine("This program cannot be executed in software yet!"); // FIXME
     return -1;
  }
}
