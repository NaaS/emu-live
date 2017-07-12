/*
 Emu framework to run Kiwi-compiled code on the NetFPGA platform.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>
                       Nik Sultana, Cambridge University Computer Lab

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

namespace Emu
{
  public abstract class Transceiver
  {
     public static NetFPGA_Data dataplane = new NetFPGA_Data(); // FIXME currently this is NetFPGA-specific.

     // NOTE the following two methods are to circumvent not being able to
     //      reference a static field of a type variable. As a result of this i
     //      can't do T.dataplane if T : Transceiver.
     //      So instead I return/send this datastructure via object instances.
     abstract public NetFPGA_Data Get_Data();
     abstract public void Set_Data (NetFPGA_Data data);

     abstract public void SwitchLogic();

     // These are the ports of the circuit (and will appear as ports in the generated Verilog)
     // Slave Stream Ports
     [Kiwi.InputWordPort("s_axis_tdata")]      // rx_data
     protected static ulong s_axis_tdata;                // Write data to be sent to device
     [Kiwi.InputBitPort("s_axis_tkeep")]       // rx_sof_n
     protected static byte s_axis_tkeep;                 // Start of frame indicator
     [Kiwi.InputBitPort("s_axis_tlast")]       // rx_eof_n
     protected static bool s_axis_tlast;                 // End of frame indicator
     [Kiwi.InputBitPort("s_axis_tvalid")]      // rx_src_rdy_n
     protected static bool s_axis_tvalid;                // Source ready indicator
     #pragma warning disable 414
     [Kiwi.OutputBitPort("s_axis_tready")]     // rx_dst_rdy_n
     protected static bool s_axis_tready = true;         // Destination ready indicator
     #pragma warning restore 414
     [Kiwi.InputWordPort("s_axis_tuser_hi")]   //
     protected static ulong s_axis_tuser_hi;             //
     [Kiwi.InputWordPort("s_axis_tuser_low")]  //
     protected static ulong s_axis_tuser_low;            //

     // Master Stream Ports
     #pragma warning disable 414
     [Kiwi.OutputWordPort("m_axis_tdata")]    // tx_data
     protected static ulong m_axis_tdata;               // Write data to be sent to device
     [Kiwi.OutputBitPort("m_axis_tkeep")]     // tx_sof_n
     protected static byte m_axis_tkeep;                // Start of frame indicator
     [Kiwi.OutputBitPort("m_axis_tlast")]     // tx_eof_n
     protected static bool m_axis_tlast;                // End of frame indicator
     [Kiwi.OutputBitPort("m_axis_tvalid")]    // tx_src_rdy_n
     protected static bool m_axis_tvalid;               // Source ready indicator
     #pragma warning restore 414
     [Kiwi.InputBitPort("m_axis_tready")]     // tx_dst_rdy_n
     protected static bool m_axis_tready;               // Destination ready indicator
     #pragma warning disable 414
     [Kiwi.OutputBitPort("m_axis_tuser_hi")]  //
     protected static ulong m_axis_tuser_hi;            //
     [Kiwi.OutputBitPort("m_axis_tuser_low")] //
     protected static ulong m_axis_tuser_low;           //
     #pragma warning restore 414

     // This method describes the operations required to rx a frame over the AXI4-Stream.
     // and extract basic information such as dst_MAC, src_MAC, dst_port, src_port
     protected static uint ReceiveFrame()
     {
        m_axis_tdata     = (ulong)0x0;
        m_axis_tkeep     = (byte)0x0;
        m_axis_tlast     = false;
        m_axis_tuser_hi  = (ulong)0x0;
        m_axis_tuser_low = (ulong)0x0;
        s_axis_tready    = true;
        Kiwi.Pause();

        // The start condition
        uint cnt         = 0;
        uint size        = 0;
        bool doneReading = true;

        cnt         = 0;
        doneReading = true;

        while (doneReading)
        {
           if (s_axis_tvalid)
           {
              dataplane.tdata[cnt]     = s_axis_tdata;
              dataplane.tkeep[cnt]     = s_axis_tkeep;
              dataplane.tlast[cnt]     = s_axis_tlast;
              dataplane.tuser_hi[cnt]  = s_axis_tuser_hi;
              dataplane.tuser_low[cnt] = s_axis_tuser_low;

              // Create backpresure to whatever sends data to us
              //s_axis_tready = s_axis_tlast ? false : true;
              size          = cnt++;
              doneReading   = !s_axis_tlast && s_axis_tvalid;
              s_axis_tready = s_axis_tlast ? false : true;
           }
           Kiwi.Pause();
        }
        s_axis_tready = false;
        cnt           = 0;
        return size;
     }

     // This method describes the operations required to tx a frame over the AXI4-Stream.
     protected static void SendFrame(uint fm_size)
     {
        m_axis_tvalid    = true;
        m_axis_tlast     = false;
        m_axis_tdata     = (ulong)0x0;
        m_axis_tkeep     = (byte)0x0;
        m_axis_tuser_hi  = (ulong)0x0;
        m_axis_tuser_low = (ulong)0x0;

        uint i = 0;

        while (i <= fm_size)
        {
           if (m_axis_tready)
           {
              m_axis_tdata = dataplane.tdata[i];
              m_axis_tkeep = dataplane.tkeep[i];
              // -- BUG DONT USE
              //m_axis_tlast    = (i==fm_size) ? true : false;
              //if (i==fm_size) m_axis_tlast = true;
              m_axis_tlast     = i == (fm_size);
              m_axis_tuser_hi  = dataplane.tuser_hi[i];
              m_axis_tuser_low = dataplane.tuser_low[i];
              i++;
           }
           Kiwi.Pause();
        }

        m_axis_tvalid    = false;
        m_axis_tlast     = false;
        m_axis_tdata     = (ulong)0x0;
        m_axis_tkeep     = (byte)0x0;
        m_axis_tuser_hi  = (ulong)0x0;
        m_axis_tuser_low = (ulong)0x0;
        Kiwi.Pause();
     }
  }
}
