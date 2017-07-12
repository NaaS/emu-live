/*
 Mock for the Transceiver class from the Emu framework to run Kiwi-compiled code on the NetFPGA platform.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>
                       Nik Sultana, Cambridge University Computer Lab
                       Jonny Shipton

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using KiwiSystem;

namespace Emu
{
  /* NOTE this is a Mock of the Emu.Transceiver class to allow CLR debugging */
  public abstract class Transceiver
  {
    /// <summary>
    /// Allows testing
    /// </summary>
    public static MockFrameController FrameController { get; set; }


    // These are the ports of the circuit (and will appear as ports in the generated Verilog)
    // Slave Stream Ports
    [Kiwi.InputWordPort("s_axis_tdata")]          // rx_data
    protected static ulong s_axis_tdata;          // Write data to be sent to device
    [Kiwi.InputBitPort("s_axis_tkeep")]           // rx_sof_n
    protected static byte s_axis_tkeep;           // Start of frame indicator
    [Kiwi.InputBitPort("s_axis_tlast")]           // rx_eof_n
    protected static bool s_axis_tlast;           // End of frame indicator
    [Kiwi.InputBitPort("s_axis_tvalid")]          // rx_src_rdy_n
    protected static bool s_axis_tvalid;          // Source ready indicator
#pragma warning disable 414
    [Kiwi.OutputBitPort("s_axis_tready")]         // rx_dst_rdy_n
    protected static bool s_axis_tready = true;   // Destination ready indicator
#pragma warning restore 414
    [Kiwi.InputWordPort("s_axis_tuser_hi")]
    protected static ulong s_axis_tuser_hi;
    [Kiwi.InputWordPort("s_axis_tuser_low")]
    protected static ulong s_axis_tuser_low;

    // Master Stream Ports
#pragma warning disable 414
    [Kiwi.OutputWordPort("m_axis_tdata")]     // tx_data
    protected static ulong m_axis_tdata;      // Write data to be sent to device
    [Kiwi.OutputBitPort("m_axis_tkeep")]      // tx_sof_n
    protected static byte m_axis_tkeep;       // Start of frame indicator
    [Kiwi.OutputBitPort("m_axis_tlast")]      // tx_eof_n
    protected static bool m_axis_tlast;       // End of frame indicator
    [Kiwi.OutputBitPort("m_axis_tvalid")]     // tx_src_rdy_n
    protected static bool m_axis_tvalid;      // Source ready indicator
#pragma warning restore 414
    [Kiwi.InputBitPort("m_axis_tready")]      // tx_dst_rdy_n
    protected static bool m_axis_tready;      // Destination ready indicator
#pragma warning disable 414
    [Kiwi.OutputBitPort("m_axis_tuser_hi")]
    protected static ulong m_axis_tuser_hi;
    [Kiwi.OutputBitPort("m_axis_tuser_low")]
    protected static ulong m_axis_tuser_low;
#pragma warning restore 414

    protected static NetFPGA_Data dataplane = new NetFPGA_Data();

    // This method describes the operations required to rx a frame over the AXI4-Stream.
    // and extract basic information such as dst_MAC, src_MAC, dst_port, src_port
    protected static uint ReceiveFrame()
    {
      var frame = FrameController.ReceiveFrame();
      dataplane = frame.Data;
      uint size = (uint)Math.Min(dataplane.tdata.Length, dataplane.tlast.TakeWhile(x => !x).Count() + 1); // Length of frame in ulongs
      return size;
    }

    // This method describes the operations required to tx a frame over the AXI4-Stream.
    protected static void SendFrame(uint fm_size)
    {
      // Make sure the data is as if it had been sent by the authentic Transceiver code:
      for (int i = 0; i < dataplane.tlast.Length; i++)
        dataplane.tlast[i] = i == fm_size;

      FrameController.SendFrame(dataplane);
    }
  }
}
