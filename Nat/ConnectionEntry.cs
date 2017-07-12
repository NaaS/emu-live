/*
Class to provide typed access to ConnectionEntry fields from arrays of uint64s

Copyright (C) 2016 -- Jonny Shipton, Cambridge University Computer Lab, August 2016

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using EmuUtil;
using KiwiSystem;
using System;

namespace Emu.Nat
{
  sealed class PortConnectionEntry
  {
    // Pack values inside ulong arrays for Kiwi

    /// <summary>
    /// Each item has the layout [src ip 4B | dst ip 4B]
    /// </summary>
    ulong[] ips_arr;
    ulong ips;
    /// <summary>
    /// Each item has the layout [inside intf 1B | outside intf 1B | external/masq tcp port 2B | src tcp port 2B | dst tcp port 2B ]
    /// </summary>
    ulong[] ports_arr;
    ulong ports;

    private uint index;
    public uint Index { get { return index; } }

    /// <summary>
    /// Indicates if this entry is in use/is allocated.
    /// </summary>
    /// <remarks>Works by assuming that <see cref="OutsideIntf"/> is always zero when not in use, and non-zero when in use.</remarks>
    public bool IsAllocated
    {
      get
      {
        return OutsideIntf != 0;
      }
      set
      {
#if DEBUG && !KIWI
        if (value) throw new ArgumentException("Cannot set " + nameof(IsAllocated) + "to true explicitly.", nameof(value));
#endif
        OutsideIntf = 0;
        Save();
      }
    }

    public uint DestinationIPAddress  { get { return BitUtil.Get32(    ips, 0); }
                                        set {        BitUtil.Set32(ref ips, 0, value); } }

    public uint SourceIPAddress       { get { return BitUtil.Get32(    ips, 4); }
                                        set {        BitUtil.Set32(ref ips, 4, value); } }

    public ushort DestinationPort     { get { return BitUtil.Get16(    ports, 0); }
                                        set {        BitUtil.Set16(ref ports, 0, value); } }

    public ushort SourcePort          { get { return BitUtil.Get16(    ports, 2); }
                                        set {        BitUtil.Set16(ref ports, 2, value); } }

    // The port we use on the Nat - the outside node will see this as the destination port
    public ushort MasqueradePort      { get { return BitUtil.Get16(    ports, 4); }
                                        set {        BitUtil.Set16(ref ports, 4, value); } }

    // The outside intf to use
    public byte OutsideIntf           { get { return BitUtil.Get8 (    ports, 6); }
                                        set {        BitUtil.Set8 (ref ports, 6, value); } }

    // The inside intf to use
    public byte InsideIntf            { get { return BitUtil.Get8 (    ports, 7); }
                                        set {        BitUtil.Set8 (ref ports, 7, value); } }

    public PortConnectionEntry(uint entry_count)
    {
      ips_arr = new ulong[entry_count];
      ports_arr = new ulong[entry_count];

#if KIWI
      // Fill ConnectionEntries with empty entries
      for (int i = 0; i < entry_count; i++)
      {
        // Non-zero values so sim works
        ips_arr[i] = 1;
        ports_arr[i] = 1;
      }
#endif
    }

    public void Load(uint index)
    {
      this.index = index;
      ips = ips_arr[index];
      ports = ports_arr[index];
      Kiwi.Pause();
    }

    /// <summary>
    /// Saves the changes to this entry.
    /// </summary>
    public void Save()
    {
      ips_arr[index] = ips;
      ports_arr[index] = ports;
    }
  }
}
