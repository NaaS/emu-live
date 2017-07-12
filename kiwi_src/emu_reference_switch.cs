//	Reference learning Switch of the NetFPGA infrastructure
//	This program (C#) replicates the functionality and the logic of
//	the OPL module (verilog) of the reference datapath
//	It is supposed to be used with the kiwi compiler and for 
//	within the NetFPGA project
//
//	 - Use of the 256 AXIS bus width
//	 - Use of a CAM 16 depth, 64b width, >>>>BRAM implementation<<<<
//	   .C_MEM_TYPE( 1 )
//	 - No buffers, acts like a cut-through
//
//	Copyright (C) 2017 Salvator Galea <salvator.galea@cl.cam.ac.uk>
//	All rights reserved
//
//	This software was developed by the University of Cambridge,
//	Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
//
//	Use of this source code is governed by the Apache 2.0 license; see LICENSE file
//
//
//	TODO:
//
//	Latest working set-up:
//		-Vivado 2014.4
//		-KiwiC Version Alpha 0.3.1x
//

using System;
using KiwiSystem;


class Emu
{
	// This class describes the OPL of the reference_switch_lite of the NetFPGA

	// ----------------
	// - I/O PORTS
	// ----------------
        // These are the ports of the circuit (and will appear as ports in the generated Verilog)
	// Slave Stream Ports
	[Kiwi.InputWordPort("s_axis_tdata_0")]	// s_axis_tdata
	static ulong s_axis_tdata_0; 		// Data to be received
	[Kiwi.InputWordPort("s_axis_tdata_1")]	// s_axis_tdata
	static ulong s_axis_tdata_1; 		// Data to be received
	[Kiwi.InputWordPort("s_axis_tdata_2")]	// s_axis_tdata
	static ulong s_axis_tdata_2; 		// Data to be received
	[Kiwi.InputWordPort("s_axis_tdata_3")]	// s_axis_tdata
	static ulong s_axis_tdata_3; 		// Data to be received

	[Kiwi.InputBitPort("s_axis_tkeep")]	// s_axis_tkeep
	static uint s_axis_tkeep;       	// Offset of valid bytes in the data bus
	[Kiwi.InputBitPort("s_axis_tlast")]	// s_axis_tlast
	static bool s_axis_tlast;      		// End of frame indicator
	[Kiwi.InputBitPort("s_axis_tvalid")]	// s_axis_tvalid
	static bool s_axis_tvalid;		// Valid data on the bus - indicator
	[Kiwi.OutputBitPort("s_axis_tready")]	// s_axis_tready
	static bool s_axis_tready;	  	// Ready to receive data - indicator
	[Kiwi.InputWordPort("s_axis_tuser_hi")]	// s_axis_tuser_hi
	static ulong s_axis_tuser_hi; 		// metadata
	[Kiwi.InputWordPort("s_axis_tuser_low")]// s_axis_tuser_low
	static ulong s_axis_tuser_low; 		// metadata

	// Master Stream Ports
	[Kiwi.OutputWordPort("m_axis_tdata_0")]	// m_axis_tdata
	static ulong m_axis_tdata_0;		// Data to be sent 
	[Kiwi.OutputWordPort("m_axis_tdata_1")]	// m_axis_tdata
	static ulong m_axis_tdata_1;		// Data to be sent 
	[Kiwi.OutputWordPort("m_axis_tdata_2")]	// m_axis_tdata
	static ulong m_axis_tdata_2;		// Data to be sent 
	[Kiwi.OutputWordPort("m_axis_tdata_3")]	// m_axis_tdata
	static ulong m_axis_tdata_3;		// Data to be sent 

	[Kiwi.OutputBitPort("m_axis_tkeep")]	// m_axis_tkeep
	static uint m_axis_tkeep;		// Offset of valid bytes in the data bus
	[Kiwi.OutputBitPort("m_axis_tlast")]	// m_axis_tlast
	static bool m_axis_tlast;		// End of frame indicator
	[Kiwi.OutputBitPort("m_axis_tvalid")]	// m_axis_tvalid
	static bool m_axis_tvalid;		// Valid data on the bus - indicator
	[Kiwi.InputBitPort("m_axis_tready")]	// m_axis_tready
	static bool m_axis_tready ;    		// Ready to transmit data - indicator
	[Kiwi.OutputBitPort("m_axis_tuser_hi")]	// m_axis_tuser_hi
	static ulong m_axis_tuser_hi;		// metadata
	[Kiwi.OutputBitPort("m_axis_tuser_low")]// m_axis_tuser_low
	static ulong m_axis_tuser_low;		// metadata

	// CAM Memory Ports
	// Input Ports
	[Kiwi.InputBitPort("cam_busy")]		// cam_busy
	static bool cam_busy;			// Busy signal from the CAM
	[Kiwi.InputBitPort("cam_match")]	// cam_match
	static bool cam_match;			// Match singal if data has been found
	[Kiwi.InputBitPort("cam_match_addr")]	// cam_match_addr
	static byte cam_match_addr;		// Return address of the matched data
	// Output Ports
	[Kiwi.OutputWordPort("cam_cmp_din")]	// cam_cmp_din
	static ulong cam_cmp_din=~(ulong)0x00;	// Data to compare against the content of the CAM
	[Kiwi.OutputWordPort("cam_din")]	// cam_din
	static ulong cam_din=0x00;		// Data to be writen in the CAM
	[Kiwi.OutputBitPort("cam_we")]		// cam_we
	static bool cam_we=false;		// Write enable signal
	[Kiwi.OutputBitPort("cam_wr_addr")]	// cam_wr_addr
	static byte cam_wr_addr=0x00;		// Address to write data in CAM

	// Constants variables
	const uint LUT_SIZE = 16U;

	// Memory to store the Output queue of a particular src_mac
	// Each entry is associated with an entry into the CAM
        static ulong[] LUT = new ulong[LUT_SIZE] {0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000,
						0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 
						0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 
						0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000};

	static ulong DEFAULT_oqs = (ulong)0x0000000000550000;
	static ulong dst_mac, src_mac, OQ, broadcast_ports, metadata; 
	static bool LUT_hit = false;
	static uint mem_controller_cnt = 0U;
	static ulong tuser_low = 0UL;

	// This method describes the operations required to route the frames
	static public void switch_logic()
	{

		metadata= 0UL;
		src_mac	= 0UL;
		dst_mac	= 0UL;
		LUT_hit	= false; 

		while (true)
		{

			ReceiveFrameSegm();

			// #############################
			// # Switch Logic -- START
			// #############################

			broadcast_ports = ( (metadata & (ulong)0x00FF0000) ^ DEFAULT_oqs)<<(byte)8; 

			CAM_check_n_learn(dst_mac, src_mac<<16);
			Kiwi.Pause();
			tuser_low = LUT_hit ? (ulong)(OQ<<24 | metadata) : (ulong)(broadcast_ports | metadata);

			//#############################
			// # Switch Logic -- END 
			// #############################

			// Send out this frame and the rest
			SendFrame();

			// End of frame, ready for next frame
			LUT_hit	=false;
			metadata= 0UL;
			src_mac	= 0UL;
			dst_mac	= 0UL;
			LUT_hit	= false; 
			OQ	= 0UL;
		}
	}


	static void CAM_check_n_learn(ulong dest_mac, ulong source_mac)
	{
		ulong dst_mac	= dest_mac;
		ulong src_mac	= source_mac;
		bool match	= false;
		byte tmp_addr	= 0x00;

		// Check if we have the src_mac into the CAM
		cam_cmp_din 	= src_mac;
		Kiwi.Pause();
		cam_cmp_din	= src_mac;
		Kiwi.Pause();
		// Latch the lookup result of the src_mac
		match		= cam_match;

		tmp_addr	= (cam_match) ? (byte)cam_match_addr : (byte)mem_controller_cnt; 
		// Update the memory with the output queue
		LUT[(byte)tmp_addr]	= (metadata>>16) & (ulong)0x00FF;
		// Prepare the data to be writen into the CAM
		cam_din			= src_mac;
		cam_wr_addr		= (byte)mem_controller_cnt;
		// Lookup for the dst_mac
		cam_cmp_din	= dst_mac;
		Kiwi.Pause();
		cam_we		= !match;
		cam_cmp_din	= dst_mac;
		Kiwi.Pause(); 
		// If we have a hit on the dst_mac set the Output Queues
		LUT_hit		= cam_match;
		OQ		= (cam_match) ? LUT[(byte)cam_match_addr] : 0UL; 
		if(!match) if(mem_controller_cnt == (uint)(LUT_SIZE-1U)) mem_controller_cnt = 0U; else mem_controller_cnt += 1U;

		cam_we		= false;
		cam_din		= 0UL;
		cam_wr_addr	= 0x00;
	}


	static void ReceiveFrameSegm()
	{
		// Procedure call for receiving the first frame of the packet

		m_axis_tdata_0 		= (ulong)0x0;
		m_axis_tdata_1 		= (ulong)0x0;
		m_axis_tdata_2 		= (ulong)0x0;
		m_axis_tdata_3		= (ulong)0x0;

		m_axis_tkeep 		= (uint)0x0;
		m_axis_tlast  		= false;
		m_axis_tuser_hi 	= (ulong)0x0;
		m_axis_tuser_low	= (ulong)0x0;
		m_axis_tvalid 		= false;
		s_axis_tready 		= false;

		bool doneReading = false;
		
		do{
			if (s_axis_tvalid)
			{
				// Read the first segment and pause
				metadata	= s_axis_tuser_low;
				dst_mac		= s_axis_tdata_0<<(byte)16;
				src_mac		= ((s_axis_tdata_0>>(byte)48) & (ulong)0x00ffff) | ( s_axis_tdata_1 & (ulong)0x00ffffffff )<<(byte)16 ;
				doneReading	= true;
			}
			Kiwi.Pause();
		}while (!doneReading);
	}

	// This method describes the operations required to tx a frame over the AXI4-Stream.
	static void SendFrame()
	{
		// #############################
		// # Transmit the frame
		// #############################
		bool done=false;
		m_axis_tvalid 		= false;
		s_axis_tready		= false;
		// Continue with the rest of the segments, as a cut through
		do
		{
			// transmit the first segment that we have already read
			if(s_axis_tvalid){
				m_axis_tdata_0 	= s_axis_tdata_0;
				m_axis_tdata_1 	= s_axis_tdata_1;
				m_axis_tdata_2 	= s_axis_tdata_2;
				m_axis_tdata_3 	= s_axis_tdata_3;

				m_axis_tkeep	= s_axis_tkeep;
				m_axis_tlast	= s_axis_tlast;
				m_axis_tuser_hi = 0UL;
				m_axis_tuser_low= tuser_low;
			}

			m_axis_tvalid	= s_axis_tvalid && s_axis_tready;
			s_axis_tready	= s_axis_tlast ? false : s_axis_tvalid;
			done 		= ( m_axis_tready && s_axis_tvalid ) ? s_axis_tlast && s_axis_tvalid : false;

			Kiwi.Pause();
		}while( !done );

		s_axis_tready		= false;

		m_axis_tvalid		= false;
		m_axis_tlast		= false;
		m_axis_tdata_0		= (ulong)0x0;
		m_axis_tdata_1		= (ulong)0x0;
		m_axis_tdata_2		= (ulong)0x0;
		m_axis_tdata_3		= (ulong)0x0;
		m_axis_tkeep		= (uint)0x0;
		m_axis_tuser_hi		= (ulong)0x0;
		m_axis_tuser_low	= (ulong)0x0;
		Kiwi.Pause();
	}

	// #############################
	// # Main Hardware Enrty point
	// #############################
	[Kiwi.HardwareEntryPoint()] 
	static int EntryPoint()
	{
		while (true) switch_logic();
	}

	static int Main()
	{
		return 0;
	}
}

