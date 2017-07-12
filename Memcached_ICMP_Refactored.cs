/*
 Memcached Server(GET/SET/DELETE response)
 Implementation on the NetFPGA platform, making use of the Kiwi compiler.
 The generated Verilog file should replace the OPL of the Reference_Switch_Lite.

 Simple Memcached Server. Basic functionality of 'set', 'get', 'delete'
 ICMP-echo response


 Copyright (C) 2016 -- Salvator Galea <salvator.galea@cl.cam.ac.uk>
                       Nik Sultana, Cambridge University Computer Lab

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

 Version/additions
 -add code for receiving/transmiting, procedures/functions
 -add buffer to store the whole packet
 -add SET response functionality (without error code)
 -add DELETE response functionality (with error code + textual error msg)
 -add GET response functionality (with error code + textual error msg)
 -add controller-logic for SRL16-based CAM (1cc read, 16cc write)
 -add functionality to calculate/validate IP checksum
 -add logic for ICMP echo reply
 -add function that calculaates/validates the UDP checksum

 References:
  https://github.com/memcached/memcached/blob/master/doc/protocol.txt
  http://memcached.googlecode.com/svn/wiki/MemcacheBinaryProtocol.wiki
  http://www.xilinx.com/support/documentation/application_notes/xapp1151_Param_CAM.pdf
*/

using System;
using KiwiSystem;
using Emu;
using Emu.Protocols;

class Server : CAM_Index
{
   // Constants variables
   const uint BUF_SIZE = (uint)256;

   //static ulong[] KEYS_MEM = new ulong[CAM_Index.MEM_SIZE];
   static ulong[] VALUES_MEM = new ulong[CAM_Index.MEM_SIZE];
   static ulong[] EXTRAS_MEM = new ulong[CAM_Index.MEM_SIZE];
   //[Kiwi.Volatile()]
   static ulong dst_mac, src_mac, src_port, dst_port, src_ip, dst_ip;
   static bool  IPv4 = false, proto_UDP = false, proto_ICMP = false;
   static byte  magic_num, opcode;
   static uint  key_length;
   static byte  extras_length;
   static bool  icmp_header = false;
   static ulong IP_total_length, UDP_total_length, app_src_port, app_dst_port, ICMP_code_type;
   static ulong key, key_value, extras, flag, opaque;
   static ulong segm_num = 0;
   static ulong shared_tdata, shared_tuser;

   static uint num = 0;

   // Local buffer for storing the incoming packet
   static byte[]  tkeep     = new byte[BUF_SIZE];
   static bool[]  tlast     = new bool[BUF_SIZE];
   static ulong[] tdata     = new ulong[BUF_SIZE];
   static ulong[] tuser_hi  = new ulong[BUF_SIZE];
   static ulong[] tuser_low = new ulong[BUF_SIZE];

   static ulong chksum_UDP = 0;

   static ulong chksumIP = 0, tmp, tmp3, tmp2, tmp1;

   static uint cnt;

   // This method describes the main logic functionality of the Server
   // FIXME override Processor_Loop?
   protected static void SwitchLogic()
   {
      ulong local_icmp_code_type, local_chksum_udp, d, u;      //, ipv4;
      uint  i  = 0, free = 0, mem_cnt = 0;
      byte  ii = 0, local_magic_num = 0, local_opcode = 0;

      uint  pkt_size         = 0;
      bool  exist            = false, is_ipv4 = false, is_udp = false, is_icmp = false;
      uint  cam_addr         = 0, tmp_addr = 0, addr = 0;
      bool  good_IP_checksum = false, error = false;
      ulong local_key_value, local_extras, local_flag;

      while (true)       // Process packets indefinately
      {
         pkt_size = ReceiveFrame();

         // Extract information from the Ethernet, IP, TCP, UDP frames
         for (i = 0; i <= 11; i++)
         {
            d = tdata[i];
            u = tuser_low[i];
            Kiwi.Pause();
            Extract_headers(i, d, u);
         }


         Kiwi.Pause();
         // We need to store the shared-threat variables here
         // otherwise if we use it explicity we get long compilation times
         is_ipv4              = IPv4;
         is_udp               = proto_UDP;
         is_icmp              = proto_ICMP;
         local_magic_num      = magic_num;
         local_opcode         = opcode;
         local_icmp_code_type = ICMP_code_type;
         local_chksum_udp     = chksum_UDP;
         local_key_value      = key_value;
         local_extras         = extras;
         local_flag           = flag;


         Kiwi.Pause();
         // #############################
         // # Server Logic -- START
         // #############################

         // #######################################################################################
         // #           MEMCACHED SERVER
         if (is_ipv4 && is_udp)
         {
            chksumIP         = Emu.Protocols.IPv4.calc_IP_checksum(dataplane.tdata);
            good_IP_checksum = (chksumIP == (ulong)0x00);
            //Kiwi.Pause();



            if ((local_magic_num == Memcached.REQUEST) && good_IP_checksum)            //&& (local_chksum_udp==(ulong)0x00ffff))
            {
               // Interpret Memcached opcode as CAM operation.
               var cam_opcode = Memcached.Memcached_Operation(local_opcode);
               // Execute CAM operation.
               addr = CAM_Control(cam_opcode, key);
               Kiwi.Pause();
               // Execute Memcached operation.
               switch (local_opcode)
               {
                 case Memcached.SET_op:
                    VALUES_MEM[addr] = key_value;
                    EXTRAS_MEM[addr] = extras;
                    break;
                 case Memcached.GET_op:
                    key_value = VALUES_MEM[addr];
                    flag = EXTRAS_MEM[addr];
                    break;
                 default:
                    break;
               }

               error = addr == (uint)MEM_SIZE;
               Kiwi.Pause();

               chksum_UDP = (ulong)0x00;
               chksumIP   = 0x00;
               swap_multiple_fields(is_udp, is_icmp);
               Kiwi.Pause();
               // Create the response packet + reset appropriate fields(ex. UDP checksum)
               switch (local_opcode)
               {
               case Memcached.SET_op:
                   pkt_size = Memcached.Memcached_SET(ref dataplane.tdata, IP_total_length, UDP_total_length);
	                // Set the correct metadata for the datapath
	                // Fixed size response packet for SET - DELETE success
	                tuser_low[0] = (src_port << 24) | (src_port << 16) | (ulong)74;
	                tkeep[9]     = (byte)0x03;
	                //pkt_size = 8;
                  break;

               case Memcached.DELETE_op:
                  pkt_size = Memcached_DELETE(error);
                  break;

               case Memcached.GET_op:
                  pkt_size = Memcached_GET(error);
                  break;
               }
               Kiwi.Pause();

               tmp = tdata[3];
               Kiwi.Pause();

               chksumIP = Emu.Protocols.IPv4.calc_IP_checksum(dataplane.tdata);
               Kiwi.Pause();
               // Set the new IP checksum - as we dont change any info in the header,
               // the checksum should remane the same - but anyway recalc and put it back
               tdata[3] = (chksumIP >> 8 | (chksumIP & (ulong)0x00ff) << 8) | tmp;
               Kiwi.Pause();

               // Here is the UDP checksum - clear it and preserve the other data
               tmp = tdata[5];                  //we have already clear the UDP checksum
               Kiwi.Pause();
               // The 4th element in the buffer is the start of the UDP frame
               for (i = 4; i <= pkt_size; i++)
               {
                  tmp2 = (i != 4) ? tdata[i] : tdata[i] >> 16;
                  Kiwi.Pause();
                  chksum_UDP = UDP.calc_UDP_checksum(chksum_UDP, tmp2);
               }
               tmp3 = (tdata[4] & (ulong)0xffff000000000000) | (ulong)0x001100;    // Here is the new UDP length + proto type
               tmp2 = src_ip << 32 | dst_ip;                                       // (optimization) src, dst IPs
               Kiwi.Pause();
               chksum_UDP = UDP.calc_UDP_checksum(chksum_UDP, tmp3);                                   // (optimization) 11U = 0x11 = UDP proto_type , UDP length
               Kiwi.Pause();
               chksum_UDP = UDP.calc_UDP_checksum(chksum_UDP, tmp2);
               Kiwi.Pause();
               // 1's complement of the result
               tmp2 = (ulong)((chksum_UDP ^ ~(ulong)0x00) & (ulong)0x00ffff);
               Kiwi.Pause();
               // make it back to little endian
               tmp3 = (ulong)((tmp2 >> 8) | (ulong)(tmp2 & (ulong)0x00ff) << 8);
               // Set the new UDP checksum
               tdata[5] = tmp | tmp3;
            }
         }
         // #
         // ###########################################################################################


         Kiwi.Pause();



         // #############################
         // # Server Logic -- END
         // #############################

         // Procedure calchksum_ICMPl for transmiting packet
         SendFrame(pkt_size);
         //End of frame, ready for next frame
         IPv4       = false;
         proto_UDP  = false;
         proto_ICMP = false;
         chksum_UDP = 0x00;
         pkt_size   = 0x00;
      }
   }

   // This procedure creates the GET response packet
   static public uint Memcached_GET(bool err)
   {
      ulong tmp = 0x00, tmp2 = 0x00;

      // Set the correct IP packet length (little endianess)
      // GET - Fixed size of extras(4B)[only flag] + key(6B) + value(8B)
      if (!err)
      {
         tmp = ((ulong)(ulong)((IP_total_length >> 8) | (IP_total_length << 8 & (ulong)0x00ff00)) + (ulong)6) & (ulong)0x00ffff;
      }
      else
      {
         // in case of an error we must adjust the length accordinlgy
         // add length of textual error code (8B)
         tmp = ((ulong)(ulong)((IP_total_length >> 8) | (IP_total_length << 8 & (ulong)0x00ff00)) + (ulong)2) & (ulong)0x00ffff;
      }

      tmp2 = tdata[2] & (ulong)0xffffffffffff0000;
      Kiwi.Pause();
      tdata[2] = tmp2 | (tmp >> 8) | (tmp << 8 & (ulong)0x00ff00);
      Kiwi.Pause();

      // Set the checksum to 0x00, calculate later
      tmp = tdata[3] & (ulong)0xffffffffffff0000;
      Kiwi.Pause();
      tdata[3] = tmp;
      // Set the correct UDP packet length (little endianess)
      // GET - Fixed size of extras(4B)[only flag] + key(6B) + value(8B)
      // in case of an error we must adjust the length accordinlgy
      if (!err)
      {
         tmp = ((ulong)(ulong)((UDP_total_length >> 8) | (UDP_total_length << 8 & (ulong)0x00ff00)) + (ulong)6);
      }
      else
      {
         tmp = ((ulong)(ulong)((UDP_total_length >> 8) | (UDP_total_length << 8 & (ulong)0x00ff00)) + (ulong)2);
      }
      tmp2 = tdata[4] & (ulong)0x0000ffffffffffff;
      Kiwi.Pause();
      tdata[4] = tmp2 | ((tmp & (ulong)0xff00) << 40) | (tmp << 56);
      Kiwi.Pause();

      // Reset the UDP checksum
      tmp = tdata[5];
      Kiwi.Pause();
      tdata[5] = tmp & ~(ulong)0x00ffff;
      Kiwi.Pause();

      tmp = tdata[6] & (ulong)0x00ffff;
      Kiwi.Pause();

      // set GET magic number + opcode
      // set also the extras length(4b)
      if (!err)
      {
         tdata[6] = ((ulong)Memcached.GET_op << 24 | (ulong)Memcached.RESPONSE << 16 | ((ulong)0x0004) << 48) | tmp;
      }
      else
      {
         tdata[6] = ((ulong)Memcached.GET_op << 24 | (ulong)Memcached.RESPONSE << 16) | tmp;
      }
      Kiwi.Pause();
      // Set the opaque
      // Set the status code = key not found
      // and the opaque - GET response
      if (err)
      {
         // total length is fixed (error msg(8B) = 0x14)
         tmp = (tdata[7] & 0xffff000000000000) | (ulong)0x0000080000000100;
      }
      else              // total length is fixed (flag(4B)+key_value(8B)= 0x0c)
      {
         tmp = (tdata[7] & 0xffff000000000000) | (ulong)0x00000c0000000000;
      }

      Kiwi.Pause();
      tdata[7] = tmp;
      Kiwi.Pause();

      // Fill up the rest of the response packet
      if (err)
      {
         tmp = (tdata[8] & 0x000000000000ffff);
         Kiwi.Pause();
         tdata[8] = tmp;
         Kiwi.Pause();

         tdata[9] = Memcached.ERROR_MSG << 16;
         Kiwi.Pause();
         tdata[10] = Memcached.ERROR_MSG >> 48;

         // Set the correct metadata for the datapath
         // Fixed size response packet for GET/DELETE failure
         tuser_low[0] = (src_port << 24) | (src_port << 16) | (ulong)82;
         tkeep[10]    = (byte)0x03;
         //pkt_size = 9;
      }
      else
      {
         tdata[9] = (((ulong)flag >> 16) & (ulong)0x00ffffffff0000) | (ulong)key_value << 48;
         Kiwi.Pause();
         tdata[10]    = (ulong)key_value >> 16;           //&(ulong)0x00ffffffffffff;
         tuser_low[0] = (src_port << 24) | (src_port << 16) | (ulong)86;
         tkeep[10]    = (byte)0x3f;

         //pkt_size = 9;
      }
      return 10U;
   }

   // This procedure creates the DELETE response packet
   static public uint Memcached_DELETE(bool err)
   {
      ulong tmp = 0x00, tmp2 = 0x00;

      // DELETE - Fixed size of key(6B)
      if (!err)
      {
         tmp = ((ulong)(ulong)((IP_total_length >> 8) | (IP_total_length << 8 & (ulong)0x00ff00)) - (ulong)6) & (ulong)0x00ffff;
      }
      else              // add length of textual error code (8B)
      {
         tmp = ((ulong)(ulong)((IP_total_length >> 8) | (IP_total_length << 8 & (ulong)0x00ff00)) + (ulong)2) & (ulong)0x00ffff;
      }

      tmp2 = tdata[2] & (ulong)0xffffffffffff0000;
      Kiwi.Pause();
      tdata[2] = tmp2 | (tmp >> 8) | (tmp << 8 & (ulong)0x00ff00);
      Kiwi.Pause();

      // Set the checksum to 0x00, calculate later
      tmp = tdata[3] & (ulong)0xffffffffffff0000;
      Kiwi.Pause();
      tdata[3] = tmp;

      // DELETE - Fixed size of key(6B)
      if (!err)
      {
         tmp = ((ulong)(ulong)((UDP_total_length >> 8) | (UDP_total_length << 8 & (ulong)0x00ff00)) - (ulong)6);
      }
      else
      {
         tmp = ((ulong)(ulong)((UDP_total_length >> 8) | (UDP_total_length << 8 & (ulong)0x00ff00)) + (ulong)2);
      }

      tmp2 = tdata[4] & (ulong)0x0000ffffffffffff;
      Kiwi.Pause();
      tdata[4] = tmp2 | ((tmp & (ulong)0xff00) << 40) | (tmp << 56);
      Kiwi.Pause();

      // Reset the UDP checksum
      tmp = tdata[5];
      Kiwi.Pause();
      tdata[5] = tmp & ~(ulong)0x00ffff;
      Kiwi.Pause();

      tmp = tdata[6] & (ulong)0x00ffff;
      Kiwi.Pause();
      //set DELETE magic number + opcode
      tdata[6] = (ulong)Memcached.DELETE_op << 24 | (ulong)Memcached.RESPONSE << 16 | tmp;
      Kiwi.Pause();

      // Set the status code = key not found IPv4
      // and the opaque - DELETE response
      if (err)
      {
         tmp = (tdata[7] & 0xffff000000000000) | (ulong)0x0000080000000100;
      }
      else
      {
         tmp = (tdata[7] & 0xffff000000000000);
      }
      Kiwi.Pause();

      tdata[7] = tmp;
      Kiwi.Pause();

      // Fill up the rest of the response packet
      if (!err)
      {
         tmp = tdata[8] & 0x000000000000ffff;
         Kiwi.Pause();
         tdata[8] = tmp;
         Kiwi.Pause();

         tdata[9] = (ulong)0x00;
         // Set the correct metadata for the datapath
         // Fixed size response packet for  DELETE success
         tuser_low[0] = (src_port << 24) | (src_port << 16) | (ulong)74;
         tkeep[9]     = (byte)0x03;
         //pkt_size = 8;
         return 9U;
      }
      else
      {
         tmp = (tdata[8] & 0x000000000000ffff);
         Kiwi.Pause();
         tdata[8] = tmp;
         Kiwi.Pause();

         tdata[9] = Memcached.ERROR_MSG << 16;
         Kiwi.Pause();
         tdata[10] = Memcached.ERROR_MSG >> 48;
         // Set the correct metadata for the datapath
         // Fixed size response packet for DELETE failure
         tuser_low[0] = (src_port << 24) | (src_port << 16) | (ulong)82;
         tkeep[10]    = (byte)0x03;
         //pkt_size = 9;
         return 10U;
      }
   }

   // This procedure perform swap of multiple fields
   // dst_mac<->src_mac, dst_ip<->src_ip, dst_port<->src_port
   static void swap_multiple_fields(bool udp, bool icmp)
   {
      ulong tmp;
      bool  udp_tmp, icmp_tmp;

      udp_tmp  = udp;
      icmp_tmp = icmp;
      // Ethernet header swap
      tdata[0] = src_mac | (dst_mac << 48);
      Kiwi.Pause();
      tmp = (tdata[1] & (ulong)0xffffffff00000000) | dst_mac >> 16;
      Kiwi.Pause();
      tdata[1] = tmp;
      Kiwi.Pause();

      // IP header swap + UDP header swap
      tmp = (tdata[3] & (ulong)0x00ffff) | dst_ip << 16 | src_ip << 48;
      // tmp = dst_ip<<16 | src_ip<<48;
      Kiwi.Pause();
      tdata[3] = tmp;
      Kiwi.Pause();
      if (udp_tmp)
      {
         // Swap the ports, Memcached
         tmp = (tdata[4] & (ulong)0xffff000000000000) | src_ip >> 16 | app_src_port << 32 | app_dst_port << 16;
      }
      if (icmp_tmp)
      {
         // Set the ICMP echo reply type=0, code=0 and checksum=0x00
         tmp = (tdata[4] & (ulong)0xffff000000000000) | src_ip >> 16;
      }
      Kiwi.Pause();
      tdata[4] = tmp;
      Kiwi.Pause();
   }

   // The procedure is implemented as a separate thread and
   // will extract usefull data from the incoming stream
   // In order to utilize more the icoming process
   static public void Extract_headers(uint count, ulong data, ulong user)
   {
      cnt = 1U;
      ulong tdata, tuser;

//		while (true)
//		{
      cnt   = count;
      tdata = data;
      tuser = user;
//			Kiwi.Pause();

      switch (cnt)
      {
      //case 0U: break;
      // Start of the Ethernet header
      case 0U:
         dst_mac = tdata & (ulong)0x0000ffffffffffff;
         src_mac = tdata >> 48 & (ulong)0x00ffff;
         // metadata ports - NOT UDP ports
         src_port = ((tuser >> 16) & 0xff);
         dst_port = ((tuser >> 24) & 0xff);
         break;

      case 1U:
         src_mac |= (tdata & (ulong)0x00ffffffff) << 16;
         IPv4     = ((tdata >> 32 & (ulong)0x00ffff) == (ulong)0x0008) && ((tdata >> 52 & (ulong)0x0f) == (ulong)0x04);
         break;

      case 2U:
         proto_ICMP      = (tdata >> 56 & (ulong)0x00ff) == (ulong)0x0001;
         proto_UDP       = (tdata >> 56 & (ulong)0x00ff) == (ulong)0x0011;
         IP_total_length = (tdata & (ulong)0x00ffff);
         break;

//				// Start of the IP header
      case 3U:
         src_ip = (tdata >> 16) & (ulong)0x00ffffffff;
         dst_ip = (tdata >> 48) & (ulong)0x00ffff;
         break;

//				// Start of the UDP header
      case 4U:
         dst_ip          |= (tdata & (ulong)0x00ffff) << 16;
         app_src_port     = (tdata >> 16 & (ulong)0x00ffff);
         app_dst_port     = (tdata >> 32 & (ulong)0x00ffff);
         UDP_total_length = (tdata >> 48 & (ulong)0x00ffff);
         ICMP_code_type   = (tdata >> 16 & (ulong)0x00ffff);
         break;

//				// Start of the UDP frame & Memcached Header
      case 6U:
         magic_num = (byte)(tdata >> 16 & (ulong)0x00ff);
         opcode    = (byte)(tdata >> 24 & (ulong)0x00ff);
         // Little endianess to big
         key_length    = (uint)(tdata >> 16 & (ulong)0x00ff00) | (uint)(tdata >> 40 & (ulong)0x00ff);
         extras_length = (byte)(tdata >> 48 & (ulong)0x00ff);
         break;

////				else if (segm_num==7){
////					opaque = s_axis_tdata<<48;
////				}
////				else if (segm_num==8){
////					opaque |= (s_axis_tdata & (ulong)0x00ffff)<<16;
////				}
//				// Start of the Memcached payload
      case 9U:
         if ((magic_num == (byte)0x80) && ((opcode == (byte)0x00) || (opcode == (byte)0x04)))
         {
            key = (ulong)(tdata & (ulong)0xffffffffffff0000);
         }
         if ((magic_num == (byte)0x80) && (opcode == (byte)0x01))
         {
            extras = tdata << 16;
         }
         break;

//				// Start of the key
//				// Currently fixed-length of the key is 6 Bytes and 8 Bytes for the value
//				// Extras(Flags/Expiration) fixed length 8 Bytes
      case 10U:
         if ((magic_num == (byte)0x80) && (opcode == (byte)0x01))
         {
            key     = (ulong)(tdata & (ulong)0xffffffffffff0000);
            extras |= tdata & (ulong)0x00ffff;
         }
         break;

      case 11U:
         if ((magic_num == (byte)0x80) && (opcode == (byte)0x01))
         {
            key_value = tdata;
         }
         break;

      default:
         break;
      }
//		}
   }

   // This method describes the operations required to rx a frame over the AXI4-Stream.
   // and extract basic information such as dst_MAC, src_MAC, dst_port, src_port
   new protected static uint ReceiveFrame()
   {
      m_axis_tdata     = (ulong)0x0;
      m_axis_tkeep     = (byte)0x0;
      m_axis_tlast     = false;
      m_axis_tvalid    = false;
      m_axis_tuser_hi  = (ulong)0x0;
      m_axis_tuser_low = (ulong)0x0;
      s_axis_tready    = true;

      segm_num    = 0U;
      icmp_header = false;
      //num = (uint)0x01;
      Kiwi.Pause();

      // The start condition
      uint  cnt         = 0;
      uint  psize       = 0;
      bool  start       = s_axis_tvalid && s_axis_tready;
      bool  doneReading = true;
      bool  receive     = s_axis_tvalid;
      ulong data        = 0x00;
      byte  data2       = 0x00;
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

            tdata[cnt]     = s_axis_tdata;
            tkeep[cnt]     = s_axis_tkeep;
            tlast[cnt]     = s_axis_tlast;
            tuser_hi[cnt]  = s_axis_tuser_hi;
            tuser_low[cnt] = s_axis_tuser_low;

            segm_num   += 1U;
            psize       = cnt++;
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
 *              if(data2==0x01){	tdata[psize] = data & (ulong)0x00ff; Kiwi.Pause();}
 *              else if(data2==0x03){	tdata[psize] = data & (ulong)0x00ffff; Kiwi.Pause();}
 *              else if(data2==0x07){	tdata[psize] = data & (ulong)0x00ffffff; Kiwi.Pause();}
 *              else if(data2==0x0f){	tdata[psize] = data & (ulong)0x00ffffffff; Kiwi.Pause();}
 *              else if(data2==0x1f){	tdata[psize] = data & (ulong)0x00ffffffffff; Kiwi.Pause();}
 *              else if(data2==0x3f){	tdata[psize] = data & (ulong)0x00ffffffffffff; Kiwi.Pause();}
 *              else if(data2==0x7f){	tdata[psize] = data & (ulong)0x00ffffffffffffff; Kiwi.Pause();}
 *              else{;}
 */
      switch (data2)
      {
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

      s_axis_tready = false;
      cnt           = 0;
      segm_num      = 0;
      //last = false;
      //start = false;
      return psize;
   }

   [Kiwi.HardwareEntryPoint()]
   static int EntryPoint()
   {
      while (true) { SwitchLogic(); }
   }

   static int Main()
   {
      System.Console.WriteLine("This program cannot be executed in software yet!"); // FIXME
      return -1;
   }
}
