

// CBG Orangepath HPR L/S System

// Verilog output file generated at 17/01/2017 21:50:48
// Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016 Unix 14.5.0.0
//  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe NaughtyQ_KL_Test.dll NaughtyQ_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl NaughtyQ_KL_Test.v
`timescale 1ns/1ns


module NaughtyQ_KL_Test(    output reg NQ_enable,
    input NQ_ready,
    input NQ_crashed,
    output reg [3:0] NQ_command,
    input [3:0] NQ_idx_out,
    input [7:0] NQ_data_out,
    output reg [3:0] NQ_idx_in,
    output reg [7:0] NQ_data_in,
    input clk,
    input reset);

function [63:0] rtl_unsigned_extend0;
   input [31:0] arg;
   rtl_unsigned_extend0 = { 32'b0, arg[31:0] };
   endfunction

  reg [63:0] NaughtyQ_idx_out_nv;
  reg [63:0] NaughtyQ_data_out_nv;
  wire [31:0] ktop16;
  reg [63:0] NaughtyQ_KL_Test_T402_Main_T402_Main_V_1;
  reg [63:0] NaughtyQ_KL_Test_T402_Main_T402_Main_V_0;
  wire [31:0] ktop14;
  reg System_BitConverter_IsLittleEndian;
  wire [31:0] ktop12;
  reg [63:0] KiwiSystem_Kiwi_tnow;
  reg [31:0] KiwiSystem_Kiwi_old_pausemode_value;
  wire [31:0] ktop10;
  reg [4:0] xpc10;
  reg xpc12;
 always   @(posedge clk )  begin 
      //Start structure HPR anontop
      if (reset)  begin 
               KiwiSystem_Kiwi_tnow <= 64'd0;
               KiwiSystem_Kiwi_old_pausemode_value <= 32'd0;
               System_BitConverter_IsLittleEndian <= 32'd0;
               NaughtyQ_idx_out_nv <= 64'd0;
               NaughtyQ_KL_Test_T402_Main_T402_Main_V_0 <= 64'd0;
               NaughtyQ_data_out_nv <= 64'd0;
               NaughtyQ_KL_Test_T402_Main_T402_Main_V_1 <= 64'd0;
               NQ_idx_in <= 32'd0;
               xpc10 <= 32'd0;
               NQ_enable <= 32'd0;
               NQ_data_in <= 32'd0;
               NQ_command <= 32'd0;
               xpc12 <= 32'd0;
               end 
               else  begin 
              if ((64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_1>=64'sh14) && (xpc10==5'sd17/*17:xpc10*/)) $finish(32'sd0);
                  if (NQ_ready) 
                  case (xpc10)
                      5'sd1/*1:xpc10*/:  xpc10 <= 5'sd29/*29:xpc10*/;

                      5'sd2/*2:xpc10*/:  xpc10 <= 5'sd3/*3:xpc10*/;

                      5'sd6/*6:xpc10*/:  begin 
                           xpc10 <= 5'sd7/*7:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      5'sd7/*7:xpc10*/:  xpc10 <= 5'sd25/*25:xpc10*/;

                      5'sd8/*8:xpc10*/:  begin 
                           xpc10 <= 5'sd9/*9:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      5'sd9/*9:xpc10*/:  xpc10 <= 5'sd23/*23:xpc10*/;

                      5'sd10/*10:xpc10*/:  begin 
                           xpc10 <= 5'sd11/*11:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      5'sd11/*11:xpc10*/:  xpc10 <= 5'sd21/*21:xpc10*/;

                      5'sd12/*12:xpc10*/:  begin 
                           xpc10 <= 5'sd13/*13:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      5'sd13/*13:xpc10*/:  begin 
                           xpc10 <= 5'sd18/*18:xpc10*/;
                           NaughtyQ_KL_Test_T402_Main_T402_Main_V_1 <= 64'h0;
                           end 
                          
                      5'sd14/*14:xpc10*/:  xpc10 <= 5'sd15/*15:xpc10*/;

                      5'sd19/*19:xpc10*/:  xpc10 <= 5'sd15/*15:xpc10*/;

                      5'sd20/*20:xpc10*/:  begin 
                           xpc10 <= 5'sd13/*13:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      5'sd22/*22:xpc10*/:  begin 
                           xpc10 <= 5'sd11/*11:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      5'sd24/*24:xpc10*/:  begin 
                           xpc10 <= 5'sd9/*9:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      5'sd26/*26:xpc10*/:  begin 
                           xpc10 <= 5'sd7/*7:xpc10*/;
                           NQ_enable <= 1'h0;
                           end 
                          
                      5'sd28/*28:xpc10*/:  xpc10 <= 5'sd3/*3:xpc10*/;
                  endcase
                   else 
                  case (xpc10)
                      5'sd1/*1:xpc10*/:  begin 
                           xpc10 <= 5'sd2/*2:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_data_in <= NaughtyQ_KL_Test_T402_Main_T402_Main_V_0;
                           NQ_command <= 8'h1;
                           end 
                          
                      5'sd2/*2:xpc10*/:  xpc10 <= 5'sd28/*28:xpc10*/;

                      5'sd6/*6:xpc10*/:  xpc10 <= 5'sd26/*26:xpc10*/;

                      5'sd7/*7:xpc10*/:  begin 
                           xpc10 <= 5'sd8/*8:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= 64'ha;
                           NQ_command <= 8'h2;
                           end 
                          
                      5'sd8/*8:xpc10*/:  xpc10 <= 5'sd24/*24:xpc10*/;

                      5'sd9/*9:xpc10*/:  begin 
                           xpc10 <= 5'sd10/*10:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= 64'h5;
                           NQ_command <= 8'h2;
                           end 
                          
                      5'sd10/*10:xpc10*/:  xpc10 <= 5'sd22/*22:xpc10*/;

                      5'sd11/*11:xpc10*/:  begin 
                           xpc10 <= 5'sd12/*12:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= 64'h5;
                           NQ_command <= 8'h2;
                           end 
                          
                      5'sd12/*12:xpc10*/:  xpc10 <= 5'sd20/*20:xpc10*/;

                      5'sd13/*13:xpc10*/:  begin 
                           xpc10 <= 5'sd14/*14:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= 64'h0;
                           NQ_command <= 8'h3;
                           NaughtyQ_KL_Test_T402_Main_T402_Main_V_1 <= 64'h0;
                           end 
                          
                      5'sd14/*14:xpc10*/:  xpc10 <= 5'sd19/*19:xpc10*/;

                      5'sd18/*18:xpc10*/:  begin 
                           xpc10 <= 5'sd14/*14:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= NaughtyQ_KL_Test_T402_Main_T402_Main_V_1;
                           NQ_command <= 8'h3;
                           end 
                          
                      5'sd21/*21:xpc10*/:  begin 
                           xpc10 <= 5'sd12/*12:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= 64'h5;
                           NQ_command <= 8'h2;
                           end 
                          
                      5'sd23/*23:xpc10*/:  begin 
                           xpc10 <= 5'sd10/*10:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= 64'h5;
                           NQ_command <= 8'h2;
                           end 
                          
                      5'sd25/*25:xpc10*/:  begin 
                           xpc10 <= 5'sd8/*8:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= 64'ha;
                           NQ_command <= 8'h2;
                           end 
                          
                      5'sd27/*27:xpc10*/:  begin 
                           xpc10 <= 5'sd6/*6:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_idx_in <= 64'h5;
                           NQ_command <= 8'h2;
                           end 
                          
                      5'sd29/*29:xpc10*/:  begin 
                           xpc10 <= 5'sd2/*2:xpc10*/;
                           NQ_enable <= 1'h1;
                           NQ_data_in <= NaughtyQ_KL_Test_T402_Main_T402_Main_V_0;
                           NQ_command <= 8'h1;
                           end 
                          endcase

              case (xpc10)
                  5'sd0/*0:xpc10*/:  begin 
                       xpc10 <= 5'sd1/*1:xpc10*/;
                       NaughtyQ_KL_Test_T402_Main_T402_Main_V_0 <= 64'h0;
                       KiwiSystem_Kiwi_tnow <= 64'h0;
                       KiwiSystem_Kiwi_old_pausemode_value <= 32'h2;
                       System_BitConverter_IsLittleEndian <= 1'h1;
                       end 
                      
                  5'sd3/*3:xpc10*/:  begin 
                       xpc10 <= 5'sd4/*4:xpc10*/;
                       NQ_enable <= 1'h0;
                       NaughtyQ_data_out_nv <= rtl_unsigned_extend0(NQ_data_out);
                       NaughtyQ_idx_out_nv <= rtl_unsigned_extend0(NQ_idx_out);
                       end 
                      
                  5'sd5/*5:xpc10*/:  begin 
                      if (!NQ_ready && (64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_0>=64'sh14))  begin 
                               xpc10 <= 5'sd6/*6:xpc10*/;
                               NQ_enable <= 1'h1;
                               NQ_idx_in <= 64'h5;
                               NQ_command <= 8'h2;
                               NaughtyQ_KL_Test_T402_Main_T402_Main_V_0 <= 64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_0;
                               end 
                              if (NQ_ready && (64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_0>=64'sh14))  begin 
                               xpc10 <= 5'sd27/*27:xpc10*/;
                               NaughtyQ_KL_Test_T402_Main_T402_Main_V_0 <= 64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_0;
                               end 
                              if ((64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_0<64'sh14))  begin 
                               xpc10 <= 5'sd1/*1:xpc10*/;
                               NaughtyQ_KL_Test_T402_Main_T402_Main_V_0 <= 64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_0;
                               end 
                               end 
                      
                  5'sd15/*15:xpc10*/:  begin 
                       xpc10 <= 5'sd16/*16:xpc10*/;
                       NQ_enable <= 1'h0;
                       NaughtyQ_data_out_nv <= rtl_unsigned_extend0(NQ_data_out);
                       end 
                      
                  5'sd17/*17:xpc10*/:  begin 
                      if (!NQ_ready && (64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_1<64'sh14))  begin 
                               xpc10 <= 5'sd14/*14:xpc10*/;
                               NQ_enable <= 1'h1;
                               NQ_idx_in <= $unsigned(64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_1);
                               NQ_command <= 8'h3;
                               NaughtyQ_KL_Test_T402_Main_T402_Main_V_1 <= 64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_1;
                               end 
                              if (NQ_ready && (64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_1<64'sh14))  begin 
                               xpc10 <= 5'sd18/*18:xpc10*/;
                               NaughtyQ_KL_Test_T402_Main_T402_Main_V_1 <= 64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_1;
                               end 
                              if ((64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_1>=64'sh14))  NaughtyQ_KL_Test_T402_Main_T402_Main_V_1
                           <= 64'sh1+NaughtyQ_KL_Test_T402_Main_T402_Main_V_1;

                           end 
                      endcase
              if ((xpc12==1'sd0/*0:xpc12*/))  xpc12 <= 1'sd1/*1:xpc12*/;
                  
              case (xpc10)
                  5'sd4/*4:xpc10*/:  xpc10 <= 5'sd5/*5:xpc10*/;

                  5'sd16/*16:xpc10*/:  xpc10 <= 5'sd17/*17:xpc10*/;
              endcase
               end 
              //End structure HPR anontop


       end 
      

// 2 vectors of width 1
// 1 vectors of width 5
// 1 vectors of width 32
// 5 vectors of width 64
// Total state bits in module = 359 bits.
// 128 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
//HPR L/S (orangepath) auxiliary reports.
//KiwiC compilation report
//Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016
//17/01/2017 21:50:45
//Cmd line args:  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe NaughtyQ_KL_Test.dll NaughtyQ_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl NaughtyQ_KL_Test.v


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
//KiwiC: front end input processing of class or method called NaughtyQ_KL_Test
//
//root_compiler: start elaborating class 'NaughtyQ_KL_Test'
//
//elaborating class 'NaughtyQ_KL_Test'
//
//compiling static method as entry point: style=Root idl=NaughtyQ_KL_Test/Main
//
//Performing root elaboration of method Main
//
//KiwiC start_thread (or entry point) id=Main12
//
//root_compiler class done: NaughtyQ_KL_Test
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
//   ?>?=srcfile, NaughtyQ_KL_Test.dll, NaughtyQ_KiwiLift.dll
//
//END OF KIWIC REPORT FILE
//

//----------------------------------------------------------

//Report from verilog_render:::
//2 vectors of width 1
//
//1 vectors of width 5
//
//1 vectors of width 32
//
//5 vectors of width 64
//
//Total state bits in module = 359 bits.
//
//128 continuously assigned (wire/non-state) bits 
//
//Total number of leaf cells = 0
//

//Major Statistics Report:
//Thread .cctor uid=cctor10 has 3 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor12 has 2 CIL instructions in 1 basic blocks
//Thread Main uid=Main12 has 117 CIL instructions in 43 basic blocks
//Thread Main uid=Main10 has 3 CIL instructions in 1 basic blocks
//Thread mpc10 has 30 bevelab control states (pauses)
//Thread mpc12 has 2 bevelab control states (pauses)
// eof (HPR L/S Verilog)
