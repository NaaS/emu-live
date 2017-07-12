/*
 Emu framework to run Kiwi-compiled code on the NetFPGA platform.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>
                       Nik Sultana, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

 TODO:
	-change the CAM to implement a RAM-based CAM (1cc read, 2cc write)
*/

using System;
using KiwiSystem;

namespace Emu
{
  /// <summary>
  ///   CAM_Index: CAM is used to map a word into an index (in some array) from where to look up the answer.
  /// </summary>
  public abstract class CAM_Index : Transceiver
  // FIXME ideally we'd have CAM as a module that can be used in a Transceiver,
  //       rather than as a kind of Transceiver.
  {
     // CAM Memory Ports
     // Input Ports
     [Kiwi.InputBitPort("cam_busy")]
     static bool cam_busy;
     [Kiwi.InputBitPort("cam_match")]
     static bool cam_match;
     [Kiwi.InputBitPort("cam_match_addr")]
     static byte cam_match_addr;                  // 8-bit address width
     // Output Ports
     #pragma warning disable 414
     [Kiwi.OutputWordPort("cam_cmp_din")]
     static ulong cam_cmp_din = ~(ulong)0x00;     // 64-bit width compare din
     [Kiwi.OutputWordPort("cam_din")]
     static ulong cam_din = 0x00;                 // 64-bit width din
     [Kiwi.OutputBitPort("cam_we")]
     static bool cam_we = false;
     [Kiwi.OutputBitPort("cam_wr_addr")]
     static byte cam_wr_addr = 0x00;              // 8-bit address width
     #pragma warning restore 414

     public static readonly uint MEM_SIZE;

     static CAM_Index()
     {
       MEM_SIZE = (uint)256; // FIXME const
     }

   static uint mem_controller_cnt = 0;

   // This procedure performs the basic control operation for the CAM.
   protected static uint CAM_Control (Memory_Operation mode, ulong key)
   {
      uint  tmp_addr = 0x00, addr = 0x00;
      ulong tmp_key;
      //tmp_addr=0x00;
      bool busy = true;

      // 1 cycle read latency, 16 cycles write latency
      // mode=true , WRITE operation
      //Kiwi.Pause();
      // Poll until CAM is ready
      while (cam_busy) { Kiwi.Pause(); }

      //addr = mem_controller_cnt;
      //tmp_key = key;

      //if(mem_controller_cnt == (uint)(MEM_SIZE-1U)) mem_controller_cnt = 0;

      switch (mode)
      {                 // WRITE operation - returns the address in which the key is stored
      case Memory_Operation.SET:         // 0x01
         cam_din     = key;
         cam_wr_addr = (byte)mem_controller_cnt;
         tmp_addr    = (byte)mem_controller_cnt;
         Kiwi.Pause();
         cam_we = true;
         Kiwi.Pause();
         cam_we = false;
         Kiwi.Pause();

         break;

      // READ operation - return the address if we have a match otherwhise MEM_SIZE
      case Memory_Operation.GET:                   // 0x00
         cam_cmp_din = key;
         Kiwi.Pause();
         cam_cmp_din = key;
         Kiwi.Pause();

         tmp_addr = (cam_match) ? (uint)cam_match_addr : (uint)MEM_SIZE;

         break;

      // DELETE operation - return the address if we have a match otherwhise MEM_SIZE
      case Memory_Operation.DELETE:                   // 0x04
         cam_cmp_din = key;
         Kiwi.Pause();
         cam_cmp_din = key;
         Kiwi.Pause();
         if (cam_match)
         {
            tmp_addr = (uint)cam_match_addr;
         }
         else
         {
            tmp_addr = (uint)MEM_SIZE;
         }

         Kiwi.Pause();
         if (cam_match)
         {
            Kiwi.Pause();
            cam_din     = (ulong)0x00;
            cam_wr_addr = (byte)tmp_addr;
            Kiwi.Pause();
            cam_we = true;
            Kiwi.Pause();
            cam_we = false;
            Kiwi.Pause();
         }
         break;

      default:
         break;
      }

      if (mem_controller_cnt == (uint)(MEM_SIZE - 1U)) { mem_controller_cnt = 0; }
      else{ mem_controller_cnt += 1U; }

      return tmp_addr;
   }
  }
}
