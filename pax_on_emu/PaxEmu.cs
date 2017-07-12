/*
Pax wrapper for the Emu library/workflow, that facilitates programming the
NetFPGA dataplane using .NET languages
Nik Sultana, Cambridge University Computer Lab, July 2016

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using KiwiSystem;
using Emu;
using Pax;

namespace Emu {

  // Wraps a Pax packet processor in a controller for NetFPGA's
  // data plane.
  // Given a frame of data, and its metadata, we use the metadata to
  // form the parameters to the Pax packet processor and call the processor.
  // When the process returns, we regain control of the updated frame, and we
  // interpret the return value into metadata for the frame's forwarding
  // through the dataplane.
  public partial class Frame_Processor
  {
    public const int no_interfaces = 4; // The NetFPGA has 4 network ports.
    public const uint max_packet_size = 1000; //in bytes

    static Frame_Processor()
    {
      // FIXME is there a cleaner way to do this?
      //       One idea is to pass the config (or a reference to it) directly
      //       to the packet processor.
      PaxConfig_Lite.no_interfaces = no_interfaces;
    }

    // FIXME this function could be inlined at compile time, since the
    //       surrounding functions are boilerplate.
    /*override*/ protected void Functor()
    {
      //Extract in_port and packet from NetFPGA_Data, and call the function
      //NOTE casting from uint to int
      int in_port = (int)NetFPGA.Read_Input_Port(dataplane);

      // FIXME currently we don't extract packet
      Hub/*FIXME currently hardcoded to Hub*/.process_packet ((byte)in_port);

/*FIXME WIP
      //Update NetFPGA_Data with packet and out_port
      // FIXME currently we don't update packet
      for (int ofs = 0; ofs < no_interfaces; ofs++)
      {
        if ((forward ^ 1L) == 0L)
        {
          NetFPGA.Set_Output_Port (ref dataplane, (ulong)(no_interfaces - ofs));
        }

        forward = forward >> 1;
      }
*/
    }
  }

  public partial class Frame_Processor : Transceiver
  {
/* NOTE this is from when Frame_Processor was an abstract class. I had to
        reorganise this since the original class structure didn't play well
        by Kiwi -- calls to Functor() were being ignored when I didn't manually
        inline it into Frame_Processor..

     // Functor is specified when Frame_Processor is specialised further.
     // NOTE it carries out useful work by side-effecting, to change the
     //      value of the "dataplane" variable. This is done this way to step
     //      around a current limitation of Kiwi's, which forbids us from
     //      modifying the values of parameters to a function.
     protected abstract void Functor ();
*/

     // Steps involved in processing and forwarding frames.
     public void Processor_Loop()
     {
        uint frame_size = 0;
        while (true) // Process frames indefinitely.
        {
           // Procedure call for receiving frame.
           frame_size = ReceiveFrame();
           Kiwi.Pause();

           Functor();

           // Procedure call for transmiting frame.
           SendFrame(frame_size);
           //End of frame processing. Ready for next frame.
        }
     }

     override public void SwitchLogic()
     {
       Processor_Loop();
     }

     override public NetFPGA_Data Get_Data()
     {
       return Frame_Processor.dataplane;
     }

     override public void Set_Data (NetFPGA_Data data)
     {
       Frame_Processor.dataplane = data;
     }
  }
}
