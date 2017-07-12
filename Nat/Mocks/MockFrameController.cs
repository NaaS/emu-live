/*
 Class to help with testing and mocking. Handles frames.

 Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;

namespace Emu
{
  public class MockFrameController
  {
    /// <summary>
    /// Notifies listeners of received frames. Raised whenever a frame is actively received by the processor.
    /// </summary>
    public event EventHandler<FrameEventArgs> OnReceiveFrame;
    /// <summary>
    /// Notifies listeners of sent frames. Raised whenever a frame is sent by the processor.
    /// </summary>
    public event EventHandler<FrameEventArgs> OnSendFrame;

    /// <summary>This stopwatch provides timestamps relative to the session start.</summary>
    /// <remarks>
    /// These timestamps are intended to be used for logging and scheduling, although
    /// by using the high-precision timer functionality, they could potentially be adapted
    /// for use in performance measurements (although the timestamps would then no longer be of type TimeSpan).
    /// </remarks>
    private Stopwatch sw;

    private object ReceiveLock = new object();
    private Queue<FrameInfo> _ReceivedFrames = new Queue<FrameInfo>();
    private List<FrameInfo> ReceivedFramesLog = new List<FrameInfo>();
    private List<FrameInfo> _SentFrames = new List<FrameInfo>();

    public IEnumerable<FrameInfo> ReceivedFrames { get { return ReceivedFramesLog.AsReadOnlyEnumerable(); } }
    public IEnumerable<FrameInfo> SentFrames { get { return _SentFrames.AsReadOnlyEnumerable(); } }

    /// <summary>Starts the session.</summary>
    public void Start()
    {
      sw = Stopwatch.StartNew();
    }

    /// <summary>Queues a frame to be received at the time specified in the <paramref name="frame"/>.</summary>
    public void QueueReceiveFrame(FrameInfo frame)
    {
      lock (ReceiveLock)
      {
        // If the time is zero, then the earliest that it can be recieved is NOW.
        // We update the time if possible for logging purposes.
        if (frame.Time == TimeSpan.Zero)
          frame = new FrameInfo(frame.Data, sw?.Elapsed ?? TimeSpan.Zero);

        // Enqueue the frame
        _ReceivedFrames.Enqueue(frame);
        // Awake some thread if there are any waiting for frames
        Monitor.Pulse(ReceiveLock);
      }
    }

    /// <summary>
    /// Receive a frame - blocks until an incoming frame is available.
    /// </summary>
    public FrameInfo ReceiveFrame()
    {
      FrameInfo frame;
      lock (ReceiveLock)
      {
        // Block until a frame is available
        while (_ReceivedFrames.Count < 1)
          Monitor.Wait(ReceiveLock);

        // Get the frame
        frame = _ReceivedFrames.Dequeue();
        // Log that this frame is being received
        ReceivedFramesLog.Add(frame);
      }

      // Make sure that we don't receive the frame earlier than the specified time
      while (frame.Time > sw.Elapsed)
        Thread.Sleep(frame.Time - sw.Elapsed);

      // Notify listeners of received frame
      OnReceiveFrame?.Invoke(this, new FrameEventArgs(frame, sw.Elapsed));

      return frame;
    }

    /// <summary>
    /// Send a frame. Uses the network interface specified by the supplied metadata.
    /// </summary>
    /// <param name="data">The data of the frame to send.</param>
    public void SendFrame(NetFPGA_Data data)
    {
      // Use the current timestamp for this frame
      var frame = new FrameInfo(data, sw.Elapsed);

      // Notify listeners of frame being sent
      OnSendFrame?.Invoke(this, new FrameEventArgs(frame, sw.Elapsed));

      // Log that the frame was sent
      _SentFrames.Add(frame);
    }

    public class FrameEventArgs : TimeEventArgs
    {
      public FrameInfo Frame { get; }

      public FrameEventArgs(FrameInfo frame, TimeSpan time) : base(time)
      {
        Frame = frame;
      }
    }
    public class TimeEventArgs : EventArgs
    {
      public TimeSpan Time { get; }

      public TimeEventArgs(TimeSpan time) : base()
      {
        Time = time;
      }
    }
  }
}
