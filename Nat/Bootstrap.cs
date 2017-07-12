/*
Code to allow simple running and debugging of the NAT code in software.

Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

#if !KIWI

using System;
using EmuUtil;
using System.Linq;
using System.Collections.Generic;

namespace Emu.Nat
{
  /// <summary>
  /// This class allows basic replaying of previously captured packets in order to allow quick running and debugging.
  /// In particular, it is designed to allow easy step-through-debugging in Visual Studio.
  /// </summary>
  /// <remarks>
  /// The packet data is hard-coded because this class is only for quick debugging.
  /// This class should not be considered a replacement for proper testing.
  /// </remarks>
  class Bootstrap
  {
    static void Main(string[] args)
    {
      var controller = new MockFrameController();
      SetupScenario1(controller);
      controller.OnSendFrame += (sender, e) =>
      {
        Console.WriteLine("Send frame on {0:x2}:", e.Frame.Data.GetSendIntf());
        Console.WriteLine(e.Frame.Data.ToHexString());
      };

      // Run the Nat implementation
      Transceiver.FrameController = controller;
      controller.Start();
      NAT.EntryPoint();
    }

    /// <summary>
    /// This scenario replays a TCP handshake between an inside client and an outside server.
    /// </summary>
    /// <remarks>
    /// These frames are intended to be identical to those generated in the run.py script in the both_simple_experiment test folder.
    /// The hex strings were obtained by printing the packet data with `str(pkt).encode("HEX")`. This is not a particularly efficient workflow,
    /// and a way of running the original `run.py` test script so that the C# code can be debugged and compared with the simulation of the Verilog
    /// would certainly be an improvement.
    /// </remarks>
    static void SetupScenario1(MockFrameController controller)
    {
      // Syn from client
      var d = MockUtil.CreateData(ParseHexString("222233445566b2b2c3d4e5f6080045000028000100004006af22c0a801010a0000043333005000000000000000005002200090b20000"), 1);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));

      // Syn+Ack from server
      d = MockUtil.CreateData(ParseHexString("122233445566a2b2c3d4e5f608004500002800010000400666cb0a0000040a00000100500401000000000000000050122000777d0000"), 0);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));

      // Ack from client
      d = MockUtil.CreateData(ParseHexString("222233445566b2b2c3d4e5f6080045000028000100004006af22c0a801010a0000043333005000000000000000005010200090a40000"), 1);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));

      // Data from client (could be request)
      d = MockUtil.CreateData(ParseHexString("222233445566b2b2c3d4e5f6080045000054000100004006aef6c0a801010a00000433330050000000000000000050002000895b00005065746572207069706572207069636b65642061207065636b206f66207069636b6c65642070657070657273"), 1);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));

      // Data from server (could be response)
      d = MockUtil.CreateData(ParseHexString("122233445566a2b2c3d4e5f6080045000054000100004006669f0a0000040a00000100500401000000000000000050102000dafb000041207065636b206f66207069636b6c65642070657070657273205065746572205069706572207069636b6564"), 0);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));

      // Fin shutdown from client
      d = MockUtil.CreateData(ParseHexString("222233445566b2b2c3d4e5f6080045000028000100004006af22c0a801010a0000043333005000000000000000005011200090a30000"), 1);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));

      // Fin+Ack from server
      d = MockUtil.CreateData(ParseHexString("122233445566a2b2c3d4e5f608004500002800010000400666cb0a0000040a00000100500401000000000000000050112000777e0000"), 0);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));

      // Ack from client
      d = MockUtil.CreateData(ParseHexString("222233445566b2b2c3d4e5f6080045000028000100004006af22c0a801010a0000043333005000000000000000005010200090a40000"), 1);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));
    }

    /// <summary>
    /// This scenario replays a single ARP request.
    /// </summary>
    /// <remarks>The data was copied from a tcpdump trace from running the NAT in Mininet on Pax.</remarks>
    static void SetupScenario2(MockFrameController controller)
    {
      // ARP request
      var d = MockUtil.CreateData(ParseHexString("ffffffffffffb2b2c3d4e5f608060001080006040001b2b2c3d4e5f6c0a8010a000000000000c0a80101"), 1);
      controller.QueueReceiveFrame(new FrameInfo(d, TimeSpan.Zero));
    }

    static IEnumerable<byte> ParseHexString(string s)
    {
      if (s.Length % 2 != 0) throw new ArgumentException("String must have even length", nameof(s));

      return Enumerable.Range(0, s.Length / 2)
                       .Select(i => s.Substring(i * 2, 2))
                       .Select(str => Convert.ToByte(str, 16));
    }
  }
}

#endif
