/*
 A class representing a frame arriving or being transmitted from an interface. Used for testing.

 Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Emu
{
  public class FrameInfo
  {
    /// <summary>
    /// The frame data, including metadata such as arrival/destination network interface.
    /// </summary>
    public NetFPGA_Data Data { get; }
    /// <summary>
    /// Frame timestamp. For arriving packets this signifies the time of arrival, and for departing
    /// packets this signifies the time the processor sends it.
    /// </summary>
    /// <remarks>This timestamp is intended for use in logging and scheduling. See <see cref="MockFrameController.sw"/> for more.</remarks>
    public TimeSpan Time { get; }

    public FrameInfo(NetFPGA_Data data, TimeSpan time)
    {
      Data = data;
      Time = time;
    }
  }
}
