/*
 Reference learning Switch lite (C#) for the NetFPGA platform and Kiwi compiler.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk<
                       Nik Sultana, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using System.Runtime.CompilerServices;
using KiwiSystem;
using Emu;
using Emu.Protocols;

class Switch : Frame_Functor
{
   public const uint LUT_SIZE = 16;

   // Lookup Table -- small one
   // Here we need to initialise (with something) the table with 0x01 instead of
   // 0x00 because in this case, in the simulation we get undefined values ('ZZ)
   // Format of the LUT entry ( 64bit )
   // |-	48bit	--	16bit	-|
   // |-	 MAC	--	port	-|
    static ulong[] LUT = new ulong[LUT_SIZE] { 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 };

   static int free = 0;

    /*FIXME would like to do this to push the compiler to inline as much as it can,
            but this annotation seems to require .NET 4.5:
   [MethodImpl(MethodImplOptions.AggressiveInlining)]*/
   override public void Apply(ref NetFPGA_Data dataplane)
   {
      bool dstmac_lut_hit = false;
      bool srcmac_lut_exist = false;
      ulong lut_element_op = 0; // Output port

      // Get the destination MAC from the buffer.
      ulong dst_mac = dataplane.tdata.Destination_MAC();

      //We structure "srcmac_port" as follows: src_mac_hi | src_mac_low | src_port;
      ulong srcmac_port = (dataplane.tdata.Source_MAC() << 16) | ((dataplane.tuser_low[0] >> 16) & 0xff);
      Kiwi.Pause();

      // Once we have the destination MAC, check if it exists in the LUT.
      // We will later set the appropriate metadata into the tuser field accordingly.
      // We also check if the source MAC is in our LUT. If it isn't then we will
      // later add it, to map to the source port number.
      // FIXME how to make an API that can be backed by a CAM rather than this loop for look-up?
      foreach (ulong lut_element in LUT)
      {
         // Get the mac address from LUT
         ulong lut_element_mac = lut_element.Extract_Bytes(length: 6);
         // Get the output port from LUT
         lut_element_op = lut_element.Extract_Bytes(from_byte: 6, length: 2);
         Kiwi.Pause();
         if (!dstmac_lut_hit && lut_element_mac == dst_mac)
         {
            dstmac_lut_hit = true;
         }

         if (!srcmac_lut_exist && srcmac_port == lut_element)
         {
            srcmac_lut_exist = true;
         }
      }

      Kiwi.Pause();
      // If the frame does not contain an IPv4 packet then we do not set its
      // output port; this implicitly drops the frame.
      if (dataplane.tdata.EtherType_Is(Ethernet.EtherTypes.IPv4)) {
          // Configure the metadata such that if we have a hit then set the appropriate output
          // port in the metadata, otherwise broadcast.
          if (dstmac_lut_hit) {
              NetFPGA.Set_Output_Port(ref dataplane, lut_element_op);
          } else {
              NetFPGA.Broadcast(ref dataplane);
          }
      }
      Kiwi.Pause();

      // Add source MAC to our LUT if it's not already there, thus the switch "learns".
      if (!srcmac_lut_exist)
      {
         LUT[free] = srcmac_port;
         free = (free > (LUT_SIZE - 1)) ? 0 : free++;
      }
   }
}


#if Kiwi_Extension
class Reference_Switch_Liter : Frame_Processor<Switch>
{
#elif Kiwi_Current
class Reference_Switch_Liter : Frame_Processor
{
   public Reference_Switch_Liter()
   {
      // Set the behaviour of this frame processor.
      functor = new Switch();
   }
#else
#error Need to specify which version of Kiwi is being targeted.
#endif
   [Kiwi.HardwareEntryPoint()]
   static int EntryPoint()
   {
      // FIXME not sure if we need this outer loop, waiting to hear back from David
      //       if it would break Kiwi's semantics if i removed it.
      while (true) { Processor_Loop(); }
   }

   static int Main()
   {
      System.Console.WriteLine("This program cannot be executed in software yet!"); // FIXME
      return -1;
   }
}


class Switch_Old : Frame_Functor
{
   public const uint LUT_SIZE = 16;

   // Lookup Table -- small one
   // Here we need to initialise (with something) the table with 0x01 instead of
   // 0x00 because in this case, in the simulation we get undefined values ('ZZ)
   // Format of the LUT entry ( 64bit )
   // |-	48bit	--	16bit	-|
   // |-	 MAC	--	port	-|
   static ulong[] LUT = new ulong[LUT_SIZE] { 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001 };

   static int free = 0;

    /*FIXME would like to do this to push the compiler to inline as much as it can,
            but this annotation seems to require .NET 4.5:
   [MethodImpl(MethodImplOptions.AggressiveInlining)]*/
   override public void Apply(ref NetFPGA_Data dataplane)
   {
      bool lut_hit = false;
      ulong lut_element_op = 0; // Output port

      ulong tmp = 0;

      // Get the destination MAC from the buffer.
      ulong dst_mac = dataplane.tdata.Destination_MAC();

      // Once we have the destination MAC, check if it exists in the LUT.
      // We will later set the appropriate metadata into the tuser field accordingly.
      foreach (ulong lut_element in LUT)
      {
         // Get the mac address from LUT
         ulong lut_element_mac = lut_element.Extract_Bytes(length: 6); /*LUT[i] & (ulong)0xffffffffffff0000;*/
         // Get the output port from LUT
         lut_element_op = lut_element.Extract_Bytes(from_byte: 6, length: 2); /*LUT[i] & (ulong)0x000000000000ffff*/
         Kiwi.Pause();
         if (lut_element_mac == dst_mac)
         {
            lut_hit = true;
            break;
         }
      }

      Kiwi.Pause();
      // If the frame does not contain an IPv4 packet then we do not set its
      // output port; this implicitly drops the frame.
      if (dataplane.tdata.EtherType_Is(Ethernet.EtherTypes.IPv4)) {
          // Configure the metadata such that if we have a hit then set the appropriate output
          // port in the metadata, otherwise broadcast.
          if (lut_hit) {
              NetFPGA.Set_Output_Port(ref dataplane, lut_element_op);
          } else {
              NetFPGA.Broadcast(ref dataplane);
          }
      }
      Kiwi.Pause();


      // Check if the source MAC is in our LUT. If it isn't then add it,
      // to map to the source port number.

      //We structure "tmp" as follows: src_mac_hi | src_mac_low | src_port;
      tmp = (dataplane.tdata.Source_MAC() << 16) | ((dataplane.tuser_low[0] >> 16) & 0xff);
      Kiwi.Pause();

      // Check if we need to store a new entry into the LUT
      if (!lut_hit)
      {
#if Kiwi_Extension
         // NOTE the Kiwi interpretation of IndexOf might need to insert hard pauses.
         bool exist = Array.IndexOf(LUT, tmp) > -1 ? true : false;
#else
         bool exist = false;
         foreach (ulong element in LUT)
         {
            Kiwi.Pause();
            // Get rid off the oq, keep only the mac
            if (tmp == element)
            {
               exist = true;
               break;
            }
         }
#endif
         if (!exist)
         {
            LUT[free] = tmp;
            free = (free > (LUT_SIZE - 1)) ? 0 : free++;
         }
      }
   }
}

// NOTE I'm not using this yet, it's an idea for further refactoring: having an abstract switch
// class.
abstract class Abs_Switch : Frame_Functor
{
   private readonly uint LUT_SIZE;

   // Lookup Table -- small one
   // Here we need to initialise (with something) the table with 0x01 instead of
   // 0x00 because in this case, in the simulation we get undefined values ('ZZ)
   // Format of the LUT entry ( 64bit )
   // |-	48bit	--	16bit	-|
   // |-	 MAC	--	port	-|
   static ulong[] LUT;

   static int free = 0;

   public Abs_Switch(uint lut_size)
   {
       LUT_SIZE = lut_size;
       for (int i = 0; i < LUT_SIZE; i++)
       {
         LUT[i] = 0x0000000000000001;
       }
   }
}
