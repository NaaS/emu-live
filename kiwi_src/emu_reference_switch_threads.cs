//	Reference learning Switch of the NetFPGA infrastructure
//	This program (C#) replicates the functionality and the logic of
//	the OPL module (verilog) of the reference datapath
//	It is supposed to be used with the kiwi compiler and for 
//	within the NetFPGA project
//
//	 - Use of the 256 AXIS bus width
//	 - Use of a x2 CAM 16 depth, 64b width >>>>BRAM implementation<<<<
//	 - Use of small_through_fifo to store the incoming packet
//	 - Use of small_through_fifo to store the destination port number
//	 - freq : 200MHz,	s_tlast->m_tlast : 40ns,	throughput : 60Mpps
//
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
using System.Threading;
using KiwiSystem;


class Emu
{
	// This class describes the OPL of the reference_switch of the NetFPGA

	// ----------------
	// - I/O PORTS
	// ----------------
	// These are the ports of the circuit (and will appear as ports in the generated Verilog)
	// Slave Stream Ports
	[Kiwi.InputWordPort("s_axis_tdata_0")]	// s_axis_tdata
	static ulong s_axis_tdata_0;			// Data to be received
	[Kiwi.InputWordPort("s_axis_tdata_1")]	// s_axis_tdata
	static ulong s_axis_tdata_1;			// Data to be received
	[Kiwi.InputWordPort("s_axis_tdata_2")]	// s_axis_tdata
	static ulong s_axis_tdata_2;			// Data to be received
	[Kiwi.InputWordPort("s_axis_tdata_3")]	// s_axis_tdata
	static ulong s_axis_tdata_3;			// Data to be received

	[Kiwi.InputBitPort("s_axis_tkeep")]	// s_axis_tkeep
	static uint s_axis_tkeep;			// Offset of valid bytes in the data bus
	[Kiwi.InputBitPort("s_axis_tlast")]	// s_axis_tlast
	static bool s_axis_tlast;			// End of frame indicator
	[Kiwi.InputBitPort("s_axis_tvalid")]	// s_axis_tvalid
	static bool s_axis_tvalid;			// Valid data on the bus - indicator
	[Kiwi.OutputBitPort("s_axis_tready")]	// s_axis_tready
	static bool s_axis_tready;			// Ready to receive data - indicator
	[Kiwi.InputWordPort("s_axis_tuser_hi")]	// s_axis_tuser_hi
	static ulong s_axis_tuser_hi;			// metadata
	[Kiwi.InputWordPort("s_axis_tuser_low")]// s_axis_tuser_low
	static ulong s_axis_tuser_low;		// metadata

	// Master Stream Ports
	[Kiwi.InputWordPort("m_axis_tdata_0")]	// m_axis_tdata
	static ulong m_axis_tdata_0;			// Data to be sent 
	[Kiwi.InputWordPort("m_axis_tdata_1")]	// m_axis_tdata
	static ulong m_axis_tdata_1;			// Data to be sent 
	[Kiwi.InputWordPort("m_axis_tdata_2")]	// m_axis_tdata
	static ulong m_axis_tdata_2;			// Data to be sent 
	[Kiwi.InputWordPort("m_axis_tdata_3")]	// m_axis_tdata
	static ulong m_axis_tdata_3;			// Data to be sent 

	[Kiwi.OutputBitPort("m_axis_tkeep")]	// m_axis_tkeep
	static uint m_axis_tkeep;			// Offset of valid bytes in the data bus
	[Kiwi.InputBitPort("m_axis_tlast")]	// m_axis_tlast
	static bool m_axis_tlast;			// End of frame indicator
	[Kiwi.OutputBitPort("m_axis_tvalid")]	// m_axis_tvalid
	static bool m_axis_tvalid;			// Valid data on the bus - indicator
	[Kiwi.InputBitPort("m_axis_tready")]	// m_axis_tready
	static bool m_axis_tready ;			// Ready to transmit data - indicator
	[Kiwi.OutputBitPort("m_axis_tuser_hi")]	// m_axis_tuser_hi
	static ulong m_axis_tuser_hi;			// metadata
	[Kiwi.OutputBitPort("m_axis_tuser_low")]// m_axis_tuser_low
	static ulong m_axis_tuser_low;		// metadata

	// CAM Memory Ports
	// Input Ports
	[Kiwi.InputWordPort("cam_busy")]		// cam_busy
	static bool cam_busy;				// Busy signal from the CAM
	[Kiwi.InputBitPort("cam_match")]		// cam_match
	static bool cam_match;				// Match singal if data has been found
	[Kiwi.InputBitPort("cam_match_addr")]	// cam_match_addr
	static byte cam_match_addr;			// Return address of the matched data
	// Output Ports
	[Kiwi.OutputWordPort("cam_cmp_din")]	// cam_cmp_din
	static ulong cam_cmp_din=~(ulong)0x00;	// Data to compare against the content of the CAM
	[Kiwi.OutputWordPort("cam_din")]		// cam_din
	static ulong cam_din=0x00;			// Data to be writen in the CAM
	[Kiwi.OutputBitPort("cam_we")]		// cam_we
	static bool cam_we=false;			// Write enable signal
	[Kiwi.OutputBitPort("cam_wr_addr")]	// cam_wr_addr
	static byte cam_wr_addr=0x00;			// Address to write data in CAM

	// CAM Memory Ports
	// Input Ports
	[Kiwi.InputBitPort("cam_busy_learn")]		// cam_busy
	static bool cam_busy_learn;				// Busy signal from the CAM
	[Kiwi.InputBitPort("cam_match_learn")]		// cam_match
	static bool cam_match_learn;				// Match singal if data has been found
	[Kiwi.InputBitPort("cam_match_addr_learn")]	// cam_match_addr
	static byte cam_match_addr_learn;			// Return address of the matched data
	// Output Ports
	[Kiwi.OutputWordPort("cam_cmp_din_learn")]	// cam_cmp_din
	static ulong cam_cmp_din_learn=~(ulong)0x00;	// Data to compare against the content of the CAM
	[Kiwi.OutputWordPort("cam_din_learn")]		// cam_din
	static ulong cam_din_learn=0x00;			// Data to be writen in the CAM
	[Kiwi.OutputBitPort("cam_we_learn")]		// cam_we
	static bool cam_we_learn=false;			// Write enable signal
	[Kiwi.OutputBitPort("cam_wr_addr_learn")]	// cam_wr_addr
	static byte cam_wr_addr_learn=0x00;		// Address to write data in CAM

	// FIFO Ports
	[Kiwi.OutputBitPort("dst_ports")]			// fifo_wr_we
	static ulong dst_ports;					// Write enable signal
	[Kiwi.OutputBitPort("dst_port_rd")]			// fifo_wr_we
	static bool dst_port_rd;					// Write enable signal
	[Kiwi.OutputBitPort("lookup_done")]		// fifo_wr_we
	static bool lookup_done=false;			// Write enable signal
	[Kiwi.InputBitPort("dst_port_fifo_empty")]	// fifo_wr_we
	static bool dst_port_fifo_empty;			// Write enable signal

	// FIFO Ports
	[Kiwi.OutputBitPort("fifo_wr_en")]		// fifo_wr_we
	static bool fifo_wr_en=false;			// Write enable signal
	[Kiwi.OutputBitPort("fifo_rd_en")]		// fifo_rd_we
	static bool fifo_rd_en=false;			// Write enable signal
	[Kiwi.InputBitPort("fifo_nearly_full")]	// fifo_nearly_full
	static bool fifo_nearly_full;			// Write enable signal
	[Kiwi.InputBitPort("fifo_empty")]		// fifo_empty
	static bool fifo_empty;				// Write enable signal


	// Constants variables
	const uint LUT_SIZE = 16U;

	[Kiwi.Volatile] static ulong DEFAULT_oqs	= (ulong)0x0000000000550000;
	[Kiwi.Volatile] static ulong dst_mac, src_mac;
	[Kiwi.Volatile] static ulong broadcast_ports; 
	[Kiwi.Volatile] static ulong metadata		= 0UL;
	[Kiwi.Volatile] static bool  eth_header_rdy	= false;


	//	This class descirbes the parser for the ethernet header
	public class Ethernet
	{
		public void eth_parser()
		{
			byte state =  0x00;

			while(true)
			{
				switch(state)
				{	// READ MAC ADDRESSES
					case 0x00:
						if(s_axis_tvalid & s_axis_tready)
						{
							Emu.metadata	= s_axis_tuser_low;
							Emu.dst_mac	= s_axis_tdata_0<<(byte)16;
							Emu.src_mac	= ((s_axis_tdata_0>>(byte)48) & (ulong)0x00ffff) | ( s_axis_tdata_1 & (ulong)0x00ffffffff )<<(byte)16 ;
							Emu.eth_header_rdy		= true;
							Emu.broadcast_ports		= ( (s_axis_tuser_low & (ulong)0x00FF0000) ^ DEFAULT_oqs)<<(byte)8;
							state		= 0x01;
						
						}
						s_axis_tready	= true;
						break;
					// WAIT EOP
					case 0x01:
						Emu.eth_header_rdy	= false; 
						state = (s_axis_tvalid & s_axis_tlast & s_axis_tready) ? (byte)0x00 : (byte)0x01;
						s_axis_tready	= (s_axis_tvalid & s_axis_tlast) ? false : true;
						break;
					default:
						break;
				}
				Kiwi.Pause();
			}
		}
	}

	// This class describes the operation needed for the CAMs
	// It tries to match and learn the dst_mac and src_mac according to the port number
	public class CAM_controller
	{
		// Memory to store the Output queue of a particular src_mac
		// Each entry is associated with an entry into the CAM
		static ulong[] LUT = new ulong[LUT_SIZE]{0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000,
										0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 
										0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 
										0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000};

		static uint mem_controller_cnt	= 0U;
		static ulong dst_mac			= 0UL;
		static ulong src_mac			= 0UL;
		static ulong metadata			= 0UL;
		static ulong broadcast_ports		= 0UL;
		static ulong tmp_dst_ports		= 0UL;

		public void CAM_lookup_n_learn()
		{
			byte tmp_addr		= 0x00;

			CAM_controller.mem_controller_cnt	= 0U;

			while(true)
			{	// Trigger this logic whenever the ethernet class is done
				if(Emu.eth_header_rdy)
				{
					CAM_controller.dst_mac		= Emu.dst_mac;
					CAM_controller.src_mac		= Emu.src_mac<<16;
					CAM_controller.metadata		= Emu.metadata;
					CAM_controller.broadcast_ports= Emu.broadcast_ports;

					lookup_done		= false;
					cam_din			= cam_din_learn= 0xFFFFFFFFFFFFFFFF;
					cam_we			= cam_we_learn	= false;

					cam_cmp_din		= cam_cmp_din_learn = 0xFFFFFFFFFFFFFFFF;

					do{Kiwi.Pause();}while(cam_busy | cam_busy_learn);

					//	Check if we have the dst_mac in the CAM and retrieve the destination port number
					//	otherwise broadcast
					if(cam_match)
						dst_ports		= (LUT[(byte)cam_match_addr] | CAM_controller.metadata);
					else
						dst_ports		= (ulong)(CAM_controller.broadcast_ports | CAM_controller.metadata);

					lookup_done		= true;


					if(!cam_match_learn)
					{

						cam_we			= true;
						cam_din			= CAM_controller.src_mac;
						cam_wr_addr		= (byte)mem_controller_cnt;

						cam_we_learn		= true;
						cam_din_learn		= CAM_controller.src_mac;
						cam_wr_addr_learn	= (byte)mem_controller_cnt;

						// Update the LUT with the src port
						tmp_addr	= (byte)CAM_controller.mem_controller_cnt;
						LUT[(byte)CAM_controller.mem_controller_cnt]	= (CAM_controller.metadata & (ulong)0x00FF0000)<<8;

						if(CAM_controller.mem_controller_cnt == (uint)(LUT_SIZE-1U)) 
							CAM_controller.mem_controller_cnt	= 0U; 
						else 
							CAM_controller.mem_controller_cnt	+= 1U;
					}
					else
					{
						cam_din	= cam_din_learn	= 0xFFFFFFFFFFFFFFFF;
						cam_we	= cam_we_learn		= false;
						tmp_addr	= (byte)cam_match_addr_learn;
					}
				}
				else
				{
					cam_cmp_din		= s_axis_tdata_0<<(byte)16; //Emu.dst_mac;
					cam_cmp_din_learn	= (((s_axis_tdata_0>>(byte)48) & (ulong)0x00ffff) | ( s_axis_tdata_1 & (ulong)0x00ffffffff )<<(byte)16 )<<16;
					cam_din	= cam_din_learn= 0xFFFFFFFFFFFFFFFF;
					cam_we	= cam_we_learn	= false;
					lookup_done		= false;
				}
				Kiwi.Pause();
			}
		}
	}

	// TODO -- future work
	public class FIFO_controller
	{
//		public void FIFO_receive()
//		{
//			while(true)
//			{
//			
//			s_axis_tready	= (!s_axis_tlast) ? true : false;

//			
//			fifo_wr_en	= (s_axis_tvalid  && !s_axis_tlast && !fifo_nearly_full) ? true : false;

//			if(s_axis_tvalid)
//			{
//				s_axis_tready	=  true;
//				fifo_wr_en	=  !fifo_nearly_full && !s_axis_tlast;
//			}
//			else
//			{
//				s_axis_tready	= !fifo_nearly_full;
//				fifo_wr_en	= false;
//			}

//				Kiwi.Pause();
//			}
//		}

		public void FIFO_send()
		{
			byte state		= 0x00;
			m_axis_tvalid		= false;
			dst_port_rd		= false;

			while(true)
			{
				switch(state)
				{	// WAIT_STATE
					case 0x00:
						if(!dst_port_fifo_empty)
						{
							state		= 0x01;
							m_axis_tvalid	= true;
							dst_port_rd	= true;
						}
						else
						{
							m_axis_tvalid	= false;
							dst_port_rd	= false;
						}
						break;
					// SEND_STATE
					case 0x01:
					
						if(m_axis_tlast & m_axis_tvalid & m_axis_tready)
						{
							state		= 0x00;
							m_axis_tvalid	= !fifo_empty & !dst_port_fifo_empty;
						}
						dst_port_rd	= false;
						break;

					default:
						break;
				}
				Kiwi.Pause();
			}
		}
	}

	// #############################
	// # Main Hardware Enrty point
	// #############################
	[Kiwi.HardwareEntryPoint()] 
	static int EntryPoint()
	{
		// Create and start the thread for the CAM controller
		CAM_controller cam_controller = new CAM_controller();
		Thread CAM_lookup_n_learn = new Thread(new ThreadStart(cam_controller.CAM_lookup_n_learn));
		CAM_lookup_n_learn.Start();

		// Create and start the thread for the ethernet parser
		Ethernet eth_controller = new Ethernet();
		Thread eth_ctrl = new Thread(new ThreadStart(eth_controller.eth_parser));
		eth_ctrl.Start();

		// Create and start the thread for the FIFO controller
		FIFO_controller fifo_controller = new FIFO_controller();
//		Thread FIFO_receive = new Thread(new ThreadStart(fifo_controller.FIFO_receive));
//		FIFO_receive.Start();
		Thread FIFO_send = new Thread(new ThreadStart(fifo_controller.FIFO_send));
		FIFO_send.Start();
		while (true) {Kiwi.Pause();};
		return 0;
	}

	static int Main()
	{
		return 0;
	}

}







