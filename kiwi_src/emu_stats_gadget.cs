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
	static bool m_axis_tready;		// Ready to transmit data - indicator
	[Kiwi.OutputBitPort("m_axis_tuser_hi")]	// m_axis_tuser_hi
	static ulong m_axis_tuser_hi=0UL;	// metadata
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
	[Kiwi.OutputWordPort("cam_cmp_din_0")]	// cam_cmp_din
	static ulong cam_cmp_din_0=~(ulong)0x00;// Data to compare against the content of the CAM
	[Kiwi.OutputWordPort("cam_cmp_din_1")]	// cam_cmp_din
	static ulong cam_cmp_din_1=~(ulong)0x00;// Data to compare against the content of the CAM
	[Kiwi.OutputWordPort("cam_din_0")]	// cam_din
	static ulong cam_din_0=0x00;		// Data to be writen in the CAM
	[Kiwi.OutputWordPort("cam_din_1")]	// cam_din
	static ulong cam_din_1=0x00;		// Data to be writen in the CAM
	[Kiwi.OutputBitPort("cam_we")]		// cam_we
	static bool cam_we=false;		// Write enable signal
	[Kiwi.OutputBitPort("cam_wr_addr")]	// cam_wr_addr
	static byte cam_wr_addr=0x00;		// Address to write data in CAM

	// STATs_reg
	[Kiwi.OutputWordPort("STATs_reg")]	// STATs_reg
	static uint STATs_reg=0x00;		// STATs_reg


	[Kiwi.Volatile] static byte PROTO	= 0x00;
	[Kiwi.Volatile] static uint SRC_IP	= 0U;
	[Kiwi.Volatile] static uint DST_IP	= 0U;
	[Kiwi.Volatile] static uint SRC_PORT	= 0U;
	[Kiwi.Volatile] static uint DST_PORT	= 0U;
	[Kiwi.Volatile] static uint SEQ_NUM	= 0U;

	static byte PROTO_prev		= 0x00;
	static uint SRC_IP_prev		= 0U;
	static uint DST_IP_prev		= 0U;
	static uint SRC_PORT_prev	= 0U;
	static uint DST_PORT_prev	= 0U;
	static uint SEQ_NUM_prev	= 0U;
	static uint tmp_dst_ip		= 0U;

	static uint[] SEQ_NUM_array	= new uint[16];

	static byte match_addr		= 0x00;
	static byte ctrl_addr		= 0x00;
	static bool cam_hit		= false;
	[Kiwi.Volatile] static bool tuple_extracted	= false;


public class RX
{
	public void parse_rx()
	{

		while (true) // Process packets indefinately
		{
			// Parse the packet
			ReceiveFrame();
			//Kiwi.Pause();
		}
	}

	// The procedure is implemented as a separate thread and
	// will extract usefull data from the incoming stream
	// In order to utilize more the icoming process 
	public void Extract_tuple(uint count, ulong tdata0, ulong tdata1, ulong tdata2, ulong tdata3, ulong tuser)
	{
		switch(count)
		{
			// Start of the Ethernet header
			case 0U:
				PROTO		= (byte)(  tdata2>>56 & (ulong)0x00ff ) ;
				SRC_IP		= (uint)(( tdata3>>16) & (ulong)0x00ffffffff);
				DST_IP		= (uint)(( tdata3>>48) & (ulong)0x00ffff);
				tmp_dst_ip	= (uint)(( tdata3>>48) & (ulong)0x00ffff);
				break;
			// Start of the UDP header
			case 1U:
				DST_IP		|= (uint)(( tdata0 & (ulong)0x00ffff )<<16);
				SRC_PORT	= (uint)(( tdata0>>16 & (ulong)0x00ffff));
				DST_PORT	= (uint)(( tdata0>>32 & (ulong)0x00ffff));
				SEQ_NUM		= (uint)(( tdata0>>48 & (ulong)0x00ffff) | ( tdata1<<16 & (ulong)0x00ffff0000));
				// Prepare the lookup
				cam_cmp_din_0	= ( ( (ulong)tmp_dst_ip ) | (( tdata0 & (ulong)0x00ffff )<<16)) | (ulong)SRC_IP<<32;
				cam_cmp_din_1	= (( tdata0>>32 & (ulong)0x00ffff)) | (( tdata0>>16 & (ulong)0x00ffff))<<32;
				// Prepare the write if needed
				cam_din_0	= ( ( (ulong)tmp_dst_ip ) | (( tdata0 & (ulong)0x00ffff )<<16)) | (ulong)SRC_IP<<32;
				cam_din_1	= (( tdata0>>32 & (ulong)0x00ffff)) | (( tdata0>>16 & (ulong)0x00ffff))<<32;
				tuple_extracted	= true;
				break;
			default:
				tuple_extracted	= false;
				break;
		}
	}


	// This method describes the operations required to rx a frame over the AXI4-Stream.
	// and extract basic information such as dst_MAC, src_MAC, dst_port, src_port
	public void ReceiveFrame()
	{
		m_axis_tdata_0 		= (ulong)0x0;
		m_axis_tdata_1 		= (ulong)0x0;
		m_axis_tdata_2 		= (ulong)0x0;
		m_axis_tdata_3 		= (ulong)0x0;
		m_axis_tkeep 		= (uint)0x0;
		m_axis_tlast  		= false;
		m_axis_tvalid		= false;
		m_axis_tuser_hi 	= (ulong)0x0;
		m_axis_tuser_low	= (ulong)0x0;
		s_axis_tready 		= true;

		// The start condition 
		uint cnt 	= 0;
		uint psize 	= 0;
		bool doneReading= true;
		ulong data_0 	= 0x00;
		ulong data_1 	= 0x00;
		ulong data_2 	= 0x00;
		ulong data_3 	= 0x00;
		uint keep	= 0x00;
		// #############################
		// # Receive the frame
		// #############################
		tuple_extracted	= false;
		Kiwi.Pause();

		while (doneReading)
		{
			if (s_axis_tvalid)
			{
//				tdata_0[cnt]	= s_axis_tdata_0;
//				tdata_1[cnt]	= s_axis_tdata_1;
//				tdata_2[cnt]	= s_axis_tdata_2;
//				tdata_3[cnt]	= s_axis_tdata_3;
//				tkeep[cnt]	= s_axis_tkeep;
//				tlast[cnt]	= s_axis_tlast;
//				tuser_low[cnt]	= s_axis_tuser_low;

				Extract_tuple(cnt, s_axis_tdata_0, s_axis_tdata_1, s_axis_tdata_2, s_axis_tdata_3, s_axis_tuser_low);
				// Condition to stop receiving data
				doneReading = !s_axis_tlast && s_axis_tvalid;
				cnt = s_axis_tlast ? 0U : cnt + 1U;
				// Create backpresure to whatever sends data to us
				s_axis_tready = s_axis_tlast ? false : true;
			}
			
			Kiwi.Pause();
		}
		//s_axis_tready	= false;
	}
}


public class CAM
{
	public void find_tuple()
	{
		uint tmp_seq_num	= 0U;
		byte tmp_match_addr	= 0x00;
		bool hit		= false;
		while(true)
		{
			if (tuple_extracted)
			{
				do{Kiwi.Pause();}while(cam_busy);
				//while(cam_busy){Kiwi.Pause();}
				// Check the CAM for the tuple
				cam_hit		= cam_match;
				tmp_match_addr	= cam_match_addr;
				if (cam_match)
				{
					cam_we		= false;
					tmp_seq_num	= SEQ_NUM_array[ cam_match_addr ];
				}
				// If it doesnt exist, prepare to write
				else
				{
					cam_we		= true;
					cam_wr_addr	= ctrl_addr;
					SEQ_NUM_array[ctrl_addr]	= SEQ_NUM;
//					cam_cmp_din_0	= 0UL;
//					cam_cmp_din_1	= 0UL;
				}

				Kiwi.Pause();

				// If we got a match, compare the SEQ_NUM from the array
				if(cam_hit)
				{
					if( tmp_seq_num < SEQ_NUM )
					{
						SEQ_NUM_array[ tmp_match_addr ] = SEQ_NUM;
						STATs_reg++;
					}
				}
				else
				{
					//cam_we	= true;
					ctrl_addr++;
				}

				tmp_seq_num	= 0U;
				cam_we		= false;
				//cam_cmp_din_0	= 0UL;
				//cam_cmp_din_1	= 0UL;
				//cam_hit		= false;
				//Kiwi.Pause();
			}
			//cam_hit = cam_match;
			cam_we	= false;
			Kiwi.Pause();
		}
	}
}

	// This method describes the operations required to tx a frame over the AXI4-Stream.
//	static void SendFrame(uint pkt_size)
//	{
//		// #############################
//		// # Transmit the frame
//		// #############################
//		m_axis_tvalid		= true;
//		m_axis_tlast		= false;
//		m_axis_tdata_0		= (ulong)tdata_0[0];
//		m_axis_tdata_1		= (ulong)tdata_1[0];
//		m_axis_tdata_2		= (ulong)tdata_2[0];
//		m_axis_tdata_3		= (ulong)tdata_3[0];
//		m_axis_tkeep		= (uint)tkeep[0];
//		m_axis_tuser_hi 	= (ulong)0x0;
//		m_axis_tuser_low	= (ulong)tuser_low[0];
//		st=1U;
//		Kiwi.Pause();

//		while (st<=pkt_size)
//		{
//			if ( m_axis_tready )
//			{
//				m_axis_tdata_0	= tdata_0[st];
//				m_axis_tdata_1	= tdata_1[st];
//				m_axis_tdata_2	= tdata_2[st];
//				m_axis_tdata_3	= tdata_3[st];
//				m_axis_tkeep	= tkeep[st];
//				m_axis_tlast	= st == (pkt_size);
//				m_axis_tuser_hi	= 0UL;
//				m_axis_tuser_low= tuser_low[st];
//			st++; 
//			}
//			Kiwi.Pause();
//		}

//		m_axis_tvalid		= false;
//		m_axis_tlast		= false;
//		m_axis_tdata_0		= (ulong)0x0;
//		m_axis_tdata_1		= (ulong)0x0;
//		m_axis_tdata_2		= (ulong)0x0;
//		m_axis_tdata_3		= (ulong)0x0;
//		m_axis_tkeep		= (uint)0x0;
//		m_axis_tuser_hi		= (ulong)0x0;
//		m_axis_tuser_low	= (ulong)0x0;
//		Kiwi.Pause();
//	}


	/////////////////////////////
	// Main Hardware Enrty point
	/////////////////////////////
	[Kiwi.HardwareEntryPoint()] 
	static int EntryPoint()
	{
		// Create and start the thread for receiving and parsing the tuple
		RX rx = new RX();
		Thread tuple_parser = new Thread(new ThreadStart(rx.parse_rx));
		tuple_parser.Start();

		// Create and start the thread for retrieving the tuple from the CAM
		CAM cam = new CAM();
		Thread tupler = new Thread(new ThreadStart(cam.find_tuple));
		tupler.Start();

		while (true) {Kiwi.Pause();};
		return 0;
	}
	
	static int Main()
	{
		return 0;
	}
}



