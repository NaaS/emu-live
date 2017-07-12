

// CBG Orangepath HPR L/S System

// Verilog output file generated at 17/01/2017 21:52:45
// Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016 Unix 14.5.0.0
//  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe HashCAM_KL_Test.dll HashCAM_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl HashCAM_KL_Test.v
`timescale 1ns/1ns


module HashCAM_KL_Test(    output reg HC_write_enable,
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

function  rtl_unsigned_bitextract2;
   input [31:0] arg;
   rtl_unsigned_bitextract2 = $unsigned(arg[0:0]);
   endfunction


function signed [63:0] rtl_sign_extend0;
   input [31:0] arg;
   rtl_sign_extend0 = { {32{arg[31]}}, arg[31:0] };
   endfunction


function [63:0] rtl_unsigned_extend1;
   input [31:0] arg;
   rtl_unsigned_extend1 = { 32'b0, arg[31:0] };
   endfunction

  reg HashCAM_matched;
  reg HashCAM_is_full;
  wire [31:0] ktop18;
  reg [63:0] T403_HashCAM_Write_1_5_V_0;
  reg [63:0] T403_HashCAM_Write_0_64_V_0;
  reg [63:0] T403_HashCAM_Read_0_58_V_0;
  reg [63:0] T403_HashCAM_Write_0_54_V_0;
  reg [63:0] T403_HashCAM_Read_0_48_V_0;
  reg [63:0] T403_HashCAM_Write_0_44_V_0;
  reg [63:0] T403_HashCAM_Read_0_38_V_0;
  reg [63:0] T403_HashCAM_Write_0_34_V_0;
  reg [63:0] T403_HashCAM_Read_0_28_V_0;
  reg [63:0] T403_HashCAM_Write_0_24_V_0;
  reg [63:0] T403_HashCAM_Read_0_18_V_0;
  reg [63:0] T403_HashCAM_Write_0_14_V_0;
  reg [63:0] T403_HashCAM_Read_0_8_V_0;
  reg [63:0] T403_HashCAM_Read_0_4_V_0;
  integer HashCAM_KL_Test_T403_Main_T403_Main_V_0;
  wire [31:0] ktop16;
  wire [31:0] ktop14;
  reg System_BitConverter_IsLittleEndian;
  wire [31:0] ktop12;
  reg [63:0] KiwiSystem_Kiwi_tnow;
  reg [31:0] KiwiSystem_Kiwi_old_pausemode_value;
  wire [31:0] ktop10;
  reg [6:0] xpc10;
  reg xpc12;
 always   @(posedge clk )  begin 
      //Start structure HPR anontop
      if (reset)  begin 
               KiwiSystem_Kiwi_tnow <= 64'd0;
               KiwiSystem_Kiwi_old_pausemode_value <= 32'd0;
               System_BitConverter_IsLittleEndian <= 32'd0;
               T403_HashCAM_Read_0_4_V_0 <= 64'd0;
               T403_HashCAM_Read_0_8_V_0 <= 64'd0;
               T403_HashCAM_Write_0_14_V_0 <= 64'd0;
               T403_HashCAM_Read_0_18_V_0 <= 64'd0;
               T403_HashCAM_Write_0_24_V_0 <= 64'd0;
               T403_HashCAM_Read_0_28_V_0 <= 64'd0;
               T403_HashCAM_Write_0_34_V_0 <= 64'd0;
               T403_HashCAM_Read_0_38_V_0 <= 64'd0;
               T403_HashCAM_Write_0_44_V_0 <= 64'd0;
               T403_HashCAM_Read_0_48_V_0 <= 64'd0;
               T403_HashCAM_Write_0_54_V_0 <= 64'd0;
               T403_HashCAM_Read_0_58_V_0 <= 64'd0;
               T403_HashCAM_Write_0_64_V_0 <= 64'd0;
               HashCAM_is_full <= 32'd0;
               HashCAM_matched <= 32'd0;
               T403_HashCAM_Write_1_5_V_0 <= 64'd0;
               HashCAM_KL_Test_T403_Main_T403_Main_V_0 <= 32'd0;
               HC_write_enable <= 32'd0;
               HC_value_in <= 32'd0;
               xpc10 <= 32'd0;
               HC_lookup_enable <= 32'd0;
               HC_key_in <= 32'd0;
               xpc12 <= 32'd0;
               end 
               else  begin 
              if ((HashCAM_KL_Test_T403_Main_T403_Main_V_0>=32'sd299) && (xpc10==7'sd43/*43:xpc10*/)) $finish(32'sd0);
                  if (HC_write_ready) 
                  case (xpc10)
                      7'sd6/*6:xpc10*/:  begin 
                           xpc10 <= 7'sd67/*67:xpc10*/;
                           T403_HashCAM_Write_0_14_V_0 <= 64'h0;
                           end 
                          
                      7'sd7/*7:xpc10*/:  xpc10 <= 7'sd8/*8:xpc10*/;

                      7'sd12/*12:xpc10*/:  begin 
                           xpc10 <= 7'sd63/*63:xpc10*/;
                           T403_HashCAM_Write_0_24_V_0 <= 64'h0;
                           end 
                          
                      7'sd13/*13:xpc10*/:  xpc10 <= 7'sd14/*14:xpc10*/;

                      7'sd18/*18:xpc10*/:  begin 
                           xpc10 <= 7'sd59/*59:xpc10*/;
                           T403_HashCAM_Write_0_34_V_0 <= 64'h0;
                           end 
                          
                      7'sd19/*19:xpc10*/:  xpc10 <= 7'sd20/*20:xpc10*/;

                      7'sd24/*24:xpc10*/:  begin 
                           xpc10 <= 7'sd55/*55:xpc10*/;
                           T403_HashCAM_Write_0_44_V_0 <= 64'h0;
                           end 
                          
                      7'sd25/*25:xpc10*/:  xpc10 <= 7'sd26/*26:xpc10*/;

                      7'sd30/*30:xpc10*/:  begin 
                           xpc10 <= 7'sd51/*51:xpc10*/;
                           T403_HashCAM_Write_0_54_V_0 <= 64'h0;
                           end 
                          
                      7'sd31/*31:xpc10*/:  xpc10 <= 7'sd32/*32:xpc10*/;

                      7'sd36/*36:xpc10*/:  begin 
                           xpc10 <= 7'sd47/*47:xpc10*/;
                           T403_HashCAM_Write_0_64_V_0 <= 64'h0;
                           end 
                          
                      7'sd37/*37:xpc10*/:  xpc10 <= 7'sd38/*38:xpc10*/;

                      7'sd39/*39:xpc10*/:  begin 
                           xpc10 <= 7'sd44/*44:xpc10*/;
                           T403_HashCAM_Write_1_5_V_0 <= 64'h0;
                           HashCAM_KL_Test_T403_Main_T403_Main_V_0 <= 32'sd0;
                           end 
                          
                      7'sd40/*40:xpc10*/:  xpc10 <= 7'sd41/*41:xpc10*/;

                      7'sd45/*45:xpc10*/:  xpc10 <= 7'sd41/*41:xpc10*/;

                      7'sd46/*46:xpc10*/:  xpc10 <= 7'sd38/*38:xpc10*/;

                      7'sd50/*50:xpc10*/:  xpc10 <= 7'sd32/*32:xpc10*/;

                      7'sd54/*54:xpc10*/:  xpc10 <= 7'sd26/*26:xpc10*/;

                      7'sd58/*58:xpc10*/:  xpc10 <= 7'sd20/*20:xpc10*/;

                      7'sd62/*62:xpc10*/:  xpc10 <= 7'sd14/*14:xpc10*/;

                      7'sd66/*66:xpc10*/:  xpc10 <= 7'sd8/*8:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      7'sd6/*6:xpc10*/:  begin 
                           xpc10 <= 7'sd7/*7:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h7;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Write_0_14_V_0 <= 64'h0;
                           end 
                          
                      7'sd7/*7:xpc10*/:  xpc10 <= 7'sd66/*66:xpc10*/;

                      7'sd12/*12:xpc10*/:  begin 
                           xpc10 <= 7'sd13/*13:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h7;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Write_0_24_V_0 <= 64'h0;
                           end 
                          
                      7'sd13/*13:xpc10*/:  xpc10 <= 7'sd62/*62:xpc10*/;

                      7'sd18/*18:xpc10*/:  begin 
                           xpc10 <= 7'sd19/*19:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h7;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Write_0_34_V_0 <= 64'h0;
                           end 
                          
                      7'sd19/*19:xpc10*/:  xpc10 <= 7'sd58/*58:xpc10*/;

                      7'sd24/*24:xpc10*/:  begin 
                           xpc10 <= 7'sd25/*25:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h8;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Write_0_44_V_0 <= 64'h0;
                           end 
                          
                      7'sd25/*25:xpc10*/:  xpc10 <= 7'sd54/*54:xpc10*/;

                      7'sd30/*30:xpc10*/:  begin 
                           xpc10 <= 7'sd31/*31:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h7;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Write_0_54_V_0 <= 64'h0;
                           end 
                          
                      7'sd31/*31:xpc10*/:  xpc10 <= 7'sd50/*50:xpc10*/;

                      7'sd36/*36:xpc10*/:  begin 
                           xpc10 <= 7'sd37/*37:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h9;
                           HC_key_in <= 64'hc;
                           T403_HashCAM_Write_0_64_V_0 <= 64'h0;
                           end 
                          
                      7'sd37/*37:xpc10*/:  xpc10 <= 7'sd46/*46:xpc10*/;

                      7'sd39/*39:xpc10*/:  begin 
                           xpc10 <= 7'sd40/*40:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h1;
                           HC_key_in <= 64'h0;
                           T403_HashCAM_Write_1_5_V_0 <= 64'h0;
                           HashCAM_KL_Test_T403_Main_T403_Main_V_0 <= 32'sd0;
                           end 
                          
                      7'sd40/*40:xpc10*/:  xpc10 <= 7'sd45/*45:xpc10*/;

                      7'sd44/*44:xpc10*/:  begin 
                           xpc10 <= 7'sd40/*40:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h1;
                           HC_key_in <= $signed(rtl_sign_extend0(HashCAM_KL_Test_T403_Main_T403_Main_V_0));
                           end 
                          
                      7'sd47/*47:xpc10*/:  begin 
                           xpc10 <= 7'sd37/*37:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h9;
                           HC_key_in <= 64'hc;
                           end 
                          
                      7'sd51/*51:xpc10*/:  begin 
                           xpc10 <= 7'sd31/*31:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h7;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd55/*55:xpc10*/:  begin 
                           xpc10 <= 7'sd25/*25:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h8;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd59/*59:xpc10*/:  begin 
                           xpc10 <= 7'sd19/*19:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h7;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd63/*63:xpc10*/:  begin 
                           xpc10 <= 7'sd13/*13:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h7;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd67/*67:xpc10*/:  begin 
                           xpc10 <= 7'sd7/*7:xpc10*/;
                           HC_write_enable <= 1'h1;
                           HC_value_in <= 64'h7;
                           HC_key_in <= 64'ha;
                           end 
                          endcase
              if (HC_lookup_ready) 
                  case (xpc10)
                      7'sd0/*0:xpc10*/:  begin 
                           xpc10 <= 7'sd71/*71:xpc10*/;
                           T403_HashCAM_Read_0_4_V_0 <= 64'h0;
                           KiwiSystem_Kiwi_tnow <= 64'h0;
                           KiwiSystem_Kiwi_old_pausemode_value <= 32'h2;
                           System_BitConverter_IsLittleEndian <= 1'h1;
                           HashCAM_is_full <= 1'h0;
                           HashCAM_matched <= 1'h0;
                           end 
                          
                      7'sd1/*1:xpc10*/:  xpc10 <= 7'sd2/*2:xpc10*/;

                      7'sd3/*3:xpc10*/:  begin 
                           xpc10 <= 7'sd69/*69:xpc10*/;
                           T403_HashCAM_Read_0_8_V_0 <= 64'h0;
                           end 
                          
                      7'sd4/*4:xpc10*/:  xpc10 <= 7'sd5/*5:xpc10*/;

                      7'sd9/*9:xpc10*/:  begin 
                           xpc10 <= 7'sd65/*65:xpc10*/;
                           T403_HashCAM_Read_0_18_V_0 <= 64'h0;
                           end 
                          
                      7'sd10/*10:xpc10*/:  xpc10 <= 7'sd11/*11:xpc10*/;

                      7'sd15/*15:xpc10*/:  begin 
                           xpc10 <= 7'sd61/*61:xpc10*/;
                           T403_HashCAM_Read_0_28_V_0 <= 64'h0;
                           end 
                          
                      7'sd16/*16:xpc10*/:  xpc10 <= 7'sd17/*17:xpc10*/;

                      7'sd21/*21:xpc10*/:  begin 
                           xpc10 <= 7'sd57/*57:xpc10*/;
                           T403_HashCAM_Read_0_38_V_0 <= 64'h0;
                           end 
                          
                      7'sd22/*22:xpc10*/:  xpc10 <= 7'sd23/*23:xpc10*/;

                      7'sd27/*27:xpc10*/:  begin 
                           xpc10 <= 7'sd53/*53:xpc10*/;
                           T403_HashCAM_Read_0_48_V_0 <= 64'h0;
                           end 
                          
                      7'sd28/*28:xpc10*/:  xpc10 <= 7'sd29/*29:xpc10*/;

                      7'sd33/*33:xpc10*/:  begin 
                           xpc10 <= 7'sd49/*49:xpc10*/;
                           T403_HashCAM_Read_0_58_V_0 <= 64'h0;
                           end 
                          
                      7'sd34/*34:xpc10*/:  xpc10 <= 7'sd35/*35:xpc10*/;

                      7'sd48/*48:xpc10*/:  xpc10 <= 7'sd35/*35:xpc10*/;

                      7'sd52/*52:xpc10*/:  xpc10 <= 7'sd29/*29:xpc10*/;

                      7'sd56/*56:xpc10*/:  xpc10 <= 7'sd23/*23:xpc10*/;

                      7'sd60/*60:xpc10*/:  xpc10 <= 7'sd17/*17:xpc10*/;

                      7'sd64/*64:xpc10*/:  xpc10 <= 7'sd11/*11:xpc10*/;

                      7'sd68/*68:xpc10*/:  xpc10 <= 7'sd5/*5:xpc10*/;

                      7'sd70/*70:xpc10*/:  xpc10 <= 7'sd2/*2:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      7'sd0/*0:xpc10*/:  begin 
                           xpc10 <= 7'sd1/*1:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Read_0_4_V_0 <= 64'h0;
                           KiwiSystem_Kiwi_tnow <= 64'h0;
                           KiwiSystem_Kiwi_old_pausemode_value <= 32'h2;
                           System_BitConverter_IsLittleEndian <= 1'h1;
                           HashCAM_is_full <= 1'h0;
                           HashCAM_matched <= 1'h0;
                           end 
                          
                      7'sd1/*1:xpc10*/:  xpc10 <= 7'sd70/*70:xpc10*/;

                      7'sd3/*3:xpc10*/:  begin 
                           xpc10 <= 7'sd4/*4:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Read_0_8_V_0 <= 64'h0;
                           end 
                          
                      7'sd4/*4:xpc10*/:  xpc10 <= 7'sd68/*68:xpc10*/;

                      7'sd9/*9:xpc10*/:  begin 
                           xpc10 <= 7'sd10/*10:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Read_0_18_V_0 <= 64'h0;
                           end 
                          
                      7'sd10/*10:xpc10*/:  xpc10 <= 7'sd64/*64:xpc10*/;

                      7'sd15/*15:xpc10*/:  begin 
                           xpc10 <= 7'sd16/*16:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Read_0_28_V_0 <= 64'h0;
                           end 
                          
                      7'sd16/*16:xpc10*/:  xpc10 <= 7'sd60/*60:xpc10*/;

                      7'sd21/*21:xpc10*/:  begin 
                           xpc10 <= 7'sd22/*22:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Read_0_38_V_0 <= 64'h0;
                           end 
                          
                      7'sd22/*22:xpc10*/:  xpc10 <= 7'sd56/*56:xpc10*/;

                      7'sd27/*27:xpc10*/:  begin 
                           xpc10 <= 7'sd28/*28:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           T403_HashCAM_Read_0_48_V_0 <= 64'h0;
                           end 
                          
                      7'sd28/*28:xpc10*/:  xpc10 <= 7'sd52/*52:xpc10*/;

                      7'sd33/*33:xpc10*/:  begin 
                           xpc10 <= 7'sd34/*34:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'hb;
                           T403_HashCAM_Read_0_58_V_0 <= 64'h0;
                           end 
                          
                      7'sd34/*34:xpc10*/:  xpc10 <= 7'sd48/*48:xpc10*/;

                      7'sd49/*49:xpc10*/:  begin 
                           xpc10 <= 7'sd34/*34:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'hb;
                           end 
                          
                      7'sd53/*53:xpc10*/:  begin 
                           xpc10 <= 7'sd28/*28:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd57/*57:xpc10*/:  begin 
                           xpc10 <= 7'sd22/*22:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd61/*61:xpc10*/:  begin 
                           xpc10 <= 7'sd16/*16:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd65/*65:xpc10*/:  begin 
                           xpc10 <= 7'sd10/*10:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd69/*69:xpc10*/:  begin 
                           xpc10 <= 7'sd4/*4:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           end 
                          
                      7'sd71/*71:xpc10*/:  begin 
                           xpc10 <= 7'sd1/*1:xpc10*/;
                           HC_lookup_enable <= 1'h1;
                           HC_key_in <= 64'ha;
                           end 
                          endcase

              case (xpc10)
                  7'sd2/*2:xpc10*/:  begin 
                       xpc10 <= 7'sd3/*3:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_4_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd5/*5:xpc10*/:  begin 
                       xpc10 <= 7'sd6/*6:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_8_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd8/*8:xpc10*/:  begin 
                       xpc10 <= 7'sd9/*9:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract2(HC_full);
                       T403_HashCAM_Write_0_14_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd11/*11:xpc10*/:  begin 
                       xpc10 <= 7'sd12/*12:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_18_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd14/*14:xpc10*/:  begin 
                       xpc10 <= 7'sd15/*15:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract2(HC_full);
                       T403_HashCAM_Write_0_24_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd17/*17:xpc10*/:  begin 
                       xpc10 <= 7'sd18/*18:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_28_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd20/*20:xpc10*/:  begin 
                       xpc10 <= 7'sd21/*21:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract2(HC_full);
                       T403_HashCAM_Write_0_34_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd23/*23:xpc10*/:  begin 
                       xpc10 <= 7'sd24/*24:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_38_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd26/*26:xpc10*/:  begin 
                       xpc10 <= 7'sd27/*27:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract2(HC_full);
                       T403_HashCAM_Write_0_44_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd29/*29:xpc10*/:  begin 
                       xpc10 <= 7'sd30/*30:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_48_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd32/*32:xpc10*/:  begin 
                       xpc10 <= 7'sd33/*33:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract2(HC_full);
                       T403_HashCAM_Write_0_54_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd35/*35:xpc10*/:  begin 
                       xpc10 <= 7'sd36/*36:xpc10*/;
                       HC_lookup_enable <= 1'h0;
                       T403_HashCAM_Read_0_58_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd38/*38:xpc10*/:  begin 
                       xpc10 <= 7'sd39/*39:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract2(HC_full);
                       T403_HashCAM_Write_0_64_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd41/*41:xpc10*/:  begin 
                       xpc10 <= 7'sd42/*42:xpc10*/;
                       HC_write_enable <= 1'h0;
                       HashCAM_is_full <= rtl_unsigned_bitextract2(HC_full);
                       T403_HashCAM_Write_1_5_V_0 <= rtl_unsigned_extend1(HC_value_out);
                       HashCAM_matched <= rtl_unsigned_bitextract2(HC_match);
                       end 
                      
                  7'sd43/*43:xpc10*/:  begin 
                      if (!HC_write_ready && (HashCAM_KL_Test_T403_Main_T403_Main_V_0<32'sd299))  begin 
                               xpc10 <= 7'sd40/*40:xpc10*/;
                               HC_write_enable <= 1'h1;
                               HC_value_in <= 64'h1;
                               HC_key_in <= $signed(rtl_sign_extend0(32'sd1+HashCAM_KL_Test_T403_Main_T403_Main_V_0));
                               T403_HashCAM_Write_1_5_V_0 <= 64'h0;
                               HashCAM_KL_Test_T403_Main_T403_Main_V_0 <= 32'sd1+HashCAM_KL_Test_T403_Main_T403_Main_V_0;
                               end 
                              if (HC_write_ready && (HashCAM_KL_Test_T403_Main_T403_Main_V_0<32'sd299))  begin 
                               xpc10 <= 7'sd44/*44:xpc10*/;
                               T403_HashCAM_Write_1_5_V_0 <= 64'h0;
                               HashCAM_KL_Test_T403_Main_T403_Main_V_0 <= 32'sd1+HashCAM_KL_Test_T403_Main_T403_Main_V_0;
                               end 
                              if ((HashCAM_KL_Test_T403_Main_T403_Main_V_0>=32'sd299))  HashCAM_KL_Test_T403_Main_T403_Main_V_0 <= 32'sd1
                          +HashCAM_KL_Test_T403_Main_T403_Main_V_0;

                           end 
                      endcase
              if ((xpc12==1'sd0/*0:xpc12*/))  xpc12 <= 1'sd1/*1:xpc12*/;
                  if ((xpc10==7'sd42/*42:xpc10*/))  xpc10 <= 7'sd43/*43:xpc10*/;
                   end 
              //End structure HPR anontop


       end 
      

// 4 vectors of width 1
// 1 vectors of width 7
// 1 vectors of width 32
// 15 vectors of width 64
// 32 bits in scalar variables
// Total state bits in module = 1035 bits.
// 160 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
//HPR L/S (orangepath) auxiliary reports.
//KiwiC compilation report
//Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016
//17/01/2017 21:52:39
//Cmd line args:  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe HashCAM_KL_Test.dll HashCAM_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl HashCAM_KL_Test.v


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
//KiwiC: front end input processing of class or method called HashCAM_KL_Test
//
//root_compiler: start elaborating class 'HashCAM_KL_Test'
//
//elaborating class 'HashCAM_KL_Test'
//
//compiling static method as entry point: style=Root idl=HashCAM_KL_Test/Main
//
//Performing root elaboration of method Main
//
//KiwiC start_thread (or entry point) id=Main12
//
//root_compiler class done: HashCAM_KL_Test
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
//KiwiC start_thread (or entry point) id=Main10
//
//root_compiler class done: HashCAM
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
//   ?>?=srcfile, HashCAM_KL_Test.dll, HashCAM_KiwiLift.dll
//
//END OF KIWIC REPORT FILE
//

//----------------------------------------------------------

//Report from verilog_render:::
//4 vectors of width 1
//
//1 vectors of width 7
//
//1 vectors of width 32
//
//15 vectors of width 64
//
//32 bits in scalar variables
//
//Total state bits in module = 1035 bits.
//
//160 continuously assigned (wire/non-state) bits 
//
//Total number of leaf cells = 0
//

//Major Statistics Report:
//Thread .cctor uid=cctor10 has 3 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor12 has 2 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor14 has 3 CIL instructions in 1 basic blocks
//Thread Main uid=Main12 has 288 CIL instructions in 88 basic blocks
//Thread Main uid=Main10 has 3 CIL instructions in 1 basic blocks
//Thread mpc10 has 72 bevelab control states (pauses)
//Thread mpc12 has 2 bevelab control states (pauses)
// eof (HPR L/S Verilog)
