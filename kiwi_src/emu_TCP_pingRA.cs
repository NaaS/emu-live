//    TCP ping response with RST-ACK flag 
//    Implementation on the NetFPGA platform, making use of the kiwi compiler (C#) 
//    The generated verilog file should replace the OPL of the reference datapath
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
//	Latest working set-up:
//		-Vivado 2014.4
//		-KiwiC Version Alpha 0.3.1x
//

using System;
using KiwiSystem;


class Emu
{
	// These are the ports of the circuit (and will appear as ports in the generated Verilog)
	// Slave Stream Ports	
	[Kiwi.InputWordPort("s_axis_tdata")]	// rx_data
	static ulong s_axis_tdata; 		// Write data to be sent to device
	[Kiwi.InputBitPort("s_axis_tkeep")]	// rx_sof_n
	static byte s_axis_tkeep;       	// Start of frame indicator
	[Kiwi.InputBitPort("s_axis_tlast")]	// rx_eof_n
	static bool s_axis_tlast;      		// End of frame indicator
	[Kiwi.InputBitPort("s_axis_tvalid")]	// rx_src_rdy_n
	static bool s_axis_tvalid;		// Source ready indicator
	[Kiwi.OutputBitPort("s_axis_tready")]	// rx_dst_rdy_n
	static bool s_axis_tready = true;  	// Destination ready indicator
	[Kiwi.InputWordPort("s_axis_tuser_hi")]	// 
	static ulong s_axis_tuser_hi; 		//
	[Kiwi.InputWordPort("s_axis_tuser_low")]//
	static ulong s_axis_tuser_low; 		// 

	// Master Stream Ports
	[Kiwi.OutputWordPort("m_axis_tdata")]	// tx_data
	static ulong m_axis_tdata;		// Write data to be sent to device
	[Kiwi.OutputBitPort("m_axis_tkeep")]	// tx_sof_n
	static byte m_axis_tkeep;		// Start of frame indicator
	[Kiwi.OutputBitPort("m_axis_tlast")]	// tx_eof_n
	static bool m_axis_tlast;		// End of frame indicator
	[Kiwi.OutputBitPort("m_axis_tvalid")]	// tx_src_rdy_n
	static bool m_axis_tvalid = false;	// Source ready indicator
	[Kiwi.InputBitPort("m_axis_tready")]	// tx_dst_rdy_n
	static bool m_axis_tready;		// Destination ready indicator
	[Kiwi.OutputWordPort("m_axis_tuser_hi")]// 
	static ulong m_axis_tuser_hi;		//
	[Kiwi.OutputWordPort("m_axis_tuser_low")]// 
	static ulong m_axis_tuser_low;		//

	// Constants variables
	const uint LUT_SIZE = (uint)10;
	const uint BUF_SIZE = (uint)50;	
	const uint MEM_SIZE = (uint)50;

	static ulong dst_mac, src_mac, src_port, dst_port, src_ip, dst_ip; 
	static bool IPv4 = false, proto_UDP = false, proto_ICMP = false, proto_TCP = false, TCP_SYN_flag = false;
	static bool icmp_header = false;
	static ulong IP_total_length, UDP_total_length, app_src_port, app_dst_port, ICMP_code_type, TCP_seq_num, TCP_ack_num;
	static ulong segm_num=0;
	static ulong shared_tdata, shared_tuser;
	static uint num=0;
    
	// Local buffer for storing the incoming packet
	static byte[] tkeep = new byte[BUF_SIZE];
	static bool[] tlast = new bool[BUF_SIZE];
	static ulong[] tdata = new ulong[BUF_SIZE];
	//static ulong[] tuser_hi = new ulong[BUF_SIZE]; // unused
	static ulong[] tuser_low = new ulong[BUF_SIZE];

	static ulong chksum_UDP=0, chksumIP=0, tmp, tmp3, tmp2, tmp1;
	static uint cnt;
	static uint mem_controller_cnt=0;

	// This method describes the main logic functionality of TCP response
	static public void tcp_ping_logic()
	{
		ulong local_icmp_code_type, local_chksum_udp;
		uint i=0, free=0, mem_cnt=0;
		byte ii=0, local_magic_num=0, local_opcode=0 ;
            
		uint pkt_size=0;
		bool exist = false, is_ipv4=false, is_udp=false, is_icmp=false, is_tcp=false;
		uint cam_addr=0,  tmp_addr=0, addr=0, random_seq_num=100U;
		bool good_IP_checksum = false, error = false;
		ulong local_key_value, local_extras, local_flag, local_TCP_length;
		random_seq_num=100U;

		while (true) // Process packets indefinately
		{
			pkt_size = ReceiveFrame();

			for(i=0; i<=5; i++)
			{
				Extract_headers(i, tdata[i], tuser_low[i]);
				Kiwi.Pause();
			}

			is_ipv4 		= IPv4;
			is_udp 			= proto_UDP;
			is_icmp			= proto_ICMP; 
			is_tcp			= proto_TCP;
			local_icmp_code_type 	= ICMP_code_type;
			Kiwi.Pause();

			// ###########################################################################################
			// # 				TCP - PING
			if(is_ipv4 && is_tcp)
			{
				// Validate the IP checksum
				chksumIP		= calc_IP_checksum();
				Kiwi.Pause();
				good_IP_checksum	= ( chksumIP == (ulong)0x00 );
				// Set the IP total length to big endianess and subtract 20B (IP header) 
				tmp1 = ( IP_total_length>>8 | (IP_total_length&(ulong)0x00ff)<<8 ) - 20U;
				// Turn it back to little endian - TCP length
				local_TCP_length = tmp1>>8 | (tmp1&(ulong)0x00ff)<<8;
				// Include in the TCP checksum the IP pseudo header
				tmp = (ulong)(src_ip<<32 | dst_ip);
				tmp2= (ulong)0x000600 | local_TCP_length<<32;
				Kiwi.Pause();
				calc_checksum(tmp2); // (optimization) 6U = 0x06 = TCP proto_type , TCP length
				Kiwi.Pause();
				calc_checksum(tmp); // (optimization) src, dst IPs

				// Validate the TCP checksum
				for(i=4; i<=pkt_size; i++)
				{
					tmp2 = (i!=4) ? tdata[i] : tdata[i]>>16; 
					Kiwi.Pause();
					calc_checksum(tmp2);
				}
				Kiwi.Pause();

				// TCP - echo request
				if( TCP_SYN_flag && good_IP_checksum && chksum_UDP==(ulong)0x00ffff )
				{
					swap_multiple_fields(is_udp|is_tcp, is_icmp);
					chksum_UDP = (ulong)0x00;

					// Set the seq_num to big endian and add 1 
					tmp1 = ( TCP_seq_num>>24 | (TCP_seq_num&(ulong)0x00ff0000)>>8 | (TCP_seq_num&(ulong)0x0000ff00)<<8 | (TCP_seq_num&(ulong)0x00ff)<<24 ) + 1U;
					Kiwi.Pause();
					TCP_seq_num = ( tmp1>>24 | (tmp1&(ulong)0x00ff0000)>>8 | (tmp1&(ulong)0x0000ff00)<<8 | (tmp1&(ulong)0x00ff)<<24 ) ;
					tmp = (ulong)((random_seq_num & (uint)0x00ff00)>>8 | (random_seq_num & (uint)0x00ff)<<8);

					// **************************************************
					// Set i.the RST-ACK, ii.seq_num, iii.part of ack_num		**** RST-ACK ****
					//***************************************************
					tmp2 = (ulong)0x0014<<56 | TCP_seq_num<<16 | tmp;
					// **************************************************
					// Set i.the SYN-ACK, ii.seq_num, iii.part of ack_num		**** SYN-ACK ****
					// **************************************************
					//tmp2 = (ulong)0x0012<<56 | TCP_seq_num<<16 | tmp;

					tmp3 = tdata[5] & (ulong)0x00ff000000000000;
					Kiwi.Pause();
					// Set the ACK flag + seq num + ack num
					tmp3 |= tmp2;
					tdata[5] = tmp3;
					Kiwi.Pause();
					// Set part of the seq_num
					tmp = tdata[4] & (ulong)0x0000ffffffffffff;
					Kiwi.Pause();
					// Set the seq to the right position
					tmp |= (ulong)(( random_seq_num& (uint)0x00ff0000)<<32 | (random_seq_num & (uint)0x00ff000000)<<32); 
					tdata[4] = tmp;
					Kiwi.Pause();

					// Set the IP total length to big endianess and subtract 20B (IP header) 
					tmp1 = ( IP_total_length>>8 | (IP_total_length&(ulong)0x00ff)<<8 ) - 20U;
					// Turn it back to little endian - TCP length
					local_TCP_length = tmp1>>8 | (tmp1&(ulong)0x00ff)<<8;
					// Include in the TCP checksum, the IP pseudo header
					tmp = (ulong)(src_ip<<32 | dst_ip);
					tmp2= (ulong)0x000600 | local_TCP_length<<32;
					Kiwi.Pause();
					calc_checksum(tmp2); // (optimization) 6U = 0x06 = TCP proto_type , TCP length
					Kiwi.Pause();
					calc_checksum(tmp); // (optimization) src, dst IPs

					// Reset the TCP checksum
					tmp = tdata[6] & (ulong)0xffffffff0000ffff;
					Kiwi.Pause();
					tdata[6] = tmp;

					// The 4th element in the buffer is the start of the TCP frame
					for(i=4; i<=pkt_size; i++)
					{
						tmp2 = (i!=4) ? tdata[i] : tdata[i]>>16; 
						Kiwi.Pause();
						calc_checksum(tmp2);
					}

					// 1's complement of the result
					tmp1 = ( chksum_UDP ^ ~(ulong)0x00 ) & (ulong)0x00ffff;
					Kiwi.Pause();
					// make it back to little endian
					tmp2 = ((tmp1>>8) | (tmp1&(ulong)0x00ff)<<8) ;
					// Set the new TCP checksum
					tdata[6] = tmp | tmp2<<16;
					tmp3 = tuser_low[0];
					Kiwi.Pause();
					// Set the output port
					tuser_low[0] = (src_port<<24) | (src_port<<16) | tmp3;
		
					random_seq_num += 1U;
				}
			}
			Kiwi.Pause();
			// # 
			// ###########################################################################################

			// Procedure calchksum_ICMPl for transmiting packet
			SendFrame(pkt_size); 
			//End of frame, ready for next frame
			IPv4		= false;
			proto_UDP	= false;
			proto_ICMP	= false;
			proto_TCP	= false;
			TCP_SYN_flag	= false;
			chksum_UDP	= 0x00;
			pkt_size	=0x00;
		}
	}

	// This procedure calculates the checksum of a given byte stream
	// It returns the result in big endianess format
	// It doenst compute the 1's complement
	static public void calc_checksum(ulong data)
	{
		ulong tmp0=0x00, tmp1=0x00, tmp2=0x00, tmp3=0x00, sum0=0, sum1=0, sum=0, chk=0;
		byte i=0;
		chk = chksum_UDP;

		tmp0 = ((ulong)(data>>0) & (ulong)0x00ff)<<8 | ((ulong)(data>>0) & (ulong)0x00ff00)>>8;
		tmp1 = ((ulong)(data>>16) & (ulong)0x00ff)<<8 | ((ulong)(data>>16) & (ulong)0x00ff00)>>8;
		tmp2 = ((ulong)(data>>32) & (ulong)0x00ff)<<8 | ((ulong)(data>>32) & (ulong)0x00ff00)>>8;
		tmp3 = ((ulong)(data>>48) & (ulong)0x00ff)<<8 | ((ulong)(data>>48) & (ulong)0x00ff00)>>8;

		// check for carry and add it if its needed
		sum0 = (ulong)( (tmp0 + tmp1)& (ulong)0x00ffff ) + (ulong)( (tmp0 + tmp1)>>16); 
		sum1 = (ulong)( (tmp2 + tmp3)& (ulong)0x00ffff ) + (ulong)( (tmp2 + tmp3)>>16); 
		Kiwi.Pause();
		// check for carry and add it if its needed
		sum = (ulong)( (sum0 + sum1)& (ulong)0x00ffff ) + (ulong)((sum0 + sum1)>>16);
		Kiwi.Pause();
		// add the current sum to the previous sums
		chksum_UDP = (ulong)( (sum + chk)& (ulong)0x00ffff ) + (ulong)((sum + chk)>>16);
}	


	// This procedure perform the calculation of the new checksum and verification
	// It returns the new checksum(on calculation process) or 0x00 if no-errors were detected(on verification process)
	static ulong calc_IP_checksum()
	{
		byte i;
		ulong data=0x00, tmp0=0x00, tmp1=0x00, tmp2=0x00, tmp3=0x00;
		ulong sum0=0x00, sum1=0x00, sum=0x00, sum2=0x00, sum3=0x00, carry;
		ulong sum_all = 0x00;

		for(i=1; i<5; i++)
		{
			data = (i==1) ? tdata[1]>>48 : (i==4) ? tdata[4]<<48 : (i==2 || i==3) ? tdata[i] : (ulong)0x00;
			Kiwi.Pause();
			// extract every 16-bit from the stream for addition and reorder it to big endianess
			tmp0 = ((ulong)(data>>0) & (ulong)0x00ff)<<8 | ((ulong)(data>>0) & (ulong)0x00ff00)>>8;
			tmp1 = ((ulong)(data>>16) & (ulong)0x00ff)<<8 | ((ulong)(data>>16) & (ulong)0x00ff00)>>8;
			tmp2 = ((ulong)(data>>32) & (ulong)0x00ff)<<8 | ((ulong)(data>>32) & (ulong)0x00ff00)>>8;
			tmp3 = ((ulong)(data>>48) & (ulong)0x00ff)<<8 | ((ulong)(data>>48) & (ulong)0x00ff00)>>8;
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
		sum_all = ( sum_all ^ ~(ulong)0x00 ) & (ulong)0x00ffff;
		return( sum_all ); 
	}


	// This procedure perform swap of multiple fields
	// dst_mac<->src_mac, dst_ip<->src_ip, dst_port<->src_port
	static void swap_multiple_fields(bool tcp_udp, bool icmp)
	{
		ulong tmp;
		bool tcp_udp_tmp, icmp_tmp; 

		tcp_udp_tmp = tcp_udp;
		icmp_tmp= icmp;
		// Ethernet header swap
		tdata[0] = src_mac | (dst_mac<<48);
		Kiwi.Pause();
		tmp = (tdata[1] & (ulong)0xffffffff00000000) | dst_mac>>16;
		Kiwi.Pause();
		tdata[1] = tmp;
		Kiwi.Pause();
		
		// IP header swap + UDP header swap 
		tmp = (tdata[3] & (ulong)0x00ffff) | dst_ip<<16 | src_ip<<48;
		Kiwi.Pause();
		tdata[3] = tmp;
		Kiwi.Pause();
		if(tcp_udp_tmp)
			// Swap the ports, Memcached - TCP ping
			tmp = (tdata[4] & (ulong)0xffff000000000000) | src_ip>>16 | app_src_port<<32 | app_dst_port<<16;
		else if(icmp_tmp)
			// Set the ICMP echo reply type=0, code=0 and checksum=0x00
			tmp = (tdata[4] & (ulong)0xffff000000000000) | src_ip>>16;
		Kiwi.Pause();
		tdata[4] = tmp;
		Kiwi.Pause();
	}

	// The procedure is implemented as a separate thread and
	// will extract usefull data from the incoming stream
	// In order to utilize more the icoming process 
	static public void Extract_headers(uint count, ulong data, ulong user)
	{
		ulong tdata=data, tuser=user;

		switch(count)
		{
			// Start of the Ethernet header
			case 0U:
				dst_mac   =  tdata & (ulong)0x0000ffffffffffff;
				src_mac   =  tdata>>48 & (ulong)0x00ffff;
				// metadata ports - NOT UDP ports
				src_port  = ((tuser>>16) & (ulong)0xff);
				dst_port  = ((tuser>>24) & (ulong)0xff);
				break;
			case 1U:
				src_mac |= ( tdata & (ulong)0x00ffffffff)<<16 ;
				IPv4 = ( ( tdata>>32 & (ulong)0x00ffff) == (ulong)0x0008) && ( ( tdata>>52 & (ulong)0x0f) == (ulong)0x04);
				break;
			case 2U:
				proto_ICMP 	= (  tdata>>56 & (ulong)0x00ff) == (ulong)0x0001;
				proto_UDP	= (  tdata>>56 & (ulong)0x00ff) == (ulong)0x0011;
				proto_TCP	= (  tdata>>56 & (ulong)0x00ff) == (ulong)0x0006;
				IP_total_length = (  tdata & (ulong)0x00ffff );
				break;
				// Start of the IP header
			case 3U:
				src_ip = ( tdata>>16) & (ulong)0x00ffffffff;
				dst_ip = ( tdata>>48) & (ulong)0x00ffff;
				break;
				// Start of the UDP header
			case 4U:
				dst_ip 		|= (  tdata & (ulong)0x00ffff )<<16; 
				app_src_port 	= (  tdata>>16 & (ulong)0x00ffff);
				app_dst_port 	= (  tdata>>32 & (ulong)0x00ffff);
				UDP_total_length= (  tdata>>48 & (ulong)0x00ffff);
				ICMP_code_type 	= (  tdata>>16 & (ulong)0x00ffff);
				TCP_seq_num	= tdata>>48;
				break;
				// Start of the UDP frame & Memcached Header
			case 5U:
				TCP_SYN_flag	= (tdata>>56 & (ulong)0x00ff) == (ulong)0x0002;
				TCP_seq_num	|= (ulong)(tdata & (ulong)0x00ffff) << 16;
				TCP_ack_num	= tdata>>16 & (ulong)0x00ffffffff;
				break;
			default: break;
		} 
	}


	// This method describes the operations required to rx a frame over the AXI4-Stream.
	// and extract basic information such as dst_MAC, src_MAC, dst_port, src_port
	static public uint ReceiveFrame()
	{	
		m_axis_tdata 		= (ulong)0x0;
		m_axis_tkeep 		= (byte)0x0;
		m_axis_tlast  		= false;
		m_axis_tvalid		= false;
		m_axis_tuser_hi 	= (ulong)0x0;
		m_axis_tuser_low	= (ulong)0x0;
		s_axis_tready 		= true;

		segm_num	= 0U;
		icmp_header	= false;
		Kiwi.Pause();

		// The start condition 
		uint cnt	= 0;
		uint psize	= 0;
		bool start	= s_axis_tvalid && s_axis_tready; 
		bool doneReading= true;
		bool receive	= s_axis_tvalid;
		ulong data	= 0x00;
		byte data2	= 0x00;
		// #############################
		// # Receive the frame
		// #############################
		cnt = 0;
		doneReading = true;
		
		while (doneReading)
		{
			if (s_axis_tvalid)
			{
				tdata[cnt]	  = s_axis_tdata;
				tkeep[cnt]	  = s_axis_tkeep;
				tlast[cnt]	  = s_axis_tlast;
				//tuser_hi[cnt]     = s_axis_tuser_hi;
				tuser_low[cnt]    = s_axis_tuser_low;

				segm_num += 1U ;
				psize = cnt++;
				doneReading = !s_axis_tlast && s_axis_tvalid;

				// Create backpresure to whatever sends data to us
				s_axis_tready = s_axis_tlast ? false : true;
			}
			Kiwi.Pause();
		}
		icmp_header = false;

		data  = tdata[psize];
		data2 = tkeep[psize];
		
		Kiwi.Pause();

		switch (data2) {
		case 0x01:
			tdata[psize] = data & (ulong)0x00ff;
			break;
		case 0x03:
			tdata[psize] = data & (ulong)0x00ffff;
			break;
		case 0x07:
			tdata[psize] = data & (ulong)0x00ffffff;
			break;
		case 0x0f:
			tdata[psize] = data & (ulong)0x00ffffffff;
			break;
		case 0x1f:
			tdata[psize] = data & (ulong)0x00ffffffffff;
			break;
		case 0x3f:
			tdata[psize] = data & (ulong)0x00ffffffffffff;
			break;
		case 0x7f:
			tdata[psize] = data & (ulong)0x00ffffffffffffff; 
			break;
		default:
			break;
		}

		Kiwi.Pause();

		s_axis_tready	= false;
		cnt		= 0;
		segm_num	= 0;
		return psize;
	}


	// This method describes the operations required to tx a frame over the AXI4-Stream.
	static void SendFrame(uint size)
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

		uint i=0, packet_size; ulong o,oo;

		i=0; packet_size=size;

		while (i<=packet_size)
		{
			if ( m_axis_tready )
			{
				m_axis_tdata	= tdata[i];
				m_axis_tkeep	= tkeep[i];
				m_axis_tlast	= i == (size);
				m_axis_tuser_hi	= 0UL;
				m_axis_tuser_low= tuser_low[0];
				i++;
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



	/////////////////////////////
	// Main Hardware Enrty point
	/////////////////////////////

	[Kiwi.HardwareEntryPoint()] 
	static int EntryPoint()
	{
		while (true) tcp_ping_logic();
	}

	static int Main()
	{
		return 0;
	}
}


