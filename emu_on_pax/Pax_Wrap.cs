/*
 Wrapper of Emu elements to run on Pax.
 Nik Sultana, Cambridge University Computer Lab, July 2016

  This software was developed by the University of Cambridge,
  Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
 
  Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using System.Diagnostics;
using Emu;
using Pax;
using PacketDotNet;

public class Pax_Wrap<T> : MultiInterface_SimplePacketProcessor where T : Transceiver
{
  private T instance;

  public Pax_Wrap (T instance)
  {
    this.instance = instance;
  }

  // NOTE currently this is specific to the version of NetFPGA SUME we're using.
  override public ForwardingDecision process_packet (int in_port, ref Packet packet)
  {
    // Set metadata.
    NetFPGA_Data dataplane = instance.Get_Data();
    NetFPGA.Set_Input_Port (ref dataplane, (ulong)in_port);
    Debug.Assert(in_port == (int)NetFPGA.Read_Input_Port (dataplane));
    byte[] bs = packet.Bytes;
    NetFPGA.Set_Frame (bs, ref dataplane);
    instance.Set_Data(dataplane);

    // Run the logic!
    instance.SwitchLogic();

    dataplane = instance.Get_Data();
    // Retrieve frame.
    bs = new byte[NetFPGA_Data.BUF_SIZE * sizeof(ulong)];
    NetFPGA.Get_Frame (dataplane, ref bs);

    // NOTE assuming Ethernet link layer.
    packet = Packet.ParsePacket(LinkLayers.Ethernet, bs);
    // Retrieve forwarding decision.
    int[] outs = new int[NetFPGA_Data.NET_PORTS];
    int outputs = NetFPGA.Get_Output_Ports (ref dataplane, ref outs, max_ports : PaxConfig_Lite.no_interfaces);
    ForwardingDecision fwd = null;

    // Trim away unused array space.
    Array.Resize<int>(ref outs, outputs);

    fwd = new ForwardingDecision.MultiPortForward(outs);

    return fwd;
  }

  static int Main()
  {
     System.Console.WriteLine("Use Pax to run this packet processor in software.");
     return -1;
  }
}
