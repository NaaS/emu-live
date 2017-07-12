//	DNS Server + Debug Logic
//	Implementation on the NetFPGA platform, making use of the kiwi compiler (C#) 
//	The generated verilog file should replace the OPL of the reference datapath
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
	static ulong s_axis_tdata;		// Write data to be sent to device
	[Kiwi.InputBitPort("s_axis_tkeep")]	// rx_sof_n
	static byte s_axis_tkeep;		// Start of frame indicator
	[Kiwi.InputBitPort("s_axis_tlast")]	// rx_eof_n
	static bool s_axis_tlast;		// End of frame indicator
	[Kiwi.InputBitPort("s_axis_tvalid")]	// rx_src_rdy_n
	static bool s_axis_tvalid;		// Source ready indicator
	[Kiwi.OutputBitPort("s_axis_tready")]	// rx_dst_rdy_n
	static bool s_axis_tready = true;	// Destination ready indicator
	[Kiwi.InputWordPort("s_axis_tuser_hi")]	// 
	static ulong s_axis_tuser_hi;		//
	[Kiwi.InputWordPort("s_axis_tuser_low")]// 
	static ulong s_axis_tuser_low;		// 

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

	[Kiwi.OutputWordPort("debug_reg")]
	static uint debug_reg=0x00;		// 8-bit address width

	// Global variables for the DEBUGER
	public enum debug_op_code : byte { 
				NOP		=0x00,
				READ		=0xAA,
				WRITE		=0xBB,
				COPY		=0xCC, 
				INC		=0xDD,
				DEC		=0xEE,
				MOVE 		=0xFF,
				EQ 		=0xAB, 
				LESS		=0xBC,
				WRITE_ARR	=0x10,
				READ_ARR	=0x20,
				MOVE_ARR_TO_ARR	=0x30, 
				MOVE_ARR_TO_VAR	=0x40,
				MOVE_VAR_TO_ARR	=0x50,
				EXEC		=0x66 };

	public enum debug_operands : byte { 
				non		=0x00,
				DNS_pkt_cnt	=0x01,
				pkt_in_cnt	=0x02,
				GPR_0		=0x03,
				GPR_1		=0x04,
				GPR_2		=0x05,
				GPR_3		=0x06,
				PC		=0x07 };

	static int DEBUG_OPERANDS_NUM		= 0x08;
	static bool DEBUG_MODE			= false;
	static debug_op_code DEBUG_OP_CODE	= debug_op_code.NOP;
	static byte DEBUG_OPERAND_0		= 0x00;
	static byte DEBUG_OPERAND_1		= 0x00;
	static byte DEBUG_OPERAND_2		= 0x00;
	static byte DEBUG_OPERAND_3		= 0x00;
	static ulong DEBUG_OPERAND_VALUE	= 0UL;
	static ulong DEBUG_LEN			= 0UL;

	// Debug Counters
	static ulong DEBUG_DNS_pkt_counter	= 0UL; // Number 1
	static ulong DEBUG_pkt_in_counter	= 0UL; // Number 2
	// Debug GPRs
	static ulong DEBUG_GPR_0		= 0UL; // Number 3
	static ulong DEBUG_GPR_1		= 0UL; // Number 4
	static ulong DEBUG_GPR_2		= 0UL; // Number 5
	static ulong DEBUG_GPR_3		= 0UL; // Number 6
	// Debug PC
	static ulong PC				= 0UL; // Number 7
	// Byte code array for the DEBUG unit
	const uint Bc_ARRAY_DEPTH		= 16U;
	const uint Bc_ARRAY_WIDTH		= 32U;
	const uint VAL_ARRAY_SIZE		= 128U;
	static byte[,] DEBUG_byte_code_array	= new byte[Bc_ARRAY_DEPTH,Bc_ARRAY_WIDTH];
	static ulong[,] DEBUG_values_array	= new ulong[1,VAL_ARRAY_SIZE];

	// 	Memory with the IP names
	//	DNS_part_0		DNS_part_1		DNS_part_2		IP
	//
	//	0. ww06googl ,		e03com00 ,		-			192.168.0.0
	//	1. ww08faceb , 		ook03com00 ,		-			192.168.0.1
	//	2. ww02cl02ca , 	m02ac02uk00 ,		-			192.168.0.2
	//	3. ww13londo , 		nservice ,		03com00			192.168.0.3
	//	4. ww09cambr , 		idge02co02 ,		uk00			192.168.0.4
	//	5. ww02in02gr , 	- ,			-			192.168.0.5
	//	6. ww0cworld ,		wildlife , 		03org00			192.168.0.6

	// Constants variables
	const uint LUT_SIZE	= (uint)10;
	const uint BUF_SIZE	= (uint)80;
	const uint MEM_SIZE	= (uint)7;

	static ulong[] DNS_part_0 = new ulong[MEM_SIZE]{0x6c676f6f67067777, 0x6265636166087777, 0x6163036c63027777, 0x6f646e6f6c0d7777, 0x72626d6163097777, 0x7267026e69027777, 0x646c726f770d7777};
	static ulong[] DNS_part_1 = new ulong[MEM_SIZE]{0x0100006d6f630365, 0x006d6f63036b6f6f, 0x006b75026361026d, 0x656369767265736e, 0x026f630265676469, 0x000100010000, 0x6566696c646c6977};
	static ulong[] DNS_part_2 = new ulong[MEM_SIZE]{0x000100	,	0x0001000100	,0x0001000100	,	0x000100006d6f6303,	0x0001000100006b75,	0x00,	0x0001000067726f03};

	// Memory with all the IP addresses 
	static uint[] IPs = new uint[MEM_SIZE]{0x0000a8c0, 0x0100a8c0, 0x0200a8c0, 0x0300a8c0, 0x0400a8c0, 0x0500a8c0, 0x0600a8c0};

	static ulong dst_mac, src_mac, src_port, dst_port, src_ip, dst_ip; 
	static bool IPv4 = false, proto_UDP = false, proto_ICMP = false;
	static uint key_length, pointer=0;
	static byte extras_length, last_tkeep=0;
	static bool exist_rest=false;
	static ulong IP_total_length, UDP_total_length, app_src_port, app_dst_port, ICMP_code_type;
	static ulong key, key_value, extras, flag, opaque;
	static ulong segm_num=0;
	static ulong shared_tdata, shared_tuser;
	
	static bool std_query, one_question, start_parsing, QR, opcode, QDCOUNT;

	static uint num=0;
    
	// Local buffer for storing the incoming packet
	static byte[] tkeep	= new byte[BUF_SIZE];
	static bool[] tlast	= new bool[BUF_SIZE];
	static ulong[] tdata	= new ulong[BUF_SIZE];
	//static ulong[] tuser_hi	= new ulong[BUF_SIZE]; // unused
	static ulong[] tuser_low= new ulong[BUF_SIZE];

	static ulong chksum_UDP=0;
	static ulong chksumIP=0,tmp, tmp3, tmp2, tmp1, tmp4, tmp5;
	static uint cnt;
	static uint mem_controller_cnt=0;

	// This method describes the main logic functionality of the Server
	static public void DNS_logic()
	{
		ulong local_icmp_code_type, local_chksum_udp, d, u, error_msg;
		uint i=0, pointer=0;
		byte ii=0, local_magic_num=0, local_opcode=0 ;

		uint pkt_size=0, p_size=0;
		bool is_ipv4=false, is_udp=false, is_icmp=false;
		uint cam_addr=0,  tmp_addr=0, addr=0;
		bool good_IP_checksum = false;
		ulong local_key_value, local_extras, local_flag;

	// ************************************************
	// Hard coded byte-code
	// Byte code for increament the dbg_DNS_counter
	// ************************************************
//	DEBUG_byte_code_array [1,0] = (byte)0xDD; // INC
//	DEBUG_byte_code_array [1,1] = (byte)0x01; // DEBUG_DNS_pkt_counter
//	DEBUG_byte_code_array [1,2] = (byte)0x01; // +1
//	DEBUG_byte_code_array [1,3] = (byte)0x00; // NOP
//	// MOVE_VAR_TO_ARR and increament index
//	DEBUG_byte_code_array [2,0] = (byte)0x50; // MOVE_VAR_TO_ARR 
//	DEBUG_byte_code_array [2,1] = (byte)0x06; // DEBUG_GPR_3
//	DEBUG_byte_code_array [2,2] = (byte)0x03; // DEBUG_GPR_0 -- X
//	DEBUG_byte_code_array [2,3] = (byte)0x04; // DEBUG_GPR_1 -- Y
//	DEBUG_byte_code_array [2,4] = (byte)0xDD; // INC
//	DEBUG_byte_code_array [2,5] = (byte)0x04; // DEBUG_GPR_1
//	DEBUG_byte_code_array [2,6] = (byte)0x01; // +1
//	DEBUG_byte_code_array [2,7] = (byte)0x00; // NOP

//	DEBUG_byte_code_array [3,0] = (byte)0x00; // NOP

		while (true) // Process packets indefinately
		{
			pkt_size = ReceiveFrame();
			error_msg = 0UL;
			// Extract information from the Ethernet, IP, TCP, UDP frames
			for(i=0; i<=pkt_size; i++)
			{
				Extract_headers(i, tdata[i], tuser_low[0]);
				Kiwi.Pause();
			}
			Kiwi.Pause();

		// ####################################################################
		// TEST CASE -- instead of the harcoded register we have the bytecode
		// ####################################################################
		// trace the tdata[0]
//		DEBUG_GPR_3 = tdata[0];
//		Kiwi.Pause();
//		debug_execute_Bc(2U);
//		Kiwi.Pause();
		// ####################################################################
		// ####################################################################

			if( DEBUG_MODE )
			{
				//i = (DEBUG_OP_CODE==debug_op_code.EXEC) ? (uint)DEBUG_OPERAND_0 : 0U ;
				error_msg	= debug_execute_Bc();
				tuser_low[0]	|= (src_port<<24);
				tdata[1]	|= error_msg;
				Kiwi.Pause();
				tdata[3]	= DEBUG_OPERAND_VALUE;
				Kiwi.Pause();
			}
			else
			{
				is_ipv4 		= IPv4;
				is_udp 			= proto_UDP;
				is_icmp			= proto_ICMP; 
				local_chksum_udp 	= chksum_UDP;

				DEBUG_pkt_in_counter++;

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

					if ( good_IP_checksum && one_question && std_query)
					{
						// ####################################################################
						// TEST CASE -- instead of the harcoded register we have the bytecode
						// ####################################################################
						DEBUG_DNS_pkt_counter++;
						// debug_execute_Bc(1);
						// ####################################################################
						chksum_UDP	= (ulong)0x00;
						chksumIP	= 0x00;
						exist_rest	= false;
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
								if((uint)pkt_size>=(uint)9)
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
			}
			Kiwi.Pause();
		// # 
		// ###########################################################################################

			// Procedure calchksum_ICMPl for transmiting packet
			SendFrame(pkt_size); 
		        //End of frame, ready for next frame
			one_question	=false;
			std_query	=false;
			start_parsing	=false;
			IPv4		= false;
			proto_UDP	= false;
			proto_ICMP	= false;
			chksum_UDP	= 0x00;
			pkt_size	=0x00;
			exist_rest	= false;
			DEBUG_MODE	= false;
		}
	}

	// TODO execute multiple index in the byte code array, currenlty only one
	// TODO Assume that the running code exist in one line of the byte code array
	// 	split the running code to multiple lines
	static public ulong debug_execute_Bc()
	{	// byte DEBUG_byte_code_array[Bc_ARRAY_DEPTH, Bc_ARRAY_WIDTH]
		byte op_code=0, op_0=0, op_1=0, op_2=0, op_3=0, op_val=0;
		ulong error_code = 0UL, tmp;
		PC	= 0UL;

		if ( DEBUG_OP_CODE != debug_op_code.EXEC )
			error_code = debug_logic(DEBUG_OP_CODE, DEBUG_OPERAND_0, DEBUG_OPERAND_1, DEBUG_OPERAND_2, DEBUG_OPERAND_3, EndianessConv(DEBUG_OPERAND_VALUE));
		else
		{ 
			do
			{
				op_code	= DEBUG_byte_code_array[(uint)DEBUG_OPERAND_0, (uint)PC];
				//if ( (debug_op_code)op_code == debug_op_code.NOP ) break;
				Kiwi.Pause();
				op_0	= DEBUG_byte_code_array[(uint)DEBUG_OPERAND_0, (uint)PC+1U];
				Kiwi.Pause();
				op_1	= DEBUG_byte_code_array[(uint)DEBUG_OPERAND_0, (uint)PC+2U];
				Kiwi.Pause();
				op_2	= DEBUG_byte_code_array[(uint)DEBUG_OPERAND_0, (uint)PC+3U];
				Kiwi.Pause();
				op_3	= DEBUG_byte_code_array[(uint)DEBUG_OPERAND_0, (uint)PC+4U];
				Kiwi.Pause();

				switch( (debug_op_code)op_code )
				{
					case debug_op_code.WRITE:	tmp	= (ulong)0x00FF & (byte)op_1 ; break;
					case debug_op_code.INC:		tmp	= (ulong)0x00FF & (byte)op_1 ; break;
					case debug_op_code.DEC:		tmp	= (ulong)0x00FF & (byte)op_1 ; break;
					case debug_op_code.WRITE_ARR:	tmp	= (ulong)0x00FF & (byte)op_2 ; break;
					default:			tmp	= 0UL; break;
				}

				error_code = debug_logic((debug_op_code)op_code, op_0, op_1, op_2, op_3, tmp);
				Kiwi.Pause();

				// TODO find another way to increment the PC based on the op_code
				if ( (debug_op_code)op_code == debug_op_code.EXEC )
				{
					PC		= 0UL;
					DEBUG_OPERAND_0	= op_0;	// The new entrie in the byte code array
				}
				else
					PC = ( (debug_op_code)op_code==debug_op_code.MOVE_ARR_TO_ARR ) ? PC + 5UL : ((debug_op_code)op_code==debug_op_code.MOVE_ARR_TO_VAR || (debug_op_code)op_code==debug_op_code.MOVE_ARR_TO_VAR || (debug_op_code)op_code==debug_op_code.MOVE_VAR_TO_ARR ) ? PC + 4UL : PC + 3UL;

			}while ( PC < (uint)Bc_ARRAY_WIDTH && (debug_op_code)op_code != debug_op_code.NOP );
		}
		return error_code;
	}


	static public ulong debug_logic(debug_op_code opcode, byte op0, byte op1, byte op2, byte op3, ulong opval)
	{
		ulong tmp, tmp1, tmp2, tmp3;
		uint i,j;
		bool ERROR	= false, ERROR_0 = false, ERROR_1 = false, ERROR_2 = false;
		ulong ERROR_CODE= 0UL;
		debug_op_code dbg_op_code = opcode;
		byte dbg_opd_0 = op0, dbg_opd_1 = op1, dbg_opd_2 = op2, dbg_opd_3 = op3;
		ulong dbg_opd_value	= opval;
		ulong VALUE	= dbg_opd_value;
		ulong RET_VALUE	= EndianessConv(dbg_opd_value);
		ulong TMP_VAL_0	= 0UL;
		ulong TMP_VAL_1	= 0UL;
		ulong TMP_VAL_2	= 0UL;

		// Only for READ, MOVE, EQ, LESS, MOVE_VAR_TO_ARR opcodes
		switch( (debug_operands)dbg_opd_0 )
		{
			case debug_operands.DNS_pkt_cnt:
				TMP_VAL_0 = DEBUG_DNS_pkt_counter;
				break;
			case debug_operands.pkt_in_cnt:
				TMP_VAL_0 = DEBUG_pkt_in_counter;
				break;
			case debug_operands.GPR_0:
				TMP_VAL_0 = DEBUG_GPR_0;
				break;
			case debug_operands.GPR_1:
				TMP_VAL_0 = DEBUG_GPR_1;
				break;
			case debug_operands.GPR_2:
				TMP_VAL_0 = DEBUG_GPR_2;
				break;
			case debug_operands.GPR_3:
				TMP_VAL_0 = DEBUG_GPR_3;
				break;
			default:// TODO find a better way to report the error
				ERROR_0		= true;
				break;
		}
		Kiwi.Pause();
		// Only for READ, MOVE, EQ, LESS, MOVE_VAR_TO_ARR opcodes
		switch( (debug_operands)dbg_opd_1 )
		{
			case debug_operands.DNS_pkt_cnt:
				TMP_VAL_1 = DEBUG_DNS_pkt_counter;
				break;
			case debug_operands.pkt_in_cnt:
				TMP_VAL_1 = DEBUG_pkt_in_counter;
				break;
			case debug_operands.GPR_0:
				TMP_VAL_1 = DEBUG_GPR_0;
				break;
			case debug_operands.GPR_1:
				TMP_VAL_1 = DEBUG_GPR_1;
				break;
			case debug_operands.GPR_2:
				TMP_VAL_1 = DEBUG_GPR_2;
				break;
			case debug_operands.GPR_3:
				TMP_VAL_1 = DEBUG_GPR_3;
				break;
			default:// TODO find a better way to report the error
				ERROR_1		= true;
				break;
		}
		Kiwi.Pause();
		// Only for READ, MOVE, EQ, LESS, MOVE_VAR_TO_ARR opcodes
		switch( (debug_operands)dbg_opd_2 )
		{
			case debug_operands.DNS_pkt_cnt:
				TMP_VAL_2 = DEBUG_DNS_pkt_counter;
				break;
			case debug_operands.pkt_in_cnt:
				TMP_VAL_2 = DEBUG_pkt_in_counter;
				break;
			case debug_operands.GPR_0:
				TMP_VAL_2 = DEBUG_GPR_0;
				break;
			case debug_operands.GPR_1:
				TMP_VAL_2 = DEBUG_GPR_1;
				break;
			case debug_operands.GPR_2:
				TMP_VAL_2 = DEBUG_GPR_2;
				break;
			case debug_operands.GPR_3:
				TMP_VAL_2 = DEBUG_GPR_3;
				break;
			default:// TODO find a better way to report the error
				ERROR_2	= true;
				break;
		}
		Kiwi.Pause();

		switch( dbg_op_code )
		{
			// opcode for READ__VAR
			case debug_op_code.READ:
			{
				if ( !ERROR_0 )
					RET_VALUE	= EndianessConv(TMP_VAL_0);
				else
				{
					ERROR		= true;
					ERROR_CODE	= 0x0001000000000000;
				}
				break;
			}
			// opcode for WRITE__VAR_VAL
			case debug_op_code.WRITE:
			{
				switch( (debug_operands)dbg_opd_0 )
				{
					case debug_operands.DNS_pkt_cnt:
						DEBUG_DNS_pkt_counter = VALUE;
						break;
					case debug_operands.pkt_in_cnt:
						DEBUG_pkt_in_counter = VALUE;
						break;
					case debug_operands.GPR_0:
						DEBUG_GPR_0 = VALUE;
						break;
					case debug_operands.GPR_1:
						DEBUG_GPR_1 = VALUE;
						break;
					case debug_operands.GPR_2:
						DEBUG_GPR_2 = VALUE;
						break;
					case debug_operands.GPR_3:
						DEBUG_GPR_3 = VALUE;
						break;
					default:// TODO find a better way to report the error
						ERROR		= true;
						ERROR_CODE	= 0x0001000000000000;
						break;
				}
				break;
			}
			// opcode for COPY__TO-BYTECODE-ARRAY-INDEX_VAL
			case debug_op_code.COPY:
			{
				tmp1 = 0UL;
				if( (uint)dbg_opd_0>=(uint)Bc_ARRAY_DEPTH ) 
				{	tmp1=1UL;	ERROR=true;	} 
				else if( (uint)dbg_opd_1>=(uint)Bc_ARRAY_WIDTH ) 
				{	tmp1=2UL;	ERROR=true;	}
				else
				{
					tmp1 = 0UL;
					tmp2 = (ulong)((byte)dbg_opd_1 / (byte)0x08);
					tmp3 = (ulong)((byte)dbg_opd_1 % (byte)0x08);
					if( (byte)dbg_opd_1<=(byte)0x08 )
					{
						tmp = (ulong)0xffffffffffffffff<<((byte)8-(byte)dbg_opd_1) & EndianessConv(tdata[3]);
						Kiwi.Pause();
						for(j=0; j<(byte)Bc_ARRAY_WIDTH; j++)
						{
							if ( j<dbg_opd_1 )
								DEBUG_byte_code_array[(uint)dbg_opd_0,j] = (byte)((tmp<<(byte)j) & (ulong)0xff00000000000000);
							else
								DEBUG_byte_code_array[(uint)dbg_opd_0,j] = (byte)0;
							Kiwi.Pause();
							//Console.WriteLine("<><><>> mask: {0:X}", DEBUG_byte_code_array[(uint)DEBUG_OPERAND_0,j]);
						}
					}
					else
					{
						for(i=0; i<(uint)tmp2; i++)
						{
							tmp = EndianessConv(tdata[i+3]);
							Kiwi.Pause();
							for(j=0; j<(uint)Bc_ARRAY_WIDTH; j++)
							{
								DEBUG_byte_code_array[(uint)dbg_opd_0,(uint)j+((uint)i*8U)] = (byte)(tmp>>(byte)(56-(uint)j*8U) & (ulong)0x00ff);
								Kiwi.Pause();
							}
						}
						if( tmp3!=0UL )
						{
							tmp = EndianessConv(tdata[i+3]);
							Kiwi.Pause();
							for(j=0; j<(byte)Bc_ARRAY_WIDTH; j++)
							{
								if ( j<tmp3 )
									DEBUG_byte_code_array[(uint)dbg_opd_0,(uint)j+((uint)i*8U)] = (byte)(tmp>>(byte)(56-(uint)j*8U) & (ulong)0x00ff);
								else
									DEBUG_byte_code_array[(uint)dbg_opd_0,(uint)j+((uint)i*8U)] = (byte)0;
								Kiwi.Pause();
							}
						}
					}
				}
				ERROR_CODE = EndianessConv(tmp1)>>8;
				break;
			}
			// opcode for INC__VAR_BY-VAL
			case debug_op_code.INC:
			{
				switch( (debug_operands)dbg_opd_0 )
				{
					case debug_operands.DNS_pkt_cnt:
						// TODO check for overflow
						DEBUG_DNS_pkt_counter = (ulong)((ulong)DEBUG_DNS_pkt_counter + (ulong)VALUE);
						break;
					case debug_operands.pkt_in_cnt:
						// TODO check for overflow
						DEBUG_pkt_in_counter = (ulong)((ulong)DEBUG_pkt_in_counter + (ulong)VALUE);
						break;
					case debug_operands.GPR_0:
						// TODO check for overflow
						DEBUG_GPR_0 = (ulong)((ulong)DEBUG_GPR_0 + (ulong)VALUE);
						break;
					case debug_operands.GPR_1:
						// TODO check for overflow
						DEBUG_GPR_1 = (ulong)((ulong)DEBUG_GPR_1 + (ulong)VALUE);
						break;
					case debug_operands.GPR_2:
						// TODO check for overflow
						DEBUG_GPR_2 = (ulong)((ulong)DEBUG_GPR_2 + (ulong)VALUE);
						break;
					case debug_operands.GPR_3:
						// TODO check for overflow
						DEBUG_GPR_3 = (ulong)((ulong)DEBUG_GPR_3 + (ulong)VALUE);
						break;
					default:// TODO find a better way to report the error
						ERROR		= true;
						ERROR_CODE	= 0x0001000000000000;
						break;
				}
				break;
			}
			// opcode for DEC__VAR_BY-VAL
			case debug_op_code.DEC:
			{
				switch( (debug_operands)dbg_opd_0 )
				{
					case debug_operands.DNS_pkt_cnt:
						// TODO check for overflow
						DEBUG_DNS_pkt_counter = (ulong)((ulong)DEBUG_DNS_pkt_counter - (ulong)VALUE);
						break;
					case debug_operands.pkt_in_cnt:
						// TODO check for overflow
						DEBUG_pkt_in_counter = (ulong)((ulong)DEBUG_pkt_in_counter - (ulong)VALUE);
						break;
					case debug_operands.GPR_0:
						// TODO check for overflow
						DEBUG_GPR_0 = (ulong)((ulong)DEBUG_GPR_0 - (ulong)VALUE);
						break;
					case debug_operands.GPR_1:
						// TODO check for overflow
						DEBUG_GPR_1 = (ulong)((ulong)DEBUG_GPR_1 - (ulong)VALUE);
						break;
					case debug_operands.GPR_2:
						// TODO check for overflow
						DEBUG_GPR_2 = (ulong)((ulong)DEBUG_GPR_2 - (ulong)VALUE);
						break;
					case debug_operands.GPR_3:
						// TODO check for overflow
						DEBUG_GPR_3 = (ulong)((ulong)DEBUG_GPR_3 - (ulong)VALUE);
						break;
					default:// TODO find a better way to report the error
						ERROR		= true;
						ERROR_CODE	= 0x0001000000000000;
						break;
				}
				break;
			}
			// opcode for MOVE__VAR1_VAR2
			case debug_op_code.MOVE:
			{
				if ( !ERROR_0 )
				{
					switch( (debug_operands)dbg_opd_1 )// This is not the length but the destination register 
					{
						case debug_operands.DNS_pkt_cnt:
							DEBUG_DNS_pkt_counter = TMP_VAL_0;
							break;
						case debug_operands.pkt_in_cnt:
							DEBUG_pkt_in_counter = TMP_VAL_0;
							break;
						case debug_operands.GPR_0:
							DEBUG_GPR_0 = TMP_VAL_0;
							break;
						case debug_operands.GPR_1:
							DEBUG_GPR_1 = TMP_VAL_0;
							break;
						case debug_operands.GPR_2:
							DEBUG_GPR_2 = TMP_VAL_0;
							break;
						case debug_operands.GPR_3:
							DEBUG_GPR_3 = TMP_VAL_0;
							break;
						default:// TODO find a better way to report the error
							ERROR		= true;
							ERROR_CODE	= 0x0001000000000000;
							break;
					}
				}
				else
				{
					ERROR		= true;
					ERROR_CODE	= 0x0001000000000000;
				}
				break;
			}
			// opcode for EQ__VAR1_VAR2
			case debug_op_code.EQ:
			{
				if ( !ERROR_0 && !ERROR_1 )
					DEBUG_GPR_0 = (TMP_VAL_0 == TMP_VAL_1) ? 1UL : 0UL;
				else
				{
					ERROR		= true;
					ERROR_CODE	= 0x0001000000000000;
				}
				break;
			}
			// opcode for LESS__VAR1_VAR2
			case debug_op_code.LESS:
			{
				if ( !ERROR_0 && !ERROR_1 )
					DEBUG_GPR_0 = (TMP_VAL_0 < TMP_VAL_1) ? 1UL : 0UL;
				else
				{
					ERROR		= true;
					ERROR_CODE	= 0x0001000000000000;
				}
				break;
			}
			// opcode for WRITE_ARR__X_Y_VAL
			case debug_op_code.WRITE_ARR:
			{
				if( (uint)dbg_opd_0>=(uint)VAL_ARRAY_SIZE || (uint)dbg_opd_1>=(uint)VAL_ARRAY_SIZE || ERROR_0 || ERROR_1 ) 
				{	ERROR = true;	ERROR_CODE = 0x0001000000000000;	}
				else
					DEBUG_values_array[(uint)TMP_VAL_0,(uint)TMP_VAL_1] = VALUE;
				Kiwi.Pause();
				break;
			}
			// opcode for READ_ARR__X_Y
			case debug_op_code.READ_ARR:
			{
				if( (uint)dbg_opd_0>=(uint)VAL_ARRAY_SIZE || (uint)dbg_opd_1>=(uint)VAL_ARRAY_SIZE || ERROR_0 || ERROR_1 ) 
				{	ERROR = true;	ERROR_CODE = 0x0001000000000000;	}
				else
					RET_VALUE = EndianessConv(DEBUG_values_array[(uint)TMP_VAL_0,(uint)TMP_VAL_1]);
				Kiwi.Pause();
				break;
			}
			// TODO change the X-Y DST-SRC to be variables instead of constant values
			// opcode for MOVE_ARR_TO_ARR__SRC-x_SRC-y_DST-x_DST-y
			case debug_op_code.MOVE_ARR_TO_ARR:
			{
				tmp = 0UL; tmp1 = 0UL;
				if( (uint)dbg_opd_0>=(uint)VAL_ARRAY_SIZE || (uint)dbg_opd_1>=(uint)VAL_ARRAY_SIZE || (uint)dbg_opd_2>=(uint)VAL_ARRAY_SIZE || (uint)dbg_opd_3>=(uint)VAL_ARRAY_SIZE ) 
				{	ERROR = true;	ERROR_CODE = 0x0001000000000000;	}
				else
					tmp	= DEBUG_values_array[(uint)dbg_opd_0,(uint)dbg_opd_1];
					Kiwi.Pause();
					tmp1	= DEBUG_values_array[(uint)dbg_opd_2,(uint)dbg_opd_3];
					Kiwi.Pause();
					DEBUG_values_array[(uint)dbg_opd_0,(uint)dbg_opd_1] = tmp1;
					Kiwi.Pause();
					DEBUG_values_array[(uint)dbg_opd_2,(uint)dbg_opd_3] = tmp;
					Kiwi.Pause();
				break;
			}
			// opcode for MOVE_ARR_TO_VAR__SRC-x_SRC-y_VAR
			case debug_op_code.MOVE_ARR_TO_VAR:
			{
				tmp = 0UL; tmp1 = 0UL; 
				if( (uint)dbg_opd_0>=(uint)VAL_ARRAY_SIZE || (uint)dbg_opd_1>=(uint)VAL_ARRAY_SIZE || (byte)dbg_opd_2>=(byte)DEBUG_OPERANDS_NUM || ERROR_0 || ERROR_1 ) 
				{	ERROR = true;	ERROR_CODE = 0x0001000000000000;	}
				else
				{
					switch( (debug_operands)dbg_opd_2 )
					{
						case debug_operands.DNS_pkt_cnt:
							DEBUG_DNS_pkt_counter = DEBUG_values_array[(uint)TMP_VAL_0, (uint)TMP_VAL_1];
							break;
						case debug_operands.pkt_in_cnt:
							DEBUG_pkt_in_counter = DEBUG_values_array[(uint)TMP_VAL_0, (uint)TMP_VAL_1];
							break;
						case debug_operands.GPR_0:
							DEBUG_GPR_0 = DEBUG_values_array[(uint)TMP_VAL_0, (uint)TMP_VAL_1];
							break;
						case debug_operands.GPR_1:
							DEBUG_GPR_1 = DEBUG_values_array[(uint)TMP_VAL_0, (uint)TMP_VAL_1];
							break;
						case debug_operands.GPR_2:
							DEBUG_GPR_2 = DEBUG_values_array[(uint)TMP_VAL_0, (uint)TMP_VAL_1];
							break;
						case debug_operands.GPR_3:
							DEBUG_GPR_3 = DEBUG_values_array[(uint)TMP_VAL_0, (uint)TMP_VAL_1];
							break;
						default:// TODO find a better way to report the error
							ERROR		= true;
							ERROR_CODE	= 0x0001000000000000;
							break;
					}
					Kiwi.Pause();
				}
				break;
			}
			// opcode for MOVE_VAR_TO_ARR__VAR_DST-x_DST-y
			case debug_op_code.MOVE_VAR_TO_ARR:
			{
				if( (uint)dbg_opd_0>=(uint)DEBUG_OPERANDS_NUM  || (uint)dbg_opd_1>=(uint)VAL_ARRAY_SIZE || (uint)dbg_opd_2>=(uint)VAL_ARRAY_SIZE || ERROR_0 || ERROR_1 || ERROR_2 ) 
				{	ERROR = true;	ERROR_CODE = 0x0001000000000000;	}
				else
					DEBUG_values_array[(uint)TMP_VAL_1, (uint)TMP_VAL_2] = TMP_VAL_0;
				Kiwi.Pause();
				break;
			}
			case debug_op_code.NOP:		break;
			case debug_op_code.EXEC:	break;
			default:
				ERROR		= true;
				ERROR_CODE	= 0x0001000000000000;
				break;
		}

		DEBUG_OPERAND_VALUE	= RET_VALUE;
		return ERROR_CODE;
	}

	static public ulong EndianessConv(ulong val)
	{
		ulong tmp_val = val;
		ulong ret_val = 0UL;

		ret_val = (tmp_val & (ulong)0xff00000000000000>>0)>>7*8 | (tmp_val & (ulong)0xff00000000000000>>8)>>5*8 | (tmp_val & (ulong)0xff00000000000000>>16)>>3*8 | (tmp_val & (ulong)0xff00000000000000>>24)>>1*8 | (tmp_val & (ulong)0xff00000000000000>>32)<<1*8 | (tmp_val & (ulong)0xff00000000000000>>40)<<3*8 | (tmp_val & (ulong)0xff00000000000000>>48)<<5*8 | (tmp_val & (ulong)0xff00000000000000>>56)<<7*8;

		return ret_val;
	}


	// This procedure calculates the checksum of a given byte stream
	// It returns the result in big endianess format
	// It doenst compute the 1's complement
	static public void calc_UDP_checksum(ulong data)
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

		// check for carry and add it if its needed
		sum = (ulong)( (sum0 + sum1)& (ulong)0x00ffff ) + (ulong)((sum0 + sum1)>>16);
		// add the current sum to the previous sums
		chksum_UDP = (ulong)( (sum + chk)& (ulong)0x00ffff ) + (ulong)((sum + chk)>>16);
	}


	// This procedure perform the calculation of the new checksum and verification
	// It returns the new checksum(on calculation process) or 0x00 if no-errors were detected(on verification process)
	static ulong calc_IP_checksum()
	{	byte i;
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

			// check for carry and add it if its needed
			sum = (ulong)( (sum0 + sum1)& (ulong)0x00ffff ) + (ulong)((sum0 + sum1)>>16);
			// add the current sum to the previous sums
			sum_all = (ulong)( (sum + sum_all)& (ulong)0x00ffff ) + (ulong)((sum + sum_all)>>16);
		}
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
	static public void Extract_headers(uint count, ulong tdata, ulong tuser)
	{
		switch(count)
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
				DEBUG_MODE =  (tdata>>32 & (ulong)0x00ffff) == (ulong)0x00ffff;
				DEBUG_OP_CODE = (debug_op_code)(tdata>>56);
				break;
			case 2U:
				proto_ICMP	= (  tdata>>56 & (ulong)0x00ff) == (ulong)0x0001;
				proto_UDP	= (  tdata>>56 & (ulong)0x00ff) == (ulong)0x0011;
				IP_total_length	= (  tdata & (ulong)0x00ffff );
				DEBUG_OPERAND_0	= (byte)(tdata>>56);
				DEBUG_OPERAND_1	= (byte)(tdata>>48);
				DEBUG_OPERAND_2	= (byte)(tdata>>40);
				DEBUG_OPERAND_3	= (byte)(tdata>>32);
				break;
				// Start of the IP header
			case 3U:
				src_ip = ( tdata>>16) & (ulong)0x00ffffffff;
				dst_ip = ( tdata>>48) & (ulong)0x00ffff;
				DEBUG_OPERAND_VALUE = tdata;
				break;
				// Start of the UDP header
			case 4U:
				dst_ip |= (  tdata & (ulong)0x00ffff )<<16; 
				app_src_port = (  tdata>>16 & (ulong)0x00ffff);
				app_dst_port = (  tdata>>32 & (ulong)0x00ffff);
				UDP_total_length = (  tdata>>48 & (ulong)0x00ffff);
				ICMP_code_type = (  tdata>>16 & (ulong)0x00ffff);
				break;
				// Start of the UDP frame & Memcached Header
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
		Kiwi.Pause();

		// The start condition 
		uint cnt	= 0;
		uint psize	= 0;
		bool start	= s_axis_tvalid && s_axis_tready; 
		bool doneReading= true;
		bool receive	= s_axis_tvalid;
		ulong data = 0x00,data2 = 0x00;
		byte keep	= 0x00;
		// #############################
		// # Receive the frame
		// #############################
		while (doneReading)
		{
			if (s_axis_tvalid)
			{
				tdata[cnt]	= s_axis_tdata;
				tkeep[cnt]	= s_axis_tkeep;
				tlast[cnt]	 = s_axis_tlast;
				//tuser_hi[cnt]	= s_axis_tuser_hi;
				tuser_low[cnt]	 = s_axis_tuser_low;

				segm_num += 1U;
				psize = cnt++;
				doneReading = !s_axis_tlast && s_axis_tvalid;

				// Create backpresure to whatever sends data to us
				s_axis_tready = s_axis_tlast ? false : true;
			}
			Kiwi.Pause();
		}
		data	= tdata[psize];
		keep	= tkeep[psize];

		Kiwi.Pause();

		switch (keep) {
		case 0x01:
			data2 = data & (ulong)0x00ff; last_tkeep = 0x01;
			break;
		case 0x03:
			data2 = data & (ulong)0x00ffff; last_tkeep = 0x02;
			break;
		case 0x07:
			data2 = data & (ulong)0x00ffffff; last_tkeep = 0x03;
			break;
		case 0x0f:
			data2 = data & (ulong)0x00ffffffff; last_tkeep = 0x04;
			break;
		case 0x1f:
			data2 = data & (ulong)0x00ffffffffff; last_tkeep = 0x05;
			break;
		case 0x3f:
			data2 = data & (ulong)0x00ffffffffffff; last_tkeep = 0x06;
			break;
		case 0x7f:
			data2 = data & (ulong)0x00ffffffffffffff; last_tkeep = 0x07;
			break;
		case 0xff:
			data2 = data & (ulong)0xffffffffffffffff; last_tkeep = 0x08;
			break;
		default:
			data2 = 0x00;
			break;
		}
		Kiwi.Pause();

		tdata[psize]	= data2;
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

		uint i=0, packet_size=size;

		while (i<=packet_size)
		{
			if ( m_axis_tready )
			{
				m_axis_tdata	= tdata[i];
				m_axis_tkeep	= tkeep[i];
				m_axis_tlast	= i == (size);
				m_axis_tuser_hi	= 0UL;
				m_axis_tuser_low= ( i == 0U ) ? tuser_low[0] : 0UL;
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
		while (true) DNS_logic();
	}
	
	static int Main()
	{
	return 0;
	}
}



