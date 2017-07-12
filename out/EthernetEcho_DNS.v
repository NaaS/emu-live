

// CBG Orangepath HPR L/S System

// Verilog output file generated at 10/05/2016 10:10:35
// Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 2.03b Interim: 14-Apr-2016 Unix 3.19.0.49
//  /root/kiwi/kiwipro/kiwic/distro/lib/kiwic.exe EthernetEcho.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-no-dram-ports=0 -restructure2=disable -vnl EthernetEcho.v
`timescale 1ns/10ps


module EthernetEcho(    input [63:0] s_axis_tdata,
    input [7:0] s_axis_tkeep,
    input s_axis_tlast,
    input s_axis_tvalid,
    output reg s_axis_tready,
    input [63:0] s_axis_tuser_hi,
    input [63:0] s_axis_tuser_low,
    output reg [63:0] m_axis_tdata,
    output reg [7:0] m_axis_tkeep,
    output reg m_axis_tlast,
    output reg m_axis_tvalid,
    input m_axis_tready,
    output reg [63:0] m_axis_tuser_hi,
    output reg [63:0] m_axis_tuser_low,
    input cam_busy,
    input cam_match,
    input [7:0] cam_match_addr,
    output reg [63:0] cam_cmp_din,
    output reg [63:0] cam_din,
    output reg cam_we,
    output reg [7:0] cam_wr_addr,
    input clk,
    input reset);
  reg LoEthernetEcho_IPv4;
  reg LoEthernetEcho_proto_UDP;
  reg LoEthernetEcho_proto_ICMP;
  reg [7:0] LoEthernetEcho_last_tkeep;
  reg LoEthernetEcho_exist_rest;
  reg [63:0] LoEthernetEcho_chksum_UDP;
  reg [63:0] LoEthernetEcho_chksumIP;
  reg [63:0] TLEsw1_1_V_2;
  reg [63:0] TLEsw1_1_V_3;
  reg [31:0] TLEsw1_1_V_4;
  reg [31:0] TLEsw1_1_V_5;
  reg [31:0] TLEsw1_1_V_9;
  reg [31:0] TLEsw1_1_V_10;
  reg TLEsw1_1_V_11;
  reg TLEsw1_1_V_12;
  reg TLEsw1_1_V_13;
  reg [31:0] TLERe1_1_V_0;
  reg [31:0] TLERe1_1_V_1;
  reg TLERe1_1_V_3;
  reg [63:0] TLERe1_1_V_5;
  reg [7:0] TLERe1_1_V_6;
  reg [7:0] TLEca6_0_V_0;
  reg [63:0] TLEca6_0_V_1;
  reg [63:0] TLEca6_0_V_6;
  reg [63:0] TLEca6_0_V_7;
  reg [63:0] TLEca6_0_V_12;
  reg [63:0] TLEsw9_10_V_0;
  reg TLEsw9_10_V_1;
  reg TLEsw9_10_V_2;
  reg [7:0] TLEca27_14_V_0;
  reg [63:0] TLEca27_14_V_1;
  reg [63:0] TLEca27_14_V_6;
  reg [63:0] TLEca27_14_V_7;
  reg [63:0] TLEca27_14_V_12;
  reg [63:0] TLEca31_5_V_4;
  reg [63:0] TLEca31_5_V_5;
  reg [63:0] TLEca31_5_V_7;
  reg [63:0] TLEca33_17_V_4;
  reg [63:0] TLEca33_17_V_5;
  reg [63:0] TLEca33_17_V_7;
  reg [63:0] TLEca33_20_V_4;
  reg [63:0] TLEca33_20_V_5;
  reg [63:0] TLEca33_20_V_7;
  reg [31:0] TLESe34_3_V_0;
  reg [31:0] TLESe34_3_V_1;
  reg LoEthernetEcho_one_question;
  reg LoEthernetEcho_std_query;
  reg [63:0] LoEthernetEcho_dst_mac;
  reg [63:0] LoEthernetEcho_src_mac;
  reg [63:0] LoEthernetEcho_dst_ip;
  reg [63:0] LoEthernetEcho_src_ip;
  reg [63:0] LoEthernetEcho_app_src_port;
  reg [63:0] LoEthernetEcho_app_dst_port;
  reg [63:0] LoEthernetEcho_tmp;
  reg [63:0] LoEthernetEcho_tmp1;
  reg [63:0] LoEthernetEcho_tmp2;
  reg [63:0] LoEthernetEcho_tmp3;
  reg [63:0] LoEthernetEcho_tmp4;
  reg [63:0] LoEthernetEcho_tmp5;
  reg LoEthernetEcho_start_parsing;
  reg [63:0] LoEthernetEcho_IP_total_length;
  reg [63:0] LoEthernetEcho_UDP_total_length;
  reg [63:0] LoEthernetEcho_src_port;
  reg [7:0] A_8_US_CC_SCALbx24_ARA0[63:0];
  reg [31:0] A_UINT_CC_SCALbx22_ARA0[6:0];
  reg [63:0] A_64_US_CC_SCALbx10_ARA0[63:0];
  reg [63:0] A_64_US_CC_SCALbx12_ARB0[63:0];
  reg [63:0] A_64_US_CC_SCALbx14_ARC0[63:0];
  reg [63:0] A_64_US_CC_SCALbx16_ARD0[6:0];
  reg [63:0] A_64_US_CC_SCALbx18_ARE0[6:0];
  reg [63:0] A_64_US_CC_SCALbx20_ARF0[6:0];
  reg [5:0] xpc10;
  wire [63:0] hprpin161810;
  wire [63:0] hprpin162310;
  wire [63:0] hprpin176810;
  wire [63:0] hprpin177310;
  wire [63:0] hprpin182110;
  wire [63:0] hprpin182610;
  wire [63:0] hprpin184210;
  wire [63:0] hprpin184710;
 always   @(posedge clk )  begin 
      //Start structure HPR EthernetEcho.dll
      if (reset)  begin 
               cam_wr_addr <= 8'd0;
               cam_we <= 1'd0;
               cam_din <= 64'd0;
               cam_cmp_din <= 64'd0;
               TLERe1_1_V_6 <= 8'd0;
               TLERe1_1_V_5 <= 64'd0;
               TLERe1_1_V_3 <= 1'd0;
               TLERe1_1_V_1 <= 32'd0;
               LoEthernetEcho_last_tkeep <= 8'd0;
               TLERe1_1_V_0 <= 32'd0;
               TLEsw1_1_V_13 <= 1'd0;
               TLEsw1_1_V_12 <= 1'd0;
               TLEsw1_1_V_11 <= 1'd0;
               TLEca6_0_V_7 <= 64'd0;
               TLEca6_0_V_6 <= 64'd0;
               TLEsw9_10_V_2 <= 1'd0;
               TLEsw9_10_V_1 <= 1'd0;
               TLEca6_0_V_1 <= 64'd0;
               TLEca6_0_V_0 <= 8'd0;
               TLEca6_0_V_12 <= 64'd0;
               TLEsw9_10_V_0 <= 64'd0;
               LoEthernetEcho_tmp4 <= 64'd0;
               TLEsw1_1_V_10 <= 32'd0;
               TLEsw1_1_V_5 <= 32'd0;
               LoEthernetEcho_tmp5 <= 64'd0;
               LoEthernetEcho_tmp1 <= 64'd0;
               TLEca27_14_V_7 <= 64'd0;
               TLEca27_14_V_6 <= 64'd0;
               LoEthernetEcho_chksumIP <= 64'd0;
               TLEca27_14_V_1 <= 64'd0;
               TLEca27_14_V_0 <= 8'd0;
               TLEca27_14_V_12 <= 64'd0;
               TLEca33_17_V_5 <= 64'd0;
               TLEca33_17_V_4 <= 64'd0;
               TLEca33_17_V_7 <= 64'd0;
               TLEca33_20_V_5 <= 64'd0;
               TLEca33_20_V_4 <= 64'd0;
               TLEca33_20_V_7 <= 64'd0;
               TLESe34_3_V_1 <= 32'd0;
               s_axis_tready <= 1'd0;
               LoEthernetEcho_exist_rest <= 1'd0;
               TLEsw1_1_V_9 <= 32'd0;
               m_axis_tvalid <= 1'd0;
               TLESe34_3_V_0 <= 32'd0;
               m_axis_tuser_low <= 64'd0;
               m_axis_tuser_hi <= 64'd0;
               m_axis_tlast <= 1'd0;
               m_axis_tkeep <= 8'd0;
               m_axis_tdata <= 64'd0;
               TLEca31_5_V_5 <= 64'd0;
               TLEca31_5_V_4 <= 64'd0;
               TLEca31_5_V_7 <= 64'd0;
               LoEthernetEcho_tmp3 <= 64'd0;
               LoEthernetEcho_chksum_UDP <= 64'd0;
               LoEthernetEcho_tmp2 <= 64'd0;
               LoEthernetEcho_tmp <= 64'd0;
               LoEthernetEcho_start_parsing <= 1'd0;
               LoEthernetEcho_std_query <= 1'd0;
               LoEthernetEcho_one_question <= 1'd0;
               LoEthernetEcho_UDP_total_length <= 64'd0;
               LoEthernetEcho_app_dst_port <= 64'd0;
               LoEthernetEcho_app_src_port <= 64'd0;
               LoEthernetEcho_dst_ip <= 64'd0;
               LoEthernetEcho_src_ip <= 64'd0;
               LoEthernetEcho_IP_total_length <= 64'd0;
               LoEthernetEcho_proto_UDP <= 1'd0;
               LoEthernetEcho_proto_ICMP <= 1'd0;
               LoEthernetEcho_IPv4 <= 1'd0;
               xpc10 <= 6'd0;
               TLEsw1_1_V_3 <= 64'd0;
               TLEsw1_1_V_2 <= 64'd0;
               TLEsw1_1_V_4 <= 32'd0;
               LoEthernetEcho_src_port <= 64'd0;
               LoEthernetEcho_src_mac <= 64'd0;
               LoEthernetEcho_dst_mac <= 64'd0;
               end 
               else  begin 
              
              case (xpc10)
                  0/*0:US*/:  begin 
                       xpc10 <= 1'd1/*1:xpc10:1*/;
                       s_axis_tready <= 1'd1;
                       m_axis_tuser_low <= 32'd0;
                       m_axis_tuser_hi <= 32'd0;
                       m_axis_tvalid <= 1'd0;
                       m_axis_tlast <= 1'd0;
                       m_axis_tkeep <= 8'd0;
                       m_axis_tdata <= 32'd0;
                       TLEsw1_1_V_13 <= 1'd0;
                       TLEsw1_1_V_12 <= 1'd0;
                       TLEsw1_1_V_11 <= 1'd0;
                       TLEsw1_1_V_10 <= 32'd0;
                       TLEsw1_1_V_9 <= 32'd0;
                       TLEsw1_1_V_5 <= 32'd0;
                       TLEsw1_1_V_4 <= 32'd0;
                       LoEthernetEcho_chksumIP <= 32'd0;
                       LoEthernetEcho_chksum_UDP <= 32'd0;
                       LoEthernetEcho_exist_rest <= 1'd0;
                       LoEthernetEcho_last_tkeep <= 8'd0;
                       LoEthernetEcho_proto_ICMP <= 1'd0;
                       LoEthernetEcho_proto_UDP <= 1'd0;
                       LoEthernetEcho_IPv4 <= 1'd0;
                       cam_wr_addr <= 8'd0;
                       cam_we <= 1'd0;
                       cam_din <= 32'd0;
                       cam_cmp_din <= 32'h_ffff_ffff;
                       A_UINT_CC_SCALbx22_ARA0[3'd6] <= 32'h600_a8c0;
                       A_UINT_CC_SCALbx22_ARA0[3'd5] <= 32'h500_a8c0;
                       A_UINT_CC_SCALbx22_ARA0[3'd4] <= 32'h400_a8c0;
                       A_UINT_CC_SCALbx22_ARA0[2'd3] <= 32'h300_a8c0;
                       A_UINT_CC_SCALbx22_ARA0[2'd2] <= 32'h200_a8c0;
                       A_UINT_CC_SCALbx22_ARA0[1'd1] <= 32'h100_a8c0;
                       A_UINT_CC_SCALbx22_ARA0[0] <= 32'h_a8c0;
                       A_64_US_CC_SCALbx16_ARD0[3'd6] <= 64'h1_0000_6772_6f03;
                       A_64_US_CC_SCALbx16_ARD0[3'd5] <= 64'd0;
                       A_64_US_CC_SCALbx16_ARD0[3'd4] <= 64'h1_0001_0000_6b75;
                       A_64_US_CC_SCALbx16_ARD0[2'd3] <= 64'h1_0000_6d6f_6303;
                       A_64_US_CC_SCALbx16_ARD0[2'd2] <= 64'h100_0100;
                       A_64_US_CC_SCALbx16_ARD0[1'd1] <= 64'h100_0100;
                       A_64_US_CC_SCALbx16_ARD0[0] <= 64'd256;
                       A_64_US_CC_SCALbx18_ARE0[3'd6] <= 64'h_6566_696c_646c_6977;
                       A_64_US_CC_SCALbx18_ARE0[3'd5] <= 64'h1_0100;
                       A_64_US_CC_SCALbx18_ARE0[3'd4] <= 64'h263_6f02_6567_6469;
                       A_64_US_CC_SCALbx18_ARE0[2'd3] <= 64'h_6563_6976_7265_736e;
                       A_64_US_CC_SCALbx18_ARE0[2'd2] <= 64'h6b_7502_6361_026d;
                       A_64_US_CC_SCALbx18_ARE0[1'd1] <= 64'h6d_6f63_036b_6f6f;
                       A_64_US_CC_SCALbx18_ARE0[0] <= 64'h100_006d_6f63_0365;
                       A_64_US_CC_SCALbx20_ARF0[3'd6] <= 64'h_646c_726f_770c_7777;
                       A_64_US_CC_SCALbx20_ARF0[3'd5] <= 64'h_7267_026e_6902_7777;
                       A_64_US_CC_SCALbx20_ARF0[3'd4] <= 64'h_7262_6d61_6309_7777;
                       A_64_US_CC_SCALbx20_ARF0[2'd3] <= 64'h_6f64_6e6f_6c0c_7777;
                       A_64_US_CC_SCALbx20_ARF0[2'd2] <= 64'h_6163_036c_6302_7777;
                       A_64_US_CC_SCALbx20_ARF0[1'd1] <= 64'h_6265_6361_6608_7777;
                       A_64_US_CC_SCALbx20_ARF0[0] <= 64'h_6c67_6f6f_6706_7777;
                       end 
                      
                  1'd1/*1:US*/:  begin 
                      if (s_axis_tvalid && s_axis_tlast)  begin 
                               xpc10 <= 2'd2/*2:xpc10:2*/;
                               s_axis_tready <= 1'd0;
                               TLERe1_1_V_3 <= 1'd0;
                               TLERe1_1_V_1 <= 32'd0;
                               TLERe1_1_V_0 <= 32'd1;
                               TLERe1_1_V_6 <= 8'd0;
                               TLERe1_1_V_5 <= 32'd0;
                               A_64_US_CC_SCALbx10_ARA0[32'd0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                               A_8_US_CC_SCALbx24_ARA0[32'd0] <= 8'hff&s_axis_tkeep;
                               A_64_US_CC_SCALbx14_ARC0[32'd0] <= 64'hffffffffffffffff&s_axis_tdata;
                               end 
                              if (s_axis_tvalid && !s_axis_tlast)  begin 
                               xpc10 <= 2'd2/*2:xpc10:2*/;
                               s_axis_tready <= 1'd1;
                               TLERe1_1_V_3 <= 1'h1&s_axis_tvalid;
                               TLERe1_1_V_1 <= 32'd0;
                               TLERe1_1_V_0 <= 32'd1;
                               TLERe1_1_V_6 <= 8'd0;
                               TLERe1_1_V_5 <= 32'd0;
                               A_64_US_CC_SCALbx10_ARA0[32'd0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                               A_8_US_CC_SCALbx24_ARA0[32'd0] <= 8'hff&s_axis_tkeep;
                               A_64_US_CC_SCALbx14_ARC0[32'd0] <= 64'hffffffffffffffff&s_axis_tdata;
                               end 
                              if (!s_axis_tvalid)  begin 
                               xpc10 <= 2'd2/*2:xpc10:2*/;
                               TLERe1_1_V_3 <= 1'd1;
                               TLERe1_1_V_0 <= 32'd0;
                               TLERe1_1_V_6 <= 8'd0;
                               TLERe1_1_V_5 <= 32'd0;
                               TLERe1_1_V_1 <= 32'd0;
                               end 
                               end 
                      
                  2'd2/*2:US*/:  begin 
                      if (s_axis_tvalid && s_axis_tlast && TLERe1_1_V_3)  begin 
                               s_axis_tready <= 1'd0;
                               TLERe1_1_V_3 <= 1'd0;
                               TLERe1_1_V_1 <= TLERe1_1_V_0;
                               TLERe1_1_V_0 <= 32'd1+(32'hffffffff&TLERe1_1_V_0);
                               A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                               A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                               A_8_US_CC_SCALbx24_ARA0[32'hffffffff&TLERe1_1_V_0] <= 8'hff&s_axis_tkeep;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                               end 
                              if (s_axis_tvalid && !s_axis_tlast && TLERe1_1_V_3)  begin 
                               s_axis_tready <= 1'd1;
                               TLERe1_1_V_3 <= 1'h1&s_axis_tvalid;
                               TLERe1_1_V_1 <= TLERe1_1_V_0;
                               TLERe1_1_V_0 <= 32'd1+(32'hffffffff&TLERe1_1_V_0);
                               A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                               A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                               A_8_US_CC_SCALbx24_ARA0[32'hffffffff&TLERe1_1_V_0] <= 8'hff&s_axis_tkeep;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                               end 
                              if (!TLERe1_1_V_3)  begin 
                               xpc10 <= 2'd3/*3:xpc10:3*/;
                               TLERe1_1_V_6 <= A_8_US_CC_SCALbx24_ARA0[8'h1*(32'hffffffff&TLERe1_1_V_1)];
                               TLERe1_1_V_5 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1];
                               end 
                               end 
                      
                  2'd3/*3:US*/:  begin 
                      
                      case (TLERe1_1_V_6)
                          1'd1/*1:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd1;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'd255&TLERe1_1_V_5;
                               end 
                              
                          2'd2/*2:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd0;
                               end 
                              
                          2'd3/*3:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd2;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'h_ffff&TLERe1_1_V_5;
                               end 
                              
                          3'd7/*7:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd3;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'hff_ffff&TLERe1_1_V_5;
                               end 
                              
                          4'd15/*15:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd4;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&32'h_ffff_ffff&TLERe1_1_V_5
                              ;

                               end 
                              
                          5'd31/*31:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd5;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'hff_ffff_ffff&TLERe1_1_V_5
                              ;

                               end 
                              
                          6'd63/*63:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd6;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'h_ffff_ffff_ffff&TLERe1_1_V_5
                              ;

                               end 
                              
                          7'd127/*127:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd7;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'hff_ffff_ffff_ffff&TLERe1_1_V_5
                              ;

                               end 
                              endcase
                      if ((TLERe1_1_V_6!=3'd7/*7:US*/) && (TLERe1_1_V_6!=4'd15/*15:US*/) && (TLERe1_1_V_6!=5'd31/*31:US*/) && (TLERe1_1_V_6
                      !=6'd63/*63:US*/) && (TLERe1_1_V_6!=7'd127/*127:US*/) && (TLERe1_1_V_6!=1'd1/*1:US*/) && (TLERe1_1_V_6!=2'd2/*2:US*/) && 
                      (TLERe1_1_V_6!=2'd3/*3:US*/))  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               LoEthernetEcho_last_tkeep <= 8'd0;
                               end 
                               end 
                      
                  3'd4/*4:US*/: if (((32'hffffffff&TLERe1_1_V_1)<32'd0))  begin 
                           xpc10 <= 3'd5/*5:xpc10:5*/;
                           TLEsw1_1_V_4 <= 32'd0;
                           TLEsw1_1_V_9 <= TLERe1_1_V_1;
                           TLERe1_1_V_0 <= 32'd0;
                           s_axis_tready <= 1'd0;
                           end 
                           else  begin 
                           xpc10 <= 6'd51/*51:xpc10:51*/;
                           TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'd0];
                           TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                           TLEsw1_1_V_4 <= 32'd0;
                           TLEsw1_1_V_9 <= TLERe1_1_V_1;
                           TLERe1_1_V_0 <= 32'd0;
                           s_axis_tready <= 1'd0;
                           end 
                          
                  4'd8/*8:US*/:  begin 
                      if (LoEthernetEcho_one_question && LoEthernetEcho_std_query && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==
                      (64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                      &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                      &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 4'd9/*9:xpc10:9*/;
                               TLEsw9_10_V_2 <= 1'h1&TLEsw1_1_V_13;
                               TLEsw9_10_V_1 <= 1'h1&TLEsw1_1_V_12;
                               LoEthernetEcho_exist_rest <= 1'd0;
                               LoEthernetEcho_chksumIP <= 32'd0;
                               LoEthernetEcho_chksum_UDP <= 32'd0;
                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               A_64_US_CC_SCALbx14_ARC0[0] <= 64'hffffffffffffffff&LoEthernetEcho_src_mac|{LoEthernetEcho_dst_mac, 48'd0
                              };

                               end 
                              if ((2'd2/*2:MS*/==(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 3'd7/*7:xpc10:7*/;
                               TLEca6_0_V_1 <= A_64_US_CC_SCALbx14_ARC0[8'hff&8'd1+TLEca6_0_V_0];
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4>=(8'hff&8'd1+TLEca6_0_V_0)) && (1'd1/*1:MS*/!=(8'hff&8'd1+TLEca6_0_V_0)) && (2'd2/*2:MS*/!=(8'hff
                      &8'd1+TLEca6_0_V_0)) && (2'd3/*3:MS*/!=(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 3'd7/*7:xpc10:7*/;
                               TLEca6_0_V_1 <= 32'd0;
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((2'd3/*3:MS*/==(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 3'd7/*7:xpc10:7*/;
                               TLEca6_0_V_1 <= A_64_US_CC_SCALbx14_ARC0[8'hff&8'd1+TLEca6_0_V_0];
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4>=(8'hff&8'd1+TLEca6_0_V_0)) && (3'd4/*4:MS*/==(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 3'd7/*7:xpc10:7*/;
                               TLEca6_0_V_1 <= {A_64_US_CC_SCALbx14_ARC0[64'd4], 48'd0};
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((1'd1/*1:MS*/==(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 3'd7/*7:xpc10:7*/;
                               TLEca6_0_V_1 <= (A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd48);
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && !(1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff
                      ^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16))>>5'd16))))))  begin 
                               xpc10 <= 6'd41/*41:xpc10:41*/;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if (!LoEthernetEcho_one_question && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff
                      &64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6
                      +TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6
                      +TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 6'd41/*41:xpc10:41*/;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if (LoEthernetEcho_one_question && !LoEthernetEcho_std_query && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1
                      &(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                      &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                      &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 6'd41/*41:xpc10:41*/;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                               end 
                      
                  5'd18/*18:US*/:  begin 
                      if ((LoEthernetEcho_tmp!=LoEthernetEcho_tmp1) && ((32'hffffffff&32'd1+TLEsw1_1_V_4)<3'd7))  begin 
                               LoEthernetEcho_tmp4 <= A_64_US_CC_SCALbx14_ARC0[64'd8];
                               LoEthernetEcho_tmp3 <= A_64_US_CC_SCALbx16_ARD0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               LoEthernetEcho_tmp2 <= A_64_US_CC_SCALbx18_ARE0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               LoEthernetEcho_tmp1 <= A_64_US_CC_SCALbx20_ARF0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_tmp==LoEthernetEcho_tmp1) && (TLEsw1_1_V_9!=4'd9/*9:US*/))  begin 
                               xpc10 <= 5'd20/*20:xpc10:20*/;
                               LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[3'd5];
                               TLEsw1_1_V_10 <= 64'h_ffff&A_64_US_CC_SCALbx10_ARA0[0];
                               TLEsw1_1_V_5 <= TLEsw1_1_V_4;
                               LoEthernetEcho_exist_rest <= 1'h1&(LoEthernetEcho_tmp2==LoEthernetEcho_tmp4);
                               end 
                              if ((LoEthernetEcho_tmp!=LoEthernetEcho_tmp1) && ((32'hffffffff&32'd1+TLEsw1_1_V_4)>=3'd7))  begin 
                               xpc10 <= 5'd20/*20:xpc10:20*/;
                               LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[3'd5];
                               TLEsw1_1_V_10 <= 64'h_ffff&A_64_US_CC_SCALbx10_ARA0[0];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_tmp==LoEthernetEcho_tmp1) && (TLEsw1_1_V_9==4'd9/*9:US*/))  begin 
                               xpc10 <= 5'd19/*19:xpc10:19*/;
                               LoEthernetEcho_tmp5 <= A_64_US_CC_SCALbx14_ARC0[64'd9];
                               end 
                               end 
                      
                  5'd31/*31:US*/:  begin 
                      if ((2'd2/*2:MS*/==(8'hff&8'd1+TLEca27_14_V_0)))  begin 
                               xpc10 <= 5'd30/*30:xpc10:30*/;
                               TLEca27_14_V_1 <= A_64_US_CC_SCALbx14_ARC0[8'hff&8'd1+TLEca27_14_V_0];
                               TLEca27_14_V_0 <= 8'd1+TLEca27_14_V_0;
                               TLEca27_14_V_12 <= (64'h_ffff&TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7
                              )+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16)))+(TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6
                              +TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4>=(8'hff&8'd1+TLEca27_14_V_0)) && (1'd1/*1:MS*/!=(8'hff&8'd1+TLEca27_14_V_0)) && (2'd2/*2:MS*/!=
                      (8'hff&8'd1+TLEca27_14_V_0)) && (2'd3/*3:MS*/!=(8'hff&8'd1+TLEca27_14_V_0)))  begin 
                               xpc10 <= 5'd30/*30:xpc10:30*/;
                               TLEca27_14_V_1 <= 32'd0;
                               TLEca27_14_V_0 <= 8'd1+TLEca27_14_V_0;
                               TLEca27_14_V_12 <= (64'h_ffff&TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7
                              )+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16)))+(TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6
                              +TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16))>>5'd16);

                               end 
                              if ((2'd3/*3:MS*/==(8'hff&8'd1+TLEca27_14_V_0)))  begin 
                               xpc10 <= 5'd30/*30:xpc10:30*/;
                               TLEca27_14_V_1 <= A_64_US_CC_SCALbx14_ARC0[8'hff&8'd1+TLEca27_14_V_0];
                               TLEca27_14_V_0 <= 8'd1+TLEca27_14_V_0;
                               TLEca27_14_V_12 <= (64'h_ffff&TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7
                              )+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16)))+(TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6
                              +TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4>=(8'hff&8'd1+TLEca27_14_V_0)) && (3'd4/*4:MS*/==(8'hff&8'd1+TLEca27_14_V_0)))  begin 
                               xpc10 <= 5'd30/*30:xpc10:30*/;
                               TLEca27_14_V_1 <= {A_64_US_CC_SCALbx14_ARC0[64'd4], 48'd0};
                               TLEca27_14_V_0 <= 8'd1+TLEca27_14_V_0;
                               TLEca27_14_V_12 <= (64'h_ffff&TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7
                              )+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16)))+(TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6
                              +TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16))>>5'd16);

                               end 
                              if ((1'd1/*1:MS*/==(8'hff&8'd1+TLEca27_14_V_0)))  begin 
                               xpc10 <= 5'd30/*30:xpc10:30*/;
                               TLEca27_14_V_1 <= (A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd48);
                               TLEca27_14_V_0 <= 8'd1+TLEca27_14_V_0;
                               TLEca27_14_V_12 <= (64'h_ffff&TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7
                              )+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16)))+(TLEca27_14_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_6
                              +TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4<(8'hff&8'd1+TLEca27_14_V_0)))  begin 
                               xpc10 <= 6'd32/*32:xpc10:32*/;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16)))+(TLEca27_14_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16))>>5'd16));

                               TLEca27_14_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca27_14_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16)))+(TLEca27_14_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca27_14_V_6+TLEca27_14_V_7)+(TLEca27_14_V_6+TLEca27_14_V_7>>5'd16))>>5'd16));

                               TLEca27_14_V_0 <= 8'd1+TLEca27_14_V_0;
                               end 
                               end 
                      
                  6'd41/*41:US*/:  begin 
                      if (!m_axis_tready && ((32'hffffffff&TLEsw1_1_V_9)>=32'd0))  begin 
                               xpc10 <= 6'd43/*43:xpc10:43*/;
                               TLESe34_3_V_1 <= TLEsw1_1_V_9;
                               TLESe34_3_V_0 <= 32'd0;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd1;
                               end 
                              if (m_axis_tready && ((32'hffffffff&TLEsw1_1_V_9)>=32'd0))  begin 
                               xpc10 <= 6'd43/*43:xpc10:43*/;
                               TLESe34_3_V_0 <= 32'd1;
                               m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[0];
                               m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[64'd0];
                               m_axis_tlast <= 1'h1&(TLEsw1_1_V_9==0/*0:US*/);
                               m_axis_tkeep <= A_8_US_CC_SCALbx24_ARA0[8'd0];
                               m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                               TLESe34_3_V_1 <= TLEsw1_1_V_9;
                               m_axis_tvalid <= 1'd1;
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_9)<32'd0))  begin 
                               xpc10 <= 6'd42/*42:xpc10:42*/;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd0;
                               TLESe34_3_V_1 <= TLEsw1_1_V_9;
                               TLESe34_3_V_0 <= 32'd0;
                               end 
                               end 
                      
                  6'd42/*42:US*/:  begin 
                       xpc10 <= 1'd1/*1:xpc10:1*/;
                       s_axis_tready <= 1'd1;
                       m_axis_tuser_low <= 32'd0;
                       m_axis_tuser_hi <= 32'd0;
                       m_axis_tvalid <= 1'd0;
                       m_axis_tlast <= 1'd0;
                       m_axis_tkeep <= 8'd0;
                       m_axis_tdata <= 32'd0;
                       LoEthernetEcho_exist_rest <= 1'd0;
                       TLEsw1_1_V_9 <= 32'd0;
                       LoEthernetEcho_chksum_UDP <= 32'd0;
                       LoEthernetEcho_proto_ICMP <= 1'd0;
                       LoEthernetEcho_proto_UDP <= 1'd0;
                       LoEthernetEcho_IPv4 <= 1'd0;
                       LoEthernetEcho_start_parsing <= 1'd0;
                       LoEthernetEcho_std_query <= 1'd0;
                       LoEthernetEcho_one_question <= 1'd0;
                       end 
                      
                  6'd43/*43:US*/:  begin 
                      if ((TLESe34_3_V_1<TLESe34_3_V_0))  begin 
                               xpc10 <= 6'd42/*42:xpc10:42*/;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd0;
                               end 
                              if (m_axis_tready && (TLESe34_3_V_1>=TLESe34_3_V_0))  begin 
                               TLESe34_3_V_0 <= 32'd1+TLESe34_3_V_0;
                               m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[0];
                               m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[64'd0];
                               m_axis_tlast <= 1'h1&(TLEsw1_1_V_9==TLESe34_3_V_0);
                               m_axis_tkeep <= A_8_US_CC_SCALbx24_ARA0[8'h1*(32'hffffffff&TLESe34_3_V_0)];
                               m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLESe34_3_V_0];
                               end 
                               end 
                      
                  6'd45/*45:US*/:  begin 
                      if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               xpc10 <= 6'd35/*35:xpc10:35*/;
                               LoEthernetEcho_tmp2 <= LoEthernetEcho_dst_ip|{LoEthernetEcho_src_ip, 32'd0};
                               LoEthernetEcho_tmp3 <= 64'h_1100|(-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[64'd4]);
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca31_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca31_5_V_4+TLEca31_5_V_5
                              )+(TLEca31_5_V_4+TLEca31_5_V_5>>5'd16)))+(TLEca31_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca31_5_V_4+
                              TLEca31_5_V_5)+(TLEca31_5_V_4+TLEca31_5_V_5>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && (3'd4/*4:MS*/==(32'hffffffff&32'd1+TLEsw1_1_V_4
                      )))  begin 
                               xpc10 <= 6'd44/*44:xpc10:44*/;
                               LoEthernetEcho_tmp2 <= (A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4]>>5'd16);
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca31_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca31_5_V_4+TLEca31_5_V_5
                              )+(TLEca31_5_V_4+TLEca31_5_V_5>>5'd16)))+(TLEca31_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca31_5_V_4+
                              TLEca31_5_V_5)+(TLEca31_5_V_4+TLEca31_5_V_5>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && (3'd4/*4:MS*/!=(32'hffffffff&32'd1+TLEsw1_1_V_4
                      )))  begin 
                               xpc10 <= 6'd44/*44:xpc10:44*/;
                               LoEthernetEcho_tmp2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca31_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca31_5_V_4+TLEca31_5_V_5
                              )+(TLEca31_5_V_4+TLEca31_5_V_5>>5'd16)))+(TLEca31_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca31_5_V_4+
                              TLEca31_5_V_5)+(TLEca31_5_V_4+TLEca31_5_V_5>>5'd16))>>5'd16);

                               end 
                               end 
                      
                  6'd51/*51:US*/:  begin 
                      if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd4/*4:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_UDP_total_length <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_app_dst_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32);
                               LoEthernetEcho_app_src_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               LoEthernetEcho_dst_ip <= LoEthernetEcho_dst_ip|{64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==0/*0:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_src_port <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_3)>>5'd16);
                               LoEthernetEcho_src_mac <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd2/*2:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IP_total_length <= 64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               LoEthernetEcho_proto_UDP <= 1'h1&(5'd17/*17:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56
                              )));

                               LoEthernetEcho_proto_ICMP <= 1'h1&(1'd1/*1:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56)));
                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd4/*4:MS*/))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_UDP_total_length <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_app_dst_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32);
                               LoEthernetEcho_app_src_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               LoEthernetEcho_dst_ip <= LoEthernetEcho_dst_ip|{64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==0/*0:MS*/))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_src_port <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_3)>>5'd16);
                               LoEthernetEcho_src_mac <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && 
                      (4'd8/*8:MS*/!=(64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'd0;
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && 
                      (4'd8/*8:MS*/==(64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'h1&(3'd4/*4:MS*/==(64'd15&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd52)));
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd2/*2:MS*/))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IP_total_length <= 64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               LoEthernetEcho_proto_UDP <= 1'h1&(5'd17/*17:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56
                              )));

                               LoEthernetEcho_proto_ICMP <= 1'h1&(1'd1/*1:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56)));
                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd3/*3:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_dst_ip <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_src_ip <= 32'h_ffff_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd5/*5:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_std_query <= 1'h1&(0/*0:MS*/==(64'd15&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd36)));
                               LoEthernetEcho_one_question <= 1'h1&(1'd1/*1:MS*/==((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56));
                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && 
                      (4'd8/*8:MS*/!=(64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'd0;
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && 
                      (4'd8/*8:MS*/==(64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'h1&(3'd4/*4:MS*/==(64'd15&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd52)));
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd3/*3:MS*/))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_dst_ip <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_src_ip <= 32'h_ffff_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd5/*5:MS*/))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_std_query <= 1'h1&(0/*0:MS*/==(64'd15&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd36)));
                               LoEthernetEcho_one_question <= 1'h1&(1'd1/*1:MS*/==((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56));
                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd6/*6:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_start_parsing <= 1'h1&(15'd30467/*30467:MS*/==((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48
                              ));

                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd6/*6:MS*/))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_start_parsing <= 1'h1&(15'd30467/*30467:MS*/==((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48
                              ));

                               end 
                              if ((TLEsw1_1_V_9>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)!=0/*0:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=1'd1/*1:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd2/*2:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd3
                      /*3:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd4/*4:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd5/*5:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=3'd6/*6:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((TLEsw1_1_V_9<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)!=0/*0:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=1'd1/*1:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd2/*2:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd3
                      /*3:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd4/*4:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd5/*5:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=3'd6/*6:MS*/))  begin 
                               xpc10 <= 3'd5/*5:xpc10:5*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                               end 
                      endcase
              if ((LoEthernetEcho_tmp2==LoEthernetEcho_tmp4))  begin if ((xpc10==5'd19/*19:US*/))  begin 
                           xpc10 <= 5'd20/*20:xpc10:20*/;
                           LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[3'd5];
                           TLEsw1_1_V_10 <= 64'h_ffff&A_64_US_CC_SCALbx10_ARA0[0];
                           TLEsw1_1_V_5 <= TLEsw1_1_V_4;
                           LoEthernetEcho_exist_rest <= 1'h1&(LoEthernetEcho_tmp3==LoEthernetEcho_tmp5);
                           end 
                           end 
                   else if ((xpc10==5'd19/*19:US*/))  begin 
                           xpc10 <= 5'd20/*20:xpc10:20*/;
                           LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[3'd5];
                           TLEsw1_1_V_10 <= 64'h_ffff&A_64_US_CC_SCALbx10_ARA0[0];
                           TLEsw1_1_V_5 <= TLEsw1_1_V_4;
                           LoEthernetEcho_exist_rest <= 1'd0;
                           end 
                          
              case (xpc10)
                  3'd5/*5:US*/:  begin 
                       xpc10 <= 3'd6/*6:xpc10:6*/;
                       TLEsw1_1_V_13 <= 1'h1&LoEthernetEcho_proto_ICMP;
                       TLEsw1_1_V_12 <= 1'h1&LoEthernetEcho_proto_UDP;
                       TLEsw1_1_V_11 <= 1'h1&LoEthernetEcho_IPv4;
                       end 
                      
                  3'd6/*6:US*/:  begin 
                      if (TLEsw1_1_V_11 && TLEsw1_1_V_12)  begin 
                               xpc10 <= 3'd7/*7:xpc10:7*/;
                               TLEca6_0_V_1 <= (A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd48);
                               TLEca6_0_V_0 <= 8'd1;
                               TLEca6_0_V_12 <= 32'd0;
                               TLEca6_0_V_7 <= 32'd0;
                               TLEca6_0_V_6 <= 32'd0;
                               end 
                              if (TLEsw1_1_V_11 && !TLEsw1_1_V_12)  xpc10 <= 6'd41/*41:xpc10:41*/;
                          if (!TLEsw1_1_V_11)  xpc10 <= 6'd41/*41:xpc10:41*/;
                           end 
                      
                  3'd7/*7:US*/:  begin 
                       xpc10 <= 4'd8/*8:xpc10:8*/;
                       TLEca6_0_V_7 <= (64'h_ffff&hprpin162310)+(hprpin162310>>5'd16);
                       TLEca6_0_V_6 <= (64'h_ffff&hprpin161810)+(hprpin161810>>5'd16);
                       end 
                      
                  4'd9/*9:US*/:  begin 
                       xpc10 <= 4'd10/*10:xpc10:10*/;
                       TLEsw9_10_V_0 <= (-64'h1_0000_0000&A_64_US_CC_SCALbx14_ARC0[64'd1])|(LoEthernetEcho_dst_mac>>5'd16);
                       end 
                      
                  4'd10/*10:US*/:  begin 
                       xpc10 <= 4'd11/*11:xpc10:11*/;
                       A_64_US_CC_SCALbx14_ARC0[64'd1] <= 64'hffffffffffffffff&TLEsw9_10_V_0;
                       end 
                      
                  4'd11/*11:US*/:  begin 
                       xpc10 <= 4'd12/*12:xpc10:12*/;
                       TLEsw9_10_V_0 <= (64'h_ffff&A_64_US_CC_SCALbx14_ARC0[64'd3])|{LoEthernetEcho_dst_ip, 16'd0}|{LoEthernetEcho_src_ip
                      , 48'd0};

                       end 
                      
                  4'd12/*12:US*/:  begin 
                       xpc10 <= 4'd13/*13:xpc10:13*/;
                       A_64_US_CC_SCALbx14_ARC0[64'd3] <= 64'hffffffffffffffff&TLEsw9_10_V_0;
                       end 
                      
                  4'd13/*13:US*/:  begin 
                      if (!TLEsw9_10_V_1 && TLEsw9_10_V_2)  begin 
                               xpc10 <= 4'd14/*14:xpc10:14*/;
                               TLEsw9_10_V_0 <= (-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[64'd4])|(LoEthernetEcho_src_ip>>5'd16
                              );

                               end 
                              if (TLEsw9_10_V_1 && !TLEsw9_10_V_2)  begin 
                               xpc10 <= 4'd14/*14:xpc10:14*/;
                               TLEsw9_10_V_0 <= (-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[64'd4])|(LoEthernetEcho_src_ip>>5'd16
                              )|{LoEthernetEcho_app_src_port, 32'd0}|{LoEthernetEcho_app_dst_port, 16'd0};

                               end 
                              if (TLEsw9_10_V_1 && TLEsw9_10_V_2)  begin 
                               xpc10 <= 4'd14/*14:xpc10:14*/;
                               TLEsw9_10_V_0 <= (-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[64'd4])|(LoEthernetEcho_src_ip>>5'd16
                              );

                               end 
                              if (!TLEsw9_10_V_1 && !TLEsw9_10_V_2)  xpc10 <= 4'd14/*14:xpc10:14*/;
                           end 
                      
                  4'd14/*14:US*/:  begin 
                       xpc10 <= 4'd15/*15:xpc10:15*/;
                       A_64_US_CC_SCALbx14_ARC0[64'd4] <= 64'hffffffffffffffff&TLEsw9_10_V_0;
                       end 
                      
                  5'd16/*16:US*/:  begin 
                       xpc10 <= 5'd17/*17:xpc10:17*/;
                       LoEthernetEcho_tmp <= A_64_US_CC_SCALbx14_ARC0[64'd7];
                       end 
                      
                  5'd17/*17:US*/:  begin 
                       xpc10 <= 5'd18/*18:xpc10:18*/;
                       LoEthernetEcho_tmp4 <= A_64_US_CC_SCALbx14_ARC0[64'd8];
                       LoEthernetEcho_tmp3 <= A_64_US_CC_SCALbx16_ARD0[32'd0];
                       LoEthernetEcho_tmp2 <= A_64_US_CC_SCALbx18_ARE0[32'd0];
                       LoEthernetEcho_tmp1 <= A_64_US_CC_SCALbx20_ARF0[32'd0];
                       TLEsw1_1_V_4 <= 32'd0;
                       TLEsw1_1_V_5 <= 32'd7;
                       end 
                      
                  5'd20/*20:US*/:  begin 
                       xpc10 <= 5'd21/*21:xpc10:21*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&64'h80_0000_0000|LoEthernetEcho_tmp;
                       end 
                      
                  5'd21/*21:US*/:  begin 
                      if (!LoEthernetEcho_start_parsing)  begin 
                               xpc10 <= 6'd50/*50:xpc10:50*/;
                               LoEthernetEcho_tmp5 <= A_64_US_CC_SCALbx10_ARA0[0];
                               A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&64'h380_0000_0000|LoEthernetEcho_tmp;
                               end 
                              if (LoEthernetEcho_start_parsing && !LoEthernetEcho_exist_rest)  begin 
                               xpc10 <= 6'd50/*50:xpc10:50*/;
                               LoEthernetEcho_tmp5 <= A_64_US_CC_SCALbx10_ARA0[0];
                               A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&64'h380_0000_0000|LoEthernetEcho_tmp;
                               end 
                              if (LoEthernetEcho_start_parsing && LoEthernetEcho_exist_rest)  begin 
                               xpc10 <= 5'd22/*22:xpc10:22*/;
                               LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[3'd6];
                               end 
                               end 
                      
                  5'd22/*22:US*/:  begin 
                       xpc10 <= 5'd23/*23:xpc10:23*/;
                       LoEthernetEcho_tmp2 <= 64'h400_100e|{64'hffffffffffffffff&A_UINT_CC_SCALbx22_ARA0[32'hffffffff&TLEsw1_1_V_5], 32'd0
                      };

                       LoEthernetEcho_tmp1 <= 64'h100_0100_0cc0;
                       A_64_US_CC_SCALbx14_ARC0[3'd6] <= 64'hffffffffffffffff&64'd256|LoEthernetEcho_tmp;
                       end 
                      
                  5'd23/*23:US*/: if (!(!LoEthernetEcho_last_tkeep))  begin 
                           xpc10 <= 6'd46/*46:xpc10:46*/;
                           LoEthernetEcho_tmp3 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLEsw1_1_V_9]|(64'h100_0100_0cc0<<(6'd63&4'd8
                          *LoEthernetEcho_last_tkeep));

                           A_8_US_CC_SCALbx24_ARA0[32'hffffffff&TLEsw1_1_V_9] <= 8'd255;
                           end 
                           else  begin 
                           xpc10 <= 5'd24/*24:xpc10:24*/;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_9] <= 64'h100_0100_0cc0;
                           end 
                          
                  5'd24/*24:US*/:  begin 
                       xpc10 <= 5'd25/*25:xpc10:25*/;
                       A_8_US_CC_SCALbx24_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_9] <= 8'd255;
                       A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd2+TLEsw1_1_V_9] <= 64'hffffffffffffffff&LoEthernetEcho_tmp2;
                       end 
                      
                  5'd25/*25:US*/:  begin 
                       xpc10 <= 5'd26/*26:xpc10:26*/;
                       LoEthernetEcho_tmp2 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[64'd2];
                       LoEthernetEcho_tmp <= (LoEthernetEcho_IP_total_length>>4'd8)|{64'd255&LoEthernetEcho_IP_total_length, 8'd0};
                       A_8_US_CC_SCALbx24_ARA0[32'hffffffff&32'd2+TLEsw1_1_V_9] <= 8'd255;
                       end 
                      
                  5'd26/*26:US*/:  begin 
                       xpc10 <= 5'd27/*27:xpc10:27*/;
                       LoEthernetEcho_tmp2 <= 64'h_ffff_ffff_ffff&A_64_US_CC_SCALbx14_ARC0[64'd4];
                       LoEthernetEcho_tmp <= (LoEthernetEcho_UDP_total_length>>4'd8)|{64'd255&LoEthernetEcho_UDP_total_length, 8'd0};
                       LoEthernetEcho_IP_total_length <= 64'd16+LoEthernetEcho_tmp;
                       A_64_US_CC_SCALbx14_ARC0[64'd2] <= 64'hffffffffffffffff&LoEthernetEcho_tmp2|((64'hffffffffffffffff&64'd16+LoEthernetEcho_tmp
                      )>>4'd8)|{64'd255&64'hffffffffffffffff&64'd16+LoEthernetEcho_tmp, 8'd0};

                       end 
                      
                  5'd27/*27:US*/:  begin 
                       xpc10 <= 5'd28/*28:xpc10:28*/;
                       LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[64'd3];
                       TLEsw1_1_V_9 <= 32'd2+TLEsw1_1_V_9;
                       LoEthernetEcho_UDP_total_length <= 64'd16+LoEthernetEcho_tmp;
                       A_64_US_CC_SCALbx10_ARA0[0] <= 64'hffffffffffffffff&(64'hffffffffffffffff&64'd16+TLEsw1_1_V_10)|{LoEthernetEcho_src_port
                      , 24'd0}|{LoEthernetEcho_src_port, 16'd0};

                       A_64_US_CC_SCALbx14_ARC0[64'd4] <= 64'hffffffffffffffff&LoEthernetEcho_tmp2|{((64'hffffffffffffffff&64'd16+LoEthernetEcho_tmp
                      )>>4'd8)|{64'd255&64'hffffffffffffffff&64'd16+LoEthernetEcho_tmp, 8'd0}, 48'd0};

                       end 
                      
                  5'd28/*28:US*/:  begin 
                       xpc10 <= 5'd29/*29:xpc10:29*/;
                       A_64_US_CC_SCALbx14_ARC0[64'd3] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                       end 
                      
                  5'd29/*29:US*/:  begin 
                       xpc10 <= 5'd30/*30:xpc10:30*/;
                       TLEca27_14_V_1 <= (A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd48);
                       TLEca27_14_V_0 <= 8'd1;
                       TLEca27_14_V_12 <= 32'd0;
                       TLEca27_14_V_7 <= 32'd0;
                       TLEca27_14_V_6 <= 32'd0;
                       end 
                      
                  5'd30/*30:US*/:  begin 
                       xpc10 <= 5'd31/*31:xpc10:31*/;
                       TLEca27_14_V_7 <= (64'h_ffff&hprpin177310)+(hprpin177310>>5'd16);
                       TLEca27_14_V_6 <= (64'h_ffff&hprpin176810)+(hprpin176810>>5'd16);
                       end 
                      
                  6'd32/*32:US*/:  begin 
                       xpc10 <= 6'd33/*33:xpc10:33*/;
                       A_64_US_CC_SCALbx14_ARC0[64'd3] <= 64'hffffffffffffffff&LoEthernetEcho_tmp|(LoEthernetEcho_chksumIP>>4'd8)|{64'd255
                      &LoEthernetEcho_chksumIP, 8'd0};

                       end 
                      
                  6'd33/*33:US*/:  begin 
                       xpc10 <= 6'd34/*34:xpc10:34*/;
                       LoEthernetEcho_tmp <= A_64_US_CC_SCALbx14_ARC0[3'd5];
                       end 
                      
                  6'd34/*34:US*/: if ((TLEsw1_1_V_9<32'd4))  begin 
                           xpc10 <= 6'd35/*35:xpc10:35*/;
                           LoEthernetEcho_tmp2 <= LoEthernetEcho_dst_ip|{LoEthernetEcho_src_ip, 32'd0};
                           LoEthernetEcho_tmp3 <= 64'h_1100|(-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[64'd4]);
                           TLEsw1_1_V_4 <= 32'd4;
                           end 
                           else  begin 
                           xpc10 <= 6'd44/*44:xpc10:44*/;
                           LoEthernetEcho_tmp2 <= (A_64_US_CC_SCALbx14_ARC0[32'd4]>>5'd16);
                           TLEsw1_1_V_4 <= 32'd4;
                           end 
                          
                  6'd35/*35:US*/:  begin 
                       xpc10 <= 6'd36/*36:xpc10:36*/;
                       TLEca33_17_V_5 <= (64'h_ffff&hprpin182610)+(hprpin182610>>5'd16);
                       TLEca33_17_V_4 <= (64'h_ffff&hprpin182110)+(hprpin182110>>5'd16);
                       TLEca33_17_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  6'd36/*36:US*/:  begin 
                       xpc10 <= 6'd37/*37:xpc10:37*/;
                       LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca33_17_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca33_17_V_4+TLEca33_17_V_5
                      )+(TLEca33_17_V_4+TLEca33_17_V_5>>5'd16)))+(TLEca33_17_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca33_17_V_4+TLEca33_17_V_5
                      )+(TLEca33_17_V_4+TLEca33_17_V_5>>5'd16))>>5'd16);

                       end 
                      
                  6'd37/*37:US*/:  begin 
                       xpc10 <= 6'd38/*38:xpc10:38*/;
                       TLEca33_20_V_5 <= (64'h_ffff&hprpin184710)+(hprpin184710>>5'd16);
                       TLEca33_20_V_4 <= (64'h_ffff&hprpin184210)+(hprpin184210>>5'd16);
                       TLEca33_20_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  6'd38/*38:US*/:  begin 
                       xpc10 <= 6'd39/*39:xpc10:39*/;
                       LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca33_20_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca33_20_V_4+TLEca33_20_V_5
                      )+(TLEca33_20_V_4+TLEca33_20_V_5>>5'd16)))+(TLEca33_20_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca33_20_V_4+TLEca33_20_V_5
                      )+(TLEca33_20_V_4+TLEca33_20_V_5>>5'd16))>>5'd16);

                       end 
                      
                  6'd39/*39:US*/:  begin 
                       xpc10 <= 6'd40/*40:xpc10:40*/;
                       LoEthernetEcho_tmp2 <= 64'h_ffff&32'h_ffff_ffff^LoEthernetEcho_chksum_UDP;
                       end 
                      
                  6'd40/*40:US*/:  begin 
                       xpc10 <= 6'd41/*41:xpc10:41*/;
                       LoEthernetEcho_tmp3 <= {64'd255&LoEthernetEcho_tmp2, 8'd0}|(LoEthernetEcho_tmp2>>4'd8);
                       A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&LoEthernetEcho_tmp|(64'hffffffffffffffff&{64'd255&LoEthernetEcho_tmp2
                      , 8'd0}|(LoEthernetEcho_tmp2>>4'd8));

                       end 
                      
                  6'd44/*44:US*/:  begin 
                       xpc10 <= 6'd45/*45:xpc10:45*/;
                       TLEca31_5_V_5 <= (64'h_ffff&hprpin184710)+(hprpin184710>>5'd16);
                       TLEca31_5_V_4 <= (64'h_ffff&hprpin184210)+(hprpin184210>>5'd16);
                       TLEca31_5_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  6'd46/*46:US*/:  begin 
                       xpc10 <= 6'd47/*47:xpc10:47*/;
                       A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLEsw1_1_V_9] <= 64'hffffffffffffffff&LoEthernetEcho_tmp3;
                       end 
                      
                  6'd47/*47:US*/:  begin 
                       xpc10 <= 6'd48/*48:xpc10:48*/;
                       A_8_US_CC_SCALbx24_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_9] <= 8'd255;
                       A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_9] <= 64'hffffffffffffffff&(64'h100_0100_0cc0>>(6'd63&4'd8
                      *(4'd8+(0-LoEthernetEcho_last_tkeep))))|(LoEthernetEcho_tmp2<<(6'd63&4'd8*LoEthernetEcho_last_tkeep));

                       end 
                      
                  6'd48/*48:US*/:  begin 
                       xpc10 <= 6'd49/*49:xpc10:49*/;
                       A_8_US_CC_SCALbx24_ARA0[32'hffffffff&32'd2+TLEsw1_1_V_9] <= 8'hff&(8'd255>>>(5'd31&4'd8+(0-LoEthernetEcho_last_tkeep
                      )));

                       A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd2+TLEsw1_1_V_9] <= 64'hffffffffffffffff&(LoEthernetEcho_tmp2>>(6'd63
                      &4'd8*(4'd8+(0-LoEthernetEcho_last_tkeep))));

                       end 
                      
                  6'd49/*49:US*/:  begin 
                       xpc10 <= 5'd26/*26:xpc10:26*/;
                       LoEthernetEcho_tmp2 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[64'd2];
                       LoEthernetEcho_tmp <= (LoEthernetEcho_IP_total_length>>4'd8)|{64'd255&LoEthernetEcho_IP_total_length, 8'd0};
                       end 
                      
                  6'd50/*50:US*/:  begin 
                       xpc10 <= 5'd28/*28:xpc10:28*/;
                       LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[64'd3];
                       A_64_US_CC_SCALbx10_ARA0[0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp5|{LoEthernetEcho_src_port, 24'd0};
                       end 
                      endcase
              if ((xpc10==4'd15/*15:US*/))  xpc10 <= 5'd16/*16:xpc10:16*/;
                   end 
              //End structure HPR EthernetEcho.dll


       end 
      

assign hprpin161810 = (64'hffffffffffffffff&{64'd255&TLEca6_0_V_1, 8'd0}|((64'h_ff00&TLEca6_0_V_1)>>4'd8))+(64'hffffffffffffffff&{64'd255&(TLEca6_0_V_1>>5'd16
), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>5'd16))>>4'd8));

assign hprpin162310 = (64'hffffffffffffffff&{64'd255&(TLEca6_0_V_1>>6'd32), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>6'd32))>>4'd8))+(64'hffffffffffffffff&{64'd255
&(TLEca6_0_V_1>>6'd48), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>6'd48))>>4'd8));

assign hprpin176810 = (64'hffffffffffffffff&{64'd255&TLEca27_14_V_1, 8'd0}|((64'h_ff00&TLEca27_14_V_1)>>4'd8))+(64'hffffffffffffffff&{64'd255&(TLEca27_14_V_1
>>5'd16), 8'd0}|((64'h_ff00&(TLEca27_14_V_1>>5'd16))>>4'd8));

assign hprpin177310 = (64'hffffffffffffffff&{64'd255&(TLEca27_14_V_1>>6'd32), 8'd0}|((64'h_ff00&(TLEca27_14_V_1>>6'd32))>>4'd8))+(64'hffffffffffffffff&{64'd255
&(TLEca27_14_V_1>>6'd48), 8'd0}|((64'h_ff00&(TLEca27_14_V_1>>6'd48))>>4'd8));

assign hprpin182110 = (64'hffffffffffffffff&{64'd255&LoEthernetEcho_tmp3, 8'd0}|((64'h_ff00&LoEthernetEcho_tmp3)>>4'd8))+(64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp3
>>5'd16), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp3>>5'd16))>>4'd8));

assign hprpin182610 = (64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp3>>6'd32), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp3>>6'd32))>>4'd8))+(64'hffffffffffffffff
&{64'd255&(LoEthernetEcho_tmp3>>6'd48), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp3>>6'd48))>>4'd8));

assign hprpin184210 = (64'hffffffffffffffff&{64'd255&LoEthernetEcho_tmp2, 8'd0}|((64'h_ff00&LoEthernetEcho_tmp2)>>4'd8))+(64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp2
>>5'd16), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>5'd16))>>4'd8));

assign hprpin184710 = (64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp2>>6'd32), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>6'd32))>>4'd8))+(64'hffffffffffffffff
&{64'd255&(LoEthernetEcho_tmp2>>6'd48), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>6'd48))>>4'd8));

// 1 vectors of width 6
// 38 vectors of width 64
// 13 vectors of width 1
// 8 vectors of width 32
// 4 vectors of width 8
// 213 array locations of width 64
// 7 array locations of width 32
// 64 array locations of width 8
// Total state bits in module = 17107 bits.
// 512 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
// eof (HPR L/S Verilog)
