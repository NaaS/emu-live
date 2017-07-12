/*
 Wraps Salvator's learning switch implementation to run on Pax.
 Nik Sultana, Cambridge University Computer Lab, July 2016

  This software was developed by the University of Cambridge,
  Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
 
  Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using Emu;
using Pax;
using PacketDotNet;

public class Wrapped_Switch : MultiInterface_SimplePacketProcessor
{
  static Reference_Switch_Lite t = new Reference_Switch_Lite();
  static MultiInterface_SimplePacketProcessor processor =
    new Pax_Wrap<Reference_Switch_Lite>(t);

  static Wrapped_Switch()
  {
    // FIXME instead of using this option should avoid forwarding to ports that
    //       don't exist.
    PaxConfig_Lite.ignore_phantom_forwarding = true;
  }

  override public ForwardingDecision process_packet (int in_port, ref Packet packet)
  {
    return Wrapped_Switch.processor.process_packet (in_port, ref packet);
  }
}
