

// CBG Orangepath HPR L/S System

// Verilog output file generated at 17/01/2017 21:52:21
// Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016 Unix 14.5.0.0
//  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe PearsonHash_KL_Test.dll PearsonHash_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl PearsonHash_KL_Test.v
`timescale 1ns/1ns


module PearsonHash_KL_Test(    output [7:0] PH_block_hash,
    input PH_block_ready,
    output reg PH_block_enable,
    output reg [63:0] PH_block_in,
    output [7:0] PH_cipher_out,
    input PH_encipher_ready,
    output reg PH_encipher_enable,
    input PH_write_ready,
    output reg PH_write_enable,
    output reg [7:0] PH_key_byte_in,
    output reg [7:0] PH_idx_in,
    input PH_init_hash_ready,
    output reg PH_init_hash_enable,
    output reg [7:0] PH_data_in,
    input clk,
    input reset);

function [7:0] rtl_unsigned_bitextract2;
   input [31:0] arg;
   rtl_unsigned_bitextract2 = $unsigned(arg[7:0]);
   endfunction


function [7:0] rtl_unsigned_bitextract0;
   input [31:0] arg;
   rtl_unsigned_bitextract0 = $unsigned(arg[7:0]);
   endfunction


function [31:0] rtl_unsigned_extend1;
   input [7:0] arg;
   rtl_unsigned_extend1 = { 24'b0, arg[7:0] };
   endfunction

  reg [7:0] T402_PearsonHash_BlockHash_6_14_V_0;
  reg [7:0] T402_PearsonHash_BlockHash_6_10_V_0;
  reg [7:0] T402_PearsonHash_BlockHash_6_6_V_0;
  reg [7:0] T402_PearsonHash_BlockHash_6_2_V_0;
  reg [7:0] T402_PearsonHash_StreamHash_4_3_V_0;
  reg [7:0] T402_PearsonHash_StreamHash_3_16_V_0;
  reg [7:0] T402_PearsonHash_StreamHash_3_13_V_0;
  reg [7:0] T402_PearsonHash_StreamHash_3_10_V_0;
  reg [7:0] T402_PearsonHash_StreamHash_3_7_V_0;
  integer PearsonHash_KL_Test_T402_Main_T402_Main_V_1;
  integer PearsonHash_KL_Test_T402_Main_T402_Main_V_0;
  wire [31:0] ktop14;
  reg System_BitConverter_IsLittleEndian;
  wire [31:0] ktop12;
  reg [63:0] KiwiSystem_Kiwi_tnow;
  reg [31:0] KiwiSystem_Kiwi_old_pausemode_value;
  wire [31:0] ktop10;
  reg [6:0] xpc10;
 always   @(posedge clk )  begin 
      //Start structure HPR anontop
      if (reset)  begin 
               KiwiSystem_Kiwi_tnow <= 64'd0;
               KiwiSystem_Kiwi_old_pausemode_value <= 32'd0;
               System_BitConverter_IsLittleEndian <= 32'd0;
               PearsonHash_KL_Test_T402_Main_T402_Main_V_0 <= 32'd0;
               T402_PearsonHash_StreamHash_3_7_V_0 <= 32'd0;
               T402_PearsonHash_StreamHash_3_10_V_0 <= 32'd0;
               T402_PearsonHash_StreamHash_3_13_V_0 <= 32'd0;
               T402_PearsonHash_StreamHash_3_16_V_0 <= 32'd0;
               T402_PearsonHash_StreamHash_4_3_V_0 <= 32'd0;
               PearsonHash_KL_Test_T402_Main_T402_Main_V_1 <= 32'd0;
               T402_PearsonHash_BlockHash_6_2_V_0 <= 32'd0;
               T402_PearsonHash_BlockHash_6_6_V_0 <= 32'd0;
               T402_PearsonHash_BlockHash_6_10_V_0 <= 32'd0;
               T402_PearsonHash_BlockHash_6_14_V_0 <= 32'd0;
               PH_block_enable <= 32'd0;
               PH_block_in <= 64'd0;
               PH_encipher_enable <= 32'd0;
               PH_write_enable <= 32'd0;
               PH_key_byte_in <= 32'd0;
               PH_idx_in <= 32'd0;
               xpc10 <= 32'd0;
               PH_init_hash_enable <= 32'd0;
               PH_data_in <= 32'd0;
               end 
               else  begin 
              if ((xpc10==7'sd46/*46:xpc10*/)) $finish(32'sd0);
                  if (PH_encipher_ready) 
                  case (xpc10)
                      7'sd15/*15:xpc10*/:  xpc10 <= 7'sd66/*66:xpc10*/;

                      7'sd16/*16:xpc10*/:  xpc10 <= 7'sd17/*17:xpc10*/;

                      7'sd18/*18:xpc10*/:  xpc10 <= 7'sd64/*64:xpc10*/;

                      7'sd19/*19:xpc10*/:  xpc10 <= 7'sd20/*20:xpc10*/;

                      7'sd21/*21:xpc10*/:  xpc10 <= 7'sd62/*62:xpc10*/;

                      7'sd22/*22:xpc10*/:  xpc10 <= 7'sd23/*23:xpc10*/;

                      7'sd24/*24:xpc10*/:  xpc10 <= 7'sd60/*60:xpc10*/;

                      7'sd25/*25:xpc10*/:  xpc10 <= 7'sd26/*26:xpc10*/;

                      7'sd30/*30:xpc10*/:  begin 
                           xpc10 <= 7'sd55/*55:xpc10*/;
                           PearsonHash_KL_Test_T402_Main_T402_Main_V_1 <= 32'sd0;
                           end 
                          
                      7'sd31/*31:xpc10*/:  xpc10 <= 7'sd32/*32:xpc10*/;

                      7'sd56/*56:xpc10*/:  xpc10 <= 7'sd32/*32:xpc10*/;

                      7'sd59/*59:xpc10*/:  xpc10 <= 7'sd26/*26:xpc10*/;

                      7'sd61/*61:xpc10*/:  xpc10 <= 7'sd23/*23:xpc10*/;

                      7'sd63/*63:xpc10*/:  xpc10 <= 7'sd20/*20:xpc10*/;

                      7'sd65/*65:xpc10*/:  xpc10 <= 7'sd17/*17:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      7'sd15/*15:xpc10*/:  begin 
                           xpc10 <= 7'sd16/*16:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h0;
                           end 
                          
                      7'sd16/*16:xpc10*/:  xpc10 <= 7'sd65/*65:xpc10*/;

                      7'sd18/*18:xpc10*/:  begin 
                           xpc10 <= 7'sd19/*19:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h1;
                           end 
                          
                      7'sd19/*19:xpc10*/:  xpc10 <= 7'sd63/*63:xpc10*/;

                      7'sd21/*21:xpc10*/:  begin 
                           xpc10 <= 7'sd22/*22:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h2;
                           end 
                          
                      7'sd22/*22:xpc10*/:  xpc10 <= 7'sd61/*61:xpc10*/;

                      7'sd24/*24:xpc10*/:  begin 
                           xpc10 <= 7'sd25/*25:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h3;
                           end 
                          
                      7'sd25/*25:xpc10*/:  xpc10 <= 7'sd59/*59:xpc10*/;

                      7'sd30/*30:xpc10*/:  begin 
                           xpc10 <= 7'sd31/*31:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h0;
                           PearsonHash_KL_Test_T402_Main_T402_Main_V_1 <= 32'sd0;
                           end 
                          
                      7'sd31/*31:xpc10*/:  xpc10 <= 7'sd56/*56:xpc10*/;

                      7'sd55/*55:xpc10*/:  begin 
                           xpc10 <= 7'sd31/*31:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= rtl_unsigned_bitextract0(PearsonHash_KL_Test_T402_Main_T402_Main_V_1);
                           end 
                          
                      7'sd60/*60:xpc10*/:  begin 
                           xpc10 <= 7'sd25/*25:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h3;
                           end 
                          
                      7'sd62/*62:xpc10*/:  begin 
                           xpc10 <= 7'sd22/*22:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h2;
                           end 
                          
                      7'sd64/*64:xpc10*/:  begin 
                           xpc10 <= 7'sd19/*19:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h1;
                           end 
                          
                      7'sd66/*66:xpc10*/:  begin 
                           xpc10 <= 7'sd16/*16:xpc10*/;
                           PH_encipher_enable <= 1'h1;
                           PH_data_in <= 8'h0;
                           end 
                          endcase
              if (PH_block_ready) 
                  case (xpc10)
                      7'sd35/*35:xpc10*/:  xpc10 <= 7'sd36/*36:xpc10*/;

                      7'sd37/*37:xpc10*/:  xpc10 <= 7'sd52/*52:xpc10*/;

                      7'sd38/*38:xpc10*/:  xpc10 <= 7'sd39/*39:xpc10*/;

                      7'sd40/*40:xpc10*/:  xpc10 <= 7'sd50/*50:xpc10*/;

                      7'sd41/*41:xpc10*/:  xpc10 <= 7'sd42/*42:xpc10*/;

                      7'sd43/*43:xpc10*/:  xpc10 <= 7'sd48/*48:xpc10*/;

                      7'sd44/*44:xpc10*/:  xpc10 <= 7'sd45/*45:xpc10*/;

                      7'sd47/*47:xpc10*/:  xpc10 <= 7'sd45/*45:xpc10*/;

                      7'sd49/*49:xpc10*/:  xpc10 <= 7'sd42/*42:xpc10*/;

                      7'sd51/*51:xpc10*/:  xpc10 <= 7'sd39/*39:xpc10*/;

                      7'sd53/*53:xpc10*/:  xpc10 <= 7'sd36/*36:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      7'sd35/*35:xpc10*/:  xpc10 <= 7'sd53/*53:xpc10*/;

                      7'sd37/*37:xpc10*/:  begin 
                           xpc10 <= 7'sd38/*38:xpc10*/;
                           PH_block_enable <= 1'h1;
                           PH_block_in <= 64'ha;
                           end 
                          
                      7'sd38/*38:xpc10*/:  xpc10 <= 7'sd51/*51:xpc10*/;

                      7'sd40/*40:xpc10*/:  begin 
                           xpc10 <= 7'sd41/*41:xpc10*/;
                           PH_block_enable <= 1'h1;
                           PH_block_in <= 64'hd_c07a;
                           end 
                          
                      7'sd41/*41:xpc10*/:  xpc10 <= 7'sd49/*49:xpc10*/;

                      7'sd43/*43:xpc10*/:  begin 
                           xpc10 <= 7'sd44/*44:xpc10*/;
                           PH_block_enable <= 1'h1;
                           PH_block_in <= 64'ha;
                           end 
                          
                      7'sd44/*44:xpc10*/:  xpc10 <= 7'sd47/*47:xpc10*/;

                      7'sd48/*48:xpc10*/:  begin 
                           xpc10 <= 7'sd44/*44:xpc10*/;
                           PH_block_enable <= 1'h1;
                           PH_block_in <= 64'ha;
                           end 
                          
                      7'sd50/*50:xpc10*/:  begin 
                           xpc10 <= 7'sd41/*41:xpc10*/;
                           PH_block_enable <= 1'h1;
                           PH_block_in <= 64'hd_c07a;
                           end 
                          
                      7'sd52/*52:xpc10*/:  begin 
                           xpc10 <= 7'sd38/*38:xpc10*/;
                           PH_block_enable <= 1'h1;
                           PH_block_in <= 64'ha;
                           end 
                          
                      7'sd54/*54:xpc10*/:  begin 
                           xpc10 <= 7'sd35/*35:xpc10*/;
                           PH_block_enable <= 1'h1;
                           PH_block_in <= 64'hd_c07a;
                           end 
                          endcase
              if (PH_write_ready) 
                  case (xpc10)
                      7'sd5/*5:xpc10*/:  begin 
                           xpc10 <= 7'sd71/*71:xpc10*/;
                           PearsonHash_KL_Test_T402_Main_T402_Main_V_0 <= 32'sd0;
                           end 
                          
                      7'sd6/*6:xpc10*/:  xpc10 <= 7'sd7/*7:xpc10*/;

                      7'sd10/*10:xpc10*/:  xpc10 <= 7'sd11/*11:xpc10*/;

                      7'sd12/*12:xpc10*/:  xpc10 <= 7'sd68/*68:xpc10*/;

                      7'sd13/*13:xpc10*/:  xpc10 <= 7'sd14/*14:xpc10*/;

                      7'sd67/*67:xpc10*/:  xpc10 <= 7'sd14/*14:xpc10*/;

                      7'sd69/*69:xpc10*/:  xpc10 <= 7'sd11/*11:xpc10*/;

                      7'sd72/*72:xpc10*/:  xpc10 <= 7'sd7/*7:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      7'sd5/*5:xpc10*/:  begin 
                           xpc10 <= 7'sd6/*6:xpc10*/;
                           PH_write_enable <= 1'h1;
                           PH_key_byte_in <= 8'hff;
                           PH_idx_in <= 8'h0;
                           PearsonHash_KL_Test_T402_Main_T402_Main_V_0 <= 32'sd0;
                           end 
                          
                      7'sd6/*6:xpc10*/:  xpc10 <= 7'sd72/*72:xpc10*/;

                      7'sd10/*10:xpc10*/:  xpc10 <= 7'sd69/*69:xpc10*/;

                      7'sd12/*12:xpc10*/:  begin 
                           xpc10 <= 7'sd13/*13:xpc10*/;
                           PH_write_enable <= 1'h1;
                           PH_key_byte_in <= 8'ha;
                           PH_idx_in <= 8'h14;
                           end 
                          
                      7'sd13/*13:xpc10*/:  xpc10 <= 7'sd67/*67:xpc10*/;

                      7'sd68/*68:xpc10*/:  begin 
                           xpc10 <= 7'sd13/*13:xpc10*/;
                           PH_write_enable <= 1'h1;
                           PH_key_byte_in <= 8'ha;
                           PH_idx_in <= 8'h14;
                           end 
                          
                      7'sd70/*70:xpc10*/:  begin 
                           xpc10 <= 7'sd10/*10:xpc10*/;
                           PH_write_enable <= 1'h1;
                           PH_key_byte_in <= 8'h14;
                           PH_idx_in <= 8'ha;
                           end 
                          
                      7'sd71/*71:xpc10*/:  begin 
                           xpc10 <= 7'sd6/*6:xpc10*/;
                           PH_write_enable <= 1'h1;
                           PH_key_byte_in <= rtl_unsigned_bitextract0(rtl_unsigned_extend1(8'd255)+(0-PearsonHash_KL_Test_T402_Main_T402_Main_V_0
                          ));

                           PH_idx_in <= rtl_unsigned_bitextract0(PearsonHash_KL_Test_T402_Main_T402_Main_V_0);
                           end 
                          endcase
              if (PH_init_hash_ready) 
                  case (xpc10)
                      7'sd1/*1:xpc10*/:  xpc10 <= 7'sd74/*74:xpc10*/;

                      7'sd2/*2:xpc10*/:  xpc10 <= 7'sd3/*3:xpc10*/;

                      7'sd27/*27:xpc10*/:  xpc10 <= 7'sd58/*58:xpc10*/;

                      7'sd28/*28:xpc10*/:  xpc10 <= 7'sd29/*29:xpc10*/;

                      7'sd57/*57:xpc10*/:  xpc10 <= 7'sd29/*29:xpc10*/;

                      7'sd73/*73:xpc10*/:  xpc10 <= 7'sd3/*3:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      7'sd1/*1:xpc10*/:  begin 
                           xpc10 <= 7'sd2/*2:xpc10*/;
                           PH_init_hash_enable <= 1'h1;
                           PH_data_in <= 8'ha;
                           end 
                          
                      7'sd2/*2:xpc10*/:  xpc10 <= 7'sd73/*73:xpc10*/;

                      7'sd27/*27:xpc10*/:  begin 
                           xpc10 <= 7'sd28/*28:xpc10*/;
                           PH_init_hash_enable <= 1'h1;
                           PH_data_in <= 8'h8;
                           end 
                          
                      7'sd28/*28:xpc10*/:  xpc10 <= 7'sd57/*57:xpc10*/;

                      7'sd58/*58:xpc10*/:  begin 
                           xpc10 <= 7'sd28/*28:xpc10*/;
                           PH_init_hash_enable <= 1'h1;
                           PH_data_in <= 8'h8;
                           end 
                          
                      7'sd74/*74:xpc10*/:  begin 
                           xpc10 <= 7'sd2/*2:xpc10*/;
                           PH_init_hash_enable <= 1'h1;
                           PH_data_in <= 8'ha;
                           end 
                          endcase

              case (xpc10)
                  7'sd0/*0:xpc10*/:  begin 
                       xpc10 <= 7'sd1/*1:xpc10*/;
                       KiwiSystem_Kiwi_tnow <= 64'h0;
                       KiwiSystem_Kiwi_old_pausemode_value <= 32'h2;
                       System_BitConverter_IsLittleEndian <= 1'h1;
                       end 
                      
                  7'sd3/*3:xpc10*/:  begin 
                       xpc10 <= 7'sd4/*4:xpc10*/;
                       PH_init_hash_enable <= 1'h0;
                       end 
                      
                  7'sd4/*4:xpc10*/:  xpc10 <= 7'sd5/*5:xpc10*/;

                  7'sd7/*7:xpc10*/:  begin 
                       xpc10 <= 7'sd8/*8:xpc10*/;
                       PH_write_enable <= 1'h0;
                       end 
                      
                  7'sd8/*8:xpc10*/:  xpc10 <= 7'sd9/*9:xpc10*/;

                  7'sd9/*9:xpc10*/:  begin 
                      if (!PH_write_ready && (PearsonHash_KL_Test_T402_Main_T402_Main_V_0>=32'sd255))  begin 
                               xpc10 <= 7'sd10/*10:xpc10*/;
                               PH_write_enable <= 1'h1;
                               PH_key_byte_in <= 8'h14;
                               PH_idx_in <= 8'ha;
                               PearsonHash_KL_Test_T402_Main_T402_Main_V_0 <= 32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_0;
                               end 
                              if (!PH_write_ready && (PearsonHash_KL_Test_T402_Main_T402_Main_V_0<32'sd255))  begin 
                               xpc10 <= 7'sd6/*6:xpc10*/;
                               PH_write_enable <= 1'h1;
                               PH_key_byte_in <= rtl_unsigned_bitextract0(rtl_unsigned_extend1(8'd254)+(0-PearsonHash_KL_Test_T402_Main_T402_Main_V_0
                              ));

                               PH_idx_in <= rtl_unsigned_bitextract0(32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_0);
                               PearsonHash_KL_Test_T402_Main_T402_Main_V_0 <= 32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_0;
                               end 
                              if (PH_write_ready && (PearsonHash_KL_Test_T402_Main_T402_Main_V_0>=32'sd255))  begin 
                               xpc10 <= 7'sd70/*70:xpc10*/;
                               PearsonHash_KL_Test_T402_Main_T402_Main_V_0 <= 32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_0;
                               end 
                              if (PH_write_ready && (PearsonHash_KL_Test_T402_Main_T402_Main_V_0<32'sd255))  begin 
                               xpc10 <= 7'sd71/*71:xpc10*/;
                               PearsonHash_KL_Test_T402_Main_T402_Main_V_0 <= 32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_0;
                               end 
                               end 
                      
                  7'sd11/*11:xpc10*/:  begin 
                       xpc10 <= 7'sd12/*12:xpc10*/;
                       PH_write_enable <= 1'h0;
                       end 
                      
                  7'sd14/*14:xpc10*/:  begin 
                       xpc10 <= 7'sd15/*15:xpc10*/;
                       PH_write_enable <= 1'h0;
                       end 
                      
                  7'sd17/*17:xpc10*/:  begin 
                       xpc10 <= 7'sd18/*18:xpc10*/;
                       T402_PearsonHash_StreamHash_3_7_V_0 <= rtl_unsigned_bitextract2(PH_cipher_out);
                       PH_encipher_enable <= 1'h0;
                       end 
                      
                  7'sd20/*20:xpc10*/:  begin 
                       xpc10 <= 7'sd21/*21:xpc10*/;
                       T402_PearsonHash_StreamHash_3_10_V_0 <= rtl_unsigned_bitextract2(PH_cipher_out);
                       PH_encipher_enable <= 1'h0;
                       end 
                      
                  7'sd23/*23:xpc10*/:  begin 
                       xpc10 <= 7'sd24/*24:xpc10*/;
                       T402_PearsonHash_StreamHash_3_13_V_0 <= rtl_unsigned_bitextract2(PH_cipher_out);
                       PH_encipher_enable <= 1'h0;
                       end 
                      
                  7'sd26/*26:xpc10*/:  begin 
                       xpc10 <= 7'sd27/*27:xpc10*/;
                       T402_PearsonHash_StreamHash_3_16_V_0 <= rtl_unsigned_bitextract2(PH_cipher_out);
                       PH_encipher_enable <= 1'h0;
                       end 
                      
                  7'sd29/*29:xpc10*/:  begin 
                       xpc10 <= 7'sd30/*30:xpc10*/;
                       PH_init_hash_enable <= 1'h0;
                       end 
                      
                  7'sd32/*32:xpc10*/:  begin 
                       xpc10 <= 7'sd33/*33:xpc10*/;
                       T402_PearsonHash_StreamHash_4_3_V_0 <= rtl_unsigned_bitextract2(PH_cipher_out);
                       PH_encipher_enable <= 1'h0;
                       end 
                      
                  7'sd33/*33:xpc10*/:  xpc10 <= 7'sd34/*34:xpc10*/;

                  7'sd34/*34:xpc10*/:  begin 
                      if (!PH_block_ready && (PearsonHash_KL_Test_T402_Main_T402_Main_V_1>=32'sd255))  begin 
                               xpc10 <= 7'sd35/*35:xpc10*/;
                               PH_block_enable <= 1'h1;
                               PH_block_in <= 64'hd_c07a;
                               PearsonHash_KL_Test_T402_Main_T402_Main_V_1 <= 32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_1;
                               end 
                              if (!PH_encipher_ready && (PearsonHash_KL_Test_T402_Main_T402_Main_V_1<32'sd255))  begin 
                               xpc10 <= 7'sd31/*31:xpc10*/;
                               PH_encipher_enable <= 1'h1;
                               PH_data_in <= rtl_unsigned_bitextract0(32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_1);
                               PearsonHash_KL_Test_T402_Main_T402_Main_V_1 <= 32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_1;
                               end 
                              if (PH_block_ready && (PearsonHash_KL_Test_T402_Main_T402_Main_V_1>=32'sd255))  begin 
                               xpc10 <= 7'sd54/*54:xpc10*/;
                               PearsonHash_KL_Test_T402_Main_T402_Main_V_1 <= 32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_1;
                               end 
                              if (PH_encipher_ready && (PearsonHash_KL_Test_T402_Main_T402_Main_V_1<32'sd255))  begin 
                               xpc10 <= 7'sd55/*55:xpc10*/;
                               PearsonHash_KL_Test_T402_Main_T402_Main_V_1 <= 32'sd1+PearsonHash_KL_Test_T402_Main_T402_Main_V_1;
                               end 
                               end 
                      
                  7'sd36/*36:xpc10*/:  begin 
                       xpc10 <= 7'sd37/*37:xpc10*/;
                       T402_PearsonHash_BlockHash_6_2_V_0 <= rtl_unsigned_bitextract2(PH_block_hash);
                       PH_block_enable <= 1'h0;
                       end 
                      
                  7'sd39/*39:xpc10*/:  begin 
                       xpc10 <= 7'sd40/*40:xpc10*/;
                       T402_PearsonHash_BlockHash_6_6_V_0 <= rtl_unsigned_bitextract2(PH_block_hash);
                       PH_block_enable <= 1'h0;
                       end 
                      
                  7'sd42/*42:xpc10*/:  begin 
                       xpc10 <= 7'sd43/*43:xpc10*/;
                       T402_PearsonHash_BlockHash_6_10_V_0 <= rtl_unsigned_bitextract2(PH_block_hash);
                       PH_block_enable <= 1'h0;
                       end 
                      
                  7'sd45/*45:xpc10*/:  begin 
                       xpc10 <= 7'sd46/*46:xpc10*/;
                       T402_PearsonHash_BlockHash_6_14_V_0 <= rtl_unsigned_bitextract2(PH_block_hash);
                       PH_block_enable <= 1'h0;
                       end 
                      endcase
               end 
              //End structure HPR anontop


       end 
      

// 1 vectors of width 7
// 1 vectors of width 32
// 1 vectors of width 64
// 1 vectors of width 1
// 9 vectors of width 8
// 64 bits in scalar variables
// Total state bits in module = 240 bits.
// 96 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
//HPR L/S (orangepath) auxiliary reports.
//KiwiC compilation report
//Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016
//17/01/2017 21:52:16
//Cmd line args:  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe PearsonHash_KL_Test.dll PearsonHash_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl PearsonHash_KL_Test.v


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
//KiwiC: front end input processing of class or method called PearsonHash_KL_Test
//
//root_compiler: start elaborating class 'PearsonHash_KL_Test'
//
//elaborating class 'PearsonHash_KL_Test'
//
//compiling static method as entry point: style=Root idl=PearsonHash_KL_Test/Main
//
//Performing root elaboration of method Main
//
//KiwiC start_thread (or entry point) id=Main10
//
//root_compiler class done: PearsonHash_KL_Test
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
//   ?>?=srcfile, PearsonHash_KL_Test.dll, PearsonHash_KiwiLift.dll
//
//END OF KIWIC REPORT FILE
//

//----------------------------------------------------------

//Report from verilog_render:::
//1 vectors of width 7
//
//1 vectors of width 32
//
//1 vectors of width 64
//
//1 vectors of width 1
//
//9 vectors of width 8
//
//64 bits in scalar variables
//
//Total state bits in module = 240 bits.
//
//96 continuously assigned (wire/non-state) bits 
//
//Total number of leaf cells = 0
//

//Major Statistics Report:
//Thread .cctor uid=cctor10 has 3 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor12 has 2 CIL instructions in 1 basic blocks
//Thread Main uid=Main10 has 253 CIL instructions in 91 basic blocks
//Thread mpc10 has 75 bevelab control states (pauses)
// eof (HPR L/S Verilog)
