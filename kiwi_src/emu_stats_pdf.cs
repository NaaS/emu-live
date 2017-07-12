//	Copyright (C) 2017 Salvator Galea <salvator.galea@cl.cam.ac.uk>
//	All rights reserved
//
//	This software was developed by the University of Cambridge,
//	Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
//
//	Use of this source code is governed by the Apache 2.0 license; see LICENSE file
//
//

using System;
using System.Threading;
using KiwiSystem;

class Emu
{
	// ----------------------------------------------------
	// These are the I/O ports of the circuit (and will appear as ports in the generated Verilog)
	// Slave Stream Ports


	[Kiwi.InputBitPort("s_axis_tkeep")]	// s_axis_tkeep
	static uint s_axis_tkeep;		// Offset of valid bytes in the data bus
	[Kiwi.InputBitPort("s_axis_tlast")]	// s_axis_tlast
	static bool s_axis_tlast;		// End of frame indicator
	[Kiwi.InputBitPort("s_axis_tvalid")]	// s_axis_tvalid
	static bool s_axis_tvalid;		// Valid data on the bus - indicator
	[Kiwi.OutputBitPort("s_axis_tready")]	// s_axis_tready
	static bool s_axis_tready;		// Ready to receive data - indicator
	[Kiwi.InputWordPort("s_axis_tuser_hi")]	// s_axis_tuser_hi
	static ulong s_axis_tuser_hi;		// metadata
	[Kiwi.InputWordPort("s_axis_tuser_low")]// s_axis_tuser_low
	static ulong s_axis_tuser_low;		// metadata

	[Kiwi.InputBitPort("timer_resolution")]	// 
	static uint timer_resolution;		// 
	[Kiwi.InputBitPort("bw_resolution")]	// 
	static uint bw_resolution;		// 
	[Kiwi.OutputBitPort("total_entries")]	// 
	static uint total_entries=0U;		// 

	[Kiwi.InputBitPort("rst")]	// 
	static bool rst;		// 
	[Kiwi.InputBitPort("clear")]	// 
	static bool clear;		//

	[Kiwi.OutputBitPort("raw_bw_mem")]	// 
	static uint raw_bw_mem=0U;		// 
	[Kiwi.OutputBitPort("processed_bw_mem")]	// 
	static uint processed_bw_mem=0U;		// 


	// ----------------------------------------------------
	// Local variables

	[Kiwi.Volatile] static bool new_bw_slot	= false;
	[Kiwi.Volatile] static bool new_pkt_arrived = false;
	[Kiwi.Volatile] static uint packet_size	= 0U;


public class TABLES
{
	private uint bw_tmp	= 0U;
	private uint raw_entry	= 0U;
	const uint raw_bw_SIZE		= 2000U;
	const uint pre_bw_SIZE		= 1000U;

	private static uint[] raw_bw		= new uint[raw_bw_SIZE];
	private static uint[] processed_bw	= new uint[pre_bw_SIZE];

	public void update_bw_tmp()
	{
		while(true)
		{
			this.bw_tmp	= new_bw_slot ? 0U : new_pkt_arrived ? this.bw_tmp + packet_size : this.bw_tmp;
			Kiwi.Pause();
		}
	}

	public void reset_bw_tmp()
	{
		this.bw_tmp	= 0U;
	}

	public void update_tables()
	{
		uint val=0U;

		while(true)
		{

			if(new_bw_slot)
			{
				raw_bw[raw_entry]	= bw_tmp;
				
				raw_entry		= (raw_entry==raw_bw_SIZE) ? 0U : raw_entry + 1U;
				total_entries++;
				val			= processed_bw[bw_tmp>>(byte)bw_resolution];
				Kiwi.Pause();

				//raw_bw_mem		= raw_entry==0U ? raw_bw[0] : raw_bw[raw_entry-1U];
				processed_bw_mem	= val;
				processed_bw[bw_tmp>>(byte)bw_resolution]	= val++;
			}
			Kiwi.Pause();
		}
	}

	public void reset_raw_entry()
	{
		this.raw_entry	= 0U;
	}

	public void reset_total_entries()
	{
		total_entries	= 0U;
	}

	public void reset_tables()
	{
		for(uint i=0; i<raw_bw_SIZE; i++)
		{
			raw_bw[i] = 0U;
			if(i<pre_bw_SIZE)
				processed_bw[i] = 0U;
			Kiwi.Pause();
		}
	}

}


public class TIMER
{
	private uint timer	= 0U;

	public void start_timer()
	{
		while(true)
		{
			new_bw_slot	= this.timer == timer_resolution;

			this.timer	= (this.timer == timer_resolution) ? 0U : this.timer + 1U;

			Kiwi.Pause();
		}
	}

	public void reset_timer()
	{	
		this.timer	= 0U;
	}

}



public class RX
{
	public void start_rx()
	{

		while (true) // Process packets indefinately
		{
			// Parse the packet
			ReceiveFrame();
			//Kiwi.Pause();
		}
	}



	// This method describes the operations required to rx a frame over the AXI4-Stream.
	// and extract basic information such as dst_MAC, src_MAC, dst_port, src_port
	public void ReceiveFrame()
	{
		s_axis_tready 		= true;

		// The start condition 
		uint cnt 	= 0U;
		bool doneReading= true;
		// #############################
		// # Receive the frame
		// #############################
		//Kiwi.Pause();

		while (doneReading)
		{
			if (s_axis_tvalid)
			{
				packet_size	= (uint)(s_axis_tuser_low & (ulong)0x00ffff);

				new_pkt_arrived	= cnt == 0U;
				// Condition to stop receiving data
				doneReading = !s_axis_tlast && s_axis_tvalid;
				cnt = s_axis_tlast ? 0 : cnt + 1U;
				// Create backpresure to whatever sends data to us
				//s_axis_tready = s_axis_tlast ? false : true;
			}
			else
				new_pkt_arrived	= false;
			
			Kiwi.Pause();
		}
		new_pkt_arrived	= false;
		//s_axis_tready	= false;
	}
}



	/////////////////////////////
	// Main Hardware Enrty point
	/////////////////////////////
	[Kiwi.HardwareEntryPoint()] 
	static int EntryPoint()
	{
		// Create and start the thread for receiving and parsing the tuple
		RX rx = new RX();
		Thread rxTh = new Thread(new ThreadStart(rx.start_rx));
		rxTh.Start();

		TIMER timer = new TIMER();
		Thread timerTh = new Thread(new ThreadStart(timer.start_timer));
		timerTh.Start();

		TABLES tables = new TABLES();
		tables.reset_tables();
		Thread bw_tmpTh = new Thread(new ThreadStart(tables.update_bw_tmp));
		bw_tmpTh.Start();
		Thread tablesTh = new Thread(new ThreadStart(tables.update_tables));
		tablesTh.Start();

		while (true)
		{
			if(rst | clear)
			{
				timer.reset_timer();
				tables.reset_raw_entry();
				tables.reset_bw_tmp();
				tables.reset_total_entries();
			}
			Kiwi.Pause();
		}
		return 0;
	}
	
	static int Main()
	{
		return 0;
	}
}



