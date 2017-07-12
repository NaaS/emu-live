/*
 DNS Server
 Implementation on the NetFPGA platform, making use of the kiwi compiler (C#) 
 The generated verilog file should replace the OPL of the reference_nic

 Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 2.03a: Feb-2016 Unix 3.16.0.30
   /root/kiwi/kiwipro/kiwic/distro/lib/kiwic.exe EthernetEcho.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-no-dram-ports=0 -restructure2=disable -vnl EthernetEcho.v

 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

using System;
using KiwiSystem;



class LocalLinkLoopBackTest
{   

    class EthernetEcho
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
        static ulong m_axis_tdata;     	// Write data to be sent to device
        [Kiwi.OutputBitPort("m_axis_tkeep")]	// tx_sof_n
        static byte m_axis_tkeep; 	// Start of frame indicator
        [Kiwi.OutputBitPort("m_axis_tlast")]	// tx_eof_n
        static bool m_axis_tlast;      	// End of frame indicator
        [Kiwi.OutputBitPort("m_axis_tvalid")]	// tx_src_rdy_n
        static bool m_axis_tvalid = false;  	// Source ready indicator
        [Kiwi.InputBitPort("m_axis_tready")]	// tx_dst_rdy_n
        static bool m_axis_tready ;    		// Destination ready indicator
        [Kiwi.OutputWordPort("m_axis_tuser_hi")]	// 
        static ulong m_axis_tuser_hi;	//	
        [Kiwi.OutputWordPort("m_axis_tuser_low")]// 
        static ulong m_axis_tuser_low;	// 


	// CAM Memory Ports
	// Input Ports
        [Kiwi.InputBitPort("cam_busy")]	
        static bool cam_busy;
        [Kiwi.InputBitPort("cam_match")]	
        static bool cam_match;
        [Kiwi.InputBitPort("cam_match_addr")]	
        static byte cam_match_addr;		// 8-bit address width
	// Output Ports
        [Kiwi.OutputWordPort("cam_cmp_din")]	
        static ulong cam_cmp_din=~(ulong)0x00;	// 64-bit width compare din
        [Kiwi.OutputWordPort("cam_din")]	
        static ulong cam_din=0x00;			// 64-bit width din
        [Kiwi.OutputBitPort("cam_we")]	
        static bool cam_we=false;
        [Kiwi.OutputBitPort("cam_wr_addr")]	
        static byte cam_wr_addr=0x00;		// 8-bit address width


	// Constants variables
	const uint LUT_SIZE = (uint)10;
	const uint BUF_SIZE = (uint)64;	
	const uint MEM_SIZE = (uint)7;


	// 	Memory with the IP names
	//	DNS_part_0		DNS_part_1		DNS_part_2
	//	0. ww06googl ,		e03com00 ,		-
	//	1. ww08faceb , 		ook03com00 ,		-
	//	2. ww02cl02ca , 	m02ac02uk00 ,		-
	//	3. ww13londo , 		nservice ,		03com00
	//	4. ww09cambr , 		idge02co02 ,		uk00
	//	5. ww02in02gr , 	- ,			-
	//	6. ww0cworld ,		wildlife , 		03org00
	static ulong[] DNS_part_0 = new ulong[MEM_SIZE]{0x6c676f6f67067777, 0x6265636166087777, 0x6163036c63027777, 0x6f646e6f6c0c7777, 0x72626d6163097777, 0x7267026e69027777, 0x646c726f770c7777};
	static ulong[] DNS_part_1 = new ulong[MEM_SIZE]{0x0100006d6f630365, 0x006d6f63036b6f6f, 0x006b75026361026d, 0x656369767265736e, 0x02636f0265676469, 0x00010100, 0x6566696c646c6977};
	static ulong[] DNS_part_2 = new ulong[MEM_SIZE]{0x000100	,	0x0001000100	,0x0001000100	,	0x000100006d6f6303,	0x0001000100006b75,	0x00,	0x0001000067726f03};

	// Memory with all the IP addresses 
	static uint[] IPs = new uint[MEM_SIZE]{0x0000a8c0, 0x0100a8c0, 0x0200a8c0, 0x0300a8c0, 0x0400a8c0, 0x0500a8c0, 0x0600a8c0};


	static ulong dst_mac, src_mac, src_port, dst_port, src_ip, dst_ip; 
	static bool IPv4 = false, proto_UDP = false, proto_ICMP = false;
	static uint key_length, pointer=0;
	static byte extras_length, last_tkeep=0;
	static bool icmp_header = false, exist_rest=false;
	static ulong IP_total_length, UDP_total_length, app_src_port, app_dst_port, ICMP_code_type;
	static ulong key, key_value, extras, flag, opaque;
	static ulong segm_num=0;
	static ulong shared_tdata, shared_tuser;
	
	static bool std_query, one_question, start_parsing, QR, opcode, QDCOUNT;

	static uint num=0;
    
	// Local buffer for storing the incoming packet
	static byte[] tkeep = new byte[BUF_SIZE];
	static bool[] tlast = new bool[BUF_SIZE];
	static ulong[] tdata = new ulong[BUF_SIZE];
	static ulong[] tuser_hi = new ulong[BUF_SIZE];
	static ulong[] tuser_low = new ulong[BUF_SIZE];

	static ulong chksum_UDP=0;

	static ulong chksumIP=0,tmp, tmp3, tmp2, tmp1, tmp4, tmp5;

	static uint cnt;
	static uint mem_controller_cnt=0;
        // This method describes the main logic functionality of the Server
        static public void switch_logic()
        {
	    ulong local_icmp_code_type, local_chksum_udp, d, u;//, ipv4;		
	    uint i=0, pointer=0;
	    byte ii=0, local_magic_num=0, local_opcode=0 ;
            
	    uint pkt_size=0, p_size=0;
	    bool is_ipv4=false, is_udp=false, is_icmp=false;
	    uint cam_addr=0,  tmp_addr=0, addr=0;
	    bool good_IP_checksum = false, error = false;
	    ulong local_key_value, local_extras, local_flag;
	
            while (true) // Process packets indefinately
            {
		pkt_size = ReceiveFrame();
	
		// Extract information from the Ethernet, IP, TCP, UDP frames	
		for(i=0; i<=pkt_size; i++)
		{
			d = tdata[i];
			u = tuser_low[i];
			Kiwi.Pause();
			Extract_headers(i, d, u);
		}
		
		
		Kiwi.Pause();
		// We need to store the shared-threat variables here 
		// otherwise if we use it explicity we get long compilation times
		is_ipv4 		= IPv4;
		is_udp 			= proto_UDP;
		is_icmp			= proto_ICMP; 
//		local_magic_num 	= magic_num;
//		local_opcode		= opcode;
//		local_icmp_code_type 	= ICMP_code_type;
		local_chksum_udp 	= chksum_UDP;
//		local_key_value		= key_value;
//		local_extras		= extras;
//		local_flag		= flag;


		Kiwi.Pause();
                // #############################
		// # Server Logic -- START
		// #############################

		// #######################################################################################
		// # 				DNS SERVER
		if (is_ipv4 && is_udp)
		{
			chksumIP = calc_IP_checksum();
			good_IP_checksum = ( chksumIP == (ulong)0x00 );
			//Kiwi.Pause();

			// We have already validate part of the UDP checksum while we were receiving the packet
			// now we need also to add the IP pseudo header + UDP length + prototype(UDP=0x0011)
//			tmp = (ulong)(src_ip<<32 | dst_ip);
//			tmp2= (ulong)0x001100 | UDP_total_length<<32;
//			Kiwi.Pause();
//			calc_UDP_checksum(tmp2); // (optimization) 11U = 0x11 = UDP proto_type , UDP length
//			Kiwi.Pause();
//			calc_UDP_checksum(tmp); // (optimization) src, dst IPs
//			local_chksum_udp = ((tdata[5]&(ulong)0x00ffff)==0x00) ? (ulong)0x00ffff : chksum_UDP; // Check if the UDP checksum is disabled
//			Kiwi.Pause();

			if ( good_IP_checksum && one_question && std_query)
			{


				chksum_UDP = (ulong)0x00;
				chksumIP = 0x00;
				exist_rest = false;
				swap_multiple_fields(is_udp, is_icmp);	
				Kiwi.Pause();

				
				// Fisrt pattern of the IP name
				tmp = tdata[7];
				Kiwi.Pause();

				pointer = MEM_SIZE;
				for(i=0; i<MEM_SIZE; i++)
				{
					// lookup the first pattern of the IP name
					tmp1 = DNS_part_0[i];
					tmp2 = DNS_part_1[i];
					tmp3 = DNS_part_2[i];
					// Second part of the IP name
					tmp4 = tdata[8];
					Kiwi.Pause();
					if(tmp == tmp1)
					{		
						if(pkt_size==9U)
						{
							// Third  pattern of the IP name
							tmp5 = tdata[9];
							Kiwi.Pause();
							exist_rest = ((tmp4 == tmp2) && (tmp5 == tmp3));
						}
						else
						{
							exist_rest = (tmp4 == tmp2);
						}
						pointer = i ;
						break;
				 	}

				}

				// Extract the size of the packet from the tuser_low
				p_size = (uint)(tuser_low[0] & (ulong)0x00ffff);

				// Preserve the transaction ID and the number of questions and flags, reset the UDP checksum 
				tmp = tdata[5] & ~(ulong)0x00ffff;
				Kiwi.Pause();	
				// Set the response bit in the flag field
				tdata[5] = tmp | (ulong)0x008000000000;
				Kiwi.Pause();


				// Set the response packet with the IP address
				if( start_parsing && exist_rest )
				{
					// Set the number of response answers field
					tmp = tdata[6] & ~(ulong)0x00ffff;
					Kiwi.Pause();	
					tdata[6] = tmp | (ulong)0x000100;// set the number of answers to 1

					// Build the answer that we need to append to the end of the packet
					// Currrenlty the answer is: 
					//	1. pointer(2B) + type(2B) + class(2B) + part of TTL(2B)
					//	2. part of TTL(2B) + length(2B) + IP(4B) 					
					tmp1 = (ulong)0x0000010001000cc0;
					tmp2 = (ulong)IPs[pointer]<<32 | (ulong)0x000400100e;
					Kiwi.Pause();

					if(last_tkeep==0x00)
					{
						tdata[pkt_size+1U] = tmp1; Kiwi.Pause();
						tdata[pkt_size+2U]= tmp2; tkeep[pkt_size+1U] = (byte)0xff; Kiwi.Pause();
						
						tkeep[pkt_size+2U] = (byte)0xff;

					}
					else
					{
						tmp3 = tdata[pkt_size] | tmp1<<(last_tkeep*0x08); tkeep[pkt_size] = 0xff; 
						Kiwi.Pause();
						tdata[pkt_size] = tmp3; 
						Kiwi.Pause();

						tdata[pkt_size+1U] = tmp1>>(((byte)0x08-last_tkeep)*0x08) | tmp2<<((last_tkeep)*0x08); 
						tkeep[pkt_size+1U] = 0xff; 
						Kiwi.Pause();
	
						tdata[pkt_size+2U] = tmp2>>(((byte)0x08-last_tkeep)*0x08); 
						tkeep[pkt_size+2U] = (byte)(0xff>>((byte)0x08-last_tkeep)); 
						Kiwi.Pause();

					}

					// Calculate the new IP length
					tmp = IP_total_length>>8 | (IP_total_length & (ulong)0x00ff)<<8;
					tmp2 = tdata[2] & ~(ulong)0x00ffff; // Reset the IP length
					Kiwi.Pause();
					IP_total_length = tmp + 16U;
					tdata[2] = tmp2 | (IP_total_length>>8 | (IP_total_length & (ulong)0x00ff)<<8);				

					// Calculate the new UDP length
					tmp = UDP_total_length>>8 | (UDP_total_length & (ulong)0x00ff)<<8;
					tmp2 = tdata[4] & (ulong)0x0000ffffffffffff; // Reset the UDP length
					Kiwi.Pause();
					UDP_total_length = tmp + 16U;
					tdata[4] = tmp2 | (UDP_total_length>>8 | (UDP_total_length & (ulong)0x00ff)<<8)<<48;


					// Set the output port with the new packet size
					tuser_low[0] = (src_port<<24) | (src_port<<16) | p_size+16U;

					pkt_size += 2U;
				}
				// Set the response packet with an error message
				else				
				{	// Set the error code = 0x03 "no such name" , and the response flag 
					tdata[5] = tmp | (ulong)0x00038000000000;
					tmp5 = tuser_low[0];
					Kiwi.Pause();
					// Set the output port
					tuser_low[0] = (src_port<<24) | tmp5;					
				}


			
				// Calculate the new IP checksum	
				tmp = tdata[3] & ~(ulong)0x00ffff;
				Kiwi.Pause();
				tdata[3] = tmp;
				Kiwi.Pause();
				chksumIP = calc_IP_checksum();
				Kiwi.Pause();
				tdata[3] = (chksumIP>>8 | (chksumIP&(ulong)0x00ff)<<8) | tmp; 
				Kiwi.Pause();

				// Here is the UDP checksum - clear it and preserve the other data
				tmp = tdata[5]; //we have already clear the UDP checksum
				Kiwi.Pause();
				// The 4th element in the buffer is the start of the UDP frame
				for(i=4; i<=pkt_size; i++)
				{
					tmp2 = (i!=4) ? tdata[i] : tdata[i]>>16; 
					Kiwi.Pause();
					calc_UDP_checksum(tmp2);
				}
				tmp3 = (tdata[4] & (ulong)0xffff000000000000) | (ulong)0x001100; // Here is the new UDP length + proto type
				tmp2 = src_ip<<32 | dst_ip; // (optimization) src, dst IPs
				Kiwi.Pause();
				calc_UDP_checksum(tmp3); // (optimization) 11U = 0x11 = UDP proto_type , UDP length
				Kiwi.Pause();
				calc_UDP_checksum(tmp2); 
				Kiwi.Pause();
				// 1's complement of the result
				tmp2 = (ulong)(( chksum_UDP ^ ~(ulong)0x00 ) & (ulong)0x00ffff);
				Kiwi.Pause();
				// make it back to little endian
				tmp3 = (ulong)((tmp2>>8) | (ulong)(tmp2&(ulong)0x00ff)<<8) ;
				// Set the new UDP checksum
				tdata[5] = tmp | tmp3;
			}
		}
		// # 
		// ###########################################################################################


		Kiwi.Pause();
		// # 
		// ###########################################################################################


                // #############################
		// # Server Logic -- END 
		// #############################

		// Procedure calchksum_ICMPl for transmiting packet
		SendFrame(pkt_size); 
		
                //End of frame, ready for next frame
		one_question=false;
		std_query=false;
		start_parsing=false;
		IPv4 = false;
		proto_UDP = false;
		proto_ICMP = false;
		chksum_UDP = 0x00;
		pkt_size=0x00;
		exist_rest = false;
            }
        }



	// This procedure calculates the checksum of a given byte stream
	// It returns the result in big endianess format
	// It doenst compute the 1's complement
	static public void calc_UDP_checksum(ulong data)
	{
		ulong tmp0=0x00, tmp1=0x00, tmp2=0x00, tmp3=0x00, sum0=0, sum1=0, sum=0, chk=0;
		byte i=0;
		chk = chksum_UDP;
			// The ICMP header & payload start from this packet number
			if( true )//cnt > (uint)3 )
			{
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
				// add the current sum to the previous sums
				chksum_UDP = (ulong)( (sum + chk)& (ulong)0x00ffff ) + (ulong)((sum + chk)>>16);
			}

	}


	// This procedure perform the calculation of the new checksum and verification
	// It returns the new checksum(on calculation process) or 0x00 if no-errors were detected(on verification process)
	static ulong calc_IP_checksum()
	{	byte i;
		ulong data=0x00, tmp0=0x00, tmp1=0x00, tmp2=0x00, tmp3=0x00;
		ulong sum0=0x00, sum1=0x00, sum=0x00, sum2=0x00, sum3=0x00, carry;	
		ulong sum_all = 0x00;


		for(i=1; i<=4; i++)
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
			// add the current sum to the previous sums
			sum_all = (ulong)( (sum + sum_all)& (ulong)0x00ffff ) + (ulong)((sum + sum_all)>>16);
		}

//		//(ulong)(~sum0 & (ulong)0x00ffff); DOESNT WORK	

		sum_all = ( sum_all ^ ~(ulong)0x00 ) & (ulong)0x00ffff;
		
		return( sum_all ); 
	}



	// This procedure perform swap of multiple fields
	// dst_mac<->src_mac, dst_ip<->src_ip, dst_port<->src_port
	static void swap_multiple_fields(bool udp, bool icmp)
	{
		ulong tmp;
		bool udp_tmp, icmp_tmp;

		udp_tmp = udp;
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
		//tmp = dst_ip<<16 | src_ip<<48;
		Kiwi.Pause();	
		tdata[3] = tmp;
		Kiwi.Pause();
		if(udp_tmp)
			// Swap the ports
			tmp = (tdata[4] & (ulong)0xffff000000000000) | src_ip>>16 | app_src_port<<32 | app_dst_port<<16;
		if(icmp_tmp)	
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
		cnt=1U;
		ulong tdata, tuser;
	
			cnt = count;
			tdata = data;
			tuser = user;

			switch(cnt)
			{
				//case 0U: break;
				// Start of the Ethernet header
				case 0U:	
					dst_mac   =  tdata & (ulong)0x0000ffffffffffff;
					src_mac   =  tdata>>48 & (ulong)0x00ffff;
					// metadata ports - NOT UDP ports
					src_port  = ((tuser>>16) & 0xff);
					dst_port  = ((tuser>>24) & 0xff);
					break;
				case 1U:
					src_mac |= ( tdata & (ulong)0x00ffffffff)<<16 ;
					IPv4 = ( ( tdata>>32 & (ulong)0x00ffff) == (ulong)0x0008) && ( ( tdata>>52 & (ulong)0x0f) == (ulong)0x04);
					break;				
				case 2U:
					proto_ICMP = (  tdata>>56 & (ulong)0x00ff) == (ulong)0x0001;
					proto_UDP = (  tdata>>56 & (ulong)0x00ff) == (ulong)0x0011;
					IP_total_length = (  tdata & (ulong)0x00ffff );
					break;				
//				// Start of the IP header
				case 3U:
					src_ip = ( tdata>>16) & (ulong)0x00ffffffff;
					dst_ip = ( tdata>>48) & (ulong)0x00ffff;
					break;
//				// Start of the UDP header
				case 4U:				
					dst_ip |= (  tdata & (ulong)0x00ffff )<<16; 
					app_src_port = (  tdata>>16 & (ulong)0x00ffff);
					app_dst_port = (  tdata>>32 & (ulong)0x00ffff);
					UDP_total_length = (  tdata>>48 & (ulong)0x00ffff);
					ICMP_code_type = (  tdata>>16 & (ulong)0x00ffff);
					break;
//				// Start of the UDP frame & Memcached Header
				case 5U:
					// We have just one question
					one_question	=  tdata>>56 == (ulong)0x0001;
					// We have standar query -- QR=b'0(request) opcode=b'000(standard query)
					std_query	= ((tdata>>36) & (ulong)0x00f) == (ulong)0x00 ; 
					break;
				case 6U:// here we have the first part of the name address which is supposed to be "03w"
					start_parsing	= (tdata>>48) == (ulong)0x007703;
					break;
				default: 
					break;
			   } 
//		}
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

		segm_num = 0U;
		icmp_header = false;
		//num = (uint)0x01;
		Kiwi.Pause();

		// The start condition 
		uint cnt = 0;
		uint psize = 0;
		bool start = s_axis_tvalid && s_axis_tready; 
		bool doneReading = true;
		bool receive = s_axis_tvalid;
		ulong data = 0x00;
		byte data2 = 0x00;
		// #############################
		// # Receive the frame
		// #############################
		cnt = 0;
		
		doneReading = true;
		
		while (doneReading)
		{
			if (s_axis_tvalid)
			{
				//Extract_data(segm_num++) <-- BUG
				//Extract_data(cnt+1);
				//Extract_data();					
//				shared_tdata	= s_axis_tdata;
//				shared_tuser	= s_axis_tuser_low;	
//				
//				if(cnt==4U) calc_UDP_checksum(s_axis_tdata >> 16);			
//				if(cnt>4U) calc_UDP_checksum(s_axis_tdata);

				tdata[cnt]	  = s_axis_tdata;
				tkeep[cnt]	  = s_axis_tkeep;
				tlast[cnt]	  = s_axis_tlast;
				tuser_hi[cnt]     = s_axis_tuser_hi;
				tuser_low[cnt]    = s_axis_tuser_low;

				segm_num += 1U ;
				psize = cnt++;
				doneReading = !s_axis_tlast && s_axis_tvalid;

				// Create backpresure to whatever sends data to us
				s_axis_tready = s_axis_tlast ? false : true;		
			}
			//else icmp_header=false;
			Kiwi.Pause();			
		}
		icmp_header = false;

		data  = tdata[psize];
		data2 = tkeep[psize];
		
		Kiwi.Pause();
/*		
		if(data2==0x01){	tdata[psize] = data & (ulong)0x00ff; Kiwi.Pause();}
		else if(data2==0x03){	tdata[psize] = data & (ulong)0x00ffff; Kiwi.Pause();}
		else if(data2==0x07){	tdata[psize] = data & (ulong)0x00ffffff; Kiwi.Pause();}
		else if(data2==0x0f){	tdata[psize] = data & (ulong)0x00ffffffff; Kiwi.Pause();}
		else if(data2==0x1f){	tdata[psize] = data & (ulong)0x00ffffffffff; Kiwi.Pause();}
		else if(data2==0x3f){	tdata[psize] = data & (ulong)0x00ffffffffffff; Kiwi.Pause();}
		else if(data2==0x7f){	tdata[psize] = data & (ulong)0x00ffffffffffffff; Kiwi.Pause();}
		else{;}
*/
		switch (data2) {
		case 0x01:
			tdata[psize] = data & (ulong)0x00ff; last_tkeep = 0x01;
			break;
		case 0x03:
			tdata[psize] = data & (ulong)0x00ffff; last_tkeep = 0x02;
			break;
		case 0x07:
			tdata[psize] = data & (ulong)0x00ffffff; last_tkeep = 0x03;
			break;
		case 0x0f:
			tdata[psize] = data & (ulong)0x00ffffffff; last_tkeep = 0x04;
			break;
		case 0x1f:
			tdata[psize] = data & (ulong)0x00ffffffffff; last_tkeep = 0x05;
			break;
		case 0x3f:
			tdata[psize] = data & (ulong)0x00ffffffffffff; last_tkeep = 0x06;
			break;
		case 0x7f:
			tdata[psize] = data & (ulong)0x00ffffffffffffff; last_tkeep = 0x07;
			break;
		default:
			last_tkeep = 0x00;
			break;
		}

		Kiwi.Pause();
		
		s_axis_tready = false;
		cnt = 0;
		segm_num = 0;
		//last = false;
		//start = false;
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
		     		m_axis_tdata 	= tdata[i];
				m_axis_tkeep 	= tkeep[i];
				// -- BUG DONT USE --
		   		//m_axis_tlast  	= (i==pkt_size) ? true : false;
				//if (i==pkt_size) m_axis_tlast = true; 
				m_axis_tlast = i == (size);
				m_axis_tuser_hi = tuser_hi[0];//i == 0U ? tuser_hi[0] : 0UL;
				m_axis_tuser_low= tuser_low[0];//tuser_low[0];//i == 0U ? tuser_low[0] : 0UL;
				i++;
			}		
			Kiwi.Pause();				
               }
		//segm_num = 0;
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
		while (true) switch_logic();
	}
	

    }


    static int Main()
    {
        return 0;
    }

}



