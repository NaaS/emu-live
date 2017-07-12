//	Memcached Server(GET/SET/DELETE response) -- UDP Memcached ASCII protocol v2
//	
//	Implementation on the NetFPGA platform, making use of the kiwi compiler (C#) 
//	The generated verilog file should replace the OPL of the reference datapath
//	Simple Memcached Server. Basic functionality of 'set', 'get', 'delete'
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
//	version/additions
//		-UPDATE the module server to support 256b AXIS intrerface
//		-UPDATE clock frequency @ 200MHz
//		-UPDATE 'SET' command to overwrite existing keys - values
//		-UPDATE works with an extra UDP header, based om the UDP Memcached binary protocol
//		-add code for receiving/transmiting, procedures/functions
//		-add buffer to store the whole packet
//		-add SET response functionality (without error code)
//		-add DELETE response functionality (with error code + textual error msg)
//		-add GET response functionality (with error code + textual error msg)
//		-add controller-logic for SRL16-based CAM (1cc read, 16cc write)
//		-add functionality to calculate/validate IP checksum
//		-add function that calculaates/validates the UDP checksum
//
//	Latest working set-up:
//		-Vivado 2014.4
//		-KiwiC Version Alpha 0.3.1x
//
//	TODO:
//		Key size 6B (fixed)
//		Value size 8B (fixed)
//
//	References:
//		https://github.com/memcached/memcached/blob/master/doc/protocol.txt
//		http://memcached.googlecode.com/svn/wiki/MemcacheBinaryProtocol.wiki
//		http://www.xilinx.com/support/documentation/application_notes/xapp1151_Param_CAM.pdf
//

using System;
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
	[Kiwi.OutputWordPort("cam_cmp_din")]	// cam_cmp_din
	static ulong cam_cmp_din=~(ulong)0x00;	// Data to compare against the content of the CAM
	[Kiwi.OutputWordPort("cam_din")]	// cam_din
	static ulong cam_din=0x00;		// Data to be writen in the CAM
	[Kiwi.OutputBitPort("cam_we")]		// cam_we
	static bool cam_we=false;		// Write enable signal
	[Kiwi.OutputBitPort("cam_wr_addr")]	// cam_wr_addr
	static byte cam_wr_addr=0x00;		// Address to write data in CAM

	// Debug register - Output Port
	[Kiwi.OutputWordPort("debug_reg")]	// debug_reg
	static uint debug_reg=0x00;		// Register for debuging purpose
	// End of I/O signals

	// Constants variables
	const uint BUF_SIZE = (uint)16;
	const uint MEM_SIZE = (uint)16;

	// Constants for the Memcached header
	// Commands
	const byte NONE		= 0x00;
	const byte SET 		= 0x01;
	const byte GET		= 0x02;
	const byte DELETE	= 0x03;
	// Error textual message
	const ulong ERROR_MSG	= 0x313020524f525245; // ASQII = "10 RORRE" ~ "ERROR 01" 
	// Memory for the values of every key
	static ulong[] VALUES_MEM = new ulong[MEM_SIZE];

	static ulong dst_mac, src_mac, src_port, dst_port, src_ip, dst_ip; 
	static bool IPv4 = false, proto_UDP = false, proto_ICMP = false;
	static uint key_length;
	static byte extras_length;
	static ulong IP_total_length, UDP_total_length, app_src_port, app_dst_port, ICMP_code_type;
	static ulong key, key_value, extras, flag;
	static uint num=0;
	static byte command_type=0;
    
	// Local buffer for storing the incoming packet
	static uint[] tkeep	= new uint[BUF_SIZE];
	static bool[] tlast	= new bool[BUF_SIZE];
	static ulong[] tdata_0	= new ulong[BUF_SIZE];
	static ulong[] tdata_1	= new ulong[BUF_SIZE];
	static ulong[] tdata_2	= new ulong[BUF_SIZE];
	static ulong[] tdata_3	= new ulong[BUF_SIZE];
	//static ulong[] tuser_hi	= new ulong[BUF_SIZE]; // unsued
	static ulong[] tuser_low= new ulong[BUF_SIZE];

	static ulong chksum_IP=0UL, chksum_UDP=0UL, tmp, tmp3, tmp2, tmp1;

	static uint mem_controller_cnt=0U;

	// This method describes the main logic functionality of the Server
	static public void memcached_logic()
	{
		ulong d0=0UL, d1=0UL, d2=0UL, d3=0UL, sum=0UL, sum1=0UL, sum2=0UL, u;
		uint i=0U;
		byte local_command_type=0;

		uint pkt_size=0U;
		bool is_ipv4=false, is_udp=false, is_icmp=false;
		uint addr=0U;
		bool good_IP_checksum = false, error = false;

		while (true) // Process packets indefinately
		{
			// Store the packet into the buffer
			pkt_size = ReceiveFrame();
			Kiwi.Pause();

			is_ipv4 		= IPv4;
			is_udp 			= proto_UDP;
			is_icmp			= false;
			local_command_type	= command_type;
			Kiwi.Pause();
		        // #############################
			// # Server Logic -- START
			// #############################

			// #######################################################################################
			// # 				MEMCACHED SERVER
			if ( is_ipv4 && is_udp )
			{
				// Calculate the IP checksum
				chksum_IP = calc_IP_checksum();
				good_IP_checksum = ( chksum_IP == (ulong)0x00 );

				if ( (local_command_type!=NONE) && good_IP_checksum )
				{
					// Give to the controller the command to perform an action
					addr	= cam_controller(local_command_type);
					error	= addr == (uint)MEM_SIZE;
					Kiwi.Pause();

					if (!error)
					{
						// Store/get the value in/from the RAM
						switch(local_command_type)
						{
							case SET:
								VALUES_MEM[addr] = key_value;
								break;
							case GET:
								key_value = VALUES_MEM[addr];
								break;
							case DELETE:
								VALUES_MEM[addr] = 0UL;
								break;
							default:
								break;
						}
					}
					Kiwi.Pause();

					chksum_UDP	= (ulong)0x00;
					chksum_IP 	= 0x00;
					// Swap the fields in the Ethernet frame 
					swap_multiple_fields(is_udp, is_icmp);
					Kiwi.Pause();
					// Create the response packet + reset appropriate fields(ex. UDP checksum)
					switch (local_command_type)
					{
						case SET	: 	pkt_size = Memcached_SET();		break;
						case GET	:	pkt_size = Memcached_GET(error);	break;
						case DELETE	:	pkt_size = Memcached_DELETE(error);	break;
						default		:						break;
					}
					Kiwi.Pause();

					tmp	= tdata_3[0];
					Kiwi.Pause();

					chksum_IP	= calc_IP_checksum();
					Kiwi.Pause();
					// Set the new IP checksum - as we dont change any info in the header,
					// the checksum should remane the same - but anyway recalc and put it back
					tdata_3[0]	= (chksum_IP>>8 | (chksum_IP&(ulong)0x00ff)<<8) | tmp; 
					// Here is the UDP checksum - clear it and preserve the other data
					tmp	= tdata_1[1]; //we have already clear the UDP checksum
					tmp2	= tdata_0[1]>>16;
					Kiwi.Pause();
					// The 1sh element in the buffer is the start of the UDP frame
					for(i=1; i<pkt_size+1; i++)
					{
						chksum_UDP	= (i==1) ? calc_UDP_checksum(tmp2, 0UL) : calc_UDP_checksum(tdata_0[i], chksum_UDP);
						Kiwi.Pause();
						chksum_UDP	= calc_UDP_checksum(tdata_1[i], chksum_UDP);
						Kiwi.Pause();
						chksum_UDP	= calc_UDP_checksum(tdata_2[i], chksum_UDP);
						Kiwi.Pause();
						chksum_UDP	= calc_UDP_checksum(tdata_3[i], chksum_UDP);
						Kiwi.Pause();
					}
					// Here is the new UDP length + proto type
					tmp3	= (tdata_0[1] & (ulong)0xffff000000000000) | (ulong)0x001100;
					// (optimization) src, dst IPs - pseudo header
					tmp2	= src_ip<<32 | dst_ip; 
					Kiwi.Pause();
					// (optimization) 11U = 0x11 = UDP proto_type , UDP length - pseudo header
					sum	= calc_UDP_checksum(tmp3, chksum_UDP); 
					Kiwi.Pause();
					chksum_UDP =	calc_UDP_checksum(tmp2, sum); 
					Kiwi.Pause();
					// 1's complement of the result
					tmp2	= (ulong)(( chksum_UDP ^ ~(ulong)0x00 ) & (ulong)0x00ffff);
					Kiwi.Pause();
					// make it back to little endian
					tmp3	= (ulong)((tmp2>>8) | (ulong)(tmp2&(ulong)0x00ff)<<8) ;
					// Set the new UDP checksum
					tdata_1[1]	= tmp | tmp3;
			}
			// # 
			// ###########################################################################################

			//#############################
			//# Server Logic -- END 
			//#############################

			// Procedure to send out the packet
			SendFrame(pkt_size); 

			//debug_reg		= (uint)(tuser_low[0]);
			//Kiwi.Pause();
		        // End of frame, ready for next frame
			command_type	= 0x00;
			IPv4		= false;
			proto_UDP	= false;
			chksum_UDP	= 0x00;
			pkt_size	= 0x00;
			error		= true;
			}
		}
	}

	// This procedure creates the GET response packet 
	static public uint Memcached_GET(bool err)
	{
		ulong tmplen1=0UL, tmplen2=0UL, tmp0=0x00, tmp1=0x00, tmp2=0x00, tmp3=0x00;

		// Calc the correct IP packet length (little endianess)
		// GET - Fixed size 
		// Error - size 41B
		// !Error - size 71B
		tmplen1	= (err) ? (ulong)0x002900 : (ulong)0x004700;
		// Calc the correct UDP packet length (little endianess)
		// GET - Fixed size 
		// in case of an error we must adjust the length accordinlgy
		// Error - size 21B - 0x15
		// !Error - size 51B - 0x33
		tmplen2	= (err) ? (ulong)0x1500000000000000 : (ulong)0x3300000000000000;
		tmp2	= tdata_2[0] & (ulong)0xffffffffffff0000;
		// Reset the UDP checksum to 0x00, calculate later
		tmp3	= tdata_3[0] & (ulong)0xffffffffffff0000;
		// Reset the IP checksum to 0x00, calculate later
		tmp0	= tdata_0[1] & (ulong)0x0000ffffffffffff; 
		// Reset the UDP checksum 
		tmp1	= tdata_1[1];

		Kiwi.Pause();
		// Set the new IP length
		tdata_2[0]	= tmp2 | tmplen1;
		// Set the checsum to 0x0000
		tdata_3[0]	= tmp3;
		// Set the new UDP length
		tdata_0[1]	= tmp0 | tmplen2;  
		// Set the UDP checsum to 0x0000
		tdata_1[1]	= tmp1 & ~(ulong)0x00ffff;
		Kiwi.Pause();

		// Set the response
		// VALUE <key> <flags> <bytes>\r\n
		// <data block>\r\n
		// END\r\n
		tmp2	= tdata_2[1] & (ulong)0x00ffff;
		Kiwi.Pause();

		// set GET magic number + opcode
		// set also the extras length(4b)
		if(!err)
		{
			tdata_2[1]	= tmp2 | (ulong)0x2045554c41560000;	// VALUE
			tdata_3[1]	= key; 					// <key>
			tdata_0[2]	= (ulong)0x00000a0d38203020 | key_value<<48;	// <flags> + <bytes> + <data_block>
			tdata_1[2]	= key_value>>16 | (ulong)0x0a0d000000000000;	// <data block>\r\n
			Kiwi.Pause();
			tdata_2[2]	= (ulong)0x000a0d444e45;
			tdata_3[2]	= 0UL;
			// Set the correct metadata for the datapath
			// Fixed size response packet for GET/DELETE failure
			tuser_low[0]	= dst_port | src_port | (ulong)85;
			tkeep[2]	= (uint)0x001fffff;
		}
		else
		{
			tdata_3[1]	= 0UL;
			tdata_2[1]	= tmp2 | (ulong)0x000a0d444e450000;	// END\r\n
			tuser_low[0]	= dst_port | src_port | (ulong)55;
			tkeep[1]	= (uint)0x00007fffff;
		}

		return( err?1U:2U );
	}

	// This procedure creates the DELETE response packet 
        static public uint Memcached_DELETE(bool err)
	{
		ulong tmplen1=0x00, tmplen2=0x00, tmp0=0x00, tm1=0x00, tmp2=0x00, tmp3=0x00;

		// DELETE - Fixed size total IP length
		tmplen1	= (!err) ? (ulong)0x002d00 : (ulong)0x002f00;
		// DELETE - Fixed size UDP length ( IP_length - 20B)
		tmplen2	= (!err) ? (ulong)0x1900000000000000 : (ulong)0x1b00000000000000;

		// Reset the IP length
		tmp2	= tdata_2[0] & (ulong)0xffffffffffff0000;
		// Reset the checksum to 0x00, calculate later
		tmp3	= tdata_3[0] & (ulong)0xffffffffffff0000;
		// Reset the UDP length
		tmp0	= tdata_0[1] & (ulong)0x0000ffffffffffff;
		// Reset the UDP checksum 
		tmp1	= tdata_1[1];
		Kiwi.Pause();

		// Set the new IP length
		tdata_2[0]	= tmp2 | tmplen1;
		// Set the checsum to 0x0000
		tdata_3[0]	= tmp3;
		// Set the new UDP checksum
		tdata_0[1]	= tmp0 | tmplen2;  
		// Set the UDP checksum to 0x0000
		tdata_1[1]	= tmp1 & ~(ulong)0x00ffff;
		Kiwi.Pause();

		// Fill up the rest of the response packet
		tmp2	= tdata_2[1] & 0x000000000000ffff;
		Kiwi.Pause();

		//				"NOT_FO"			"DELETE"
		tdata_2[1]	= (err) ? (ulong)0x4f465f544f4e0000 | tmp2 : (ulong)0x4554454c45440000 | tmp2;
		//				"UND\r\n"		"D\r\n"
		tdata_3[1]	= (err) ? (ulong)0x000a0d444e55 : (ulong)0x000a0d44;
		// Set the correct metadata for the datapath
		// Fixed size response packet for  DELETE success
		tuser_low[0]	= (err) ? dst_port | src_port | (ulong)61 : dst_port | src_port | (ulong)59;
		tkeep[1]	= (err) ? (uint)0x1fffffff : (uint)0x07ffffff;
		return 1U;
	}

	// This procedure creates the SET response packet 
        static public uint Memcached_SET()
	{
		ulong tmp0=0UL, tmp1=0UL, tmp2=0UL, tmp3=0UL;
		
		// Set the correct IP packet length (little endianess)
		// SET - Fixed size 44B
		tmp2	= tdata_2[0] & (ulong)0xffffffffffff0000;
		// Set the checksum to 0x00, calculate later
		tmp3	= tdata_3[0] & (ulong)0xffffffffffff0000;
		// Set the correct UDP packet length (little endianess)
		// SET - Fixed size 24B
		tmp0	= tdata_0[1] & (ulong)0x0000ffffffffffff;
		// Reset the UDP checksum 
		tmp1	= tdata_1[1];
		Kiwi.Pause();

		tdata_2[0]	= tmp2 | (ulong)0x002c00;	// 44 Bytes
		tdata_3[0]	= tmp3;
		tdata_1[1]	= tmp1 & ~(ulong)0x00ffff;
		tdata_0[1]	= tmp0 | (ulong)0x1800000000000000;	// 24 Bytes
		Kiwi.Pause();

		tmp2	= tdata_2[1] & (ulong)0x00ffff;
		Kiwi.Pause();

		// ASCII response - STORED
		tdata_2[1]	= tmp2 | (ulong)0x4445524f54530000; 
		// ASCII response cont - \r\n
		tdata_3[1]	= (ulong)0x000a0d;
		// Set the correct metadata for the datapath
		// Fixed size response packet for SET - DELETE success
		tuser_low[0]	= dst_port | src_port | (ulong)58;
		tkeep[1]	= (uint)0x03ffffff;
		return 1U;
	}

	// This procedure calculates the checksum of a given byte stream
	// It returns the result in big endianess format
	// It doenst compute the 1's complement
	static public ulong calc_UDP_checksum(ulong data, ulong chksum_udp)
	{
		ulong tmp0=0x00, tmp1=0x00, tmp2=0x00, tmp3=0x00, sum0=0, sum1=0, sum=0, chk=0;

		chk = chksum_udp;

		// extract every 16-bit from the stream for addition and reorder it to big endianess

		tmp0 = ((ulong)(data>>0 ) & (ulong)0x00ff)<<8 | ((ulong)(data>>0) & (ulong)0x00ff00)>>8;
		tmp1 = ((ulong)(data>>16) & (ulong)0x00ff)<<8 | ((ulong)(data>>16) & (ulong)0x00ff00)>>8;
		tmp2 = ((ulong)(data>>32) & (ulong)0x00ff)<<8 | ((ulong)(data>>32) & (ulong)0x00ff00)>>8;
		tmp3 = ((ulong)(data>>48) & (ulong)0x00ff)<<8 | ((ulong)(data>>48) & (ulong)0x00ff00)>>8;
                Kiwi.Pause();
		// check for carry and add it if its needed
		sum0 = (ulong)( (tmp0 + tmp1)& (ulong)0x00ffff ) + (ulong)( (tmp0 + tmp1)>>16); 
		sum1 = (ulong)( (tmp2 + tmp3)& (ulong)0x00ffff ) + (ulong)( (tmp2 + tmp3)>>16); 
		Kiwi.Pause();
		// check for carry and add it if its needed
		sum = (ulong)( (sum0 + sum1)& (ulong)0x00ffff ) + (ulong)((sum0 + sum1)>>16);
		Kiwi.Pause();
		// add the current sum to the previous sums
		chksum_udp = (ulong)( (sum + chk)& (ulong)0x00ffff ) + (ulong)((sum + chk)>>16);

		return ( chksum_udp );
	}



	// This procedure perform the calculation of the new checksum and verification
	// It returns the new checksum(on calculation process) or 0x00 if no-errors were detected(on verification process)
	static ulong calc_IP_checksum()
	{
		ulong tmp0=0x00, tmp1=0x00, tmp2=0x00, tmp3=0x00;
		ulong sum0=0x00, sum1=0x00, sum=0x00;
		ulong data=0x00,sum_all = 0x00;
		byte i;
		for(i=1; i<5; i++)
		{
			data = (i==1) ? tdata_1[0]>>48 : (i==4) ? tdata_0[1]<<48 : (i==2) ? tdata_2[0] : (i==3) ? tdata_3[0] : (ulong)0x00;
			Kiwi.Pause();
			// extract every 16-bit from the stream for addition and reorder it to big endianess
			tmp0 = ((ulong)(data>>0) & (ulong)0x00ff)<<8 | ((ulong)(data>>0) & (ulong)0x00ff00)>>8;
			tmp1 = ((ulong)(data>>16) & (ulong)0x00ff)<<8 | ((ulong)(data>>16) & (ulong)0x00ff00)>>8;
			tmp2 = ((ulong)(data>>32) & (ulong)0x00ff)<<8 | ((ulong)(data>>32) & (ulong)0x00ff00)>>8;
			tmp3 = ((ulong)(data>>48) & (ulong)0x00ff)<<8 | ((ulong)(data>>48) & (ulong)0x00ff00)>>8;
                        Kiwi.Pause();
			// check for carry and add it if its needed
			sum0 = (ulong)( (tmp0 + tmp1)& (ulong)0x00ffff ) + (ulong)( (tmp0 + tmp1)>>16); 
			sum1 = (ulong)( (tmp2 + tmp3)& (ulong)0x00ffff ) + (ulong)( (tmp2 + tmp3)>>16); 
			Kiwi.Pause();
			// check for carry and add it if its needed
			sum = (ulong)( (sum0 + sum1)& (ulong)0x00ffff ) + (ulong)((sum0 + sum1)>>16);
			Kiwi.Pause();
			// add the current sum to the previous sums
			sum_all = (ulong)( (sum + sum_all)& (ulong)0x00ffff ) + (ulong)((sum + sum_all)>>16);
		}
		Kiwi.Pause();
		//(ulong)(~sum0 & (ulong)0x00ffff); DOESNT WORK	
		sum_all = ( sum_all ^ ~(ulong)0x00 ) & (ulong)0x00ffff;
		
		return( sum_all ); 
	}


	// This procedure perform basic control operation for the CAM 
	static uint cam_controller(byte mode)
	{
		uint tmp_addr=0x00;

		// Poll until CAM is ready
		while(cam_busy){Kiwi.Pause();}

		switch (mode)
		{	// WRITE operation - returns the address in which the key is stored
			case SET: // 0x01
				// Check if the key exists in the CAM
				cam_cmp_din	= key;
				Kiwi.Pause();
				cam_cmp_din	= key;
				Kiwi.Pause();
				// Perform the store operation
				cam_din		= key;
				cam_wr_addr	= (cam_match) ? (byte)cam_match_addr : (byte)mem_controller_cnt;
				tmp_addr	= (cam_match) ? (byte)cam_match_addr : (byte)mem_controller_cnt;
				Kiwi.Pause();

				cam_we	= true;
				Kiwi.Pause();
				cam_we	= false;
				Kiwi.Pause();

				break;
			// READ operation - return the address if we have a match otherwhise MEM_SIZE
			case GET: // 0x00
				cam_cmp_din	= key;
				Kiwi.Pause();
				cam_cmp_din	= key;
				Kiwi.Pause();
				tmp_addr	= (cam_match) ? (uint)cam_match_addr : (uint)MEM_SIZE; 
				
				break;	
			// DELETE operation - return the address if we have a match otherwhise MEM_SIZE
			case DELETE: // 0x04
				cam_cmp_din	= key;
				Kiwi.Pause();
				cam_cmp_din	= key;
				Kiwi.Pause();
				if(cam_match)
					tmp_addr	= (uint)cam_match_addr;
				else 
					tmp_addr	= (uint)MEM_SIZE; 

				Kiwi.Pause();
				if(cam_match){
					Kiwi.Pause();
					cam_din		= (ulong)0x00;
					cam_wr_addr	= (byte)tmp_addr;
					Kiwi.Pause();
					cam_we		= true;
					Kiwi.Pause();
					cam_we		= false;
					Kiwi.Pause();
				}
				break;
			default: break;
		}

		if(mem_controller_cnt == (uint)(MEM_SIZE-1U)) mem_controller_cnt = 0; else mem_controller_cnt += 1U;

		return tmp_addr;
	}


	// This procedure perform swap of multiple fields
	// dst_mac<->src_mac, dst_ip<->src_ip, dst_port<->src_port
	static void swap_multiple_fields(bool udp, bool icmp)
	{
		ulong tmp=0UL, tmp1=0UL, tmp3=0UL;
		bool udp_tmp, icmp_tmp;

		if(udp)
			// Swap the ports, Memcached
			tmp = (tdata_0[1]& (ulong)0xffff000000000000) | src_ip>>16 | app_src_port<<32 | app_dst_port<<16;
		if(icmp)
			// Set the ICMP echo reply type=0, code=0 and checksum=0x00
			tmp = (tdata_0[1] & (ulong)0xffff000000000000) | src_ip>>16;
		// Ethernet header swap
		tdata_0[0]	= src_mac | (dst_mac<<48);
		// Ethernet header swap
		tmp1		= (tdata_1[0] & (ulong)0xffffffff00000000) | dst_mac>>16;
		// IP header swap + UDP header swap 
		tmp3		= (tdata_3[0] & (ulong)0x00ffff) | dst_ip<<16 | src_ip<<48;
		Kiwi.Pause();

		tdata_1[0]	= tmp1;
		tdata_3[0]	= tmp3;
		tdata_0[1]	= tmp;
		Kiwi.Pause();
	}

	// The procedure is implemented as a separate thread and
	// will extract usefull data from the incoming stream
	// In order to utilize more the icoming process 
	static public void Extract_headers(uint count, ulong tdata0, ulong tdata1, ulong tdata2, ulong tdata3, ulong tuser)
	{
		switch(count)
		{
			// Start of the Ethernet header
			case 0U:
				dst_mac		= tdata0 & (ulong)0x0000ffffffffffff;
				src_mac		= (tdata0>>48 & (ulong)0x00ffff) | (( tdata1 & (ulong)0x00ffffffff)<<16);
				// metadata ports - NOT UDP ports
				src_port	= (tuser & (ulong)0x00ff0000);
				// set the dst_port the same as the src_port
				dst_port	= ((tuser & (ulong)0x00ff0000)<<8);
				IPv4		= ( ( tdata1>>32 & (ulong)0x00ffff) == (ulong)0x0008) && (( tdata1>>52 & (ulong)0x0f) == (ulong)0x04);
				proto_ICMP	= (  tdata2>>56 & (ulong)0x00ff) == (ulong)0x0001;
				proto_UDP	= (  tdata2>>56 & (ulong)0x00ff) == (ulong)0x0011;
				IP_total_length	= (  tdata2 & (ulong)0x00ffff );
				// Start of the IP header
				src_ip		= ( tdata3>>16) & (ulong)0x00ffffffff;
				dst_ip		= ( tdata3>>48) & (ulong)0x00ffff;
				break;
			// Start of the UDP header
			case 1U:
				dst_ip		|= (  tdata0 & (ulong)0x00ffff )<<16; 
				app_src_port	= (  tdata0>>16 & (ulong)0x00ffff);
				app_dst_port	= (  tdata0>>32 & (ulong)0x00ffff);
				UDP_total_length= (  tdata0>>48 & (ulong)0x00ffff);
				ICMP_code_type	= (  tdata0>>16 & (ulong)0x00ffff);
				
				// Start of the UDP frame & Memcached Header
				// <command name> <key> <flags> <exptime> <bytes> \r\n
				// <data block>\r\n
				// <key>	8 Bytes
				// <flags>	1 Byte
				// <exptime>	1 Byte
				// <bytes>	1 Byte
				// <data block> 8 Byte
				// Start of the Memcached payload

				// SET command
				if ( (( tdata2>>16 ) & (ulong)0x00ffffffff) == (ulong)0x0020746573 )
				{	command_type = SET;	key = tdata2>>48 | tdata3<<16; 	}
				// GET command
				else if ( (( tdata2>>16 ) & (ulong)0x00ffffffff) == (ulong)0x0020746567 )
				// get <key>\r\n
				{	command_type = GET;	key = tdata2>>48 | tdata3<<16;	}
				// DELETE command
				else if ( (( tdata2>>16 ) & (ulong)0x00ffffffffffff) == (ulong)0x006574656c6564 )
				// delete <key>\r\n
				{	command_type = DELETE;	key = tdata3>>8;	}
				else
				{	command_type = NONE;	key = 0U;	}
				break;
			case 2U:
				if ( command_type == SET )
					key_value = tdata0>>48 | tdata1<<16;
				else if ( command_type == DELETE )
					key |= tdata0<<56;
				else
					key_value = 0UL;
				break;
			default: break;
		} 
	}


	// This method describes the operations required to rx a frame over the AXI4-Stream.
	// and extract basic information such as dst_MAC, src_MAC, dst_port, src_port
	static public uint ReceiveFrame()
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

		Kiwi.Pause();

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
				tuser_low[cnt]	= s_axis_tuser_low;

				Extract_headers(cnt, s_axis_tdata_0, s_axis_tdata_1, s_axis_tdata_2, s_axis_tdata_3, s_axis_tuser_low);

				psize = cnt++;
				// Condition to stop receiving data
				doneReading = !s_axis_tlast && s_axis_tvalid;
				// Create backpresure to whatever sends data to us
				s_axis_tready = s_axis_tlast ? false : true;
			}
			Kiwi.Pause();
		}

		data_0	= tdata_0[psize];
		data_1	= tdata_1[psize];
		data_2	= tdata_2[psize];
		data_3	= tdata_3[psize];
		keep	= tkeep[psize];

		Kiwi.Pause();

		if( keep>>24 != (uint)0x00 )
		{
		data_3 =  keep== 0x01ffffff ? data_3 & (ulong)0x00ff:
			  keep== 0x03ffffff ? data_3 & (ulong)0x00ffff:
			  keep== 0x07ffffff ? data_3 & (ulong)0x00ffffff:
			  keep== 0x0fffffff ? data_3 & (ulong)0x00ffffffff:
			  keep== 0x1fffffff ? data_3 & (ulong)0x00ffffffffff:
			  keep== 0x3fffffff ? data_3 & (ulong)0x00ffffffffffff:
			  keep== 0x7fffffff ? data_3 & (ulong)0x00ffffffffffffff:
			  keep== 0xffffffff ? data_3 & (ulong)0xffffffffffffffff : 0;
		}
		else if( keep>>16 != (uint)0x0000)
		{
		data_2 =  keep== 0x0001ffff ? data_2 & (ulong)0x00ff:
			  keep== 0x0003ffff ? data_2 & (ulong)0x00ffff:
			  keep== 0x0007ffff ? data_2 & (ulong)0x00ffffff:
			  keep== 0x000fffff ? data_2 & (ulong)0x00ffffffff:
			  keep== 0x001fffff ? data_2 & (ulong)0x00ffffffffff:
			  keep== 0x003fffff ? data_2 & (ulong)0x00ffffffffffff:
			  keep== 0x007fffff ? data_2 & (ulong)0x00ffffffffffffff:
                          keep== 0x00ffffff ? data_2 & (ulong)0xffffffffffffffff : 0;
		data_3 = 0UL;
		}
		else if( keep>>8 != (uint)0x0000)
		{
		data_1 =  keep== 0x000001ff ? data_1 & (ulong)0x00ff:
			  keep== 0x000003ff ? data_1 & (ulong)0x00ffff:
			  keep== 0x000007ff ? data_1 & (ulong)0x00ffffff:
			  keep== 0x00000fff ? data_1 & (ulong)0x00ffffffff:
			  keep== 0x00001fff ? data_1 & (ulong)0x00ffffffffff:
			  keep== 0x00003fff ? data_1 & (ulong)0x00ffffffffffff:
			  keep== 0x00007fff ? data_1 & (ulong)0x00ffffffffffffff:
                          keep== 0x0000ffff ? data_1 & (ulong)0xffffffffffffffff : 0;
		data_3 = 0UL;
		data_2 = 0UL;
		}
		else
		{
		data_0 =  keep== 0x00000001 ? data_0 & (ulong)0x00ff:
			  keep== 0x00000003 ? data_0 & (ulong)0x00ffff:
			  keep== 0x00000007 ? data_0 & (ulong)0x00ffffff:
			  keep== 0x0000000f ? data_0 & (ulong)0x00ffffffff:
			  keep== 0x0000001f ? data_0 & (ulong)0x00ffffffffff:
			  keep== 0x0000003f ? data_0 & (ulong)0x00ffffffffffff:
			  keep== 0x0000007f ? data_0 & (ulong)0x00ffffffffffffff:
                          keep== 0x000000ff ? data_0 & (ulong)0xffffffffffffffff : 0;
		data_3 = 0UL;
		data_2 = 0UL;
		data_1 = 0UL;
		}

		Kiwi.Pause();

		tdata_0[psize]	= data_0;
		tdata_1[psize]	= data_1;
		tdata_2[psize]	= data_2;
		tdata_3[psize]	= data_3;
		Kiwi.Pause();

		s_axis_tready	= false;

		return psize;
	}

	// This method describes the operations required to tx a frame over the AXI4-Stream.
	static void SendFrame(uint pkt_size)
	{
		// #############################
		// # Transmit the frame
		// #############################
		m_axis_tvalid		= true;
		m_axis_tlast		= false;
		m_axis_tdata_0		= 0UL;
		m_axis_tdata_1		= 0UL;
		m_axis_tdata_2		= 0UL;
		m_axis_tdata_3		= 0UL;
		m_axis_tkeep		= (byte)0x0;
		m_axis_tuser_hi		= 0UL;
		m_axis_tuser_low	= 0UL;

		uint i=0;

		while (i<=pkt_size)
		{
			if ( m_axis_tready )
			{
				m_axis_tdata_0	= tdata_0[i];
				m_axis_tdata_1	= tdata_1[i];
				m_axis_tdata_2	= tdata_2[i];
				m_axis_tdata_3	= tdata_3[i];
				m_axis_tkeep	= i == (pkt_size) ? tkeep[pkt_size] : (uint)0xffffffff;
				m_axis_tlast	= i == (pkt_size);
				m_axis_tuser_hi	= 0UL;
				m_axis_tuser_low= tuser_low[i];
				i++;
			}
			Kiwi.Pause();
		}

		m_axis_tvalid		= false;
		m_axis_tlast		= false;
		m_axis_tdata_0		= (ulong)0x0;
		m_axis_tdata_1		= (ulong)0x0;
		m_axis_tdata_2		= (ulong)0x0;
		m_axis_tdata_3		= (ulong)0x0;
		m_axis_tkeep		= (byte)0x0;
		m_axis_tuser_hi		= (ulong)0x0;
		m_axis_tuser_low	= (ulong)0x0;
		Kiwi.Pause();
	}


	/////////////////////////////
	// Main Hardware Enrty point
	/////////////////////////////
	[Kiwi.HardwareEntryPoint()] 
	static int EntryPoint()
	{
		while (true) memcached_logic();
	}
	
	static int Main()
	{
		return 0;
	}
 }



