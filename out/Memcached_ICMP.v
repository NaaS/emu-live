

// CBG Orangepath HPR L/S System

// Verilog output file generated at 04/05/2016 17:51:43
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
  reg [63:0] LoEthernetEcho_chksum_UDP;
  reg [63:0] LoEthernetEcho_chksumIP;
  reg [31:0] LoEthernetEcho_mem_controller_cnt;
  reg [63:0] TLEsw1_1_V_2;
  reg [63:0] TLEsw1_1_V_3;
  reg [31:0] TLEsw1_1_V_4;
  reg [7:0] TLEsw1_1_V_8;
  reg [7:0] TLEsw1_1_V_9;
  reg [31:0] TLEsw1_1_V_10;
  reg TLEsw1_1_V_12;
  reg TLEsw1_1_V_13;
  reg TLEsw1_1_V_14;
  reg [31:0] TLEsw1_1_V_17;
  reg TLEsw1_1_V_19;
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
  reg [31:0] TLEca8_1_V_0;
  reg [63:0] TLEsw14_14_V_0;
  reg TLEsw14_14_V_1;
  reg TLEsw14_14_V_2;
  reg [63:0] TLEMe18_1_V_0;
  reg [63:0] TLEMe18_1_V_1;
  reg [63:0] TLEMe19_2_V_0;
  reg [63:0] TLEMe19_2_V_1;
  reg [63:0] TLEMe20_2_V_0;
  reg [63:0] TLEMe20_2_V_1;
  reg [7:0] TLEca21_7_V_0;
  reg [63:0] TLEca21_7_V_1;
  reg [63:0] TLEca21_7_V_6;
  reg [63:0] TLEca21_7_V_7;
  reg [63:0] TLEca21_7_V_12;
  reg [63:0] TLEca25_5_V_4;
  reg [63:0] TLEca25_5_V_5;
  reg [63:0] TLEca25_5_V_7;
  reg [63:0] TLEca27_17_V_4;
  reg [63:0] TLEca27_17_V_5;
  reg [63:0] TLEca27_17_V_7;
  reg [63:0] TLEca27_20_V_4;
  reg [63:0] TLEca27_20_V_5;
  reg [63:0] TLEca27_20_V_7;
  reg [31:0] TLESe28_3_V_0;
  reg [31:0] TLESe28_3_V_1;
  reg [7:0] LoEthernetEcho_magic_num;
  reg [7:0] LoEthernetEcho_opcode;
  reg [63:0] LoEthernetEcho_key_value;
  reg [63:0] LoEthernetEcho_extras;
  reg [63:0] LoEthernetEcho_flag;
  reg [63:0] LoEthernetEcho_key;
  reg [63:0] LoEthernetEcho_dst_mac;
  reg [63:0] LoEthernetEcho_src_mac;
  reg [63:0] LoEthernetEcho_dst_ip;
  reg [63:0] LoEthernetEcho_src_ip;
  reg [63:0] LoEthernetEcho_app_src_port;
  reg [63:0] LoEthernetEcho_app_dst_port;
  reg [63:0] LoEthernetEcho_IP_total_length;
  reg [63:0] LoEthernetEcho_UDP_total_length;
  reg [63:0] LoEthernetEcho_src_port;
  reg [63:0] LoEthernetEcho_tmp;
  reg [63:0] LoEthernetEcho_tmp3;
  reg [63:0] LoEthernetEcho_tmp2;
  reg [7:0] A_8_US_CC_SCALbx20_ARA0[255:0];
  reg [63:0] A_64_US_CC_SCALbx10_ARA0[255:0];
  reg [63:0] A_64_US_CC_SCALbx12_ARB0[255:0];
  reg [63:0] A_64_US_CC_SCALbx14_ARC0[255:0];
  reg [63:0] A_64_US_CC_SCALbx16_ARD0[255:0];
  reg [63:0] A_64_US_CC_SCALbx18_ARE0[255:0];
  reg [6:0] xpc10;
  wire [63:0] hprpin155110;
  wire [63:0] hprpin155610;
  wire [63:0] hprpin168410;
  wire [63:0] hprpin168910;
  wire [63:0] hprpin173710;
  wire [63:0] hprpin174210;
  wire [63:0] hprpin175810;
  wire [63:0] hprpin176310;
 always   @(posedge clk )  begin 
      //Start structure HPR EthernetEcho.dll
      if (reset)  begin 
               TLERe1_1_V_6 <= 8'd0;
               TLERe1_1_V_5 <= 64'd0;
               TLERe1_1_V_3 <= 1'd0;
               TLERe1_1_V_1 <= 32'd0;
               TLERe1_1_V_0 <= 32'd0;
               LoEthernetEcho_extras <= 64'd0;
               LoEthernetEcho_key <= 64'd0;
               LoEthernetEcho_opcode <= 8'd0;
               LoEthernetEcho_magic_num <= 8'd0;
               LoEthernetEcho_UDP_total_length <= 64'd0;
               LoEthernetEcho_app_dst_port <= 64'd0;
               LoEthernetEcho_app_src_port <= 64'd0;
               LoEthernetEcho_dst_ip <= 64'd0;
               LoEthernetEcho_src_ip <= 64'd0;
               LoEthernetEcho_IP_total_length <= 64'd0;
               TLEsw1_1_V_3 <= 64'd0;
               TLEsw1_1_V_2 <= 64'd0;
               LoEthernetEcho_src_port <= 64'd0;
               LoEthernetEcho_src_mac <= 64'd0;
               LoEthernetEcho_dst_mac <= 64'd0;
               TLEsw1_1_V_9 <= 8'd0;
               TLEsw1_1_V_8 <= 8'd0;
               TLEsw1_1_V_14 <= 1'd0;
               TLEsw1_1_V_13 <= 1'd0;
               TLEsw1_1_V_12 <= 1'd0;
               TLEca6_0_V_7 <= 64'd0;
               TLEca6_0_V_6 <= 64'd0;
               TLEca6_0_V_1 <= 64'd0;
               TLEca6_0_V_0 <= 8'd0;
               TLEca6_0_V_12 <= 64'd0;
               LoEthernetEcho_flag <= 64'd0;
               LoEthernetEcho_key_value <= 64'd0;
               TLEsw1_1_V_19 <= 1'd0;
               TLEsw14_14_V_2 <= 1'd0;
               TLEsw14_14_V_1 <= 1'd0;
               TLEsw14_14_V_0 <= 64'd0;
               TLEca21_7_V_7 <= 64'd0;
               TLEca21_7_V_6 <= 64'd0;
               LoEthernetEcho_chksumIP <= 64'd0;
               TLEca21_7_V_1 <= 64'd0;
               TLEca21_7_V_0 <= 8'd0;
               TLEca21_7_V_12 <= 64'd0;
               LoEthernetEcho_tmp <= 64'd0;
               TLEca27_17_V_5 <= 64'd0;
               TLEca27_17_V_4 <= 64'd0;
               TLEca27_17_V_7 <= 64'd0;
               TLEca27_20_V_5 <= 64'd0;
               TLEca27_20_V_4 <= 64'd0;
               TLEca27_20_V_7 <= 64'd0;
               TLESe28_3_V_1 <= 32'd0;
               s_axis_tready <= 1'd0;
               LoEthernetEcho_proto_ICMP <= 1'd0;
               LoEthernetEcho_proto_UDP <= 1'd0;
               LoEthernetEcho_IPv4 <= 1'd0;
               m_axis_tvalid <= 1'd0;
               TLESe28_3_V_0 <= 32'd0;
               m_axis_tuser_low <= 64'd0;
               m_axis_tuser_hi <= 64'd0;
               m_axis_tlast <= 1'd0;
               m_axis_tkeep <= 8'd0;
               m_axis_tdata <= 64'd0;
               TLEca25_5_V_5 <= 64'd0;
               TLEca25_5_V_4 <= 64'd0;
               TLEca25_5_V_7 <= 64'd0;
               LoEthernetEcho_tmp3 <= 64'd0;
               LoEthernetEcho_tmp2 <= 64'd0;
               TLEsw1_1_V_4 <= 32'd0;
               LoEthernetEcho_chksum_UDP <= 64'd0;
               TLEMe20_2_V_1 <= 64'd0;
               TLEMe20_2_V_0 <= 64'd0;
               TLEMe19_2_V_1 <= 64'd0;
               TLEMe19_2_V_0 <= 64'd0;
               TLEMe18_1_V_1 <= 64'd0;
               TLEMe18_1_V_0 <= 64'd0;
               TLEsw1_1_V_10 <= 32'd0;
               cam_we <= 1'd0;
               TLEsw1_1_V_17 <= 32'd0;
               LoEthernetEcho_mem_controller_cnt <= 32'd0;
               TLEca8_1_V_0 <= 32'd0;
               cam_wr_addr <= 8'd0;
               cam_din <= 64'd0;
               xpc10 <= 7'd0;
               cam_cmp_din <= 64'd0;
               end 
               else  begin 
              
              case (xpc10)
                  3'd5/*5:US*/:  begin 
                      if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd4/*4:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_UDP_total_length <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_app_dst_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32);
                               LoEthernetEcho_app_src_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               LoEthernetEcho_dst_ip <= LoEthernetEcho_dst_ip|{64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_4)==0/*0:MS*/) && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_src_port <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_3)>>5'd16);
                               LoEthernetEcho_src_mac <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd2/*2:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IP_total_length <= 64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               LoEthernetEcho_proto_UDP <= 1'h1&(5'd17/*17:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56
                              )));

                               LoEthernetEcho_proto_ICMP <= 1'h1&(1'd1/*1:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56)));
                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd4/*4:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_UDP_total_length <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_app_dst_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32);
                               LoEthernetEcho_app_src_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               LoEthernetEcho_dst_ip <= LoEthernetEcho_dst_ip|{64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_4)==0/*0:MS*/) && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_src_port <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_3)>>5'd16);
                               LoEthernetEcho_src_mac <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && (4'd8/*8:MS*/!=
                      (64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'd0;
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && (4'd8/*8:MS*/==
                      (64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'h1&(3'd4/*4:MS*/==(64'd15&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd52)));
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd2/*2:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IP_total_length <= 64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               LoEthernetEcho_proto_UDP <= 1'h1&(5'd17/*17:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56
                              )));

                               LoEthernetEcho_proto_ICMP <= 1'h1&(1'd1/*1:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56)));
                               end 
                              if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd3/*3:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_dst_ip <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_src_ip <= 32'h_ffff_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               end 
                              if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd6/*6:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_opcode <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd24);
                               LoEthernetEcho_magic_num <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && !LoEthernetEcho_opcode
                       && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_extras <= {64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               LoEthernetEcho_key <= 64'h_ffff_ffff_ffff_0000&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && (4'd11>=(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_extras <= LoEthernetEcho_extras|(64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2);
                               LoEthernetEcho_key <= 64'h_ffff_ffff_ffff_0000&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && (4'd8/*8:MS*/!=
                      (64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'd0;
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && (4'd8/*8:MS*/==
                      (64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'h1&(3'd4/*4:MS*/==(64'd15&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd52)));
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd3/*3:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_dst_ip <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_src_ip <= 32'h_ffff_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd6/*6:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_opcode <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd24);
                               LoEthernetEcho_magic_num <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && !LoEthernetEcho_opcode
                       && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_key <= 64'h_ffff_ffff_ffff_0000&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && !LoEthernetEcho_opcode
                       && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_extras <= {64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               LoEthernetEcho_key <= 64'h_ffff_ffff_ffff_0000&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && !(!LoEthernetEcho_opcode
                      ) && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_extras <= {64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && !(!LoEthernetEcho_opcode) && (LoEthernetEcho_opcode
                      ==3'd4/*4:US*/) && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_key <= 64'h_ffff_ffff_ffff_0000&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && (4'd11<(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_extras <= LoEthernetEcho_extras|(64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2);
                               LoEthernetEcho_key <= 64'h_ffff_ffff_ffff_0000&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && (4'd11>=(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd11/*11:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_key_value <= TLEsw1_1_V_2;
                               end 
                              if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd5/*5:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd7/*7:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && !LoEthernetEcho_opcode
                       && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_key <= 64'h_ffff_ffff_ffff_0000&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && !(!LoEthernetEcho_opcode
                      ) && (LoEthernetEcho_opcode!=3'd4/*4:US*/) && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4
                      )==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && !(!LoEthernetEcho_opcode
                      ) && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_extras <= {64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && !(!LoEthernetEcho_opcode) && (LoEthernetEcho_opcode
                      ==3'd4/*4:US*/) && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_key <= 64'h_ffff_ffff_ffff_0000&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && (4'd11>=(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd11/*11:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && (4'd11>=(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd11/*11:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && (4'd11<(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd11/*11:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_key_value <= TLEsw1_1_V_2;
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_4)!=0/*0:MS*/) && (4'd11>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=1'd1/*1:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd2/*2:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd3
                      /*3:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd4/*4:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd5/*5:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=3'd6/*6:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd7/*7:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd8
                      /*8:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd9/*9:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd10/*10:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=4'd11/*11:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd5/*5:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd7/*7:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && !(!LoEthernetEcho_opcode
                      ) && (LoEthernetEcho_opcode!=3'd4/*4:US*/) && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4
                      )==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && (4'd11<(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd11/*11:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && (4'd11<(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd11/*11:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_4)!=0/*0:MS*/) && (4'd11<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=1'd1/*1:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd2/*2:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd3
                      /*3:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd4/*4:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd5/*5:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=3'd6/*6:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd7/*7:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd8
                      /*8:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd9/*9:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd10/*10:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=4'd11/*11:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                               end 
                      
                  4'd9/*9:US*/:  begin 
                      if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9==1'd1/*1:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0
                      )) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12
                      +(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12
                      +(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 7'd89/*89:xpc10:89*/;
                               TLEca8_1_V_0 <= 8'hff&LoEthernetEcho_mem_controller_cnt;
                               cam_wr_addr <= LoEthernetEcho_mem_controller_cnt;
                               cam_din <= LoEthernetEcho_key;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9==2'd2/*2:US*/) && (LoEthernetEcho_mem_controller_cnt
                      !=8'd255/*255:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff
                      ^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= 32'd0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9==2'd2/*2:US*/) && (LoEthernetEcho_mem_controller_cnt
                      ==8'd255/*255:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff
                      ^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= 32'd0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd0;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9==2'd3/*3:US*/) && (LoEthernetEcho_mem_controller_cnt
                      !=8'd255/*255:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff
                      ^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= 32'd0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9==2'd3/*3:US*/) && (LoEthernetEcho_mem_controller_cnt
                      ==8'd255/*255:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff
                      ^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= 32'd0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd0;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9!=0/*0:US*/) && (TLEsw1_1_V_9!=1'd1/*1:US*/) && 
                      (TLEsw1_1_V_9!=2'd2/*2:US*/) && (TLEsw1_1_V_9!=2'd3/*3:US*/) && (TLEsw1_1_V_9!=3'd4/*4:US*/) && (LoEthernetEcho_mem_controller_cnt
                      !=8'd255/*255:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff
                      ^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= 32'd0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9!=0/*0:US*/) && (TLEsw1_1_V_9!=1'd1/*1:US*/) && 
                      (TLEsw1_1_V_9!=2'd2/*2:US*/) && (TLEsw1_1_V_9!=2'd3/*3:US*/) && (TLEsw1_1_V_9!=3'd4/*4:US*/) && (LoEthernetEcho_mem_controller_cnt
                      ==8'd255/*255:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff
                      ^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6
                      +TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= 32'd0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd0;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9==0/*0:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0
                      )) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12
                      +(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12
                      +(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 7'd92/*92:xpc10:92*/;
                               cam_cmp_din <= LoEthernetEcho_key;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && !cam_busy && (TLEsw1_1_V_9==3'd4/*4:US*/) && (3'd4<(8'hff&8'd1+
                      TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff
                      &TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+
                      (TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>
                      5'd16)))))  begin 
                               xpc10 <= 7'd82/*82:xpc10:82*/;
                               cam_cmp_din <= LoEthernetEcho_key;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && cam_busy && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && 1'h1&(0/*0:MS*/==
                      (64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                      &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                      &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16)))))  begin 
                               xpc10 <= 7'd94/*94:xpc10:94*/;
                               TLEca8_1_V_0 <= 32'd0;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((2'd2/*2:MS*/==(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 4'd8/*8:xpc10:8*/;
                               TLEca6_0_V_1 <= A_64_US_CC_SCALbx14_ARC0[8'hff&8'd1+TLEca6_0_V_0];
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4>=(8'hff&8'd1+TLEca6_0_V_0)) && (1'd1/*1:MS*/!=(8'hff&8'd1+TLEca6_0_V_0)) && (2'd2/*2:MS*/!=(8'hff
                      &8'd1+TLEca6_0_V_0)) && (2'd3/*3:MS*/!=(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 4'd8/*8:xpc10:8*/;
                               TLEca6_0_V_1 <= 32'd0;
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((2'd3/*3:MS*/==(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 4'd8/*8:xpc10:8*/;
                               TLEca6_0_V_1 <= A_64_US_CC_SCALbx14_ARC0[8'hff&8'd1+TLEca6_0_V_0];
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4>=(8'hff&8'd1+TLEca6_0_V_0)) && (3'd4/*4:MS*/==(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 4'd8/*8:xpc10:8*/;
                               TLEca6_0_V_1 <= {A_64_US_CC_SCALbx14_ARC0[3'd4], 48'd0};
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((1'd1/*1:MS*/==(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 4'd8/*8:xpc10:8*/;
                               TLEca6_0_V_1 <= (A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd48);
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_8!=8'd128/*128:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 6'd33/*33:xpc10:33*/;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                              if ((TLEsw1_1_V_8==8'd128/*128:US*/) && (3'd4<(8'hff&8'd1+TLEca6_0_V_0)) && !(1'h1&(0/*0:MS*/==(64'hffffffffffffffff
                      &64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6
                      +TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6
                      +TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16))))))  begin 
                               xpc10 <= 6'd33/*33:xpc10:33*/;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                               end 
                      endcase
              if (TLEsw1_1_V_19) 
                  case (xpc10)
                      6'd40/*40:US*/:  begin 
                           xpc10 <= 6'd41/*41:xpc10:41*/;
                           TLEMe20_2_V_1 <= 64'h_ffff_ffff_ffff&A_64_US_CC_SCALbx14_ARC0[3'd4];
                           TLEMe20_2_V_0 <= 32'd2+((64'h_ff00&{LoEthernetEcho_UDP_total_length, 8'd0})|(LoEthernetEcho_UDP_total_length
                          >>4'd8));

                           A_64_US_CC_SCALbx14_ARC0[2'd3] <= 64'hffffffffffffffff&TLEMe20_2_V_0;
                           end 
                          
                      6'd45/*45:US*/:  begin 
                           xpc10 <= 6'd46/*46:xpc10:46*/;
                           A_64_US_CC_SCALbx14_ARC0[3'd6] <= 64'hffffffffffffffff&64'h81_0000|TLEMe20_2_V_0;
                           end 
                          
                      6'd46/*46:US*/:  begin 
                           xpc10 <= 6'd47/*47:xpc10:47*/;
                           TLEMe20_2_V_0 <= 64'h800_0000_0100|(-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd7]);
                           end 
                          
                      6'd48/*48:US*/:  begin 
                           xpc10 <= 6'd49/*49:xpc10:49*/;
                           TLEMe20_2_V_0 <= 64'h_ffff&A_64_US_CC_SCALbx14_ARC0[4'd8];
                           end 
                          
                      6'd55/*55:US*/:  begin 
                           xpc10 <= 6'd56/*56:xpc10:56*/;
                           TLEMe19_2_V_1 <= 64'h_ffff_ffff_ffff&A_64_US_CC_SCALbx14_ARC0[3'd4];
                           TLEMe19_2_V_0 <= 32'd2+((64'h_ff00&{LoEthernetEcho_UDP_total_length, 8'd0})|(LoEthernetEcho_UDP_total_length
                          >>4'd8));

                           A_64_US_CC_SCALbx14_ARC0[2'd3] <= 64'hffffffffffffffff&TLEMe19_2_V_0;
                           end 
                          
                      6'd61/*61:US*/:  begin 
                           xpc10 <= 6'd62/*62:xpc10:62*/;
                           TLEMe19_2_V_0 <= 64'h800_0000_0100|(-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd7]);
                           end 
                          
                      6'd63/*63:US*/:  begin 
                           xpc10 <= 7'd66/*66:xpc10:66*/;
                           TLEMe19_2_V_0 <= 64'h_ffff&A_64_US_CC_SCALbx14_ARC0[4'd8];
                           end 
                          endcase
                   else 
                  case (xpc10)
                      6'd40/*40:US*/:  begin 
                           xpc10 <= 6'd41/*41:xpc10:41*/;
                           TLEMe20_2_V_1 <= 64'h_ffff_ffff_ffff&A_64_US_CC_SCALbx14_ARC0[3'd4];
                           TLEMe20_2_V_0 <= 32'd6+((64'h_ff00&{LoEthernetEcho_UDP_total_length, 8'd0})|(LoEthernetEcho_UDP_total_length
                          >>4'd8));

                           A_64_US_CC_SCALbx14_ARC0[2'd3] <= 64'hffffffffffffffff&TLEMe20_2_V_0;
                           end 
                          
                      6'd45/*45:US*/:  begin 
                           xpc10 <= 6'd46/*46:xpc10:46*/;
                           A_64_US_CC_SCALbx14_ARC0[3'd6] <= 64'hffffffffffffffff&64'h4_0000_0081_0000|TLEMe20_2_V_0;
                           end 
                          
                      6'd46/*46:US*/:  begin 
                           xpc10 <= 6'd47/*47:xpc10:47*/;
                           TLEMe20_2_V_0 <= 64'hc00_0000_0000|(-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd7]);
                           end 
                          
                      6'd48/*48:US*/:  begin 
                           xpc10 <= 6'd52/*52:xpc10:52*/;
                           A_64_US_CC_SCALbx14_ARC0[4'd9] <= 64'hffffffffffffffff&(64'h_ffff_ffff_0000&(LoEthernetEcho_flag>>5'd16))|
                          {LoEthernetEcho_key_value, 48'd0};

                           end 
                          
                      6'd55/*55:US*/:  begin 
                           xpc10 <= 6'd56/*56:xpc10:56*/;
                           TLEMe19_2_V_1 <= 64'h_ffff_ffff_ffff&A_64_US_CC_SCALbx14_ARC0[3'd4];
                           TLEMe19_2_V_0 <= 32'h_ffff_fffa+((64'h_ff00&{LoEthernetEcho_UDP_total_length, 8'd0})|(LoEthernetEcho_UDP_total_length
                          >>4'd8));

                           A_64_US_CC_SCALbx14_ARC0[2'd3] <= 64'hffffffffffffffff&TLEMe19_2_V_0;
                           end 
                          
                      6'd61/*61:US*/:  begin 
                           xpc10 <= 6'd62/*62:xpc10:62*/;
                           TLEMe19_2_V_0 <= -64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd7];
                           end 
                          
                      6'd63/*63:US*/:  begin 
                           xpc10 <= 7'd64/*64:xpc10:64*/;
                           TLEMe19_2_V_0 <= 64'h_ffff&A_64_US_CC_SCALbx14_ARC0[4'd8];
                           end 
                          endcase

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
                       TLEsw1_1_V_19 <= 1'd0;
                       TLEsw1_1_V_17 <= 32'd0;
                       TLEsw1_1_V_14 <= 1'd0;
                       TLEsw1_1_V_13 <= 1'd0;
                       TLEsw1_1_V_12 <= 1'd0;
                       TLEsw1_1_V_10 <= 32'd0;
                       TLEsw1_1_V_9 <= 8'd0;
                       TLEsw1_1_V_8 <= 8'd0;
                       TLEsw1_1_V_4 <= 32'd0;
                       LoEthernetEcho_mem_controller_cnt <= 32'd0;
                       LoEthernetEcho_chksumIP <= 32'd0;
                       LoEthernetEcho_chksum_UDP <= 32'd0;
                       LoEthernetEcho_proto_ICMP <= 1'd0;
                       LoEthernetEcho_proto_UDP <= 1'd0;
                       LoEthernetEcho_IPv4 <= 1'd0;
                       cam_wr_addr <= 8'd0;
                       cam_we <= 1'd0;
                       cam_din <= 32'd0;
                       cam_cmp_din <= 32'h_ffff_ffff;
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
                               A_64_US_CC_SCALbx12_ARB0[32'd0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                               A_8_US_CC_SCALbx20_ARA0[32'd0] <= 8'hff&s_axis_tkeep;
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
                               A_64_US_CC_SCALbx12_ARB0[32'd0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                               A_8_US_CC_SCALbx20_ARA0[32'd0] <= 8'hff&s_axis_tkeep;
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
                               A_8_US_CC_SCALbx20_ARA0[32'hffffffff&TLERe1_1_V_0] <= 8'hff&s_axis_tkeep;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                               end 
                              if (s_axis_tvalid && !s_axis_tlast && TLERe1_1_V_3)  begin 
                               s_axis_tready <= 1'd1;
                               TLERe1_1_V_3 <= 1'h1&s_axis_tvalid;
                               TLERe1_1_V_1 <= TLERe1_1_V_0;
                               TLERe1_1_V_0 <= 32'd1+(32'hffffffff&TLERe1_1_V_0);
                               A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                               A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                               A_8_US_CC_SCALbx20_ARA0[32'hffffffff&TLERe1_1_V_0] <= 8'hff&s_axis_tkeep;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                               end 
                              if (!TLERe1_1_V_3)  begin 
                               xpc10 <= 2'd3/*3:xpc10:3*/;
                               TLERe1_1_V_6 <= A_8_US_CC_SCALbx20_ARA0[8'h1*(32'hffffffff&TLERe1_1_V_1)];
                               TLERe1_1_V_5 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1];
                               end 
                               end 
                      
                  2'd3/*3:US*/:  begin 
                      
                      case (TLERe1_1_V_6)
                          1'd1/*1:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'd255&TLERe1_1_V_5;
                               end 
                              
                          2'd3/*3:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'h_ffff&TLERe1_1_V_5;
                               end 
                              
                          3'd7/*7:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'hff_ffff&TLERe1_1_V_5;
                               end 
                              
                          4'd15/*15:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&32'h_ffff_ffff&TLERe1_1_V_5
                              ;

                               end 
                              
                          5'd31/*31:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'hff_ffff_ffff&TLERe1_1_V_5
                              ;

                               end 
                              
                          6'd63/*63:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'h_ffff_ffff_ffff&TLERe1_1_V_5
                              ;

                               end 
                              
                          7'd127/*127:US*/:  begin 
                               xpc10 <= 3'd4/*4:xpc10:4*/;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_1] <= 64'hffffffffffffffff&64'hff_ffff_ffff_ffff&TLERe1_1_V_5
                              ;

                               end 
                              endcase
                      if ((TLERe1_1_V_6!=3'd7/*7:US*/) && (TLERe1_1_V_6!=4'd15/*15:US*/) && (TLERe1_1_V_6!=5'd31/*31:US*/) && (TLERe1_1_V_6
                      !=6'd63/*63:US*/) && (TLERe1_1_V_6!=7'd127/*127:US*/) && (TLERe1_1_V_6!=1'd1/*1:US*/) && (TLERe1_1_V_6!=2'd2/*2:US*/) && 
                      (TLERe1_1_V_6!=2'd3/*3:US*/))  xpc10 <= 3'd4/*4:xpc10:4*/;
                          if ((TLERe1_1_V_6==2'd2/*2:US*/))  xpc10 <= 3'd4/*4:xpc10:4*/;
                           end 
                      
                  5'd19/*19:US*/:  begin 
                      if ((TLEsw1_1_V_9==1'd1/*1:US*/))  begin 
                               xpc10 <= 7'd69/*69:xpc10:69*/;
                               TLEMe18_1_V_1 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[2'd2];
                               TLEMe18_1_V_0 <= 64'h_ffff&64'h_ffff_ffff_ffff_ffea+((64'h_ff00&{LoEthernetEcho_IP_total_length, 8'd0})|
                              (LoEthernetEcho_IP_total_length>>4'd8));

                               end 
                              if ((TLEsw1_1_V_9==3'd4/*4:US*/) && TLEsw1_1_V_19)  begin 
                               xpc10 <= 6'd53/*53:xpc10:53*/;
                               TLEMe19_2_V_1 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[2'd2];
                               TLEMe19_2_V_0 <= 64'h_ffff&32'd2+((64'h_ff00&{LoEthernetEcho_IP_total_length, 8'd0})|(LoEthernetEcho_IP_total_length
                              >>4'd8));

                               end 
                              if ((TLEsw1_1_V_9==3'd4/*4:US*/) && !TLEsw1_1_V_19)  begin 
                               xpc10 <= 6'd53/*53:xpc10:53*/;
                               TLEMe19_2_V_1 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[2'd2];
                               TLEMe19_2_V_0 <= 64'h_ffff&32'h_ffff_fffa+((64'h_ff00&{LoEthernetEcho_IP_total_length, 8'd0})|(LoEthernetEcho_IP_total_length
                              >>4'd8));

                               end 
                              if ((TLEsw1_1_V_9!=1'd1/*1:US*/) && (TLEsw1_1_V_9!=3'd4/*4:US*/) && !TLEsw1_1_V_9 && TLEsw1_1_V_19)  begin 
                               xpc10 <= 6'd38/*38:xpc10:38*/;
                               TLEMe20_2_V_1 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[2'd2];
                               TLEMe20_2_V_0 <= 64'h_ffff&32'd2+((64'h_ff00&{LoEthernetEcho_IP_total_length, 8'd0})|(LoEthernetEcho_IP_total_length
                              >>4'd8));

                               end 
                              if ((TLEsw1_1_V_9!=1'd1/*1:US*/) && (TLEsw1_1_V_9!=3'd4/*4:US*/) && !TLEsw1_1_V_9 && !TLEsw1_1_V_19)  begin 
                               xpc10 <= 6'd38/*38:xpc10:38*/;
                               TLEMe20_2_V_1 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[2'd2];
                               TLEMe20_2_V_0 <= 64'h_ffff&32'd6+((64'h_ff00&{LoEthernetEcho_IP_total_length, 8'd0})|(LoEthernetEcho_IP_total_length
                              >>4'd8));

                               end 
                              if ((TLEsw1_1_V_9!=1'd1/*1:US*/) && (TLEsw1_1_V_9!=3'd4/*4:US*/) && !(!TLEsw1_1_V_9))  xpc10 <= 5'd20/*20:xpc10:20*/;
                           end 
                      
                  5'd23/*23:US*/:  begin 
                      if ((2'd2/*2:MS*/==(8'hff&8'd1+TLEca21_7_V_0)))  begin 
                               xpc10 <= 5'd22/*22:xpc10:22*/;
                               TLEca21_7_V_1 <= A_64_US_CC_SCALbx14_ARC0[8'hff&8'd1+TLEca21_7_V_0];
                               TLEca21_7_V_0 <= 8'd1+TLEca21_7_V_0;
                               TLEca21_7_V_12 <= (64'h_ffff&TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7
                              )+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16)))+(TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6
                              +TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4>=(8'hff&8'd1+TLEca21_7_V_0)) && (1'd1/*1:MS*/!=(8'hff&8'd1+TLEca21_7_V_0)) && (2'd2/*2:MS*/!=
                      (8'hff&8'd1+TLEca21_7_V_0)) && (2'd3/*3:MS*/!=(8'hff&8'd1+TLEca21_7_V_0)))  begin 
                               xpc10 <= 5'd22/*22:xpc10:22*/;
                               TLEca21_7_V_1 <= 32'd0;
                               TLEca21_7_V_0 <= 8'd1+TLEca21_7_V_0;
                               TLEca21_7_V_12 <= (64'h_ffff&TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7
                              )+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16)))+(TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6
                              +TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16))>>5'd16);

                               end 
                              if ((2'd3/*3:MS*/==(8'hff&8'd1+TLEca21_7_V_0)))  begin 
                               xpc10 <= 5'd22/*22:xpc10:22*/;
                               TLEca21_7_V_1 <= A_64_US_CC_SCALbx14_ARC0[8'hff&8'd1+TLEca21_7_V_0];
                               TLEca21_7_V_0 <= 8'd1+TLEca21_7_V_0;
                               TLEca21_7_V_12 <= (64'h_ffff&TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7
                              )+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16)))+(TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6
                              +TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4>=(8'hff&8'd1+TLEca21_7_V_0)) && (3'd4/*4:MS*/==(8'hff&8'd1+TLEca21_7_V_0)))  begin 
                               xpc10 <= 5'd22/*22:xpc10:22*/;
                               TLEca21_7_V_1 <= {A_64_US_CC_SCALbx14_ARC0[3'd4], 48'd0};
                               TLEca21_7_V_0 <= 8'd1+TLEca21_7_V_0;
                               TLEca21_7_V_12 <= (64'h_ffff&TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7
                              )+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16)))+(TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6
                              +TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16))>>5'd16);

                               end 
                              if ((1'd1/*1:MS*/==(8'hff&8'd1+TLEca21_7_V_0)))  begin 
                               xpc10 <= 5'd22/*22:xpc10:22*/;
                               TLEca21_7_V_1 <= (A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd48);
                               TLEca21_7_V_0 <= 8'd1+TLEca21_7_V_0;
                               TLEca21_7_V_12 <= (64'h_ffff&TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7
                              )+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16)))+(TLEca21_7_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_6
                              +TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4<(8'hff&8'd1+TLEca21_7_V_0)))  begin 
                               xpc10 <= 5'd24/*24:xpc10:24*/;
                               LoEthernetEcho_chksumIP <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16)))+(TLEca21_7_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16))>>5'd16));

                               TLEca21_7_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca21_7_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16)))+(TLEca21_7_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca21_7_V_6+TLEca21_7_V_7)+(TLEca21_7_V_6+TLEca21_7_V_7>>5'd16))>>5'd16));

                               TLEca21_7_V_0 <= 8'd1+TLEca21_7_V_0;
                               end 
                               end 
                      
                  6'd33/*33:US*/:  begin 
                      if (!m_axis_tready && ((32'hffffffff&TLEsw1_1_V_10)>=32'd0))  begin 
                               xpc10 <= 6'd35/*35:xpc10:35*/;
                               TLESe28_3_V_1 <= TLEsw1_1_V_10;
                               TLESe28_3_V_0 <= 32'd0;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd1;
                               end 
                              if (m_axis_tready && ((32'hffffffff&TLEsw1_1_V_10)>=32'd0))  begin 
                               xpc10 <= 6'd35/*35:xpc10:35*/;
                               TLESe28_3_V_0 <= 32'd1;
                               m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'd0];
                               m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'd0];
                               m_axis_tlast <= 1'h1&(TLEsw1_1_V_10==0/*0:US*/);
                               m_axis_tkeep <= A_8_US_CC_SCALbx20_ARA0[8'd0];
                               m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                               TLESe28_3_V_1 <= TLEsw1_1_V_10;
                               m_axis_tvalid <= 1'd1;
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_10)<32'd0))  begin 
                               xpc10 <= 6'd34/*34:xpc10:34*/;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd0;
                               TLESe28_3_V_1 <= TLEsw1_1_V_10;
                               TLESe28_3_V_0 <= 32'd0;
                               end 
                               end 
                      
                  6'd34/*34:US*/:  begin 
                       xpc10 <= 1'd1/*1:xpc10:1*/;
                       s_axis_tready <= 1'd1;
                       m_axis_tuser_low <= 32'd0;
                       m_axis_tuser_hi <= 32'd0;
                       m_axis_tvalid <= 1'd0;
                       m_axis_tlast <= 1'd0;
                       m_axis_tkeep <= 8'd0;
                       m_axis_tdata <= 32'd0;
                       TLEsw1_1_V_10 <= 32'd0;
                       LoEthernetEcho_chksum_UDP <= 32'd0;
                       LoEthernetEcho_proto_ICMP <= 1'd0;
                       LoEthernetEcho_proto_UDP <= 1'd0;
                       LoEthernetEcho_IPv4 <= 1'd0;
                       end 
                      
                  6'd35/*35:US*/:  begin 
                      if ((TLESe28_3_V_1<TLESe28_3_V_0))  begin 
                               xpc10 <= 6'd34/*34:xpc10:34*/;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd0;
                               end 
                              if (m_axis_tready && (TLESe28_3_V_1>=TLESe28_3_V_0))  begin 
                               TLESe28_3_V_0 <= 32'd1+TLESe28_3_V_0;
                               m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLESe28_3_V_0];
                               m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLESe28_3_V_0];
                               m_axis_tlast <= 1'h1&(TLEsw1_1_V_10==TLESe28_3_V_0);
                               m_axis_tkeep <= A_8_US_CC_SCALbx20_ARA0[8'h1*(32'hffffffff&TLESe28_3_V_0)];
                               m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLESe28_3_V_0];
                               end 
                               end 
                      
                  6'd37/*37:US*/:  begin 
                      if ((TLEsw1_1_V_10<(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               xpc10 <= 5'd27/*27:xpc10:27*/;
                               LoEthernetEcho_tmp2 <= LoEthernetEcho_dst_ip|{LoEthernetEcho_src_ip, 32'd0};
                               LoEthernetEcho_tmp3 <= 64'h_1100|(-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd4]);
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca25_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca25_5_V_4+TLEca25_5_V_5
                              )+(TLEca25_5_V_4+TLEca25_5_V_5>>5'd16)))+(TLEca25_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca25_5_V_4+
                              TLEca25_5_V_5)+(TLEca25_5_V_4+TLEca25_5_V_5>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && (3'd4/*4:MS*/==(32'hffffffff&32'd1+TLEsw1_1_V_4
                      )))  begin 
                               xpc10 <= 6'd36/*36:xpc10:36*/;
                               LoEthernetEcho_tmp2 <= (A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4]>>5'd16);
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca25_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca25_5_V_4+TLEca25_5_V_5
                              )+(TLEca25_5_V_4+TLEca25_5_V_5>>5'd16)))+(TLEca25_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca25_5_V_4+
                              TLEca25_5_V_5)+(TLEca25_5_V_4+TLEca25_5_V_5>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && (3'd4/*4:MS*/!=(32'hffffffff&32'd1+TLEsw1_1_V_4
                      )))  begin 
                               xpc10 <= 6'd36/*36:xpc10:36*/;
                               LoEthernetEcho_tmp2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca25_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca25_5_V_4+TLEca25_5_V_5
                              )+(TLEca25_5_V_4+TLEca25_5_V_5>>5'd16)))+(TLEca25_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca25_5_V_4+
                              TLEca25_5_V_5)+(TLEca25_5_V_4+TLEca25_5_V_5>>5'd16))>>5'd16);

                               end 
                               end 
                      
                  7'd93/*93:US*/:  begin 
                      if (!cam_match && (LoEthernetEcho_mem_controller_cnt!=8'd255/*255:US*/))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= 32'd256;
                               LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                               TLEca8_1_V_0 <= 32'd256;
                               end 
                              if (!cam_match && (LoEthernetEcho_mem_controller_cnt==8'd255/*255:US*/))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= 32'd256;
                               LoEthernetEcho_mem_controller_cnt <= 32'd0;
                               TLEca8_1_V_0 <= 32'd256;
                               end 
                              if (cam_match && (LoEthernetEcho_mem_controller_cnt!=8'd255/*255:US*/))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= cam_match_addr;
                               LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                               TLEca8_1_V_0 <= cam_match_addr;
                               end 
                              if (cam_match && (LoEthernetEcho_mem_controller_cnt==8'd255/*255:US*/))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= cam_match_addr;
                               LoEthernetEcho_mem_controller_cnt <= 32'd0;
                               TLEca8_1_V_0 <= cam_match_addr;
                               end 
                               end 
                      
                  7'd94/*94:US*/:  begin 
                      if (!cam_busy && (TLEsw1_1_V_9==1'd1/*1:US*/))  begin 
                               xpc10 <= 7'd89/*89:xpc10:89*/;
                               TLEca8_1_V_0 <= 8'hff&LoEthernetEcho_mem_controller_cnt;
                               cam_wr_addr <= LoEthernetEcho_mem_controller_cnt;
                               cam_din <= LoEthernetEcho_key;
                               end 
                              if (!cam_busy && (TLEsw1_1_V_9==2'd2/*2:US*/) && (LoEthernetEcho_mem_controller_cnt!=8'd255/*255:US*/)) 
                       begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= TLEca8_1_V_0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                               end 
                              if (!cam_busy && (TLEsw1_1_V_9==2'd2/*2:US*/) && (LoEthernetEcho_mem_controller_cnt==8'd255/*255:US*/)) 
                       begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= TLEca8_1_V_0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd0;
                               end 
                              if (!cam_busy && (TLEsw1_1_V_9==2'd3/*3:US*/) && (LoEthernetEcho_mem_controller_cnt!=8'd255/*255:US*/)) 
                       begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= TLEca8_1_V_0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                               end 
                              if (!cam_busy && (TLEsw1_1_V_9==2'd3/*3:US*/) && (LoEthernetEcho_mem_controller_cnt==8'd255/*255:US*/)) 
                       begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= TLEca8_1_V_0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd0;
                               end 
                              if (!cam_busy && (TLEsw1_1_V_9!=0/*0:US*/) && (TLEsw1_1_V_9!=1'd1/*1:US*/) && (TLEsw1_1_V_9!=2'd2/*2:US*/) && 
                      (TLEsw1_1_V_9!=2'd3/*3:US*/) && (TLEsw1_1_V_9!=3'd4/*4:US*/) && (LoEthernetEcho_mem_controller_cnt!=8'd255/*255:US*/)) 
                       begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= TLEca8_1_V_0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                               end 
                              if (!cam_busy && (TLEsw1_1_V_9!=0/*0:US*/) && (TLEsw1_1_V_9!=1'd1/*1:US*/) && (TLEsw1_1_V_9!=2'd2/*2:US*/) && 
                      (TLEsw1_1_V_9!=2'd3/*3:US*/) && (TLEsw1_1_V_9!=3'd4/*4:US*/) && (LoEthernetEcho_mem_controller_cnt==8'd255/*255:US*/)) 
                       begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_17 <= TLEca8_1_V_0;
                               LoEthernetEcho_mem_controller_cnt <= 32'd0;
                               end 
                              if (!cam_busy && (TLEsw1_1_V_9==0/*0:US*/))  begin 
                               xpc10 <= 7'd92/*92:xpc10:92*/;
                               cam_cmp_din <= LoEthernetEcho_key;
                               end 
                              if (!cam_busy && (TLEsw1_1_V_9==3'd4/*4:US*/))  begin 
                               xpc10 <= 7'd82/*82:xpc10:82*/;
                               cam_cmp_din <= LoEthernetEcho_key;
                               end 
                               end 
                      endcase
              if ((LoEthernetEcho_mem_controller_cnt==8'd255/*255:US*/)) 
                  case (xpc10)
                      7'd88/*88:US*/:  begin 
                           xpc10 <= 4'd10/*10:xpc10:10*/;
                           TLEsw1_1_V_17 <= TLEca8_1_V_0;
                           LoEthernetEcho_mem_controller_cnt <= 32'd0;
                           end 
                          
                      7'd91/*91:US*/:  begin 
                           xpc10 <= 4'd10/*10:xpc10:10*/;
                           TLEsw1_1_V_17 <= TLEca8_1_V_0;
                           LoEthernetEcho_mem_controller_cnt <= 32'd0;
                           end 
                          endcase
                   else 
                  case (xpc10)
                      7'd88/*88:US*/:  begin 
                           xpc10 <= 4'd10/*10:xpc10:10*/;
                           TLEsw1_1_V_17 <= TLEca8_1_V_0;
                           LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                           end 
                          
                      7'd91/*91:US*/:  begin 
                           xpc10 <= 4'd10/*10:xpc10:10*/;
                           TLEsw1_1_V_17 <= TLEca8_1_V_0;
                           LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                           end 
                          endcase

              case (xpc10)
                  3'd7/*7:US*/:  begin 
                      if (TLEsw1_1_V_12 && TLEsw1_1_V_13)  begin 
                               xpc10 <= 4'd8/*8:xpc10:8*/;
                               TLEca6_0_V_1 <= (A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd48);
                               TLEca6_0_V_0 <= 8'd1;
                               TLEca6_0_V_12 <= 32'd0;
                               TLEca6_0_V_7 <= 32'd0;
                               TLEca6_0_V_6 <= 32'd0;
                               end 
                              if (TLEsw1_1_V_12 && !TLEsw1_1_V_13)  xpc10 <= 6'd33/*33:xpc10:33*/;
                          if (!TLEsw1_1_V_12)  xpc10 <= 6'd33/*33:xpc10:33*/;
                           end 
                      
                  4'd10/*10:US*/:  begin 
                      if ((TLEsw1_1_V_9==1'd1/*1:US*/))  begin 
                               xpc10 <= 4'd11/*11:xpc10:11*/;
                               TLEsw1_1_V_19 <= 1'h1&(TLEsw1_1_V_17==9'd256/*256:US*/);
                               A_64_US_CC_SCALbx16_ARD0[4'h8*(32'hffffffff&TLEsw1_1_V_17)] <= 64'hffffffffffffffff&LoEthernetEcho_extras
                              ;

                               A_64_US_CC_SCALbx18_ARE0[4'h8*(32'hffffffff&TLEsw1_1_V_17)] <= 64'hffffffffffffffff&LoEthernetEcho_key_value
                              ;

                               end 
                              if ((TLEsw1_1_V_9!=1'd1/*1:US*/) && !TLEsw1_1_V_9)  begin 
                               xpc10 <= 4'd11/*11:xpc10:11*/;
                               TLEsw1_1_V_19 <= 1'h1&(TLEsw1_1_V_17==9'd256/*256:US*/);
                               LoEthernetEcho_flag <= A_64_US_CC_SCALbx16_ARD0[4'h8*(32'hffffffff&TLEsw1_1_V_17)];
                               LoEthernetEcho_key_value <= A_64_US_CC_SCALbx18_ARE0[4'h8*(32'hffffffff&TLEsw1_1_V_17)];
                               end 
                              if ((TLEsw1_1_V_9!=1'd1/*1:US*/) && !(!TLEsw1_1_V_9))  begin 
                               xpc10 <= 4'd11/*11:xpc10:11*/;
                               TLEsw1_1_V_19 <= 1'h1&(TLEsw1_1_V_17==9'd256/*256:US*/);
                               end 
                               end 
                      endcase
              if (!cam_match && (LoEthernetEcho_mem_controller_cnt!=8'd255/*255:US*/) && (xpc10==7'd84/*84:US*/))  begin 
                       xpc10 <= 4'd10/*10:xpc10:10*/;
                       TLEsw1_1_V_17 <= TLEca8_1_V_0;
                       LoEthernetEcho_mem_controller_cnt <= 32'd1+LoEthernetEcho_mem_controller_cnt;
                       end 
                      if (!cam_match && (LoEthernetEcho_mem_controller_cnt==8'd255/*255:US*/) && (xpc10==7'd84/*84:US*/))  begin 
                       xpc10 <= 4'd10/*10:xpc10:10*/;
                       TLEsw1_1_V_17 <= TLEca8_1_V_0;
                       LoEthernetEcho_mem_controller_cnt <= 32'd0;
                       end 
                      if (cam_match && (xpc10==7'd84/*84:US*/))  xpc10 <= 7'd85/*85:xpc10:85*/;
                  
              case (xpc10)
                  3'd4/*4:US*/:  begin 
                       xpc10 <= 3'd5/*5:xpc10:5*/;
                       TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'd0];
                       TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                       TLEsw1_1_V_4 <= 32'd0;
                       TLEsw1_1_V_10 <= TLERe1_1_V_1;
                       TLERe1_1_V_0 <= 32'd0;
                       s_axis_tready <= 1'd0;
                       end 
                      
                  3'd6/*6:US*/:  begin 
                       xpc10 <= 3'd7/*7:xpc10:7*/;
                       TLEsw1_1_V_9 <= LoEthernetEcho_opcode;
                       TLEsw1_1_V_8 <= LoEthernetEcho_magic_num;
                       TLEsw1_1_V_14 <= 1'h1&LoEthernetEcho_proto_ICMP;
                       TLEsw1_1_V_13 <= 1'h1&LoEthernetEcho_proto_UDP;
                       TLEsw1_1_V_12 <= 1'h1&LoEthernetEcho_IPv4;
                       end 
                      
                  4'd11/*11:US*/:  begin 
                       xpc10 <= 4'd12/*12:xpc10:12*/;
                       TLEsw14_14_V_2 <= 1'h1&TLEsw1_1_V_14;
                       TLEsw14_14_V_1 <= 1'h1&TLEsw1_1_V_13;
                       LoEthernetEcho_chksumIP <= 32'd0;
                       LoEthernetEcho_chksum_UDP <= 32'd0;
                       A_64_US_CC_SCALbx14_ARC0[0] <= 64'hffffffffffffffff&LoEthernetEcho_src_mac|{LoEthernetEcho_dst_mac, 48'd0};
                       end 
                      
                  5'd16/*16:US*/:  begin 
                      if (!TLEsw14_14_V_1 && TLEsw14_14_V_2)  begin 
                               xpc10 <= 5'd17/*17:xpc10:17*/;
                               TLEsw14_14_V_0 <= (-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd4])|(LoEthernetEcho_src_ip>>5'd16
                              );

                               end 
                              if (TLEsw14_14_V_1 && !TLEsw14_14_V_2)  begin 
                               xpc10 <= 5'd17/*17:xpc10:17*/;
                               TLEsw14_14_V_0 <= (-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd4])|(LoEthernetEcho_src_ip>>5'd16
                              )|{LoEthernetEcho_app_src_port, 32'd0}|{LoEthernetEcho_app_dst_port, 16'd0};

                               end 
                              if (TLEsw14_14_V_1 && TLEsw14_14_V_2)  begin 
                               xpc10 <= 5'd17/*17:xpc10:17*/;
                               TLEsw14_14_V_0 <= (-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd4])|(LoEthernetEcho_src_ip>>5'd16
                              );

                               end 
                              if (!TLEsw14_14_V_1 && !TLEsw14_14_V_2)  xpc10 <= 5'd17/*17:xpc10:17*/;
                           end 
                      
                  5'd21/*21:US*/:  begin 
                       xpc10 <= 5'd22/*22:xpc10:22*/;
                       TLEca21_7_V_1 <= (A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd48);
                       TLEca21_7_V_0 <= 8'd1;
                       TLEca21_7_V_12 <= 32'd0;
                       TLEca21_7_V_7 <= 32'd0;
                       TLEca21_7_V_6 <= 32'd0;
                       end 
                      
                  5'd26/*26:US*/: if ((TLEsw1_1_V_10<32'd4))  begin 
                           xpc10 <= 5'd27/*27:xpc10:27*/;
                           LoEthernetEcho_tmp2 <= LoEthernetEcho_dst_ip|{LoEthernetEcho_src_ip, 32'd0};
                           LoEthernetEcho_tmp3 <= 64'h_1100|(-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd4]);
                           TLEsw1_1_V_4 <= 32'd4;
                           end 
                           else  begin 
                           xpc10 <= 6'd36/*36:xpc10:36*/;
                           LoEthernetEcho_tmp2 <= (A_64_US_CC_SCALbx14_ARC0[32'd4]>>5'd16);
                           TLEsw1_1_V_4 <= 32'd4;
                           end 
                          endcase
              if (cam_match)  begin if ((xpc10==7'd83/*83:US*/))  begin 
                           xpc10 <= 7'd84/*84:xpc10:84*/;
                           TLEca8_1_V_0 <= cam_match_addr;
                           end 
                           end 
                   else if ((xpc10==7'd83/*83:US*/))  begin 
                           xpc10 <= 7'd84/*84:xpc10:84*/;
                           TLEca8_1_V_0 <= 32'd256;
                           end 
                          
              case (xpc10)
                  4'd8/*8:US*/:  begin 
                       xpc10 <= 4'd9/*9:xpc10:9*/;
                       TLEca6_0_V_7 <= (64'h_ffff&hprpin155610)+(hprpin155610>>5'd16);
                       TLEca6_0_V_6 <= (64'h_ffff&hprpin155110)+(hprpin155110>>5'd16);
                       end 
                      
                  4'd12/*12:US*/:  begin 
                       xpc10 <= 4'd13/*13:xpc10:13*/;
                       TLEsw14_14_V_0 <= (-64'h1_0000_0000&A_64_US_CC_SCALbx14_ARC0[64'd1])|(LoEthernetEcho_dst_mac>>5'd16);
                       end 
                      
                  4'd13/*13:US*/:  begin 
                       xpc10 <= 4'd14/*14:xpc10:14*/;
                       A_64_US_CC_SCALbx14_ARC0[64'd1] <= 64'hffffffffffffffff&TLEsw14_14_V_0;
                       end 
                      
                  4'd14/*14:US*/:  begin 
                       xpc10 <= 4'd15/*15:xpc10:15*/;
                       TLEsw14_14_V_0 <= (64'h_ffff&A_64_US_CC_SCALbx14_ARC0[2'd3])|{LoEthernetEcho_dst_ip, 16'd0}|{LoEthernetEcho_src_ip
                      , 48'd0};

                       end 
                      
                  4'd15/*15:US*/:  begin 
                       xpc10 <= 5'd16/*16:xpc10:16*/;
                       A_64_US_CC_SCALbx14_ARC0[2'd3] <= 64'hffffffffffffffff&TLEsw14_14_V_0;
                       end 
                      
                  5'd17/*17:US*/:  begin 
                       xpc10 <= 5'd18/*18:xpc10:18*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd4] <= 64'hffffffffffffffff&TLEsw14_14_V_0;
                       end 
                      
                  5'd20/*20:US*/:  begin 
                       xpc10 <= 5'd21/*21:xpc10:21*/;
                       LoEthernetEcho_tmp <= A_64_US_CC_SCALbx14_ARC0[2'd3];
                       end 
                      
                  5'd22/*22:US*/:  begin 
                       xpc10 <= 5'd23/*23:xpc10:23*/;
                       TLEca21_7_V_7 <= (64'h_ffff&hprpin168910)+(hprpin168910>>5'd16);
                       TLEca21_7_V_6 <= (64'h_ffff&hprpin168410)+(hprpin168410>>5'd16);
                       end 
                      
                  5'd24/*24:US*/:  begin 
                       xpc10 <= 5'd25/*25:xpc10:25*/;
                       A_64_US_CC_SCALbx14_ARC0[2'd3] <= 64'hffffffffffffffff&LoEthernetEcho_tmp|(LoEthernetEcho_chksumIP>>4'd8)|{64'd255
                      &LoEthernetEcho_chksumIP, 8'd0};

                       end 
                      
                  5'd25/*25:US*/:  begin 
                       xpc10 <= 5'd26/*26:xpc10:26*/;
                       LoEthernetEcho_tmp <= A_64_US_CC_SCALbx14_ARC0[3'd5];
                       end 
                      
                  5'd27/*27:US*/:  begin 
                       xpc10 <= 5'd28/*28:xpc10:28*/;
                       TLEca27_17_V_5 <= (64'h_ffff&hprpin174210)+(hprpin174210>>5'd16);
                       TLEca27_17_V_4 <= (64'h_ffff&hprpin173710)+(hprpin173710>>5'd16);
                       TLEca27_17_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  5'd28/*28:US*/:  begin 
                       xpc10 <= 5'd29/*29:xpc10:29*/;
                       LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca27_17_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca27_17_V_4+TLEca27_17_V_5
                      )+(TLEca27_17_V_4+TLEca27_17_V_5>>5'd16)))+(TLEca27_17_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca27_17_V_4+TLEca27_17_V_5
                      )+(TLEca27_17_V_4+TLEca27_17_V_5>>5'd16))>>5'd16);

                       end 
                      
                  5'd29/*29:US*/:  begin 
                       xpc10 <= 5'd30/*30:xpc10:30*/;
                       TLEca27_20_V_5 <= (64'h_ffff&hprpin176310)+(hprpin176310>>5'd16);
                       TLEca27_20_V_4 <= (64'h_ffff&hprpin175810)+(hprpin175810>>5'd16);
                       TLEca27_20_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  5'd30/*30:US*/:  begin 
                       xpc10 <= 5'd31/*31:xpc10:31*/;
                       LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca27_20_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca27_20_V_4+TLEca27_20_V_5
                      )+(TLEca27_20_V_4+TLEca27_20_V_5>>5'd16)))+(TLEca27_20_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca27_20_V_4+TLEca27_20_V_5
                      )+(TLEca27_20_V_4+TLEca27_20_V_5>>5'd16))>>5'd16);

                       end 
                      
                  5'd31/*31:US*/:  begin 
                       xpc10 <= 6'd32/*32:xpc10:32*/;
                       LoEthernetEcho_tmp2 <= 64'h_ffff&32'h_ffff_ffff^LoEthernetEcho_chksum_UDP;
                       end 
                      
                  6'd32/*32:US*/:  begin 
                       xpc10 <= 6'd33/*33:xpc10:33*/;
                       LoEthernetEcho_tmp3 <= {64'd255&LoEthernetEcho_tmp2, 8'd0}|(LoEthernetEcho_tmp2>>4'd8);
                       A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&LoEthernetEcho_tmp|(64'hffffffffffffffff&{64'd255&LoEthernetEcho_tmp2
                      , 8'd0}|(LoEthernetEcho_tmp2>>4'd8));

                       end 
                      
                  6'd36/*36:US*/:  begin 
                       xpc10 <= 6'd37/*37:xpc10:37*/;
                       TLEca25_5_V_5 <= (64'h_ffff&hprpin176310)+(hprpin176310>>5'd16);
                       TLEca25_5_V_4 <= (64'h_ffff&hprpin175810)+(hprpin175810>>5'd16);
                       TLEca25_5_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  6'd38/*38:US*/:  begin 
                       xpc10 <= 6'd39/*39:xpc10:39*/;
                       A_64_US_CC_SCALbx14_ARC0[2'd2] <= 64'hffffffffffffffff&TLEMe20_2_V_1|(64'h_ff00&{TLEMe20_2_V_0, 8'd0})|(TLEMe20_2_V_0
                      >>4'd8);

                       end 
                      
                  6'd39/*39:US*/:  begin 
                       xpc10 <= 6'd40/*40:xpc10:40*/;
                       TLEMe20_2_V_0 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[2'd3];
                       end 
                      
                  6'd41/*41:US*/:  begin 
                       xpc10 <= 6'd42/*42:xpc10:42*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd4] <= 64'hffffffffffffffff&TLEMe20_2_V_1|{64'h_ff00&TLEMe20_2_V_0, 40'd0}|{TLEMe20_2_V_0
                      , 56'd0};

                       end 
                      
                  6'd42/*42:US*/:  begin 
                       xpc10 <= 6'd43/*43:xpc10:43*/;
                       TLEMe20_2_V_0 <= A_64_US_CC_SCALbx14_ARC0[3'd5];
                       end 
                      
                  6'd43/*43:US*/:  begin 
                       xpc10 <= 6'd44/*44:xpc10:44*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&64'h_ffff_ffff_ffff_0000&TLEMe20_2_V_0;
                       end 
                      
                  6'd44/*44:US*/:  begin 
                       xpc10 <= 6'd45/*45:xpc10:45*/;
                       TLEMe20_2_V_0 <= 64'h_ffff&A_64_US_CC_SCALbx14_ARC0[3'd6];
                       end 
                      
                  6'd47/*47:US*/:  begin 
                       xpc10 <= 6'd48/*48:xpc10:48*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd7] <= 64'hffffffffffffffff&TLEMe20_2_V_0;
                       end 
                      
                  6'd49/*49:US*/:  begin 
                       xpc10 <= 6'd50/*50:xpc10:50*/;
                       A_64_US_CC_SCALbx14_ARC0[4'd8] <= 64'hffffffffffffffff&TLEMe20_2_V_0;
                       end 
                      
                  6'd50/*50:US*/:  begin 
                       xpc10 <= 6'd51/*51:xpc10:51*/;
                       A_64_US_CC_SCALbx14_ARC0[4'd9] <= 64'h_2052_4f52_5245_0000;
                       end 
                      
                  6'd51/*51:US*/:  begin 
                       xpc10 <= 5'd20/*20:xpc10:20*/;
                       TLEsw1_1_V_10 <= 32'd10;
                       A_8_US_CC_SCALbx20_ARA0[4'ha] <= 8'd3;
                       A_64_US_CC_SCALbx10_ARA0[0] <= 64'hffffffffffffffff&64'd82|{LoEthernetEcho_src_port, 24'd0}|{LoEthernetEcho_src_port
                      , 16'd0};

                       A_64_US_CC_SCALbx14_ARC0[4'd10] <= 64'h_3130;
                       end 
                      
                  6'd52/*52:US*/:  begin 
                       xpc10 <= 5'd20/*20:xpc10:20*/;
                       TLEsw1_1_V_10 <= 32'd10;
                       A_8_US_CC_SCALbx20_ARA0[4'ha] <= 8'd63;
                       A_64_US_CC_SCALbx10_ARA0[0] <= 64'hffffffffffffffff&64'd86|{LoEthernetEcho_src_port, 24'd0}|{LoEthernetEcho_src_port
                      , 16'd0};

                       A_64_US_CC_SCALbx14_ARC0[4'd10] <= 64'hffffffffffffffff&(LoEthernetEcho_key_value>>5'd16);
                       end 
                      
                  6'd53/*53:US*/:  begin 
                       xpc10 <= 6'd54/*54:xpc10:54*/;
                       A_64_US_CC_SCALbx14_ARC0[2'd2] <= 64'hffffffffffffffff&TLEMe19_2_V_1|(64'h_ff00&{TLEMe19_2_V_0, 8'd0})|(TLEMe19_2_V_0
                      >>4'd8);

                       end 
                      
                  6'd54/*54:US*/:  begin 
                       xpc10 <= 6'd55/*55:xpc10:55*/;
                       TLEMe19_2_V_0 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[2'd3];
                       end 
                      
                  6'd56/*56:US*/:  begin 
                       xpc10 <= 6'd57/*57:xpc10:57*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd4] <= 64'hffffffffffffffff&TLEMe19_2_V_1|{64'h_ff00&TLEMe19_2_V_0, 40'd0}|{TLEMe19_2_V_0
                      , 56'd0};

                       end 
                      
                  6'd57/*57:US*/:  begin 
                       xpc10 <= 6'd58/*58:xpc10:58*/;
                       TLEMe19_2_V_0 <= A_64_US_CC_SCALbx14_ARC0[3'd5];
                       end 
                      
                  6'd58/*58:US*/:  begin 
                       xpc10 <= 6'd59/*59:xpc10:59*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&64'h_ffff_ffff_ffff_0000&TLEMe19_2_V_0;
                       end 
                      
                  6'd59/*59:US*/:  begin 
                       xpc10 <= 6'd60/*60:xpc10:60*/;
                       TLEMe19_2_V_0 <= 64'h_ffff&A_64_US_CC_SCALbx14_ARC0[3'd6];
                       end 
                      
                  6'd60/*60:US*/:  begin 
                       xpc10 <= 6'd61/*61:xpc10:61*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd6] <= 64'hffffffffffffffff&64'h481_0000|TLEMe19_2_V_0;
                       end 
                      
                  6'd62/*62:US*/:  begin 
                       xpc10 <= 6'd63/*63:xpc10:63*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd7] <= 64'hffffffffffffffff&TLEMe19_2_V_0;
                       end 
                      
                  7'd64/*64:US*/:  begin 
                       xpc10 <= 7'd65/*65:xpc10:65*/;
                       A_64_US_CC_SCALbx14_ARC0[4'd8] <= 64'hffffffffffffffff&TLEMe19_2_V_0;
                       end 
                      
                  7'd65/*65:US*/:  begin 
                       xpc10 <= 5'd20/*20:xpc10:20*/;
                       TLEsw1_1_V_10 <= 32'd9;
                       A_8_US_CC_SCALbx20_ARA0[4'h9] <= 8'd3;
                       A_64_US_CC_SCALbx10_ARA0[0] <= 64'hffffffffffffffff&64'd74|{LoEthernetEcho_src_port, 24'd0}|{LoEthernetEcho_src_port
                      , 16'd0};

                       A_64_US_CC_SCALbx14_ARC0[4'd9] <= 32'd0;
                       end 
                      
                  7'd66/*66:US*/:  begin 
                       xpc10 <= 7'd67/*67:xpc10:67*/;
                       A_64_US_CC_SCALbx14_ARC0[4'd8] <= 64'hffffffffffffffff&TLEMe19_2_V_0;
                       end 
                      
                  7'd67/*67:US*/:  begin 
                       xpc10 <= 7'd68/*68:xpc10:68*/;
                       A_64_US_CC_SCALbx14_ARC0[4'd9] <= 64'h_2052_4f52_5245_0000;
                       end 
                      
                  7'd68/*68:US*/:  begin 
                       xpc10 <= 5'd20/*20:xpc10:20*/;
                       TLEsw1_1_V_10 <= 32'd10;
                       A_8_US_CC_SCALbx20_ARA0[4'ha] <= 8'd3;
                       A_64_US_CC_SCALbx10_ARA0[0] <= 64'hffffffffffffffff&64'd82|{LoEthernetEcho_src_port, 24'd0}|{LoEthernetEcho_src_port
                      , 16'd0};

                       A_64_US_CC_SCALbx14_ARC0[4'd10] <= 64'h_3130;
                       end 
                      
                  7'd69/*69:US*/:  begin 
                       xpc10 <= 7'd70/*70:xpc10:70*/;
                       A_64_US_CC_SCALbx14_ARC0[2'd2] <= 64'hffffffffffffffff&TLEMe18_1_V_1|(64'h_ff00&{TLEMe18_1_V_0, 8'd0})|(TLEMe18_1_V_0
                      >>4'd8);

                       end 
                      
                  7'd70/*70:US*/:  begin 
                       xpc10 <= 7'd71/*71:xpc10:71*/;
                       TLEMe18_1_V_0 <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx14_ARC0[2'd3];
                       end 
                      
                  7'd71/*71:US*/:  begin 
                       xpc10 <= 7'd72/*72:xpc10:72*/;
                       TLEMe18_1_V_1 <= 64'h_ffff_ffff_ffff&A_64_US_CC_SCALbx14_ARC0[3'd4];
                       TLEMe18_1_V_0 <= 64'h_ffff_ffff_ffff_ffea+((64'h_ff00&{LoEthernetEcho_UDP_total_length, 8'd0})|(LoEthernetEcho_UDP_total_length
                      >>4'd8));

                       A_64_US_CC_SCALbx14_ARC0[2'd3] <= 64'hffffffffffffffff&TLEMe18_1_V_0;
                       end 
                      
                  7'd72/*72:US*/:  begin 
                       xpc10 <= 7'd73/*73:xpc10:73*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd4] <= 64'hffffffffffffffff&TLEMe18_1_V_1|{64'h_ff00&TLEMe18_1_V_0, 40'd0}|{TLEMe18_1_V_0
                      , 56'd0};

                       end 
                      
                  7'd73/*73:US*/:  begin 
                       xpc10 <= 7'd74/*74:xpc10:74*/;
                       TLEMe18_1_V_0 <= A_64_US_CC_SCALbx14_ARC0[3'd5];
                       end 
                      
                  7'd74/*74:US*/:  begin 
                       xpc10 <= 7'd75/*75:xpc10:75*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&64'h_ffff_ffff_ffff_0000&TLEMe18_1_V_0;
                       end 
                      
                  7'd75/*75:US*/:  begin 
                       xpc10 <= 7'd76/*76:xpc10:76*/;
                       TLEMe18_1_V_0 <= 64'h_ffff&A_64_US_CC_SCALbx14_ARC0[3'd6];
                       end 
                      
                  7'd76/*76:US*/:  begin 
                       xpc10 <= 7'd77/*77:xpc10:77*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd6] <= 64'hffffffffffffffff&64'h181_0000|TLEMe18_1_V_0;
                       end 
                      
                  7'd77/*77:US*/:  begin 
                       xpc10 <= 7'd78/*78:xpc10:78*/;
                       TLEMe18_1_V_0 <= -64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd7];
                       end 
                      
                  7'd78/*78:US*/:  begin 
                       xpc10 <= 7'd79/*79:xpc10:79*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd7] <= 64'hffffffffffffffff&TLEMe18_1_V_0;
                       end 
                      
                  7'd79/*79:US*/:  begin 
                       xpc10 <= 7'd80/*80:xpc10:80*/;
                       TLEMe18_1_V_0 <= 64'h_ffff&A_64_US_CC_SCALbx14_ARC0[4'd8];
                       end 
                      
                  7'd80/*80:US*/:  begin 
                       xpc10 <= 7'd81/*81:xpc10:81*/;
                       A_64_US_CC_SCALbx14_ARC0[4'd8] <= 64'hffffffffffffffff&TLEMe18_1_V_0;
                       end 
                      
                  7'd81/*81:US*/:  begin 
                       xpc10 <= 5'd20/*20:xpc10:20*/;
                       TLEsw1_1_V_10 <= 32'd9;
                       A_8_US_CC_SCALbx20_ARA0[4'h9] <= 8'd3;
                       A_64_US_CC_SCALbx10_ARA0[0] <= 64'hffffffffffffffff&64'd74|{LoEthernetEcho_src_port, 24'd0}|{LoEthernetEcho_src_port
                      , 16'd0};

                       A_64_US_CC_SCALbx14_ARC0[4'd9] <= 32'd0;
                       end 
                      
                  7'd82/*82:US*/:  begin 
                       xpc10 <= 7'd83/*83:xpc10:83*/;
                       cam_cmp_din <= LoEthernetEcho_key;
                       end 
                      
                  7'd85/*85:US*/:  begin 
                       xpc10 <= 7'd86/*86:xpc10:86*/;
                       cam_wr_addr <= TLEca8_1_V_0;
                       cam_din <= 32'd0;
                       end 
                      
                  7'd86/*86:US*/:  begin 
                       xpc10 <= 7'd87/*87:xpc10:87*/;
                       cam_we <= 1'd1;
                       end 
                      
                  7'd87/*87:US*/:  begin 
                       xpc10 <= 7'd88/*88:xpc10:88*/;
                       cam_we <= 1'd0;
                       end 
                      
                  7'd89/*89:US*/:  begin 
                       xpc10 <= 7'd90/*90:xpc10:90*/;
                       cam_we <= 1'd1;
                       end 
                      
                  7'd90/*90:US*/:  begin 
                       xpc10 <= 7'd91/*91:xpc10:91*/;
                       cam_we <= 1'd0;
                       end 
                      
                  7'd92/*92:US*/:  begin 
                       xpc10 <= 7'd93/*93:xpc10:93*/;
                       cam_cmp_din <= LoEthernetEcho_key;
                       end 
                      endcase
              if ((xpc10==5'd18/*18:US*/))  xpc10 <= 5'd19/*19:xpc10:19*/;
                   end 
              //End structure HPR EthernetEcho.dll


       end 
      

assign hprpin155110 = (64'hffffffffffffffff&{64'd255&TLEca6_0_V_1, 8'd0}|((64'h_ff00&TLEca6_0_V_1)>>4'd8))+(64'hffffffffffffffff&{64'd255&(TLEca6_0_V_1>>5'd16
), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>5'd16))>>4'd8));

assign hprpin155610 = (64'hffffffffffffffff&{64'd255&(TLEca6_0_V_1>>6'd32), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>6'd32))>>4'd8))+(64'hffffffffffffffff&{64'd255
&(TLEca6_0_V_1>>6'd48), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>6'd48))>>4'd8));

assign hprpin168410 = (64'hffffffffffffffff&{64'd255&TLEca21_7_V_1, 8'd0}|((64'h_ff00&TLEca21_7_V_1)>>4'd8))+(64'hffffffffffffffff&{64'd255&(TLEca21_7_V_1>>
5'd16), 8'd0}|((64'h_ff00&(TLEca21_7_V_1>>5'd16))>>4'd8));

assign hprpin168910 = (64'hffffffffffffffff&{64'd255&(TLEca21_7_V_1>>6'd32), 8'd0}|((64'h_ff00&(TLEca21_7_V_1>>6'd32))>>4'd8))+(64'hffffffffffffffff&{64'd255
&(TLEca21_7_V_1>>6'd48), 8'd0}|((64'h_ff00&(TLEca21_7_V_1>>6'd48))>>4'd8));

assign hprpin173710 = (64'hffffffffffffffff&{64'd255&LoEthernetEcho_tmp3, 8'd0}|((64'h_ff00&LoEthernetEcho_tmp3)>>4'd8))+(64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp3
>>5'd16), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp3>>5'd16))>>4'd8));

assign hprpin174210 = (64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp3>>6'd32), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp3>>6'd32))>>4'd8))+(64'hffffffffffffffff
&{64'd255&(LoEthernetEcho_tmp3>>6'd48), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp3>>6'd48))>>4'd8));

assign hprpin175810 = (64'hffffffffffffffff&{64'd255&LoEthernetEcho_tmp2, 8'd0}|((64'h_ff00&LoEthernetEcho_tmp2)>>4'd8))+(64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp2
>>5'd16), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>5'd16))>>4'd8));

assign hprpin176310 = (64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp2>>6'd32), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>6'd32))>>4'd8))+(64'hffffffffffffffff
&{64'd255&(LoEthernetEcho_tmp2>>6'd48), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>6'd48))>>4'd8));

// 1 vectors of width 7
// 45 vectors of width 64
// 7 vectors of width 8
// 9 vectors of width 32
// 10 vectors of width 1
// 1280 array locations of width 64
// 256 array locations of width 8
// Total state bits in module = 87209 bits.
// 512 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
// eof (HPR L/S Verilog)
