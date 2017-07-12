//	Reference learning Switch lite of the NetFPGA infrastructure
//	This program (C#) replicates the functionality and the logic of
//	the OPL module (verilog) of the reference datapath
//	It is supposed to be used with the kiwi compiler and for 
//	within the NetFPGA project
//
//	Version 2 -- Reference Switch Lite
//
//	Copyright 2016	Salvator Galea	<salvator.galea@cl.cam.ac.uk>
//	All rights reserved
//
//	Updates:	Removed the 256-to-64 converters from the output port lookup
//			Optimization in the code to delete stall cc's
//			This version can run @ 200MHz with positive slack
//
//
//
//	Copyright 2016	Salvator Galea	<salvator.galea@cl.cam.ac.uk>
//
//	This software was developed by the University of Cambridge,
//	Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
//
//	Use of this source code is governed by the Apache 2.0 license; see LICENSE file
//
//
//	TODO:
//	 -need to take care of the tlast signal for the last receiving frame
//	  not all the bytes are valid data
//	 -remove the buffers for the incoming packet, not needed
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

	// Constants variables
	const uint LUT_SIZE = 16U;
	const uint BUF_SIZE = 200U; // Max frame size = 1526 Bytes ~ 191x8Bxmd entries

	// Lookup Table -- Register based LUT
	// Here we need to initialise (with something) the table with 0x01 instead of
	// 0x00 because in this case, in the simulation we get undefined values ('ZZ)
	//
	// Format of the LUT entry ( 64bit x LUT_SIZE)
	//  ______________________________
	// |-		64bit		-|
	// |-	48bit	--	16bit	-|
	// |-	MAC	--	port	-|
        static ulong[] LUT = new ulong[LUT_SIZE] {0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001,
						0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001,
						0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 
						0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001};

	static ulong DEFAULT_oqs = (ulong)0x0000000000550000;

	static ulong tmp0, tmp, tmp1, tmp2, dst_mac, src_mac, OQ, broadcast_ports, metadata; 

	static bool LUT_hit = false, IP = false;

	// Internal buffer to keep the whole packet
	// TODO maybe we dont need all these buffers as we make the decision based on the first frame
	static uint[]	tkeep		= new uint[BUF_SIZE];
	static bool[]	tlast		= new bool[BUF_SIZE];
	static ulong[]	tdata_0		= new ulong[BUF_SIZE];
	static ulong[]	tdata_1		= new ulong[BUF_SIZE];
	static ulong[]	tdata_2		= new ulong[BUF_SIZE];
	static ulong[]	tdata_3		= new ulong[BUF_SIZE];
	static ulong[]	tuser_hi	= new ulong[BUF_SIZE];
	static ulong[]	tuser_low	= new ulong[BUF_SIZE];


	// This method describes the operations required to route the frames
	static public void switch_logic()
	{

		uint i=0U, ptr=0U, free=0U, cnt=0U;
		uint pkt_size	= 0U;
		bool exist	= false, doneReading;
		IP		= false;
		metadata	= 0UL;
		src_mac		= 0UL;
		dst_mac		= 0UL;
		LUT_hit		= false; 

	while (true) // Process packets indefinately
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
		s_axis_tready 		= true;
		cnt			= 0U;
		Kiwi.Pause();

		doneReading = true;

		while (doneReading)
		{
			if (s_axis_tvalid)
			{
				tdata_0[cnt]	= s_axis_tdata_0;
				tdata_1[cnt]	= s_axis_tdata_1;
				tdata_2[cnt]	= s_axis_tdata_2;
				tdata_3[cnt]	= s_axis_tdata_3;

				tkeep[cnt]	= s_axis_tkeep;
				tlast[cnt]	= s_axis_tlast;
				tuser_hi[cnt]	= s_axis_tuser_hi;
				tuser_low[cnt]	= s_axis_tuser_low;

				if (cnt==0U)
				{
					metadata	= s_axis_tuser_low;
					dst_mac		= s_axis_tdata_0<<(byte)16;
					src_mac		= ((s_axis_tdata_0>>(byte)48) & (ulong)0x00ffff) | ( s_axis_tdata_1 & (ulong)0x00ffffffff )<<(byte)16 ;

					s_axis_tready	= false; 
					doneReading=false;
					break;
				}

				cnt++;
				
			}
			Kiwi.Pause();
		}

		// #############################
		// # Switch Logic -- START
		// #############################
		tmp = 0UL; tmp1 = 0UL; tmp2 = 0UL; tmp0 = 0UL; ptr = 0U;

		broadcast_ports = ( (metadata & (ulong)0x00FF0000) ^ DEFAULT_oqs)<<(byte)8; 

		// Search the LUT for the dst_mac and for the src_mac
		for (i=0U; (uint)i<(uint)LUT_SIZE; i=i+1U)
		{
			tmp1	= LUT[i];
			Kiwi.Pause();
			// Get the mac address from LUT
			tmp	= tmp1 & (ulong)0xffffffffffff0000;
			// Get the output port from LUT
			tmp2	= tmp1 & (ulong)0x00000000000000ff;

			// Check if we have a hit in the LUT for the dst_mac
			if( dst_mac == tmp  )
			{
				// Get the engress port numnber from the LUT
				OQ	= tmp2 << 24;
				LUT_hit	= true;
				//break;
			}
			// Here we check if we need to update an entry based on the src_mac
			// Get rid off the oq, keep only the mac
			if( src_mac == tmp>>(byte)16 ) 
			{
				// Update if needed
				// tmp0	= tmp | (metadata & (ulong)0x00ff0000)>>(byte)16;
				exist	= true;
				ptr	= i;
				//break;
			}
			// Save some cycles (maybe)
			if ( LUT_hit && exist )
				break;
		}
		
		// If we have a LUT hit prepare the appropriate output port in the metadata, otherwise flood
		tuser_low[0] = LUT_hit ? (ulong)(OQ | metadata) : (ulong)(broadcast_ports | metadata);
		// Update entry
		if ( exist ) LUT[ptr]	= src_mac<<(byte)16 | (ulong)( (metadata>>(byte)16) & (ulong)0x00ff );
		Kiwi.Pause();
		// Create entry
		if ( !LUT_hit ) 
		{
			LUT[ptr]	= src_mac<<(byte)16 | (ulong)( (metadata>>(byte)16) & (ulong)0x00ff );
			free = ( free>(uint)(LUT_SIZE-1U) ) ? 0U : free=free+1U;
		}
		// #############################
		// # Switch Logic -- END 
		// #############################

		// Send out this frame and the rest
		SendFrame(0);

		// End of frame, ready for next frame
		IP	= false;
		metadata= 0UL;
		src_mac	= 0UL;
		dst_mac	= 0UL;
		LUT_hit	= false; 
		OQ	= 0UL;
		exist	= false;
		}
	}

	// This method describes the operations required to tx a frame over the AXI4-Stream.
	static void SendFrame(uint psize)
	{
		// #############################
		// # Transmit the frame
		// #############################
                m_axis_tvalid 		= false;
		s_axis_tready		= false;

		uint i=0U, ttkeep; bool done = false, valid=false, ttlast;

		ulong a=0UL, ttdata_0, ttdata_1, ttdata_2, ttdata_3, ttuser_hi, ttuser_low; byte b=0; bool c=false;

		// transmit the first frame that we have already read
		do{

			m_axis_tdata_0 	= tdata_0[0];
			m_axis_tdata_1 	= tdata_1[0];
			m_axis_tdata_2 	= tdata_2[0];
			m_axis_tdata_3 	= tdata_3[0];

			m_axis_tkeep	=  tkeep[0];
			m_axis_tlast	=  tlast[0];
			m_axis_tuser_hi =  0U;
			m_axis_tuser_low=  tuser_low[0];
		
			m_axis_tvalid	= true;

			Kiwi.Pause();

		}while( !m_axis_tready );

		m_axis_tvalid	= false;

		s_axis_tready	= true;

		// Continue with the rest of the frames, as a cut through
		do
		{

			if ( m_axis_tready && s_axis_tvalid){
				m_axis_tdata_0 	=  s_axis_tdata_0;
				m_axis_tdata_1 	=  s_axis_tdata_1;
				m_axis_tdata_2 	=  s_axis_tdata_2;
				m_axis_tdata_3 	=  s_axis_tdata_3;

				m_axis_tkeep	=  s_axis_tkeep;
				m_axis_tlast	=  s_axis_tlast;
				m_axis_tuser_hi =  0U;
				m_axis_tuser_low=  0U;
		
				m_axis_tvalid	= true;

				s_axis_tready	= true;

				done = s_axis_tlast && s_axis_tvalid;

			}
			else 
			{ 
				s_axis_tready	= false;
				m_axis_tvalid	= false; 
			}

			Kiwi.Pause(); 
			m_axis_tvalid	= false;
			s_axis_tready	= false;
			Kiwi.Pause(); 

		}while( !done );


		s_axis_tready		= false;

		m_axis_tvalid 		= false;
		m_axis_tlast 		= false;
		m_axis_tdata_0 		= (ulong)0x0;
		m_axis_tdata_1 		= (ulong)0x0;
		m_axis_tdata_2 		= (ulong)0x0;
		m_axis_tdata_3		= (ulong)0x0;
		m_axis_tkeep 		= (uint)0x0;
		m_axis_tuser_hi 	= (ulong)0x0;
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







