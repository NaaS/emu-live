

// CBG Orangepath HPR L/S System

// Verilog output file generated at 17/01/2017 23:40:24
// Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016 Unix 14.5.0.0
//  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe LRU.dll HashCAM_KiwiLift.dll NaughtyQ_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl LRU.v
`timescale 1ns/1ns


module LRU(    output reg NQ_enable,
    input NQ_ready,
    input NQ_crashed,
    output reg [3:0] NQ_command,
    input [3:0] NQ_idx_out,
    input [7:0] NQ_data_out,
    output reg [3:0] NQ_idx_in,
    output reg [7:0] NQ_data_in,
    output reg HC_write_enable,
    input HC_write_ready,
    output reg HC_lookup_enable,
    input HC_lookup_ready,
    input HC_match,
    input HC_full,
    output reg [15:0] HC_key_in,
    output reg [7:0] HC_value_in,
    input [7:0] HC_value_out,
    input clk,
    input reset);

function  rtl_unsigned_bitextract0;
   input [31:0] arg;
   rtl_unsigned_bitextract0 = $unsigned(arg[0:0]);
   endfunction


function [63:0] rtl_unsigned_extend1;
   input [31:0] arg;
   rtl_unsigned_extend1 = { 32'b0, arg[31:0] };
   endfunction

  reg [63:0] NaughtyQ_idx_out_nv;
  reg [63:0] NaughtyQ_data_out_nv;
  reg HashCAM_matched;
  reg HashCAM_is_full;
  wire [31:0] ktop20;
  wire [31:0] ktop18;
  reg [31:0] LRU_Lookup_CZ_0_1_blockrefxxnewobj14;
  reg [63:0] T403_LRU_Lookup_0_22_V_1;
  reg [31:0] T403_LRU_Lookup_0_22_V_0;
  reg [31:0] LRU_Lookup_CZ_0_1_blockrefxxnewobj12;
  reg [63:0] T403_LRU_Lookup_0_18_V_1;
  reg [31:0] T403_LRU_Lookup_0_18_V_0;
  reg [63:0] T403_LRU_Cache_0_15_V_0;
  reg [63:0] T403_HashCAM_Write_0_6_V_0;
  reg [63:0] T403_LRU_Cache_0_10_V_0;
  reg [63:0] T403_HashCAM_Read_0_7_V_0;
  reg [31:0] LRU_Lookup_CZ_0_1_blockrefxxnewobj10;
  reg [63:0] T403_LRU_Lookup_0_4_V_1;
  reg [31:0] T403_LRU_Lookup_0_4_V_0;
  reg [31:0] LRU_T403_Main_T403_Main_V_0;
  wire [31:0] ktop16;
  wire [31:0] ktop14;
  reg System_BitConverter_IsLittleEndian;
  wire [31:0] ktop12;
  reg [63:0] KiwiSystem_Kiwi_tnow;
  reg [31:0] KiwiSystem_Kiwi_old_pausemode_value;
  wire [31:0] ktop10;
  reg A_BOOL_CC_SCALbx16_matched;
  reg A_BOOL_CC_SCALbx18_matched;
  reg A_BOOL_CC_SCALbx20_matched;
  reg [63:0] A_64_US_CC_SCALbx16_result;
  reg [63:0] A_64_US_CC_SCALbx18_result;
  reg [63:0] A_64_US_CC_SCALbx20_result;
  reg [5:0] xpc10;
  reg xpc12;
  reg xpc14;
 always   @(posedge clk )  begin 
      //Start structure HPR anontop
      if (reset)  begin 
               T403_LRU_Lookup_0_4_V_0 <= 32'd0;
               LRU_Lookup_CZ_0_1_blockrefxxnewobj10 <= 32'd0;
               KiwiSystem_Kiwi_tnow <= 64'd0;
               KiwiSystem_Kiwi_old_pausemode_value <= 32'd0;
               System_BitConverter_IsLittleEndian <= 32'd0;
               A_BOOL_CC_SCALbx20_matched <= 32'd0;
               T403_LRU_Lookup_0_4_V_1 <= 64'd0;
               LRU_T403_Main_T403_Main_V_0 <= 32'd0;
               A_64_US_CC_SCALbx20_result <= 64'd0;
               T403_LRU_Cache_0_10_V_0 <= 64'd0;
               NaughtyQ_idx_out_nv <= 64'd0;
               T403_LRU_Cache_0_15_V_0 <= 64'd0;
               HashCAM_is_full <= 32'd0;
               T403_HashCAM_Write_0_6_V_0 <= 64'd0;
               T403_LRU_Lookup_0_18_V_0 <= 32'd0;
               LRU_Lookup_CZ_0_1_blockrefxxnewobj12 <= 32'd0;
               A_BOOL_CC_SCALbx18_matched <= 32'd0;
               T403_LRU_Lookup_0_18_V_1 <= 64'd0;
               T403_LRU_Lookup_0_22_V_0 <= 32'd0;
               LRU_Lookup_CZ_0_1_blockrefxxnewobj14 <= 32'd0;
               A_64_US_CC_SCALbx18_result <= 64'd0;
               T403_HashCAM_Read_0_7_V_0 <= 64'd0;
               HashCAM_matched <= 32'd0;
               A_BOOL_CC_SCALbx16_matched <= 32'd0;
               T403_LRU_Lookup_0_22_V_1 <= 64'd0;
               NaughtyQ_data_out_nv <= 64'd0;
               A_64_US_CC_SCALbx16_result <= 64'd0;
               HC_write_enable <= 32'd0;
               HC_value_in <= 32'd0;
               NQ_data_in <= 32'd0;
               NQ_enable <= 32'd0;
               NQ_idx_in <= 32'd0;
               NQ_command <= 32'd0;
               xpc10 <= 32'd0;
               HC_lookup_enable <= 32'd0;
               HC_key_in <= 32'd0;
               xpc12 <= 32'd0;
               xpc14 <= 32'd0;
               end 
               else  begin 
              if (!HashCAM_matched && (xpc10==6'sd31/*31:xpc10*/)) $finish(32'sd0);
                  if ((xpc10==6'sd36/*36:xpc10*/)) $finish(32'sd0);
                  if (NQ_ready) 
                  case (xpc10)
                      6'sd4/*4:xpc10*/:  begin 
                           xpc10 <= 6'sd5/*5:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      6'sd5/*5:xpc10*/:  xpc10 <= 6'sd58/*58:xpc10*/;

                      6'sd6/*6:xpc10*/:  xpc10 <= 6'sd7/*7:xpc10*/;

                      6'sd8/*8:xpc10*/:  begin 
                           xpc10 <= 6'sd56/*56:xpc10*/;
                           LRU_T403_Main_T403_Main_V_0 <= 32'd0;
                           A_64_US_CC_SCALbx20_result <= NaughtyQ_data_out_nv;
                           end 
                          
                      6'sd9/*9:xpc10*/:  xpc10 <= 6'sd10/*10:xpc10*/;

                      6'sd14/*14:xpc10*/:  xpc10 <= 6'sd52/*52:xpc10*/;

                      6'sd15/*15:xpc10*/:  xpc10 <= 6'sd16/*16:xpc10*/;

                      6'sd24/*24:xpc10*/:  begin 
                           xpc10 <= 6'sd25/*25:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      6'sd25/*25:xpc10*/:  xpc10 <= 6'sd44/*44:xpc10*/;

                      6'sd26/*26:xpc10*/:  xpc10 <= 6'sd27/*27:xpc10*/;

                      6'sd32/*32:xpc10*/:  begin 
                           xpc10 <= 6'sd33/*33:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      6'sd33/*33:xpc10*/:  xpc10 <= 6'sd38/*38:xpc10*/;

                      6'sd34/*34:xpc10*/:  xpc10 <= 6'sd35/*35:xpc10*/;

                      6'sd37/*37:xpc10*/:  xpc10 <= 6'sd35/*35:xpc10*/;

                      6'sd39/*39:xpc10*/:  begin 
                           xpc10 <= 6'sd33/*33:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      6'sd43/*43:xpc10*/:  xpc10 <= 6'sd27/*27:xpc10*/;

                      6'sd45/*45:xpc10*/:  begin 
                           xpc10 <= 6'sd25/*25:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      6'sd51/*51:xpc10*/:  xpc10 <= 6'sd16/*16:xpc10*/;

                      6'sd55/*55:xpc10*/:  xpc10 <= 6'sd10/*10:xpc10*/;

                      6'sd57/*57:xpc10*/:  xpc10 <= 6'sd7/*7:xpc10*/;

                      6'sd59/*59:xpc10*/:  begin 
                           xpc10 <= 6'sd5/*5:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          endcase
                   else 
                  case (xpc10)
                      6'sd4/*4:xpc10*/:  xpc10 <= 6'sd59/*59:xpc10*/;

                      6'sd5/*5:xpc10*/:  begin 
                           xpc10 <= 6'sd6/*6:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_4_V_1;
                           NQ_command <= 8'h3;
                           end 
                          
                      6'sd6/*6:xpc10*/:  xpc10 <= 6'sd57/*57:xpc10*/;

                      6'sd8/*8:xpc10*/:  begin 
                           xpc10 <= 6'sd9/*9:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_data_in <= 64'h2;
                           NQ_command <= 8'h1;
                           LRU_T403_Main_T403_Main_V_0 <= 32'd0;
                           A_64_US_CC_SCALbx20_result <= NaughtyQ_data_out_nv;
                           end 
                          
                      6'sd9/*9:xpc10*/:  xpc10 <= 6'sd55/*55:xpc10*/;

                      6'sd14/*14:xpc10*/:  begin 
                           xpc10 <= 6'sd15/*15:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_data_in <= 64'h14;
                           NQ_command <= 8'h1;
                           end 
                          
                      6'sd15/*15:xpc10*/:  xpc10 <= 6'sd51/*51:xpc10*/;

                      6'sd24/*24:xpc10*/:  xpc10 <= 6'sd45/*45:xpc10*/;

                      6'sd25/*25:xpc10*/:  begin 
                           xpc10 <= 6'sd26/*26:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_18_V_1;
                           NQ_command <= 8'h3;
                           end 
                          
                      6'sd26/*26:xpc10*/:  xpc10 <= 6'sd43/*43:xpc10*/;

                      6'sd32/*32:xpc10*/:  xpc10 <= 6'sd39/*39:xpc10*/;

                      6'sd33/*33:xpc10*/:  begin 
                           xpc10 <= 6'sd34/*34:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_22_V_1;
                           NQ_command <= 8'h3;
                           end 
                          
                      6'sd34/*34:xpc10*/:  xpc10 <= 6'sd37/*37:xpc10*/;

                      6'sd38/*38:xpc10*/:  begin 
                           xpc10 <= 6'sd34/*34:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_22_V_1;
                           NQ_command <= 8'h3;
                           end 
                          
                      6'sd40/*40:xpc10*/:  begin 
                           xpc10 <= 6'sd32/*32:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_22_V_1;
                           NQ_command <= 8'h2;
                           end 
                          
                      6'sd44/*44:xpc10*/:  begin 
                           xpc10 <= 6'sd26/*26:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_18_V_1;
                           NQ_command <= 8'h3;
                           end 
                          
                      6'sd46/*46:xpc10*/:  begin 
                           xpc10 <= 6'sd24/*24:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_18_V_1;
                           NQ_command <= 8'h2;
                           end 
                          
                      6'sd52/*52:xpc10*/:  begin 
                           xpc10 <= 6'sd15/*15:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_data_in <= 64'h14;
                           NQ_command <= 8'h1;
                           end 
                          
                      6'sd56/*56:xpc10*/:  begin 
                           xpc10 <= 6'sd9/*9:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_data_in <= 64'h2;
                           NQ_command <= 8'h1;
                           end 
                          
                      6'sd58/*58:xpc10*/:  begin 
                           xpc10 <= 6'sd6/*6:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_4_V_1;
                           NQ_command <= 8'h3;
                           end 
                          
                      6'sd60/*60:xpc10*/:  begin 
                           xpc10 <= 6'sd4/*4:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= T403_LRU_Lookup_0_4_V_1;
                           NQ_command <= 8'h2;
                           end 
                          endcase
              if (HC_lookup_ready) 
                  case (xpc10)
                      6'sd0/*0:xpc10*/:  begin 
                           xpc10 <= 6'sd62/*62:xpc10*/;
                           T403_HashCAM_Read_0_7_V_0 <= 64'h0;
                           T403_LRU_Lookup_0_4_V_1 <= 64'h0;
                           T403_LRU_Lookup_0_4_V_0 <= 32'd0;
                           A_64_US_CC_SCALbx20_result <= 64'h0;
                           A_BOOL_CC_SCALbx20_matched <= 1'h0;
                           LRU_Lookup_CZ_0_1_blockrefxxnewobj10 <= 32'd0;
                           KiwiSystem_Kiwi_tnow <= 64'h0;
                           KiwiSystem_Kiwi_old_pausemode_value <= 32'h2;
                           System_BitConverter_IsLittleEndian <= 1'h1;
                           HashCAM_is_full <= 1'h0;
                           HashCAM_matched <= 1'h0;
                           end 
                          
                      6'sd1/*1:xpc10*/:  xpc10 <= 6'sd2/*2:xpc10*/;

                      6'sd20/*20:xpc10*/:  begin 
                           xpc10 <= 6'sd48/*48:xpc10*/;
                           T403_HashCAM_Read_0_7_V_0 <= 64'h0;
                           T403_LRU_Lookup_0_18_V_1 <= 64'h0;
                           T403_LRU_Lookup_0_18_V_0 <= 32'd0;
                           A_64_US_CC_SCALbx18_result <= 64'h0;
                           A_BOOL_CC_SCALbx18_matched <= 1'h0;
                           LRU_Lookup_CZ_0_1_blockrefxxnewobj12 <= 32'd0;
                           end 
                          
                      6'sd21/*21:xpc10*/:  xpc10 <= 6'sd22/*22:xpc10*/;

                      6'sd28/*28:xpc10*/:  begin 
                           xpc10 <= 6'sd42/*42:xpc10*/;
                           T403_HashCAM_Read_0_7_V_0 <= 64'h0;
                           T403_LRU_Lookup_0_22_V_1 <= 64'h0;
                           T403_LRU_Lookup_0_22_V_0 <= 32'd0;
                           A_64_US_CC_SCALbx16_result <= 64'h0;
                           A_BOOL_CC_SCALbx16_matched <= 1'h0;
                           LRU_Lookup_CZ_0_1_blockrefxxnewobj14 <= 32'd0;
                           A_64_US_CC_SCALbx18_result <= NaughtyQ_data_out_nv;
                           end 
                          
                      6'sd29/*29:xpc10*/:  xpc10 <= 6'sd30/*30:xpc10*/;

                      6'sd41/*41:xpc10*/:  xpc10 <= 6'sd30/*30:xpc10*/;

                      6'sd47/*47:xpc10*/:  xpc10 <= 6'sd22/*22:xpc10*/;

                      6'sd61/*61:xpc10*/:  xpc10 <= 6'sd2/*2:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      6'sd0/*0:xpc10*/:  begin 
                           xpc10 <= 6'sd1/*1:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'hd;
                           T403_HashCAM_Read_0_7_V_0 <= 64'h0;
                           T403_LRU_Lookup_0_4_V_1 <= 64'h0;
                           T403_LRU_Lookup_0_4_V_0 <= 32'd0;
                           A_64_US_CC_SCALbx20_result <= 64'h0;
                           A_BOOL_CC_SCALbx20_matched <= 1'h0;
                           LRU_Lookup_CZ_0_1_blockrefxxnewobj10 <= 32'd0;
                           KiwiSystem_Kiwi_tnow <= 64'h0;
                           KiwiSystem_Kiwi_old_pausemode_value <= 32'h2;
                           System_BitConverter_IsLittleEndian <= 1'h1;
                           HashCAM_is_full <= 1'h0;
                           HashCAM_matched <= 1'h0;
                           end 
                          
                      6'sd1/*1:xpc10*/:  xpc10 <= 6'sd61/*61:xpc10*/;

                      6'sd20/*20:xpc10*/:  begin 
                           xpc10 <= 6'sd21/*21:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'hd;
                           T403_HashCAM_Read_0_7_V_0 <= 64'h0;
                           T403_LRU_Lookup_0_18_V_1 <= 64'h0;
                           T403_LRU_Lookup_0_18_V_0 <= 32'd0;
                           A_64_US_CC_SCALbx18_result <= 64'h0;
                           A_BOOL_CC_SCALbx18_matched <= 1'h0;
                           LRU_Lookup_CZ_0_1_blockrefxxnewobj12 <= 32'd0;
                           end 
                          
                      6'sd21/*21:xpc10*/:  xpc10 <= 6'sd47/*47:xpc10*/;

                      6'sd28/*28:xpc10*/:  begin 
                           xpc10 <= 6'sd29/*29:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'hd;
                           T403_HashCAM_Read_0_7_V_0 <= 64'h0;
                           T403_LRU_Lookup_0_22_V_1 <= 64'h0;
                           T403_LRU_Lookup_0_22_V_0 <= 32'd0;
                           A_64_US_CC_SCALbx16_result <= 64'h0;
                           A_BOOL_CC_SCALbx16_matched <= 1'h0;
                           LRU_Lookup_CZ_0_1_blockrefxxnewobj14 <= 32'd0;
                           A_64_US_CC_SCALbx18_result <= NaughtyQ_data_out_nv;
                           end 
                          
                      6'sd29/*29:xpc10*/:  xpc10 <= 6'sd41/*41:xpc10*/;

                      6'sd42/*42:xpc10*/:  begin 
                           xpc10 <= 6'sd29/*29:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'hd;
                           end 
                          
                      6'sd48/*48:xpc10*/:  begin 
                           xpc10 <= 6'sd21/*21:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'hd;
                           end 
                          
                      6'sd62/*62:xpc10*/:  begin 
                           xpc10 <= 6'sd1/*1:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'hd;
                           end 
                          endcase
              if ((xpc10==6'sd23/*23:xpc10*/))  begin 
                      if (HashCAM_matched && !NQ_ready)  begin 
                               xpc10 <= 6'sd24/*24:xpc10*/;
                               NQ_enable <= 1'h1;
                               NQ_idx_in <= T403_HashCAM_Read_0_7_V_0;
                               NQ_command <= 8'h2;
                               A_64_US_CC_SCALbx18_result <= 64'h0;
                               A_BOOL_CC_SCALbx18_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_18_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                              if (!HC_lookup_ready && !HashCAM_matched)  begin 
                               xpc10 <= 6'sd29/*29:xpc10*/;
                               HC_lookup_enable <= 1'h1;
                               HC_key_in <= 64'hd;
                               T403_HashCAM_Read_0_7_V_0 <= 64'h0;
                               T403_LRU_Lookup_0_22_V_1 <= 64'h0;
                               T403_LRU_Lookup_0_22_V_0 <= 32'd0;
                               A_64_US_CC_SCALbx16_result <= 64'h0;
                               A_BOOL_CC_SCALbx16_matched <= 1'h0;
                               LRU_Lookup_CZ_0_1_blockrefxxnewobj14 <= 32'd0;
                               A_64_US_CC_SCALbx18_result <= 64'h0;
                               A_BOOL_CC_SCALbx18_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_18_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                              if (HashCAM_matched && NQ_ready)  begin 
                               xpc10 <= 6'sd46/*46:xpc10*/;
                               A_64_US_CC_SCALbx18_result <= 64'h0;
                               A_BOOL_CC_SCALbx18_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_18_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                              if (HC_lookup_ready && !HashCAM_matched)  begin 
                               xpc10 <= 6'sd42/*42:xpc10*/;
                               T403_HashCAM_Read_0_7_V_0 <= 64'h0;
                               T403_LRU_Lookup_0_22_V_1 <= 64'h0;
                               T403_LRU_Lookup_0_22_V_0 <= 32'd0;
                               A_64_US_CC_SCALbx16_result <= 64'h0;
                               A_BOOL_CC_SCALbx16_matched <= 1'h0;
                               LRU_Lookup_CZ_0_1_blockrefxxnewobj14 <= 32'd0;
                               A_64_US_CC_SCALbx18_result <= 64'h0;
                               A_BOOL_CC_SCALbx18_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_18_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                               end 
                      if (HC_write_ready) 
                  case (xpc10)
                      6'sd11/*11:xpc10*/:  begin 
                           xpc10 <= 6'sd54/*54:xpc10*/;
                           T403_HashCAM_Write_0_6_V_0 <= 64'h0;
                           T403_LRU_Cache_0_10_V_0 <= NaughtyQ_idx_out_nv;
                           end 
                          
                      6'sd12/*12:xpc10*/:  xpc10 <= 6'sd13/*13:xpc10*/;

                      6'sd17/*17:xpc10*/:  begin 
                           xpc10 <= 6'sd50/*50:xpc10*/;
                           T403_HashCAM_Write_0_6_V_0 <= 64'h0;
                           T403_LRU_Cache_0_15_V_0 <= NaughtyQ_idx_out_nv;
                           end 
                          
                      6'sd18/*18:xpc10*/:  xpc10 <= 6'sd19/*19:xpc10*/;

                      6'sd49/*49:xpc10*/:  xpc10 <= 6'sd19/*19:xpc10*/;

                      6'sd53/*53:xpc10*/:  xpc10 <= 6'sd13/*13:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      6'sd11/*11:xpc10*/:  begin 
                           xpc10 <= 6'sd12/*12:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= NaughtyQ_idx_out_nv;
                           HC_key_in <= 64'hd;
                           T403_HashCAM_Write_0_6_V_0 <= 64'h0;
                           T403_LRU_Cache_0_10_V_0 <= NaughtyQ_idx_out_nv;
                           end 
                          
                      6'sd12/*12:xpc10*/:  xpc10 <= 6'sd53/*53:xpc10*/;

                      6'sd17/*17:xpc10*/:  begin 
                           xpc10 <= 6'sd18/*18:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= NaughtyQ_idx_out_nv;
                           HC_key_in <= 64'hd;
                           T403_HashCAM_Write_0_6_V_0 <= 64'h0;
                           T403_LRU_Cache_0_15_V_0 <= NaughtyQ_idx_out_nv;
                           end 
                          
                      6'sd18/*18:xpc10*/:  xpc10 <= 6'sd49/*49:xpc10*/;

                      6'sd50/*50:xpc10*/:  begin 
                           xpc10 <= 6'sd18/*18:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= T403_LRU_Cache_0_15_V_0;
                           HC_key_in <= 64'hd;
                           end 
                          
                      6'sd54/*54:xpc10*/:  begin 
                           xpc10 <= 6'sd12/*12:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= T403_LRU_Cache_0_10_V_0;
                           HC_key_in <= 64'hd;
                           end 
                          endcase
              if ((xpc10==6'sd3/*3:xpc10*/))  begin 
                      if (HashCAM_matched && !NQ_ready)  begin 
                               xpc10 <= 6'sd4/*4:xpc10*/;
                               NQ_enable <= 1'h1;
                               NQ_idx_in <= T403_HashCAM_Read_0_7_V_0;
                               NQ_command <= 8'h2;
                               A_64_US_CC_SCALbx20_result <= 64'h0;
                               A_BOOL_CC_SCALbx20_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_4_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                              if (HashCAM_matched && NQ_ready)  begin 
                               xpc10 <= 6'sd60/*60:xpc10*/;
                               A_64_US_CC_SCALbx20_result <= 64'h0;
                               A_BOOL_CC_SCALbx20_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_4_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                              if (!HashCAM_matched && !NQ_ready)  begin 
                               xpc10 <= 6'sd9/*9:xpc10*/;
                               NQ_enable <= 1'h1;
                               NQ_data_in <= 64'h2;
                               NQ_command <= 8'h1;
                               LRU_T403_Main_T403_Main_V_0 <= 32'd0;
                               A_64_US_CC_SCALbx20_result <= 64'h0;
                               A_BOOL_CC_SCALbx20_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_4_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                              if (!HashCAM_matched && NQ_ready)  begin 
                               xpc10 <= 6'sd56/*56:xpc10*/;
                               LRU_T403_Main_T403_Main_V_0 <= 32'd0;
                               A_64_US_CC_SCALbx20_result <= 64'h0;
                               A_BOOL_CC_SCALbx20_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_4_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                               end 
                      if (HashCAM_matched && !NQ_ready && (xpc10==6'sd31/*31:xpc10*/))  begin 
                       xpc10 <= 6'sd32/*32:xpc10*/;
                       NQ_enable <= 1'h1;
                       NQ_idx_in <= T403_HashCAM_Read_0_7_V_0;
                       NQ_command <= 8'h2;
                       A_64_US_CC_SCALbx16_result <= 64'h0;
                       A_BOOL_CC_SCALbx16_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                       T403_LRU_Lookup_0_22_V_1 <= T403_HashCAM_Read_0_7_V_0;
                       end 
                      
              case (xpc10)
                  6'sd2/*2:xpc10*/:  begin 
                       xpc10 <= 6'sd3/*3:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_7_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract0(HC_match);
                       end 
                      
                  6'sd7/*7:xpc10*/:  begin 
                       xpc10 <= 6'sd8/*8:xpc10*/;
                       NQ_enable <= 1'h0;
                       NaughtyQ_data_out_nv <= rtl_unsigned_extend1(NQ_data_out);
                       end 
                      
                  6'sd10/*10:xpc10*/:  begin 
                       xpc10 <= 6'sd11/*11:xpc10*/;
                       NQ_enable <= 1'h0;
                       NaughtyQ_data_out_nv <= rtl_unsigned_extend1(NQ_data_out);
                       NaughtyQ_idx_out_nv <= rtl_unsigned_extend1(NQ_idx_out);
                       end 
                      
                  6'sd13/*13:xpc10*/:  begin 
                       xpc10 <= 6'sd14/*14:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract0(HC_full);
                       T403_HashCAM_Write_0_6_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract0(HC_match);
                       end 
                      
                  6'sd16/*16:xpc10*/:  begin 
                       xpc10 <= 6'sd17/*17:xpc10*/;
                       NQ_enable <= 1'h0;
                       NaughtyQ_data_out_nv <= rtl_unsigned_extend1(NQ_data_out);
                       NaughtyQ_idx_out_nv <= rtl_unsigned_extend1(NQ_idx_out);
                       end 
                      
                  6'sd19/*19:xpc10*/:  begin 
                       xpc10 <= 6'sd20/*20:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract0(HC_full);
                       T403_HashCAM_Write_0_6_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract0(HC_match);
                       end 
                      
                  6'sd22/*22:xpc10*/:  begin 
                       xpc10 <= 6'sd23/*23:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_7_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract0(HC_match);
                       end 
                      
                  6'sd27/*27:xpc10*/:  begin 
                       xpc10 <= 6'sd28/*28:xpc10*/;
                       NQ_enable <= 1'h0;
                       NaughtyQ_data_out_nv <= rtl_unsigned_extend1(NQ_data_out);
                       end 
                      
                  6'sd30/*30:xpc10*/:  begin 
                       xpc10 <= 6'sd31/*31:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_7_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract0(HC_match);
                       end 
                      
                  6'sd31/*31:xpc10*/:  begin 
                      if (HashCAM_matched && NQ_ready)  begin 
                               xpc10 <= 6'sd40/*40:xpc10*/;
                               A_64_US_CC_SCALbx16_result <= 64'h0;
                               A_BOOL_CC_SCALbx16_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_22_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                              if (!HashCAM_matched)  begin 
                               A_64_US_CC_SCALbx16_result <= 64'h0;
                               A_BOOL_CC_SCALbx16_matched <= rtl_unsigned_bitextract0(HashCAM_matched);
                               T403_LRU_Lookup_0_22_V_1 <= T403_HashCAM_Read_0_7_V_0;
                               end 
                               end 
                      
                  6'sd35/*35:xpc10*/:  begin 
                       xpc10 <= 6'sd36/*36:xpc10*/;
                       NQ_enable <= 1'h0;
                       NaughtyQ_data_out_nv <= rtl_unsigned_extend1(NQ_data_out);
                       end 
                      
                  6'sd36/*36:xpc10*/:  A_64_US_CC_SCALbx16_result <= NaughtyQ_data_out_nv;
              endcase
              if ((xpc14==1'sd0/*0:xpc14*/))  xpc14 <= 1'sd1/*1:xpc14*/;
                  if ((xpc12==1'sd0/*0:xpc12*/))  xpc12 <= 1'sd1/*1:xpc12*/;
                   end 
              //End structure HPR anontop


       end 
      

// 8 vectors of width 1
// 1 vectors of width 6
// 13 vectors of width 64
// 8 vectors of width 32
// Total state bits in module = 1102 bits.
// 192 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
//HPR L/S (orangepath) auxiliary reports.
//KiwiC compilation report
//Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016
//17/01/2017 23:40:17
//Cmd line args:  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe LRU.dll HashCAM_KiwiLift.dll NaughtyQ_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl LRU.v


//----------------------------------------------------------

//Report from Abbreviation:::
//Setting up abbreviation @64 for prefix @/64

//----------------------------------------------------------

//Report from KiwiC-fe.rpt:::
//KiwiC: front end input processing of class or method called KiwiSystem/Kiwi
//
//root_walk start thread at a static method (used as an entry point). Method name=.cctor uid=cctor10
//
//KiwiC start_thread (or entry point) id=cctor10
//
//Root method elaborated: specificf=S_kickoff_collate leftover=1+0
//
//KiwiC: front end input processing of class or method called System/BitConverter
//
//root_walk start thread at a static method (used as an entry point). Method name=.cctor uid=cctor12
//
//KiwiC start_thread (or entry point) id=cctor12
//
//Root method elaborated: specificf=S_kickoff_collate leftover=1+1
//
//KiwiC: front end input processing of class or method called HashCAM
//
//root_walk start thread at a static method (used as an entry point). Method name=.cctor uid=cctor14
//
//KiwiC start_thread (or entry point) id=cctor14
//
//Root method elaborated: specificf=S_kickoff_collate leftover=1+2
//
//KiwiC: front end input processing of class or method called LRU
//
//root_compiler: start elaborating class 'LRU'
//
//elaborating class 'LRU'
//
//compiling static method as entry point: style=Root idl=LRU/Main
//
//Performing root elaboration of method Main
//
//KiwiC start_thread (or entry point) id=Main14
//
//root_compiler class done: LRU
//
//KiwiC: front end input processing of class or method called HashCAM
//
//root_compiler: start elaborating class 'HashCAM'
//
//elaborating class 'HashCAM'
//
//compiling static method as entry point: style=Root idl=HashCAM/Main
//
//Performing root elaboration of method Main
//
//KiwiC start_thread (or entry point) id=Main12
//
//root_compiler class done: HashCAM
//
//KiwiC: front end input processing of class or method called NaughtyQ
//
//root_compiler: start elaborating class 'NaughtyQ'
//
//elaborating class 'NaughtyQ'
//
//compiling static method as entry point: style=Root idl=NaughtyQ/Main
//
//Performing root elaboration of method Main
//
//KiwiC start_thread (or entry point) id=Main10
//
//root_compiler class done: NaughtyQ
//
//Report of all settings used from the recipe or command line:
//
//   cil-uwind-budget=10000
//
//   kiwic-finish=enable
//
//   kiwic-cil-dump=disable
//
//   kiwic-kcode-dump=disable
//
//   kiwic-register-colours=disable
//
//   array-4d-name=KIWIARRAY4D
//
//   array-3d-name=KIWIARRAY3D
//
//   array-2d-name=KIWIARRAY2D
//
//   kiwi-dll=Kiwi.dll
//
//   kiwic-dll=Kiwic.dll
//
//   kiwic-zerolength-arrays=disable
//
//   kiwic-fpgaconsole-default=enable
//
//   postgen-optimise=enable
//
//   ataken-loglevel=20
//
//   gtrace-loglevel=20
//
//   firstpass-loglevel=20
//
//   overloads-loglevel=20
//
//   root=$attributeroot
//
//   ?>?=srcfile, LRU.dll, HashCAM_KiwiLift.dll, NaughtyQ_KiwiLift.dll
//
//END OF KIWIC REPORT FILE
//

//----------------------------------------------------------

//Report from verilog_render:::
//8 vectors of width 1
//
//1 vectors of width 6
//
//13 vectors of width 64
//
//8 vectors of width 32
//
//Total state bits in module = 1102 bits.
//
//192 continuously assigned (wire/non-state) bits 
//
//Total number of leaf cells = 0
//

//Major Statistics Report:
//Thread .cctor uid=cctor10 has 3 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor12 has 2 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor14 has 3 CIL instructions in 1 basic blocks
//Thread Main uid=Main14 has 276 CIL instructions in 85 basic blocks
//Thread Main uid=Main12 has 3 CIL instructions in 1 basic blocks
//Thread Main uid=Main10 has 3 CIL instructions in 1 basic blocks
//Thread mpc10 has 63 bevelab control states (pauses)
//Thread mpc12 has 2 bevelab control states (pauses)
//Thread mpc14 has 2 bevelab control states (pauses)
// eof (HPR L/S Verilog)
