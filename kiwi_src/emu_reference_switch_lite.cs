//	Reference learning Switch lite of the NetFPGA infrastructure
//	This program (C#) replicates the functionality and the logic of
//	the OPL module (verilog) of the reference datapath
//	It is supposed to be used with the kiwi compiler and for 
//	within the NetFPGA project
//
//	Copyright 2016	Salvator Galea	<salvator.galea@cl.cam.ac.uk>
//	All rights reserved
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
	[Kiwi.InputWordPort("s_axis_tdata")]	// s_axis_tdata
	static ulong s_axis_tdata; 		// Data to be received
	[Kiwi.InputBitPort("s_axis_tkeep")]	// s_axis_tkeep
	static byte s_axis_tkeep;       	// Offset of valid bytes in the data bus
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
	[Kiwi.OutputWordPort("m_axis_tdata")]	// m_axis_tdata
	static ulong m_axis_tdata;		// Data to be sent 
	[Kiwi.OutputBitPort("m_axis_tkeep")]	// m_axis_tkeep
	static byte m_axis_tkeep;		// Offset of valid bytes in the data bus
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
	static byte[]	tkeep		= new byte[BUF_SIZE];
	static bool[]	tlast		= new bool[BUF_SIZE];
	static ulong[]	tdata		= new ulong[BUF_SIZE];
	static ulong[]	tuser_hi	= new ulong[BUF_SIZE];
	static ulong[]	tuser_low	= new ulong[BUF_SIZE];


        // This method describes the operations required to route the frames
        static public void switch_logic()
        {

	    uint i=0U, ptr=0U, free=0U;
            uint pkt_size=0U;
	    bool exist = false;
		IP	= false;
		metadata= 0UL;
		src_mac	= 0UL;
		dst_mac	= 0UL;
		LUT_hit	= false; 


            while (true) // Process packets indefinately
            {
		// Procedure call for receiving packet
		pkt_size = ReceiveFrame();

                // #############################
		// # Switch Logic -- START
		// #############################
		tmp = 0UL; tmp1 = 0UL; tmp2 = 0UL; tmp0 = 0UL; ptr = 0U;
		// Once we have the destination MAC, 
		// check the LUT if it exists in there
		// and set the appropriate metadata into the tuser field 
		Kiwi.Pause();
		for(i=0; i<2; i++)
		{	Extract(i);	Kiwi.Pause();	}

		broadcast_ports = ( (metadata & (ulong)0x00FF0000) ^ DEFAULT_oqs)<<(byte)8; 

		// Search the LUT for the dst_mac
		for (i=0U; (uint)i<(uint)LUT_SIZE; i=i+1U)
		{
			tmp1	= LUT[i];
			Kiwi.Pause();
			// Get the mac address from LUT
			tmp	= tmp1 & (ulong)0xffffffffffff0000;
			// Get the output port from LUT
			tmp2	= tmp1 & (ulong)0x00000000000000ff;

			// Check if we have a hit in the LUT for the dst_mac
			if( dst_mac == tmp && !LUT_hit )
			{
				// Get the engress port numnber from the LUT
				OQ	= tmp2 << 24;
				LUT_hit	= true;
				//break;
			}
			// Here we check if we need to update an entry based on the src_mac
			// Get rid off the oq, keep only the mac
			if( src_mac == tmp>>(byte)16 && !exist) 
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
		

		// Check if the ether_type = IP and set the metadata aotherwise discrad the packet
		//if ( IP )
		// If we have a hit prepare the appropriate output port in the metadata, otherwise flood
		tuser_low[0] = LUT_hit ? (ulong)(OQ | metadata) : (ulong)(broadcast_ports | metadata);
		Kiwi.Pause();

		// Once we have the source MAC,
		// If we had a hit in the previous stage-lookup, we skip this one
		// If we dint have a 'hit', then we need to store the source MAC and 
		// the source port number

		// Replace policy -- LIFO
		// If it exists update, otherwise create new entry
		i	= ( exist ) ? ptr : free;
		LUT[i]	= src_mac<<(byte)16 | (ulong)( (metadata>>(byte)16) & (ulong)0x00ff );

		if ( !LUT_hit ) free = ( free>(uint)(LUT_SIZE-1U) ) ? 0U : free=free+1U;

		Kiwi.Pause();
                // #############################
		// # Switch Logic -- END 
		// #############################
 
		// Procedure call for transmiting packet
		SendFrame(pkt_size);
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

	static void Extract(uint cnt)
	{
		if (cnt==0U)
		{
			metadata	= tuser_low[cnt];
			dst_mac		= tdata[cnt]<<(byte)16;
			src_mac		= (tdata[cnt]>>(byte)48) & (ulong)0x00ffff;
		}
		else if (cnt==1U)
		{
			IP		= ( tdata[cnt]>>32 & (ulong)0x00ffff ) == (ulong)0x0008;
			src_mac		|=  ( tdata[cnt] & (ulong)0x00ffffffff )<<(byte)16;
		}
	}


	// This method describes the operations required to rx a frame over the AXI4-Stream.
	// and extract basic information such as dst_MAC, src_MAC, dst_port, src_port
	static public uint ReceiveFrame()
	{	
		m_axis_tdata 		= (ulong)0x0;
		m_axis_tkeep 		= (byte)0x0;
		m_axis_tlast  		= false;
		m_axis_tuser_hi 	= (ulong)0x0;
		m_axis_tuser_low	= (ulong)0x0;
		s_axis_tready 		= true;
		Kiwi.Pause();

		// The start condition 
		bool doneReading	= true;

		// Local variables - counters
		uint cnt	= 0U;
		uint size	= 0U;
		ulong data 	= 0x00;
		byte data2	= 0x00;

		// #############################
		// # Receive the frame
		// #############################
		while (doneReading)
		{
			if (s_axis_tvalid)
			{
				tdata[cnt]	= s_axis_tdata;
				tkeep[cnt]	= s_axis_tkeep;
				tlast[cnt]	= s_axis_tlast;
				tuser_hi[cnt]	= s_axis_tuser_hi;
				tuser_low[cnt]	= s_axis_tuser_low;


				//cnt = cnt + 1U;
				size = cnt++;
				// Condition to stop receiving data
				doneReading	= !s_axis_tlast && s_axis_tvalid;
				// Create backpresure to whatever sends data to us
				s_axis_tready	= s_axis_tlast ? false : true;
			}
			Kiwi.Pause();
		}

		data  = tdata[size];
		data2 = tkeep[size];
		
		Kiwi.Pause();

		switch (data2) {
		case 0x01:
			tdata[size] = data & (ulong)0x00ff;
			break;
		case 0x03:
			tdata[size] = data & (ulong)0x00ffff;
			break;
		case 0x07:
			tdata[size] = data & (ulong)0x00ffffff;
			break;
		case 0x0f:
			tdata[size] = data & (ulong)0x00ffffffff;
			break;
		case 0x1f:
			tdata[size] = data & (ulong)0x00ffffffffff;
			break;
		case 0x3f:
			tdata[size] = data & (ulong)0x00ffffffffffff;
			break;
		case 0x7f:
			tdata[size] = data & (ulong)0x00ffffffffffffff; 
			break;
		default:
			break;
		}

		Kiwi.Pause();

		s_axis_tready	= false;
		cnt		= 0U;

		return size;
	}

	// This method describes the operations required to tx a frame over the AXI4-Stream.
	static void SendFrame(uint psize)
	{
		// #############################
                // # Transmit the frame
		// #############################
                m_axis_tvalid 		= true;
		m_axis_tlast 		= false;
     		m_axis_tdata 		= (ulong)0x0;
		m_axis_tkeep 		= (byte)0x0;
		m_axis_tuser_hi 	= (ulong)0x0;
		m_axis_tuser_low	= (ulong)0x0;

		uint i=0U;


		while (i<=psize)
                {
			if ( m_axis_tready )
			{
		     		m_axis_tdata	= tdata[i];
				m_axis_tkeep	= tkeep[i];
				m_axis_tlast	= i == (psize);
				m_axis_tuser_hi = tuser_hi[i];
				m_axis_tuser_low= tuser_low[i];
				i = i + 1U;
			}
			Kiwi.Pause();
               }

                m_axis_tvalid 		= false;
		m_axis_tlast 		= false;
     		m_axis_tdata 		= (ulong)0x0;
		m_axis_tkeep 		= (byte)0x0;
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

