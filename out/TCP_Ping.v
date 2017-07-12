

// CBG Orangepath HPR L/S System

// Verilog output file generated at 02/05/2016 07:04:16
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
  reg LoEthernetEcho_proto_TCP;
  reg LoEthernetEcho_TCP_SYN_flag;
  reg [63:0] LoEthernetEcho_chksum_UDP;
  reg [63:0] TLEsw1_1_V_2;
  reg [63:0] TLEsw1_1_V_3;
  reg [31:0] TLEsw1_1_V_4;
  reg [31:0] TLEsw1_1_V_10;
  reg TLEsw1_1_V_12;
  reg TLEsw1_1_V_13;
  reg TLEsw1_1_V_14;
  reg TLEsw1_1_V_15;
  reg [31:0] TLEsw1_1_V_19;
  reg TLEsw1_1_V_20;
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
  reg [63:0] TLEca6_46_V_4;
  reg [63:0] TLEca6_46_V_5;
  reg [63:0] TLEca6_49_V_4;
  reg [63:0] TLEca6_49_V_5;
  reg [63:0] TLEca6_49_V_7;
  reg [63:0] TLEca10_5_V_4;
  reg [63:0] TLEca10_5_V_5;
  reg [63:0] TLEca10_5_V_7;
  reg [63:0] TLEsw15_4_V_0;
  reg TLEsw15_4_V_1;
  reg TLEsw15_4_V_2;
  reg [63:0] TLEca15_166_V_4;
  reg [63:0] TLEca15_166_V_5;
  reg [63:0] TLEca15_169_V_4;
  reg [63:0] TLEca15_169_V_5;
  reg [63:0] TLEca15_169_V_7;
  reg [63:0] TLEca19_5_V_4;
  reg [63:0] TLEca19_5_V_5;
  reg [63:0] TLEca19_5_V_7;
  reg [31:0] TLESe22_3_V_0;
  reg [31:0] TLESe22_3_V_1;
  reg [7:0] LoEthernetEcho_magic_num;
  reg [7:0] LoEthernetEcho_opcode;
  reg [63:0] LoEthernetEcho_IP_total_length;
  reg [63:0] LoEthernetEcho_tmp1;
  reg [63:0] LoEthernetEcho_src_ip;
  reg [63:0] LoEthernetEcho_dst_ip;
  reg [63:0] LoEthernetEcho_tmp;
  reg [63:0] LoEthernetEcho_tmp2;
  reg [63:0] LoEthernetEcho_dst_mac;
  reg [63:0] LoEthernetEcho_src_mac;
  reg [63:0] LoEthernetEcho_app_src_port;
  reg [63:0] LoEthernetEcho_app_dst_port;
  reg [63:0] LoEthernetEcho_TCP_seq_num;
  reg [63:0] LoEthernetEcho_tmp3;
  reg [63:0] LoEthernetEcho_src_port;
  reg [7:0] A_8_US_CC_SCALbx16_ARA0[255:0];
  reg [63:0] A_64_US_CC_SCALbx10_ARA0[255:0];
  reg [63:0] A_64_US_CC_SCALbx12_ARB0[255:0];
  reg [63:0] A_64_US_CC_SCALbx14_ARC0[255:0];
  reg [5:0] xpc10;
  wire [63:0] hprpin134410;
  wire [63:0] hprpin134910;
  wire [63:0] hprpin139510;
  wire [63:0] hprpin140010;
  wire [63:0] hprpin141610;
  wire [63:0] hprpin142110;
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
               TLERe1_1_V_0 <= 32'd0;
               LoEthernetEcho_opcode <= 8'd0;
               LoEthernetEcho_magic_num <= 8'd0;
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
               TLEsw1_1_V_15 <= 1'd0;
               TLEsw1_1_V_14 <= 1'd0;
               TLEsw1_1_V_13 <= 1'd0;
               TLEsw1_1_V_12 <= 1'd0;
               TLEca6_0_V_7 <= 64'd0;
               TLEca6_0_V_6 <= 64'd0;
               TLEsw1_1_V_20 <= 1'd0;
               TLEca6_0_V_1 <= 64'd0;
               TLEca6_0_V_0 <= 8'd0;
               TLEca6_0_V_12 <= 64'd0;
               TLEca6_46_V_5 <= 64'd0;
               TLEca6_46_V_4 <= 64'd0;
               TLEca6_49_V_5 <= 64'd0;
               TLEca6_49_V_4 <= 64'd0;
               TLEca6_49_V_7 <= 64'd0;
               TLEsw15_4_V_2 <= 1'd0;
               TLEsw15_4_V_1 <= 1'd0;
               TLEsw15_4_V_0 <= 64'd0;
               LoEthernetEcho_TCP_seq_num <= 64'd0;
               TLEca15_166_V_5 <= 64'd0;
               TLEca15_166_V_4 <= 64'd0;
               TLEca15_169_V_5 <= 64'd0;
               TLEca15_169_V_4 <= 64'd0;
               TLEca15_169_V_7 <= 64'd0;
               LoEthernetEcho_tmp <= 64'd0;
               LoEthernetEcho_tmp3 <= 64'd0;
               TLEsw1_1_V_19 <= 32'd0;
               TLESe22_3_V_1 <= 32'd0;
               s_axis_tready <= 1'd0;
               TLEsw1_1_V_10 <= 32'd0;
               LoEthernetEcho_TCP_SYN_flag <= 1'd0;
               LoEthernetEcho_proto_TCP <= 1'd0;
               LoEthernetEcho_proto_ICMP <= 1'd0;
               LoEthernetEcho_proto_UDP <= 1'd0;
               LoEthernetEcho_IPv4 <= 1'd0;
               m_axis_tvalid <= 1'd0;
               TLESe22_3_V_0 <= 32'd0;
               m_axis_tuser_low <= 64'd0;
               m_axis_tuser_hi <= 64'd0;
               m_axis_tlast <= 1'd0;
               m_axis_tkeep <= 8'd0;
               m_axis_tdata <= 64'd0;
               TLEca19_5_V_5 <= 64'd0;
               TLEca19_5_V_4 <= 64'd0;
               TLEca19_5_V_7 <= 64'd0;
               LoEthernetEcho_tmp1 <= 64'd0;
               TLEca10_5_V_5 <= 64'd0;
               TLEca10_5_V_4 <= 64'd0;
               TLEca10_5_V_7 <= 64'd0;
               xpc10 <= 6'd0;
               LoEthernetEcho_tmp2 <= 64'd0;
               TLEsw1_1_V_4 <= 32'd0;
               LoEthernetEcho_chksum_UDP <= 64'd0;
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
                       TLEsw1_1_V_19 <= 32'd100;
                       TLEsw1_1_V_20 <= 1'd0;
                       TLEsw1_1_V_15 <= 1'd0;
                       TLEsw1_1_V_14 <= 1'd0;
                       TLEsw1_1_V_13 <= 1'd0;
                       TLEsw1_1_V_12 <= 1'd0;
                       TLEsw1_1_V_10 <= 32'd0;
                       TLEsw1_1_V_4 <= 32'd0;
                       LoEthernetEcho_chksum_UDP <= 32'd0;
                       LoEthernetEcho_TCP_SYN_flag <= 1'd0;
                       LoEthernetEcho_proto_TCP <= 1'd0;
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
                               A_8_US_CC_SCALbx16_ARA0[32'd0] <= 8'hff&s_axis_tkeep;
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
                               A_8_US_CC_SCALbx16_ARA0[32'd0] <= 8'hff&s_axis_tkeep;
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
                               A_8_US_CC_SCALbx16_ARA0[32'hffffffff&TLERe1_1_V_0] <= 8'hff&s_axis_tkeep;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                               end 
                              if (s_axis_tvalid && !s_axis_tlast && TLERe1_1_V_3)  begin 
                               s_axis_tready <= 1'd1;
                               TLERe1_1_V_3 <= 1'h1&s_axis_tvalid;
                               TLERe1_1_V_1 <= TLERe1_1_V_0;
                               TLERe1_1_V_0 <= 32'd1+(32'hffffffff&TLERe1_1_V_0);
                               A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tuser_low;
                               A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tuser_hi;
                               A_8_US_CC_SCALbx16_ARA0[32'hffffffff&TLERe1_1_V_0] <= 8'hff&s_axis_tkeep;
                               A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLERe1_1_V_0] <= 64'hffffffffffffffff&s_axis_tdata;
                               end 
                              if (!TLERe1_1_V_3)  begin 
                               xpc10 <= 2'd3/*3:xpc10:3*/;
                               TLERe1_1_V_6 <= A_8_US_CC_SCALbx16_ARA0[8'h1*(32'hffffffff&TLERe1_1_V_1)];
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
                      
                  3'd5/*5:US*/:  begin 
                      if ((4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd2/*2:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IP_total_length <= 64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               LoEthernetEcho_proto_TCP <= 1'h1&(3'd6/*6:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56)));
                               LoEthernetEcho_proto_UDP <= 1'h1&(5'd17/*17:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56
                              )));

                               LoEthernetEcho_proto_ICMP <= 1'h1&(1'd1/*1:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56)));
                               end 
                              if ((4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd4/*4:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_TCP_seq_num <= ((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_app_dst_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32);
                               LoEthernetEcho_app_src_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               LoEthernetEcho_dst_ip <= LoEthernetEcho_dst_ip|{64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               end 
                              if ((4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd5/*5:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_opcode <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd24);
                               LoEthernetEcho_magic_num <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               LoEthernetEcho_TCP_seq_num <= LoEthernetEcho_TCP_seq_num|{64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               LoEthernetEcho_TCP_SYN_flag <= 1'h1&(2'd2/*2:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56
                              )));

                               end 
                              if (((32'hffffffff&TLEsw1_1_V_4)==0/*0:MS*/) && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_src_port <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_3)>>5'd16);
                               LoEthernetEcho_src_mac <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd2/*2:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IP_total_length <= 64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               LoEthernetEcho_proto_TCP <= 1'h1&(3'd6/*6:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56)));
                               LoEthernetEcho_proto_UDP <= 1'h1&(5'd17/*17:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56
                              )));

                               LoEthernetEcho_proto_ICMP <= 1'h1&(1'd1/*1:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56)));
                               end 
                              if ((4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd4/*4:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_TCP_seq_num <= ((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_app_dst_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32);
                               LoEthernetEcho_app_src_port <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               LoEthernetEcho_dst_ip <= LoEthernetEcho_dst_ip|{64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0};
                               end 
                              if ((4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd5/*5:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_opcode <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd24);
                               LoEthernetEcho_magic_num <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               LoEthernetEcho_TCP_seq_num <= LoEthernetEcho_TCP_seq_num|{64'h_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               LoEthernetEcho_TCP_SYN_flag <= 1'h1&(2'd2/*2:MS*/==(64'd255&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd56
                              )));

                               end 
                              if (((32'hffffffff&TLEsw1_1_V_4)==0/*0:MS*/) && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_src_port <= 64'd255&((64'hffffffffffffffff&TLEsw1_1_V_3)>>5'd16);
                               LoEthernetEcho_src_mac <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_dst_mac <= 64'h_ffff_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2;
                               end 
                              if ((4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && (4'd8/*8:MS*/!=
                      (64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'd0;
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && (4'd8/*8:MS*/==
                      (64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'h1&(3'd4/*4:MS*/==(64'd15&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd52)));
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd3/*3:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_dst_ip <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_src_ip <= 32'h_ffff_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               end 
                              if ((4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && (4'd8/*8:MS*/!=
                      (64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'd0;
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==1'd1/*1:MS*/) && (4'd8/*8:MS*/==
                      (64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd32))))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_IPv4 <= 1'h1&(3'd4/*4:MS*/==(64'd15&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd52)));
                               LoEthernetEcho_src_mac <= LoEthernetEcho_src_mac|{32'h_ffff_ffff&64'hffffffffffffffff&TLEsw1_1_V_2, 16'd0
                              };

                               end 
                              if ((4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==2'd3/*3:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_dst_ip <= 64'h_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>6'd48);
                               LoEthernetEcho_src_ip <= 32'h_ffff_ffff&((64'hffffffffffffffff&TLEsw1_1_V_2)>>5'd16);
                               end 
                              if ((4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd6/*6:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd7/*7:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && !LoEthernetEcho_opcode
                       && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && !LoEthernetEcho_opcode
                       && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && !(!LoEthernetEcho_opcode
                      ) && (LoEthernetEcho_opcode!=3'd4/*4:US*/) && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4
                      )==4'd8/*8:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && !(!LoEthernetEcho_opcode
                      ) && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && !(!LoEthernetEcho_opcode) && (LoEthernetEcho_opcode
                      ==3'd4/*4:US*/) && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && (4'd10>=(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && (4'd10>=(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && (4'd10>=(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && (4'd10>=(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_4)!=0/*0:MS*/) && (4'd10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=1'd1/*1:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd2/*2:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd3
                      /*3:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd4/*4:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd5/*5:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=3'd6/*6:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd7/*7:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd8
                      /*8:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd9/*9:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd10/*10:MS*/))  begin 
                               TLEsw1_1_V_3 <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd6/*6:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==3'd7/*7:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && !LoEthernetEcho_opcode
                       && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && !LoEthernetEcho_opcode
                       && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && !(!LoEthernetEcho_opcode
                      ) && (LoEthernetEcho_opcode!=3'd4/*4:US*/) && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4
                      )==4'd8/*8:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && !(!LoEthernetEcho_opcode
                      ) && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && !(!LoEthernetEcho_opcode) && (LoEthernetEcho_opcode
                      ==3'd4/*4:US*/) && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd8/*8:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && (4'd10<(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && (4'd10<(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd9/*9:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num!=8'd128/*128:US*/) && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode!=1'd1/*1:US*/) && (4'd10<(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if ((LoEthernetEcho_magic_num==8'd128/*128:US*/) && (LoEthernetEcho_opcode==1'd1/*1:US*/) && (4'd10<(32'hffffffff
                      &32'd1+TLEsw1_1_V_4)) && ((32'hffffffff&TLEsw1_1_V_4)==4'd10/*10:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_4)!=0/*0:MS*/) && (4'd10<(32'hffffffff&32'd1+TLEsw1_1_V_4)) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=1'd1/*1:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd2/*2:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=2'd3
                      /*3:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd4/*4:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd5/*5:MS*/) && ((32'hffffffff
                      &TLEsw1_1_V_4)!=3'd6/*6:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=3'd7/*7:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd8
                      /*8:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd9/*9:MS*/) && ((32'hffffffff&TLEsw1_1_V_4)!=4'd10/*10:MS*/))  begin 
                               xpc10 <= 3'd6/*6:xpc10:6*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               end 
                               end 
                      
                  4'd9/*9:US*/:  begin 
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
                               TLEca6_0_V_1 <= (A_64_US_CC_SCALbx14_ARC0[1'd1]>>6'd48);
                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               TLEca6_0_V_12 <= (64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+
                              (TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7
                              )+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16);

                               end 
                              if ((3'd4<(8'hff&8'd1+TLEca6_0_V_0)))  begin 
                               xpc10 <= 4'd10/*10:xpc10:10*/;
                               TLEsw1_1_V_20 <= 1'h1&(0/*0:MS*/==(64'hffffffffffffffff&64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7
                              >>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7
                              >>5'd16))>>5'd16))));

                               TLEca6_0_V_12 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16)))+(TLEca6_0_V_12+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca6_0_V_6+TLEca6_0_V_7)+(TLEca6_0_V_6+TLEca6_0_V_7>>5'd16))>>5'd16));

                               TLEca6_0_V_0 <= 8'd1+TLEca6_0_V_0;
                               end 
                               end 
                      
                  6'd35/*35:US*/:  begin 
                      if (!m_axis_tready && ((32'hffffffff&TLEsw1_1_V_10)>=32'd0))  begin 
                               xpc10 <= 6'd37/*37:xpc10:37*/;
                               TLESe22_3_V_1 <= TLEsw1_1_V_10;
                               TLESe22_3_V_0 <= 32'd0;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd1;
                               end 
                              if (m_axis_tready && ((32'hffffffff&TLEsw1_1_V_10)>=32'd0))  begin 
                               xpc10 <= 6'd37/*37:xpc10:37*/;
                               TLESe22_3_V_0 <= 32'd1;
                               m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'd0];
                               m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'd0];
                               m_axis_tlast <= 1'h1&(TLEsw1_1_V_10==0/*0:US*/);
                               m_axis_tkeep <= A_8_US_CC_SCALbx16_ARA0[8'd0];
                               m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'd0];
                               TLESe22_3_V_1 <= TLEsw1_1_V_10;
                               m_axis_tvalid <= 1'd1;
                               end 
                              if (((32'hffffffff&TLEsw1_1_V_10)<32'd0))  begin 
                               xpc10 <= 6'd36/*36:xpc10:36*/;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd0;
                               TLESe22_3_V_1 <= TLEsw1_1_V_10;
                               TLESe22_3_V_0 <= 32'd0;
                               end 
                               end 
                      
                  6'd36/*36:US*/:  begin 
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
                       LoEthernetEcho_TCP_SYN_flag <= 1'd0;
                       LoEthernetEcho_proto_TCP <= 1'd0;
                       LoEthernetEcho_proto_ICMP <= 1'd0;
                       LoEthernetEcho_proto_UDP <= 1'd0;
                       LoEthernetEcho_IPv4 <= 1'd0;
                       end 
                      endcase
              if ((TLEsw1_1_V_10<32'd4)) 
                  case (xpc10)
                      4'd14/*14:US*/:  begin 
                           xpc10 <= 4'd15/*15:xpc10:15*/;
                           TLEsw1_1_V_4 <= 32'd4;
                           LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca6_49_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca6_49_V_4+TLEca6_49_V_5
                          )+(TLEca6_49_V_4+TLEca6_49_V_5>>5'd16)))+(TLEca6_49_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca6_49_V_4+TLEca6_49_V_5
                          )+(TLEca6_49_V_4+TLEca6_49_V_5>>5'd16))>>5'd16);

                           end 
                          
                      6'd32/*32:US*/:  begin 
                           xpc10 <= 6'd33/*33:xpc10:33*/;
                           LoEthernetEcho_tmp1 <= 64'h_ffff&32'h_ffff_ffff^LoEthernetEcho_chksum_UDP;
                           TLEsw1_1_V_4 <= 32'd4;
                           A_64_US_CC_SCALbx14_ARC0[3'd6] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          endcase
                   else 
                  case (xpc10)
                      4'd14/*14:US*/:  begin 
                           xpc10 <= 6'd40/*40:xpc10:40*/;
                           LoEthernetEcho_tmp2 <= (A_64_US_CC_SCALbx14_ARC0[32'd4]>>5'd16);
                           TLEsw1_1_V_4 <= 32'd4;
                           LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca6_49_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca6_49_V_4+TLEca6_49_V_5
                          )+(TLEca6_49_V_4+TLEca6_49_V_5>>5'd16)))+(TLEca6_49_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca6_49_V_4+TLEca6_49_V_5
                          )+(TLEca6_49_V_4+TLEca6_49_V_5>>5'd16))>>5'd16);

                           end 
                          
                      6'd32/*32:US*/:  begin 
                           xpc10 <= 6'd38/*38:xpc10:38*/;
                           LoEthernetEcho_tmp2 <= (A_64_US_CC_SCALbx14_ARC0[32'd4]>>5'd16);
                           TLEsw1_1_V_4 <= 32'd4;
                           A_64_US_CC_SCALbx14_ARC0[3'd6] <= 64'hffffffffffffffff&LoEthernetEcho_tmp;
                           end 
                          endcase

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
                       TLEsw1_1_V_15 <= 1'h1&LoEthernetEcho_proto_TCP;
                       TLEsw1_1_V_14 <= 1'h1&LoEthernetEcho_proto_ICMP;
                       TLEsw1_1_V_13 <= 1'h1&LoEthernetEcho_proto_UDP;
                       TLEsw1_1_V_12 <= 1'h1&LoEthernetEcho_IPv4;
                       end 
                      
                  3'd7/*7:US*/:  begin 
                      if (TLEsw1_1_V_12 && TLEsw1_1_V_15)  begin 
                               xpc10 <= 4'd8/*8:xpc10:8*/;
                               TLEca6_0_V_1 <= (A_64_US_CC_SCALbx14_ARC0[1'd1]>>6'd48);
                               TLEca6_0_V_0 <= 8'd1;
                               TLEca6_0_V_12 <= 32'd0;
                               TLEca6_0_V_7 <= 32'd0;
                               TLEca6_0_V_6 <= 32'd0;
                               end 
                              if (TLEsw1_1_V_12 && !TLEsw1_1_V_15)  xpc10 <= 6'd35/*35:xpc10:35*/;
                          if (!TLEsw1_1_V_12)  xpc10 <= 6'd35/*35:xpc10:35*/;
                           end 
                      
                  4'd8/*8:US*/:  begin 
                       xpc10 <= 4'd9/*9:xpc10:9*/;
                       TLEca6_0_V_7 <= (64'h_ffff&hprpin134910)+(hprpin134910>>5'd16);
                       TLEca6_0_V_6 <= (64'h_ffff&hprpin134410)+(hprpin134410>>5'd16);
                       end 
                      
                  4'd10/*10:US*/:  begin 
                       xpc10 <= 4'd11/*11:xpc10:11*/;
                       LoEthernetEcho_tmp2 <= 64'd1536|{64'hffffffffffffffff&((64'hffffffffffffffff&64'h_ffff_ffff_ffff_ffec+((LoEthernetEcho_IP_total_length
                      >>4'd8)|{64'd255&LoEthernetEcho_IP_total_length, 8'd0}))>>4'd8)|{64'd255&64'hffffffffffffffff&64'h_ffff_ffff_ffff_ffec
                      +((LoEthernetEcho_IP_total_length>>4'd8)|{64'd255&LoEthernetEcho_IP_total_length, 8'd0}), 8'd0}, 32'd0};

                       LoEthernetEcho_tmp <= LoEthernetEcho_dst_ip|{LoEthernetEcho_src_ip, 32'd0};
                       LoEthernetEcho_tmp1 <= 64'h_ffff_ffff_ffff_ffec+((LoEthernetEcho_IP_total_length>>4'd8)|{64'd255&LoEthernetEcho_IP_total_length
                      , 8'd0});

                       end 
                      
                  4'd11/*11:US*/:  begin 
                       xpc10 <= 4'd12/*12:xpc10:12*/;
                       TLEca6_46_V_5 <= (64'h_ffff&hprpin140010)+(hprpin140010>>5'd16);
                       TLEca6_46_V_4 <= (64'h_ffff&hprpin139510)+(hprpin139510>>5'd16);
                       end 
                      
                  4'd12/*12:US*/:  begin 
                       xpc10 <= 4'd13/*13:xpc10:13*/;
                       LoEthernetEcho_chksum_UDP <= (64'h_ffff&32'd0+(64'hffffffffffffffff&(64'h_ffff&TLEca6_46_V_4+TLEca6_46_V_5)+(TLEca6_46_V_4
                      +TLEca6_46_V_5>>5'd16)))+(32'd0+(64'hffffffffffffffff&(64'h_ffff&TLEca6_46_V_4+TLEca6_46_V_5)+(TLEca6_46_V_4+TLEca6_46_V_5
                      >>5'd16))>>5'd16);

                       end 
                      
                  4'd13/*13:US*/:  begin 
                       xpc10 <= 4'd14/*14:xpc10:14*/;
                       TLEca6_49_V_5 <= (64'h_ffff&hprpin142110)+(hprpin142110>>5'd16);
                       TLEca6_49_V_4 <= (64'h_ffff&hprpin141610)+(hprpin141610>>5'd16);
                       TLEca6_49_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  4'd15/*15:US*/:  begin 
                      if ((64'h_ffff==LoEthernetEcho_chksum_UDP) && LoEthernetEcho_TCP_SYN_flag && TLEsw1_1_V_20)  begin 
                               xpc10 <= 5'd16/*16:xpc10:16*/;
                               TLEsw15_4_V_2 <= 1'h1&TLEsw1_1_V_14;
                               TLEsw15_4_V_1 <= 1'h1&TLEsw1_1_V_13|TLEsw1_1_V_15;
                               A_64_US_CC_SCALbx14_ARC0[0] <= 64'hffffffffffffffff&LoEthernetEcho_src_mac|{LoEthernetEcho_dst_mac, 48'd0
                              };

                               end 
                              if ((64'h_ffff!=LoEthernetEcho_chksum_UDP) && LoEthernetEcho_TCP_SYN_flag && TLEsw1_1_V_20)  xpc10 <= 6'd35
                          /*35:xpc10:35*/;

                          if (LoEthernetEcho_TCP_SYN_flag && !TLEsw1_1_V_20)  xpc10 <= 6'd35/*35:xpc10:35*/;
                          if (!LoEthernetEcho_TCP_SYN_flag)  xpc10 <= 6'd35/*35:xpc10:35*/;
                           end 
                      
                  5'd16/*16:US*/:  begin 
                       xpc10 <= 5'd17/*17:xpc10:17*/;
                       TLEsw15_4_V_0 <= (-64'h1_0000_0000&A_64_US_CC_SCALbx14_ARC0[1'd1])|(LoEthernetEcho_dst_mac>>5'd16);
                       end 
                      
                  5'd17/*17:US*/:  begin 
                       xpc10 <= 5'd18/*18:xpc10:18*/;
                       A_64_US_CC_SCALbx14_ARC0[1'd1] <= 64'hffffffffffffffff&TLEsw15_4_V_0;
                       end 
                      
                  5'd18/*18:US*/:  begin 
                       xpc10 <= 5'd19/*19:xpc10:19*/;
                       TLEsw15_4_V_0 <= (64'h_ffff&A_64_US_CC_SCALbx14_ARC0[2'd3])|{LoEthernetEcho_dst_ip, 16'd0}|{LoEthernetEcho_src_ip
                      , 48'd0};

                       end 
                      
                  5'd19/*19:US*/:  begin 
                       xpc10 <= 5'd20/*20:xpc10:20*/;
                       A_64_US_CC_SCALbx14_ARC0[2'd3] <= 64'hffffffffffffffff&TLEsw15_4_V_0;
                       end 
                      
                  5'd20/*20:US*/:  begin 
                      if (!TLEsw15_4_V_1 && TLEsw15_4_V_2)  begin 
                               xpc10 <= 5'd21/*21:xpc10:21*/;
                               TLEsw15_4_V_0 <= (-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd4])|(LoEthernetEcho_src_ip>>5'd16);
                               end 
                              if (TLEsw15_4_V_1)  begin 
                               xpc10 <= 5'd21/*21:xpc10:21*/;
                               TLEsw15_4_V_0 <= (-64'h1_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd4])|(LoEthernetEcho_src_ip>>5'd16)|
                              {LoEthernetEcho_app_src_port, 32'd0}|{LoEthernetEcho_app_dst_port, 16'd0};

                               end 
                              if (!TLEsw15_4_V_1 && !TLEsw15_4_V_2)  xpc10 <= 5'd21/*21:xpc10:21*/;
                           end 
                      
                  5'd21/*21:US*/:  begin 
                       xpc10 <= 5'd22/*22:xpc10:22*/;
                       A_64_US_CC_SCALbx14_ARC0[3'd4] <= 64'hffffffffffffffff&TLEsw15_4_V_0;
                       end 
                      
                  5'd22/*22:US*/:  begin 
                       xpc10 <= 5'd23/*23:xpc10:23*/;
                       LoEthernetEcho_tmp1 <= 32'd1+((LoEthernetEcho_TCP_seq_num>>5'd24)|((64'hff_0000&LoEthernetEcho_TCP_seq_num)>>4'd8
                      )|{64'h_ff00&LoEthernetEcho_TCP_seq_num, 8'd0}|{64'd255&LoEthernetEcho_TCP_seq_num, 24'd0});

                       LoEthernetEcho_chksum_UDP <= 32'd0;
                       end 
                      
                  5'd23/*23:US*/:  begin 
                       xpc10 <= 5'd24/*24:xpc10:24*/;
                       LoEthernetEcho_tmp3 <= 64'hff_0000_0000_0000&A_64_US_CC_SCALbx14_ARC0[3'd5];
                       LoEthernetEcho_tmp2 <= 64'h_1400_0000_0000_0000|(64'hffffffffffffffff&((64'h_ff00&TLEsw1_1_V_19)>>4'd8)|{64'd255
                      &TLEsw1_1_V_19, 8'd0})|{64'hffffffffffffffff&(LoEthernetEcho_tmp1>>5'd24)|((64'hff_0000&LoEthernetEcho_tmp1)>>4'd8
                      )|{64'h_ff00&LoEthernetEcho_tmp1, 8'd0}|{64'd255&LoEthernetEcho_tmp1, 24'd0}, 16'd0};

                       LoEthernetEcho_tmp <= ((64'h_ff00&TLEsw1_1_V_19)>>4'd8)|{64'd255&TLEsw1_1_V_19, 8'd0};
                       LoEthernetEcho_TCP_seq_num <= (LoEthernetEcho_tmp1>>5'd24)|((64'hff_0000&LoEthernetEcho_tmp1)>>4'd8)|{64'h_ff00
                      &LoEthernetEcho_tmp1, 8'd0}|{64'd255&LoEthernetEcho_tmp1, 24'd0};

                       end 
                      
                  5'd24/*24:US*/:  begin 
                       xpc10 <= 5'd25/*25:xpc10:25*/;
                       LoEthernetEcho_tmp3 <= LoEthernetEcho_tmp2|LoEthernetEcho_tmp3;
                       A_64_US_CC_SCALbx14_ARC0[3'd5] <= 64'hffffffffffffffff&LoEthernetEcho_tmp2|LoEthernetEcho_tmp3;
                       end 
                      
                  5'd25/*25:US*/:  begin 
                       xpc10 <= 5'd26/*26:xpc10:26*/;
                       LoEthernetEcho_tmp <= 64'h_ffff_ffff_ffff&A_64_US_CC_SCALbx14_ARC0[3'd4];
                       end 
                      
                  5'd26/*26:US*/:  begin 
                       xpc10 <= 5'd27/*27:xpc10:27*/;
                       LoEthernetEcho_tmp <= LoEthernetEcho_tmp|(64'hffffffffffffffff&(64'hff_0000&TLEsw1_1_V_19)|(-64'h100_0000&TLEsw1_1_V_19
                      ));

                       A_64_US_CC_SCALbx14_ARC0[3'd4] <= 64'hffffffffffffffff&LoEthernetEcho_tmp|(64'hffffffffffffffff&(64'hff_0000&TLEsw1_1_V_19
                      )|(-64'h100_0000&TLEsw1_1_V_19));

                       end 
                      
                  5'd27/*27:US*/:  begin 
                       xpc10 <= 5'd28/*28:xpc10:28*/;
                       LoEthernetEcho_tmp2 <= 64'd1536|{64'hffffffffffffffff&((64'hffffffffffffffff&64'h_ffff_ffff_ffff_ffec+((LoEthernetEcho_IP_total_length
                      >>4'd8)|{64'd255&LoEthernetEcho_IP_total_length, 8'd0}))>>4'd8)|{64'd255&64'hffffffffffffffff&64'h_ffff_ffff_ffff_ffec
                      +((LoEthernetEcho_IP_total_length>>4'd8)|{64'd255&LoEthernetEcho_IP_total_length, 8'd0}), 8'd0}, 32'd0};

                       LoEthernetEcho_tmp <= LoEthernetEcho_dst_ip|{LoEthernetEcho_src_ip, 32'd0};
                       LoEthernetEcho_tmp1 <= 64'h_ffff_ffff_ffff_ffec+((LoEthernetEcho_IP_total_length>>4'd8)|{64'd255&LoEthernetEcho_IP_total_length
                      , 8'd0});

                       end 
                      
                  5'd28/*28:US*/:  begin 
                       xpc10 <= 5'd29/*29:xpc10:29*/;
                       TLEca15_166_V_5 <= (64'h_ffff&hprpin140010)+(hprpin140010>>5'd16);
                       TLEca15_166_V_4 <= (64'h_ffff&hprpin139510)+(hprpin139510>>5'd16);
                       end 
                      
                  5'd29/*29:US*/:  begin 
                       xpc10 <= 5'd30/*30:xpc10:30*/;
                       LoEthernetEcho_chksum_UDP <= (64'h_ffff&32'd0+(64'hffffffffffffffff&(64'h_ffff&TLEca15_166_V_4+TLEca15_166_V_5
                      )+(TLEca15_166_V_4+TLEca15_166_V_5>>5'd16)))+(32'd0+(64'hffffffffffffffff&(64'h_ffff&TLEca15_166_V_4+TLEca15_166_V_5
                      )+(TLEca15_166_V_4+TLEca15_166_V_5>>5'd16))>>5'd16);

                       end 
                      
                  5'd30/*30:US*/:  begin 
                       xpc10 <= 5'd31/*31:xpc10:31*/;
                       TLEca15_169_V_5 <= (64'h_ffff&hprpin142110)+(hprpin142110>>5'd16);
                       TLEca15_169_V_4 <= (64'h_ffff&hprpin141610)+(hprpin141610>>5'd16);
                       TLEca15_169_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  5'd31/*31:US*/:  begin 
                       xpc10 <= 6'd32/*32:xpc10:32*/;
                       LoEthernetEcho_tmp <= -64'h_ffff_0001&A_64_US_CC_SCALbx14_ARC0[3'd6];
                       LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca15_169_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca15_169_V_4+TLEca15_169_V_5
                      )+(TLEca15_169_V_4+TLEca15_169_V_5>>5'd16)))+(TLEca15_169_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca15_169_V_4+
                      TLEca15_169_V_5)+(TLEca15_169_V_4+TLEca15_169_V_5>>5'd16))>>5'd16);

                       end 
                      
                  6'd33/*33:US*/:  begin 
                       xpc10 <= 6'd34/*34:xpc10:34*/;
                       LoEthernetEcho_tmp3 <= A_64_US_CC_SCALbx10_ARA0[0];
                       LoEthernetEcho_tmp2 <= (LoEthernetEcho_tmp1>>4'd8)|{64'd255&LoEthernetEcho_tmp1, 8'd0};
                       A_64_US_CC_SCALbx14_ARC0[3'd6] <= 64'hffffffffffffffff&LoEthernetEcho_tmp|{64'hffffffffffffffff&(LoEthernetEcho_tmp1
                      >>4'd8)|{64'd255&LoEthernetEcho_tmp1, 8'd0}, 16'd0};

                       end 
                      
                  6'd34/*34:US*/:  begin 
                       xpc10 <= 6'd35/*35:xpc10:35*/;
                       TLEsw1_1_V_19 <= 32'd1+TLEsw1_1_V_19;
                       A_64_US_CC_SCALbx10_ARA0[0] <= 64'hffffffffffffffff&LoEthernetEcho_tmp3|{LoEthernetEcho_src_port, 24'd0}|{LoEthernetEcho_src_port
                      , 16'd0};

                       end 
                      
                  6'd37/*37:US*/:  begin 
                      if ((TLESe22_3_V_1<TLESe22_3_V_0))  begin 
                               xpc10 <= 6'd36/*36:xpc10:36*/;
                               m_axis_tuser_low <= 32'd0;
                               m_axis_tuser_hi <= 32'd0;
                               m_axis_tkeep <= 8'd0;
                               m_axis_tdata <= 32'd0;
                               m_axis_tlast <= 1'd0;
                               m_axis_tvalid <= 1'd0;
                               end 
                              if (m_axis_tready && (TLESe22_3_V_1>=TLESe22_3_V_0))  begin 
                               TLESe22_3_V_0 <= 32'd1+TLESe22_3_V_0;
                               m_axis_tuser_low <= A_64_US_CC_SCALbx10_ARA0[32'hffffffff&TLESe22_3_V_0];
                               m_axis_tuser_hi <= A_64_US_CC_SCALbx12_ARB0[32'hffffffff&TLESe22_3_V_0];
                               m_axis_tlast <= 1'h1&(TLEsw1_1_V_10==TLESe22_3_V_0);
                               m_axis_tkeep <= A_8_US_CC_SCALbx16_ARA0[8'h1*(32'hffffffff&TLESe22_3_V_0)];
                               m_axis_tdata <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&TLESe22_3_V_0];
                               end 
                               end 
                      
                  6'd38/*38:US*/:  begin 
                       xpc10 <= 6'd39/*39:xpc10:39*/;
                       TLEca19_5_V_5 <= (64'h_ffff&hprpin140010)+(hprpin140010>>5'd16);
                       TLEca19_5_V_4 <= (64'h_ffff&hprpin139510)+(hprpin139510>>5'd16);
                       TLEca19_5_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  6'd39/*39:US*/:  begin 
                      if ((TLEsw1_1_V_10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && (3'd4/*4:MS*/==(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               xpc10 <= 6'd38/*38:xpc10:38*/;
                               LoEthernetEcho_tmp2 <= (A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4]>>5'd16);
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca19_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca19_5_V_4+TLEca19_5_V_5
                              )+(TLEca19_5_V_4+TLEca19_5_V_5>>5'd16)))+(TLEca19_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca19_5_V_4+
                              TLEca19_5_V_5)+(TLEca19_5_V_4+TLEca19_5_V_5>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && (3'd4/*4:MS*/!=(32'hffffffff&32'd1+TLEsw1_1_V_4
                      )))  begin 
                               xpc10 <= 6'd38/*38:xpc10:38*/;
                               LoEthernetEcho_tmp2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca19_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca19_5_V_4+TLEca19_5_V_5
                              )+(TLEca19_5_V_4+TLEca19_5_V_5>>5'd16)))+(TLEca19_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca19_5_V_4+
                              TLEca19_5_V_5)+(TLEca19_5_V_4+TLEca19_5_V_5>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_10<(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               xpc10 <= 6'd33/*33:xpc10:33*/;
                               LoEthernetEcho_tmp1 <= 64'h_ffff&32'h_ffff_ffff^(64'hffffffffffffffff&(64'h_ffff&TLEca19_5_V_7+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca19_5_V_4+TLEca19_5_V_5)+(TLEca19_5_V_4+TLEca19_5_V_5>>5'd16)))+(TLEca19_5_V_7+(64'hffffffffffffffff
                              &(64'h_ffff&TLEca19_5_V_4+TLEca19_5_V_5)+(TLEca19_5_V_4+TLEca19_5_V_5>>5'd16))>>5'd16));

                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca19_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca19_5_V_4+TLEca19_5_V_5
                              )+(TLEca19_5_V_4+TLEca19_5_V_5>>5'd16)))+(TLEca19_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca19_5_V_4+
                              TLEca19_5_V_5)+(TLEca19_5_V_4+TLEca19_5_V_5>>5'd16))>>5'd16);

                               end 
                               end 
                      
                  6'd40/*40:US*/:  begin 
                       xpc10 <= 6'd41/*41:xpc10:41*/;
                       TLEca10_5_V_5 <= (64'h_ffff&hprpin140010)+(hprpin140010>>5'd16);
                       TLEca10_5_V_4 <= (64'h_ffff&hprpin139510)+(hprpin139510>>5'd16);
                       TLEca10_5_V_7 <= LoEthernetEcho_chksum_UDP;
                       end 
                      
                  6'd41/*41:US*/:  begin 
                      if ((TLEsw1_1_V_10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && (3'd4/*4:MS*/==(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               xpc10 <= 6'd40/*40:xpc10:40*/;
                               LoEthernetEcho_tmp2 <= (A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4]>>5'd16);
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca10_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca10_5_V_4+TLEca10_5_V_5
                              )+(TLEca10_5_V_4+TLEca10_5_V_5>>5'd16)))+(TLEca10_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca10_5_V_4+
                              TLEca10_5_V_5)+(TLEca10_5_V_4+TLEca10_5_V_5>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_10>=(32'hffffffff&32'd1+TLEsw1_1_V_4)) && (3'd4/*4:MS*/!=(32'hffffffff&32'd1+TLEsw1_1_V_4
                      )))  begin 
                               xpc10 <= 6'd40/*40:xpc10:40*/;
                               LoEthernetEcho_tmp2 <= A_64_US_CC_SCALbx14_ARC0[32'hffffffff&32'd1+TLEsw1_1_V_4];
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca10_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca10_5_V_4+TLEca10_5_V_5
                              )+(TLEca10_5_V_4+TLEca10_5_V_5>>5'd16)))+(TLEca10_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca10_5_V_4+
                              TLEca10_5_V_5)+(TLEca10_5_V_4+TLEca10_5_V_5>>5'd16))>>5'd16);

                               end 
                              if ((TLEsw1_1_V_10<(32'hffffffff&32'd1+TLEsw1_1_V_4)))  begin 
                               xpc10 <= 4'd15/*15:xpc10:15*/;
                               TLEsw1_1_V_4 <= 32'd1+TLEsw1_1_V_4;
                               LoEthernetEcho_chksum_UDP <= (64'h_ffff&TLEca10_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca10_5_V_4+TLEca10_5_V_5
                              )+(TLEca10_5_V_4+TLEca10_5_V_5>>5'd16)))+(TLEca10_5_V_7+(64'hffffffffffffffff&(64'h_ffff&TLEca10_5_V_4+
                              TLEca10_5_V_5)+(TLEca10_5_V_4+TLEca10_5_V_5>>5'd16))>>5'd16);

                               end 
                               end 
                      endcase
               end 
              //End structure HPR EthernetEcho.dll


       end 
      

assign hprpin134410 = (64'hffffffffffffffff&{64'd255&TLEca6_0_V_1, 8'd0}|((64'h_ff00&TLEca6_0_V_1)>>4'd8))+(64'hffffffffffffffff&{64'd255&(TLEca6_0_V_1>>5'd16
), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>5'd16))>>4'd8));

assign hprpin134910 = (64'hffffffffffffffff&{64'd255&(TLEca6_0_V_1>>6'd32), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>6'd32))>>4'd8))+(64'hffffffffffffffff&{64'd255
&(TLEca6_0_V_1>>6'd48), 8'd0}|((64'h_ff00&(TLEca6_0_V_1>>6'd48))>>4'd8));

assign hprpin139510 = (64'hffffffffffffffff&{64'd255&LoEthernetEcho_tmp2, 8'd0}|((64'h_ff00&LoEthernetEcho_tmp2)>>4'd8))+(64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp2
>>5'd16), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>5'd16))>>4'd8));

assign hprpin140010 = (64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp2>>6'd32), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>6'd32))>>4'd8))+(64'hffffffffffffffff
&{64'd255&(LoEthernetEcho_tmp2>>6'd48), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp2>>6'd48))>>4'd8));

assign hprpin141610 = (64'hffffffffffffffff&{64'd255&LoEthernetEcho_tmp, 8'd0}|((64'h_ff00&LoEthernetEcho_tmp)>>4'd8))+(64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp
>>5'd16), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp>>5'd16))>>4'd8));

assign hprpin142110 = (64'hffffffffffffffff&{64'd255&(LoEthernetEcho_tmp>>6'd32), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp>>6'd32))>>4'd8))+(64'hffffffffffffffff
&{64'd255&(LoEthernetEcho_tmp>>6'd48), 8'd0}|((64'h_ff00&(LoEthernetEcho_tmp>>6'd48))>>4'd8));

// 1 vectors of width 6
// 38 vectors of width 64
// 4 vectors of width 8
// 7 vectors of width 32
// 13 vectors of width 1
// 768 array locations of width 64
// 256 array locations of width 8
// Total state bits in module = 53907 bits.
// 384 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
// eof (HPR L/S Verilog)
