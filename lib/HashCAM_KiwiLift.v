

// CBG Orangepath HPR L/S System

// Verilog output file generated at 17/01/2017 21:52:38
// Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016 Unix 14.5.0.0
//  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe HashCAM_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl HashCAM_KiwiLift.v
`timescale 1ns/1ns


module HashCAM_KiwiLift(    output HC_write_enable,
    input HC_write_ready,
    output HC_lookup_enable,
    input HC_lookup_ready,
    input HC_match,
    input HC_full,
    output [15:0] HC_key_in,
    output [7:0] HC_value_in,
    input [7:0] HC_value_out,
    input clk,
    input reset);
  reg HashCAM_matched;
  reg HashCAM_is_full;
  wire [31:0] ktop16;
  wire [31:0] ktop14;
  reg System_BitConverter_IsLittleEndian;
  wire [31:0] ktop12;
  reg [63:0] KiwiSystem_Kiwi_tnow;
  reg [31:0] KiwiSystem_Kiwi_old_pausemode_value;
  wire [31:0] ktop10;
  reg xpc10;
 always   @(posedge clk )  begin 
      //Start structure HPR anontop
      if (reset)  begin 
               xpc10 <= 32'd0;
               KiwiSystem_Kiwi_tnow <= 64'd0;
               KiwiSystem_Kiwi_old_pausemode_value <= 32'd0;
               System_BitConverter_IsLittleEndian <= 32'd0;
               HashCAM_is_full <= 32'd0;
               HashCAM_matched <= 32'd0;
               end 
               else if ((xpc10==1'sd0/*0:xpc10*/))  begin 
                   xpc10 <= 1'sd1/*1:xpc10*/;
                   KiwiSystem_Kiwi_tnow <= 64'h0;
                   KiwiSystem_Kiwi_old_pausemode_value <= 32'h2;
                   System_BitConverter_IsLittleEndian <= 1'h1;
                   HashCAM_is_full <= 1'h0;
                   HashCAM_matched <= 1'h0;
                   end 
                  //End structure HPR anontop


       end 
      

// 4 vectors of width 1
// 1 vectors of width 32
// 1 vectors of width 64
// Total state bits in module = 100 bits.
// 128 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
//HPR L/S (orangepath) auxiliary reports.
//KiwiC compilation report
//Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 0.2.16q : 25th-November-2016
//17/01/2017 21:52:36
//Cmd line args:  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe HashCAM_KiwiLift.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl HashCAM_KiwiLift.v


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
//   srcfile=HashCAM_KiwiLift.dll
//
//END OF KIWIC REPORT FILE
//

//----------------------------------------------------------

//Report from verilog_render:::
//4 vectors of width 1
//
//1 vectors of width 32
//
//1 vectors of width 64
//
//Total state bits in module = 100 bits.
//
//128 continuously assigned (wire/non-state) bits 
//
//Total number of leaf cells = 0
//

//Major Statistics Report:
//Thread .cctor uid=cctor10 has 3 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor12 has 2 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor14 has 3 CIL instructions in 1 basic blocks
//Thread Main uid=Main10 has 3 CIL instructions in 1 basic blocks
//Thread mpc10 has 2 bevelab control states (pauses)
// eof (HPR L/S Verilog)
