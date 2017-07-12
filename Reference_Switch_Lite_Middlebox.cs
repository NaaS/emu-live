/*
 Reference learning Switch lite (C#) for the NetFPGA platform and kiwi compiler
 This is experimental source code, to work with the "iptablet" generator.
 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

 Version/additions
 -add code for receiving/transmiting, procedures/functions
 -add buffer to store the whole packet
 -move some code out of the receiving function. RX/TX functions are handling
  only the data and the control signals of the AXI4-Stream
*/


using System;
using KiwiSystem;



class LocalLinkLoopBackTest
{   

    class EthernetEcho
    {


        // This class describes a switch
        // and is designed to mimick the functionality of s static switch


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
        static bool m_axis_tvalid;  	// Source ready indicator
        [Kiwi.InputBitPort("m_axis_tready")]	// tx_dst_rdy_n
        static bool m_axis_tready ;    		// Destination ready indicator
        [Kiwi.OutputBitPort("m_axis_tuser_hi")]	// 
        static ulong m_axis_tuser_hi;	//	
        [Kiwi.OutputBitPort("m_axis_tuser_low")]// 
        static ulong m_axis_tuser_low;	// 


	// CAM Memory Ports
	// Output Ports
        [Kiwi.InputBitPort("cam_busy")]	
        static bool cam_busy;
        [Kiwi.InputBitPort("cam_match")]	
        static bool cam_match;
        [Kiwi.InputBitPort("cam_match_addr")]	
        static byte cam_match_addr;		// 8-bit address width
	// Input Ports
        [Kiwi.OutputWordPort("cam_cmp_din")]	
        static ulong cam_cmp_din=~(ulong)0x00;	// 64-bit width compare din
        [Kiwi.OutputWordPort("cam_din")]	
        static ulong cam_din;			// 64-bit width din
        [Kiwi.OutputBitPort("cam_we")]	
        static bool cam_we;
        [Kiwi.OutputBitPort("cam_wr_addr")]	
        static byte cam_wr_addr;
	// Constants variables
	const uint LUT_SIZE = 16;
	const uint BUF_SIZE = 30;	

	// Lookup Table -- small one
	// Here we need to initialise (with something) the table with 0x01 instead of
	// 0x00 because in this case, in the simulation we get undefined values ('ZZ)
	// Format of the LUT entry ( 62bit )
	// |-	48bit	--	16bit	-|
	// |-	MAC	--	port	-|
        static ulong[] LUT = new ulong[LUT_SIZE] {0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001,0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001,0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001, 0x0000000000000001};

	static ulong DEFAULT_oqs = (ulong)0x0000000000550000;

	// Little endianess
	// These must be accesible by the host - should be interact 
	// with the register infrastucture
	//static ulong[] MAC = {0x00010000feca, 0x00020000feca, 0x00030000feca, 0x00040000feca};
	static ulong dst_mac, src_mac, src_port, dst_port, src_ip, dst_ip, app_src_port, app_dst_port; 

	static ulong tmp, tmp2, OQ, broadcast_ports; 
	static bool IPv4 = false, proto_UDP = false, proto_ICMP = false;

	static uint segm_num;
	static bool LUT_hit = false;
    
	static byte[] tkeep = new byte[BUF_SIZE];
	static bool[] tlast = new bool[BUF_SIZE];
	static ulong[] tdata = new ulong[BUF_SIZE];
	static ulong[] tuser_hi = new ulong[BUF_SIZE];
	static ulong[] tuser_low = new ulong[BUF_SIZE];


	static	ulong data, user_hi, user_low;
	static	bool last;
	static	byte keep;
	//static  uint size;

        // This method describes the operations required to route the frames
        static public void switch_logic()
        {
	    	
	    int i=0, free=0;
            uint pkt_size=0;
	    bool exist = false;
	    segm_num = 0;


            while (true) // Process packets indefinately
            {
		segm_num = 0;
		// Procedure call for receiving packet
		pkt_size = ReceiveFrame();
		
                // #############################
		// # Switch Logic -- START
		// #############################

		// Once we have the destination MAC, 
		// check the LUT if it exists in there
		// and set the appropriate metadata into the tuser field 
		Kiwi.Pause();
		// Get the destination mac from the buffer
		dst_mac = tdata[0]<<16;
		// Set the broadcasts ports if need for later, based on the metadata
		broadcast_ports = ((tuser_low[0] ^ DEFAULT_oqs)>>8)<<16 | tuser_low[0];

		for (i=0; i<LUT_SIZE; i++)
		{	// Get the mac address from LUT
			tmp = LUT[i] & (ulong)0xffffffffffff0000;
			// Get the output port from LUT
			tmp2= LUT[i] & (ulong)0x000000000000ffff;
			Kiwi.Pause();
			// Compare with the one existed in the current packet
			if( tmp == dst_mac ){
				// Put the output port to the right offset
				OQ = tmp2 << 24;
				LUT_hit = true; break;
			}	
		}
		// If we have a hit set the appropriate output port in the metadata, else flooding
		tmp = LUT_hit ? (ulong)(OQ | tuser_low[0]) : (ulong)(broadcast_ports | tuser_low[0]);
		Kiwi.Pause();
		// Configure the metadata
		if (Test() && (( tdata[1]>>32 & (ulong)0x00ffff) == (ulong)0x0008)) {
			tuser_low[0] = tmp;
		}
		Kiwi.Pause();

		// Once we have the source MAC,
		// If we had a hit in the previous stage-lookup, we skip this one
		// If we dint have a 'hit', then we need to store the source MAC and 
		// the source port number
		
		//tmp = src_mac_hi | src_mac_low | src_port;
		tmp = ((tdata[0]>>48)<<16) | ((tuser_low[0]>>16) & 0xff);	
		Kiwi.Pause();		
		tmp |= (tdata[1]<<32);
		// Check if we need to store a new entry into the LUT
		if ( !LUT_hit )
		{									
			LUT_hit = false;	
			
			for (i=0; i<LUT_SIZE; i++)
			{
				Kiwi.Pause();
				// Get rid off the oq, keep only the mac
				if( tmp == LUT[i] ){
					exist = true;	break;												
				}	
			}
			// Replace policy -- LIFO
			if( !exist ){	LUT[free]=tmp;	free=(free>9)?0:free++;	}
		}
                // #############################
		// # Switch Logic -- END 
		// #############################
 
		// Procedure call for transmiting packet
		SendFrame(pkt_size);
		IPv4 = false;
		proto_UDP = false;
                //End of frame, ready for next frame
            }
        }
static ulong src_address = 0UL, dst_address = 0UL;
// NOTE: This function was automatically generated using iptablet. Do not edit.
static public bool Test() {
        bool result = false;
        //ulong src_address = 0UL;
        // src_address set to 192.168.2.2
        unchecked { src_address = (ulong)(-1062731262); }
        //ulong dst_address = 0UL;
        // dst_address set to 192.168.4.4
        unchecked { dst_address = (ulong)(3232236548); } //(-1062730748)   1023410176 3,232,236,548
        result = proto_UDP;
	//dst_address =  littlel(dst_address);
	mo = 205095699460UL;
        result &= //(src_ip<<32 != littlel(src_address)) &&
                (dst_ip<<32 ==  littlel(mo)) &&
                ((app_src_port<<48 >= littlel(30UL)) && (app_src_port<<16 <= littlel(34UL))) &&
                ((app_dst_port<<48 >= littlel(50UL)) && (app_dst_port<<16 <= littlel(52UL)));
        return result;
}

static ulong s0,s1,s2,s3, swaped,mo,ko;
	static public ulong littlel(ulong da)
	{	ulong d;
		d = da;
		//mo = d & (ulong)0x00ffffffff;
		// Currently we only swap the first 32bit, dont care about the rest
		// because ip and ports can fit into the first 32bit of the ulong
		s0 = (d & (ulong)0x000000ff)<<24;
		s1 = (d & (ulong)0x0000ff00)<<8;
		s2 = (d & (ulong)0x00ff0000)>>8;
		s3 = (d & (ulong)0xff000000)>>24;
	
		swaped = (s0|s1|s2|s3) <<32;

		return ( swaped );
	}


	// This procedure should be executed in paralel while we receive data
	// Currently it is called inside the receiving procedure
	static public void Extract_data()//uint segm_num)
	{		

				if (segm_num==(uint)0);
				
				// Start of the Ethernet header
				else if (segm_num==(uint)1){ 	
					dst_mac   = s_axis_tdata & (ulong)0x0000ffffffffffff;
					src_mac   = s_axis_tdata>>48 & (ulong)0x00ffff;
					//src_mac_hi= s_axis_tdata & (ulong)0xffff000000000000;
					// metadata ports - NOT UDP ports
					src_port  = ((s_axis_tuser_low>>16) & 0xff);
					dst_port  = ((s_axis_tuser_low>>24) & 0xff);
				}
				else if (segm_num==(uint)2){
					src_mac |= (s_axis_tdata & (ulong)0x00ffffffff)<<16 ;
					IPv4 = ( (s_axis_tdata>>32 & (ulong)0x00ffff) == (ulong)0x0008) && ( (s_axis_tdata>>52 & (ulong)0x0f) == (ulong)0x04);
				}
				else if (segm_num==(uint)3){
					proto_ICMP = ( s_axis_tdata>>56 & (ulong)0x00ff) == (ulong)0x0001;
					proto_UDP = ( s_axis_tdata>>56 & (ulong)0x00ff) == (ulong)0x0011;
//					IP_total_length = ( s_axis_tdata & (ulong)0x00ffff );
				}
				// Start of the IP header
				else if (segm_num==(uint)4){
					src_ip = (s_axis_tdata>>16) & (ulong)0x00ffffffff;
					dst_ip = (s_axis_tdata>>48) & (ulong)0x00ffff;
				}
				// Start of the UDP header
				else if (segm_num==(uint)5){					
					dst_ip |= ( s_axis_tdata & (ulong)0x00ffff )<<16; 
					app_src_port = ( s_axis_tdata>>16 & (ulong)0x00ffff);
					app_dst_port = ( s_axis_tdata>>32 & (ulong)0x00ffff);
//					UDP_total_length = ( s_axis_tdata>>48 & (ulong)0x00ffff);
//					ICMP_code_type = ( s_axis_tdata>>16 & (ulong)0x00ffff);
				}
//				// Start of the UDP frame & Memcached Header
//				else if (segm_num==(uint)6){
//					magic_num	= (byte)(s_axis_tdata>>16 & (ulong)0x00ff);
//					opcode		= (byte)(s_axis_tdata>>24 & (ulong)0x00ff);
//					// Little endianess 
//					key_length	= (uint)(s_axis_tdata>>16 & (ulong)0x00ff00) | (uint)(s_axis_tdata>>40 & (ulong)0x00ff);
//					extras_length	= (byte)(s_axis_tdata>>48 & (ulong)0x00ff);
//				}
////				else if (segm_num==7){
////					opaque = s_axis_tdata<<48;
////				}
////				else if (segm_num==8){
////					opaque |= (s_axis_tdata & (ulong)0x00ffff)<<16; 
////				}
//				// Start of the Memcached payload
//				else if (segm_num==(uint)9){
//					if ( (magic_num==REQUEST) && (opcode==GET || opcode==DELETE) )
//						key	= (ulong)(s_axis_tdata & (ulong)0xffffffffffff0000);
//					if ( (magic_num==REQUEST) && (opcode==SET) )
//						extras	= s_axis_tdata<<16;
//				}
//				// Start of the key
//				// Currently fixed-length of the key is 6 Bytes and 8 Bytes for the value
//				// Extras(Flags/Expiration) fixed length 8 Bytes
//				else if (segm_num==(uint)10){
//					if ( (magic_num==REQUEST) && (opcode==SET) ){
//						key	= (ulong)(s_axis_tdata & (ulong)0xffffffffffff0000);
//						extras	|= s_axis_tdata&(ulong)0x00ffff;
//					}
//				}
//				else if (segm_num==(uint)11){
//					if ( (magic_num==REQUEST) && (opcode==SET) ){
//						key_value = s_axis_tdata;
//						//extras = tmp | s_axis_tdata<<48;
//					}
//				}
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
		uint cnt = 0;
		uint size = 0;
		bool start = s_axis_tvalid && s_axis_tready; 
		bool doneReading = true;
		bool receive = s_axis_tvalid;
		// #############################
		// # Receive the frame
		// #############################
		cnt = 0; segm_num=1;
		doneReading = true;

		while (doneReading)
		{

			if (s_axis_tvalid)
			{
				Extract_data();
				tdata[cnt]	  = s_axis_tdata;
				tkeep[cnt]	  = s_axis_tkeep;
				tlast[cnt]	  = s_axis_tlast;
				tuser_hi[cnt]  = s_axis_tuser_hi;
				tuser_low[cnt] = s_axis_tuser_low;
					
				// Create backpresure to whatever sends data to us
				//s_axis_tready = s_axis_tlast ? false : true;	
				size = cnt++;
				segm_num += 1U;
				doneReading = !s_axis_tlast && s_axis_tvalid;
				s_axis_tready = s_axis_tlast ? false : true;		
			}
			Kiwi.Pause();			
		}
		s_axis_tready = false;
		cnt = 0;
		start = false;
		return size;
	}

	// This method describes the operations required to tx a frame over the AXI4-Stream.
	static void SendFrame(uint pkt_size)
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

		uint i=0;

		i=0;

		while (i<=pkt_size)
                {
			if ( m_axis_tready )
			{
		     		m_axis_tdata 	= tdata[i];
				m_axis_tkeep 	= tkeep[i];
				// -- BUG DONT USE	
		   		//m_axis_tlast  	= (i==pkt_size) ? true : false;
				//if (i==pkt_size) m_axis_tlast = true; 
				m_axis_tlast = i == (pkt_size);
				m_axis_tuser_hi = tuser_hi[i];
				m_axis_tuser_low= tuser_low[i];
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
		while (true) switch_logic();
	}
    }


    static int Main()
    {
	ulong dst_address = 0UL;
        unchecked { dst_address = (ulong)(3232236548); } //(-1062730748)   1023410176 3,232,236,548
	//dst_address =  littlel(dst_address);
	//mo = 205095699460UL;
	System.Console.WriteLine(dst_address);
	ulong simulation = 0xffffffffc0a80404;
	ulong simulation_ = 0xc0a80404;
	//long simulation2 = (long)(0xffffffffc0a80404);
	System.Console.WriteLine(dst_address == simulation);
	//System.Console.WriteLine(simulation2 = simulation);
	System.Console.WriteLine(dst_address == simulation_);

        return 0;
    }

}


