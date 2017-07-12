

// CBG Orangepath HPR L/S System

// Verilog output file generated at 04/05/2016 18:13:44
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
    output [63:0] cam_din,
    output cam_we,
    output [7:0] cam_wr_addr,
    input clk,
    input reset);
  reg LoEthernetEcho_proto_UDP;
  reg LoEthernetEcho_LUT_hit;
  integer TLEsw1_1_V_0;
  reg [31:0] TLEsw1_1_V_2;
  reg TLEsw1_1_V_3;
  reg [31:0] TLERe1_3_V_0;
  reg [31:0] TLERe1_3_V_1;
  reg TLERe1_3_V_3;
  reg [31:0] TLESe23_2_V_0;
  reg [31:0] LoEthernetEcho_segm_num;
  reg [63:0] LoEthernetEcho_dst_mac;
  reg [63:0] LoEthernetEcho_broadcast_ports;
  reg [63:0] LoEthernetEcho_tmp;
  reg [63:0] LoEthernetEcho_tmp2;
  reg [63:0] LoEthernetEcho_OQ;
  reg [63:0] LoEthernetEcho_dst_ip;
  reg [63:0] LoEthernetEcho_app_src_port;
  reg [63:0] LoEthernetEcho_app_dst_port;
  reg [7:0] A_8_US_CC_SCALbx18_ARA0[29:0];
  reg [63:0] A_64_US_CC_SCALbx10_ARA0[29:0];
  reg [63:0] A_64_US_CC_SCALbx12_ARB0[29:0];
  reg [63:0] A_64_US_CC_SCALbx14_ARC0[29:0];
  reg [63:0] A_64_US_CC_SCALbx16_ARD0[15:0];
  reg [9:0] xpc10;
 always   @(posedge clk )  begin 
      //Start structure HPR EthernetEcho.dll
      if (reset)  begin 
               cam_cmp_din <= 64'd0;
               TLEsw1_1_V_2 <= 32'd0;
               LoEthernetEcho_app_dst_port <= 64'd0;
               LoEthernetEcho_app_src_port <= 64'd0;
               LoEthernetEcho_dst_ip <= 64'd0;
               TLERe1_3_V_3 <= 1'd0;
               TLERe1_3_V_1 <= 32'd0;
               TLERe1_3_V_0 <= 32'd0;
               LoEthernetEcho_broadcast_ports <= 64'd0;
               LoEthernetEcho_dst_mac <= 64'd0;
               LoEthernetEcho_OQ <= 64'd0;
               LoEthernetEcho_tmp2 <= 64'd0;
               LoEthernetEcho_LUT_hit <= 1'd0;
               LoEthernetEcho_tmp <= 64'd0;
               TLEsw1_1_V_3 <= 1'd0;
               TLEsw1_1_V_0 <= 32'd0;
               s_axis_tready <= 1'd0;
               LoEthernetEcho_segm_num <= 32'd0;
               LoEthernetEcho_proto_UDP <= 1'd0;
               xpc10 <= 10'd0;
               m_axis_tvalid <= 1'd0;
               TLESe23_2_V_0 <= 32'd0;
               m_axis_tuser_low <= 64'd0;
               m_axis_tuser_hi <= 64'd0;
               m_axis_tlast <= 1'd0;
               m_axis_tkeep <= 8'd0;
               m_axis_tdata <= 64'd0;
               end 
               else 
          case (xpc10)
              0/*0:US*/:  begin 
                   xpc10 <= 1'd1/*1:xpc10:1*/;
                   s_axis_tready <= 1'd1;
                   m_axis_tuser_low <= 32'd0;
                   m_axis_tuser_hi <= 32'd0;
                   m_axis_tlast <= 1'd0;
                   m_axis_tkeep <= 8'd0;
                   m_axis_tdata <= 32'd0;
                   LoEthernetEcho_segm_num <= 32'd0;
                   TLEsw1_1_V_3 <= 1'd0;
                   TLEsw1_1_V_2 <= 32'd0;
                   TLEsw1_1_V_0 <= 32'd0;
                   LoEthernetEcho_LUT_hit <= 1'd0;
                   LoEthernetEcho_proto_UDP <= 1'd0;
                   cam_cmp_din <= 32'h_ffff_ffff;
                   A_64_US_CC_SCALbx16_ARD0[4'd15] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[4'd14] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[4'd13] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[4'd12] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[4'd11] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[4'd10] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[4'd9] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[4'd8] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[3'd7] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[3'd6] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[3'd5] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[3'd4] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[2'd3] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[2'd2] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[1'd1] <= 64'd1;
                   A_64_US_CC_SCALbx16_ARD0[0] <= 64'd1;
                   end 
                  
              1'd1/*1:US*/:  begin 
                  if (s_axis_tvalid && s_axis_tlast)  begin 
                           xpc10 <= 2'd2/*2:xpc10:2*/;
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd2;
                           TLERe1_3_V_1 <= 32'd0;
                           TLERe1_3_V_0 <= 32'd1;
                           LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&s_axis_tdata;
                           A_64_US_CC_SCALbx10_ARA0[32'd0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'd0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'd0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'd0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && !s_axis_tlast)  begin 
                           xpc10 <= 2'd2/*2:xpc10:2*/;
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd2;
                           TLERe1_3_V_1 <= 32'd0;
                           TLERe1_3_V_0 <= 32'd1;
                           LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&s_axis_tdata;
                           A_64_US_CC_SCALbx10_ARA0[32'd0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'd0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'd0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'd0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (!s_axis_tvalid)  begin 
                           xpc10 <= 2'd2/*2:xpc10:2*/;
                           TLERe1_3_V_3 <= 1'd1;
                           LoEthernetEcho_segm_num <= 32'd1;
                           TLERe1_3_V_0 <= 32'd0;
                           TLERe1_3_V_1 <= 32'd0;
                           end 
                           end 
                  
              2'd2/*2:US*/:  begin 
                  if (s_axis_tvalid && s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num==3'd5/*5:US*/)) 
                   begin 
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           LoEthernetEcho_app_dst_port <= 64'h_ffff&(s_axis_tdata>>6'd32);
                           LoEthernetEcho_app_src_port <= 64'h_ffff&(s_axis_tdata>>5'd16);
                           LoEthernetEcho_dst_ip <= LoEthernetEcho_dst_ip|{64'h_ffff&s_axis_tdata, 16'd0};
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && !s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  ==3'd5/*5:US*/))  begin 
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           LoEthernetEcho_app_dst_port <= 64'h_ffff&(s_axis_tdata>>6'd32);
                           LoEthernetEcho_app_src_port <= 64'h_ffff&(s_axis_tdata>>5'd16);
                           LoEthernetEcho_dst_ip <= LoEthernetEcho_dst_ip|{64'h_ffff&s_axis_tdata, 16'd0};
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  ==3'd4/*4:US*/))  begin 
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           LoEthernetEcho_dst_ip <= 64'h_ffff&(s_axis_tdata>>6'd48);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && !s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  ==3'd4/*4:US*/))  begin 
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           LoEthernetEcho_dst_ip <= 64'h_ffff&(s_axis_tdata>>6'd48);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  ==2'd3/*3:US*/))  begin 
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           LoEthernetEcho_proto_UDP <= 1'h1&(5'd17/*17:MS*/==(64'd255&(s_axis_tdata>>6'd56)));
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && !s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  ==2'd3/*3:US*/))  begin 
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           LoEthernetEcho_proto_UDP <= 1'h1&(5'd17/*17:MS*/==(64'd255&(s_axis_tdata>>6'd56)));
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  ==1'd1/*1:US*/))  begin 
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&s_axis_tdata;
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && !s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  ==1'd1/*1:US*/))  begin 
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&s_axis_tdata;
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  !=1'd1/*1:US*/) && (LoEthernetEcho_segm_num!=2'd2/*2:US*/) && (LoEthernetEcho_segm_num!=2'd3/*3:US*/) && (LoEthernetEcho_segm_num
                  !=3'd4/*4:US*/) && (LoEthernetEcho_segm_num!=3'd5/*5:US*/))  begin 
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && !s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num
                  !=1'd1/*1:US*/) && (LoEthernetEcho_segm_num!=2'd2/*2:US*/) && (LoEthernetEcho_segm_num!=2'd3/*3:US*/) && (LoEthernetEcho_segm_num
                  !=3'd4/*4:US*/) && (LoEthernetEcho_segm_num!=3'd5/*5:US*/))  begin 
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && (4'd8/*8:MS*/!=(64'h_ffff&(s_axis_tdata>>6'd32))) && s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num
                  ) && (LoEthernetEcho_segm_num==2'd2/*2:US*/))  begin 
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && (4'd8/*8:MS*/!=(64'h_ffff&(s_axis_tdata>>6'd32))) && !s_axis_tlast && TLERe1_3_V_3 && 
                  !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num==2'd2/*2:US*/))  begin 
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && (4'd8/*8:MS*/==(64'h_ffff&(s_axis_tdata>>6'd32))) && s_axis_tlast && TLERe1_3_V_3 && !(!LoEthernetEcho_segm_num
                  ) && (LoEthernetEcho_segm_num==2'd2/*2:US*/))  begin 
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && (4'd8/*8:MS*/==(64'h_ffff&(s_axis_tdata>>6'd32))) && !s_axis_tlast && TLERe1_3_V_3 && 
                  !(!LoEthernetEcho_segm_num) && (LoEthernetEcho_segm_num==2'd2/*2:US*/))  begin 
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && s_axis_tlast && TLERe1_3_V_3 && !LoEthernetEcho_segm_num)  begin 
                           s_axis_tready <= 1'd0;
                           TLERe1_3_V_3 <= 1'd0;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (s_axis_tvalid && !s_axis_tlast && TLERe1_3_V_3 && !LoEthernetEcho_segm_num)  begin 
                           s_axis_tready <= 1'd1;
                           TLERe1_3_V_3 <= 1'h1&s_axis_tvalid;
                           LoEthernetEcho_segm_num <= 32'd1+LoEthernetEcho_segm_num;
                           TLERe1_3_V_1 <= TLERe1_3_V_0;
                           TLERe1_3_V_0 <= 32'd1+(32'hffffffff&TLERe1_3_V_0);
                           A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                           A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                           A_8_US_CC_SCALbx18_ARA0[32'hffffffff&TLERe1_3_V_0] <= 8'hff&s_axis_tkeep;
                           A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_3_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                           end 
                          if (!TLERe1_3_V_3)  begin 
                           xpc10 <= 3'd4/*4:xpc10:4*/;
                           TLEsw1_1_V_2 <= TLERe1_3_V_1;
                           TLERe1_3_V_0 <= 32'd0;
                           s_axis_tready <= 1'd0;
                           end 
                           end 
                  
              3'd4/*4:US*/:  begin 
                   xpc10 <= 4'd8/*8:xpc10:8*/;
                   LoEthernetEcho_tmp2 <= 64'h_ffff&A_64_US_CC_SCALbx16_ARD0[32'd0];
                   LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx16_ARD0[32'd0];
                   TLEsw1_1_V_0 <= 32'd0;
                   LoEthernetEcho_broadcast_ports <= A_64_US_CC_SCALbx10_ARA0[64'd0]|{((64'h55_0000^A_64_US_CC_SCALbx10_ARA0[64'd0])>>
                  4'd8), 16'd0};

                   LoEthernetEcho_dst_mac <= {A_64_US_CC_SCALbx14_ARC0[64'd0], 16'd0};
                   end 
                  
              4'd8/*8:US*/:  begin 
                  if ((LoEthernetEcho_dst_mac==LoEthernetEcho_tmp))  begin 
                           xpc10 <= 5'd16/*16:xpc10:16*/;
                           LoEthernetEcho_tmp <= A_64_US_CC_SCALbx10_ARA0[64'd0]|(64'hffffffffffffffff&{LoEthernetEcho_tmp2, 24'd0});
                           LoEthernetEcho_LUT_hit <= 1'd1;
                           LoEthernetEcho_OQ <= {LoEthernetEcho_tmp2, 24'd0};
                           end 
                          if ((LoEthernetEcho_dst_mac!=LoEthernetEcho_tmp) && ((32'hffffffff&32'd1+TLEsw1_1_V_0)<64'd16))  begin 
                           LoEthernetEcho_tmp2 <= 64'h_ffff&A_64_US_CC_SCALbx16_ARD0[32'hffffffff&32'd1+TLEsw1_1_V_0];
                           LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff_0000&A_64_US_CC_SCALbx16_ARD0[32'hffffffff&32'd1+TLEsw1_1_V_0];
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           end 
                          if ((LoEthernetEcho_dst_mac!=LoEthernetEcho_tmp) && !LoEthernetEcho_LUT_hit && ((32'hffffffff&32'd1+TLEsw1_1_V_0
                  )>=64'd16))  begin 
                           xpc10 <= 5'd16/*16:xpc10:16*/;
                           LoEthernetEcho_tmp <= LoEthernetEcho_broadcast_ports|A_64_US_CC_SCALbx10_ARA0[64'd0];
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           end 
                          if ((LoEthernetEcho_dst_mac!=LoEthernetEcho_tmp) && LoEthernetEcho_LUT_hit && ((32'hffffffff&32'd1+TLEsw1_1_V_0
                  )>=64'd16))  begin 
                           xpc10 <= 5'd16/*16:xpc10:16*/;
                           LoEthernetEcho_tmp <= LoEthernetEcho_OQ|A_64_US_CC_SCALbx10_ARA0[64'd0];
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           end 
                           end 
                  
              5'd16/*16:US*/:  begin 
                  if ((64'h404_afc0_0000_0000!={LoEthernetEcho_dst_ip, 32'd0}) && (4'd8/*8:MS*/==(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0
                  [64'd1]>>6'd32))) && 1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP)  begin 
                           xpc10 <= 6'd32/*32:xpc10:32*/;
                           A_64_US_CC_SCALbx10_ARA0[64'd0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}<64'h_1e00_0000_0000_0000
                  ) && (4'd8/*8:MS*/==(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd32))) && 1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP
                  )  begin 
                           xpc10 <= 6'd32/*32:xpc10:32*/;
                           A_64_US_CC_SCALbx10_ARA0[64'd0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000<{LoEthernetEcho_app_src_port, 16'd0}) && (4'd8/*8:MS*/==(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0
                  [64'd1]>>6'd32))) && 1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP)  begin 
                           xpc10 <= 6'd32/*32:xpc10:32*/;
                           A_64_US_CC_SCALbx10_ARA0[64'd0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000>={LoEthernetEcho_app_src_port, 16'd0}) && ({LoEthernetEcho_app_dst_port, 48'd0}<64'h_3200_0000_0000_0000
                  ) && (4'd8/*8:MS*/==(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd32))) && 1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP
                  )  begin 
                           xpc10 <= 6'd32/*32:xpc10:32*/;
                           A_64_US_CC_SCALbx10_ARA0[64'd0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000>={LoEthernetEcho_app_src_port, 16'd0}) && ({LoEthernetEcho_app_dst_port, 48'd0}>=64'h_3200_0000_0000_0000
                  ) && (4'd8/*8:MS*/==(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd32))) && 1'h1&1'h1&LoEthernetEcho_proto_UDP&1'h1
                  &(0/*0:MS*/==(64'h_3400_0000_0000_0000<{LoEthernetEcho_app_dst_port, 16'd0})))  begin 
                           xpc10 <= 6'd32/*32:xpc10:32*/;
                           A_64_US_CC_SCALbx10_ARA0[64'd0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000>={LoEthernetEcho_app_src_port, 16'd0}) && ({LoEthernetEcho_app_dst_port, 48'd0}>=64'h_3200_0000_0000_0000
                  ) && (4'd8/*8:MS*/!=(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd32))) && 1'h1&1'h1&LoEthernetEcho_proto_UDP&1'h1
                  &(0/*0:MS*/==(64'h_3400_0000_0000_0000<{LoEthernetEcho_app_dst_port, 16'd0})))  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000>={LoEthernetEcho_app_src_port, 16'd0}) && ({LoEthernetEcho_app_dst_port, 48'd0}>=64'h_3200_0000_0000_0000
                  ) && !(1'h1&1'h1&LoEthernetEcho_proto_UDP&1'h1&(0/*0:MS*/==(64'h_3400_0000_0000_0000<{LoEthernetEcho_app_dst_port, 16'd0
                  }))))  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000>={LoEthernetEcho_app_src_port, 16'd0}) && ({LoEthernetEcho_app_dst_port, 48'd0}<64'h_3200_0000_0000_0000
                  ) && (4'd8/*8:MS*/!=(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd32))) && 1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP
                  )  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000>={LoEthernetEcho_app_src_port, 16'd0}) && ({LoEthernetEcho_app_dst_port, 48'd0}<64'h_3200_0000_0000_0000
                  ) && !(1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP))  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000<{LoEthernetEcho_app_src_port, 16'd0}) && (4'd8/*8:MS*/!=(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0
                  [64'd1]>>6'd32))) && 1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP)  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}>=64'h_1e00_0000_0000_0000
                  ) && (64'h_2200_0000_0000_0000<{LoEthernetEcho_app_src_port, 16'd0}) && !(1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP)
                  )  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}<64'h_1e00_0000_0000_0000
                  ) && (4'd8/*8:MS*/!=(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0[64'd1]>>6'd32))) && 1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP
                  )  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000=={LoEthernetEcho_dst_ip, 32'd0}) && ({LoEthernetEcho_app_src_port, 48'd0}<64'h_1e00_0000_0000_0000
                  ) && !(1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP))  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000!={LoEthernetEcho_dst_ip, 32'd0}) && (4'd8/*8:MS*/!=(64'h_ffff&(A_64_US_CC_SCALbx14_ARC0
                  [64'd1]>>6'd32))) && 1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP)  xpc10 <= 6'd32/*32:xpc10:32*/;
                      if ((64'h404_afc0_0000_0000!={LoEthernetEcho_dst_ip, 32'd0}) && !(1'h1&32'd0&1'h1&LoEthernetEcho_proto_UDP))  xpc10
                       <= 6'd32/*32:xpc10:32*/;

                       end 
                  
              6'd32/*32:US*/:  begin 
                   xpc10 <= 7'd64/*64:xpc10:64*/;
                   LoEthernetEcho_tmp <= (64'd255&(A_64_US_CC_SCALbx10_ARA0[64'd0]>>5'd16))|{(A_64_US_CC_SCALbx14_ARC0[64'd0]>>6'd48), 16'd0
                  };

                   end 
                  
              7'd64/*64:US*/:  begin 
                  if (LoEthernetEcho_LUT_hit && !m_axis_tready && (TLEsw1_1_V_2>=32'd0))  begin 
                           xpc10 <= 10'd512/*512:xpc10:512*/;
                           TLESe23_2_V_0 <= 32'd0;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd1;
                           LoEthernetEcho_tmp <= LoEthernetEcho_tmp|{A_64_US_CC_SCALbx14_ARC0[64'd1], 32'd0};
                           end 
                          if (LoEthernetEcho_LUT_hit && m_axis_tready && (TLEsw1_1_V_2>=32'd0))  begin 
                           xpc10 <= 10'd512/*512:xpc10:512*/;
                           TLESe23_2_V_0 <= 32'd1;
                           m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'd0];
                           m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'd0];
                           m_axis_tlast <= 1'h1&(TLEsw1_1_V_2==0/*0:US*/);
                           m_axis_tkeep <= A_8_US_CC_SCALbx18_ARA0[8'd0];
                           m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                           m_axis_tvalid <= 1'd1;
                           LoEthernetEcho_tmp <= LoEthernetEcho_tmp|{A_64_US_CC_SCALbx14_ARC0[64'd1], 32'd0};
                           end 
                          if (LoEthernetEcho_LUT_hit && (TLEsw1_1_V_2<32'd0))  begin 
                           xpc10 <= 9'd256/*256:xpc10:256*/;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd0;
                           TLESe23_2_V_0 <= 32'd0;
                           LoEthernetEcho_tmp <= LoEthernetEcho_tmp|{A_64_US_CC_SCALbx14_ARC0[64'd1], 32'd0};
                           end 
                          if (!LoEthernetEcho_LUT_hit)  begin 
                           xpc10 <= 8'd128/*128:xpc10:128*/;
                           TLEsw1_1_V_0 <= 32'd0;
                           LoEthernetEcho_LUT_hit <= 1'd0;
                           LoEthernetEcho_tmp <= LoEthernetEcho_tmp|{A_64_US_CC_SCALbx14_ARC0[64'd1], 32'd0};
                           end 
                           end 
                  
              8'd128/*128:US*/:  begin 
                  if (!TLEsw1_1_V_3 && !m_axis_tready && (LoEthernetEcho_tmp!=A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && ((32'hffffffff
                  &32'd1+TLEsw1_1_V_0)>=64'd16) && (TLEsw1_1_V_2>=32'd0))  begin 
                           xpc10 <= 10'd512/*512:xpc10:512*/;
                           TLESe23_2_V_0 <= 32'd0;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd1;
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           A_64_US_CC_SCALbx16_ARD0[0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          if (!TLEsw1_1_V_3 && m_axis_tready && (LoEthernetEcho_tmp!=A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && ((32'hffffffff
                  &32'd1+TLEsw1_1_V_0)>=64'd16) && (TLEsw1_1_V_2>=32'd0))  begin 
                           xpc10 <= 10'd512/*512:xpc10:512*/;
                           TLESe23_2_V_0 <= 32'd1;
                           m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'd0];
                           m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'd0];
                           m_axis_tlast <= 1'h1&(TLEsw1_1_V_2==0/*0:US*/);
                           m_axis_tkeep <= A_8_US_CC_SCALbx18_ARA0[8'd0];
                           m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                           m_axis_tvalid <= 1'd1;
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           A_64_US_CC_SCALbx16_ARD0[0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          if (!TLEsw1_1_V_3 && (LoEthernetEcho_tmp!=A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && ((32'hffffffff&32'd1+TLEsw1_1_V_0
                  )>=64'd16) && (TLEsw1_1_V_2<32'd0))  begin 
                           xpc10 <= 9'd256/*256:xpc10:256*/;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd0;
                           TLESe23_2_V_0 <= 32'd0;
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           A_64_US_CC_SCALbx16_ARD0[0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          if (TLEsw1_1_V_3 && !m_axis_tready && (LoEthernetEcho_tmp!=A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && ((32'hffffffff
                  &32'd1+TLEsw1_1_V_0)>=64'd16) && (TLEsw1_1_V_2>=32'd0))  begin 
                           xpc10 <= 10'd512/*512:xpc10:512*/;
                           TLESe23_2_V_0 <= 32'd0;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd1;
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           end 
                          if (TLEsw1_1_V_3 && m_axis_tready && (LoEthernetEcho_tmp!=A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && ((32'hffffffff
                  &32'd1+TLEsw1_1_V_0)>=64'd16) && (TLEsw1_1_V_2>=32'd0))  begin 
                           xpc10 <= 10'd512/*512:xpc10:512*/;
                           TLESe23_2_V_0 <= 32'd1;
                           m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'd0];
                           m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'd0];
                           m_axis_tlast <= 1'h1&(TLEsw1_1_V_2==0/*0:US*/);
                           m_axis_tkeep <= A_8_US_CC_SCALbx18_ARA0[8'd0];
                           m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                           m_axis_tvalid <= 1'd1;
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           end 
                          if (TLEsw1_1_V_3 && (LoEthernetEcho_tmp!=A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && ((32'hffffffff&32'd1+TLEsw1_1_V_0
                  )>=64'd16) && (TLEsw1_1_V_2<32'd0))  begin 
                           xpc10 <= 9'd256/*256:xpc10:256*/;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd0;
                           TLESe23_2_V_0 <= 32'd0;
                           TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                           end 
                          if (!m_axis_tready && (LoEthernetEcho_tmp==A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && (TLEsw1_1_V_2>=32'd0)) 
                   begin 
                           xpc10 <= 10'd512/*512:xpc10:512*/;
                           TLESe23_2_V_0 <= 32'd0;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd1;
                           TLEsw1_1_V_3 <= 1'd1;
                           end 
                          if (m_axis_tready && (LoEthernetEcho_tmp==A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && (TLEsw1_1_V_2>=32'd0)) 
                   begin 
                           xpc10 <= 10'd512/*512:xpc10:512*/;
                           TLESe23_2_V_0 <= 32'd1;
                           m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'd0];
                           m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'd0];
                           m_axis_tlast <= 1'h1&(TLEsw1_1_V_2==0/*0:US*/);
                           m_axis_tkeep <= A_8_US_CC_SCALbx18_ARA0[8'd0];
                           m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                           m_axis_tvalid <= 1'd1;
                           TLEsw1_1_V_3 <= 1'd1;
                           end 
                          if ((LoEthernetEcho_tmp==A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && (TLEsw1_1_V_2<32'd0))  begin 
                           xpc10 <= 9'd256/*256:xpc10:256*/;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd0;
                           TLESe23_2_V_0 <= 32'd0;
                           TLEsw1_1_V_3 <= 1'd1;
                           end 
                          if ((LoEthernetEcho_tmp!=A_64_US_CC_SCALbx16_ARD0[TLEsw1_1_V_0]) && ((32'hffffffff&32'd1+TLEsw1_1_V_0)<64'd16
                  ))  TLEsw1_1_V_0 <= 32'd1+TLEsw1_1_V_0;
                       end 
                  
              9'd256/*256:US*/:  begin 
                   xpc10 <= 1'd1/*1:xpc10:1*/;
                   s_axis_tready <= 1'd1;
                   m_axis_tuser_low <= 32'd0;
                   m_axis_tuser_hi <= 32'd0;
                   m_axis_tlast <= 1'd0;
                   m_axis_tkeep <= 8'd0;
                   m_axis_tdata <= 32'd0;
                   LoEthernetEcho_segm_num <= 32'd0;
                   LoEthernetEcho_proto_UDP <= 1'd0;
                   end 
                  
              10'd512/*512:US*/:  begin 
                  if ((TLEsw1_1_V_2<TLESe23_2_V_0))  begin 
                           xpc10 <= 9'd256/*256:xpc10:256*/;
                           m_axis_tuser_low <= 32'd0;
                           m_axis_tuser_hi <= 32'd0;
                           m_axis_tkeep <= 8'd0;
                           m_axis_tdata <= 32'd0;
                           m_axis_tlast <= 1'd0;
                           m_axis_tvalid <= 1'd0;
                           end 
                          if (m_axis_tready && (TLEsw1_1_V_2>=TLESe23_2_V_0))  begin 
                           TLESe23_2_V_0 <= 32'd1+TLESe23_2_V_0;
                           m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLESe23_2_V_0];
                           m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLESe23_2_V_0];
                           m_axis_tlast <= 1'h1&(TLEsw1_1_V_2==TLESe23_2_V_0);
                           m_axis_tkeep <= A_8_US_CC_SCALbx18_ARA0[8'h1*(32'hffffffff&TLESe23_2_V_0)];
                           m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLESe23_2_V_0];
                           end 
                           end 
                  endcase
      //End structure HPR EthernetEcho.dll


       end 
      

// 1 vectors of width 10
// 8 vectors of width 64
// 5 vectors of width 32
// 4 vectors of width 1
// 106 array locations of width 64
// 30 array locations of width 8
// 32 bits in scalar variables
// Total state bits in module = 7742 bits.
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
// eof (HPR L/S Verilog)
