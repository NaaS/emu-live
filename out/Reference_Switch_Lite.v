

// CBG Orangepath HPR L/S System

// Verilog output file generated at 17/07/2016 21:43:58
// Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 2.15h : 27th-June-2016 Unix 14.5.0.0
//  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe out/Reference_Switch_Lite.dll out/Emu.dll out/Transceiver.dll out/NetFPGA.dll out/Protocols.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl out/Reference_Switch_Lite.v
`timescale 1ns/1ns


module out_Reference_Switch_Lite(output reg s_axis_tready, input clk, input reset);
  wire [31:0] Reference_Switch_Lite_LUT_SIZE;
  reg [63:0] Reference_Switch_Lite_LUT;
  reg [63:0] Reference_Switch_Lite_DEFAULT_oqs;
  reg [31:0] RTEnCZ_0_2_blockrefxxnewobj12;
  reg [31:0] RTET4EntryPoint_V_0;
  wire [31:0] ktop18;
  reg [63:0] fastspilldup10;
  reg [63:0] CS0_3_refxxarray20;
  wire [31:0] ktop16;
  reg [63:0] CS0_24_refxxarray18;
  reg [63:0] CS0_19_refxxarray16;
  reg CS0_14_refxxarray14;
  reg [7:0] CS0_9_refxxarray12;
  reg [63:0] CS0_4_refxxarray10;
  reg [31:0] ET_cCZ_0_1_blockrefxxnewobj10;
  reg [31:0] EmTransceiver_dataplane;
  wire [31:0] ktop14;
  reg SyBitConverter_IsLittleEndian;
  wire [31:0] ktop12;
  reg [63:0] KiKiwi_tnow;
  reg [31:0] KiKiwi_old_pausemode_value;
  wire [31:0] ktop10;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARP0_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARO1_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARN2_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARM3_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARL4_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARK5_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARJ6_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARI7_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARH8_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARG9_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARF10_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARE11_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARD12_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARC13_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARB14_0;
  reg [63:0] A_64_US_CC_SCALbx10_SCALARA15_0;
  reg [31:0] A_A_64_US_CC_SCALbx16_tuser_low;
  reg [31:0] A_A_64_US_CC_SCALbx16_tuser_hi;
  reg [31:0] A_A_64_US_CC_SCALbx16_tdata;
  reg [31:0] A_A_8_US_CC_SCALbx16_tkeep;
  reg [31:0] A_sA_BOOL_CC_SCALbx16_tlast;
  reg xpc10;
 always   @(posedge clk )  begin 
      //Start structure HPR out/Protocols.dll
      if (reset)  begin 
               xpc10 <= 1'd0;
               RTET4EntryPoint_V_0 <= 32'd0;
               RTEnCZ_0_2_blockrefxxnewobj12 <= 32'd0;
               KiKiwi_tnow <= 64'd0;
               KiKiwi_old_pausemode_value <= 32'd0;
               SyBitConverter_IsLittleEndian <= 1'd0;
               s_axis_tready <= 1'd0;
               EmTransceiver_dataplane <= 32'd0;
               A_A_64_US_CC_SCALbx16_tuser_low <= 32'd0;
               CS0_24_refxxarray18 <= 64'd0;
               A_A_64_US_CC_SCALbx16_tuser_hi <= 32'd0;
               CS0_19_refxxarray16 <= 64'd0;
               A_sA_BOOL_CC_SCALbx16_tlast <= 32'd0;
               CS0_14_refxxarray14 <= 1'd0;
               A_A_8_US_CC_SCALbx16_tkeep <= 32'd0;
               CS0_9_refxxarray12 <= 8'd0;
               A_A_64_US_CC_SCALbx16_tdata <= 32'd0;
               CS0_4_refxxarray10 <= 64'd0;
               ET_cCZ_0_1_blockrefxxnewobj10 <= 32'd0;
               Reference_Switch_Lite_DEFAULT_oqs <= 64'd0;
               Reference_Switch_Lite_LUT <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARP0_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARO1_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARN2_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARM3_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARL4_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARK5_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARJ6_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARI7_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARH8_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARG9_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARF10_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARE11_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARD12_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARC13_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARB14_0 <= 64'd0;
               A_64_US_CC_SCALbx10_SCALARA15_0 <= 64'd0;
               fastspilldup10 <= 64'd0;
               CS0_3_refxxarray20 <= 64'd0;
               end 
               else if ((xpc10==0/*US*/))  begin 
                   xpc10 <= 1'd1/*xpc10:1*/;
                   RTET4EntryPoint_V_0 <= 32'd0;
                   RTEnCZ_0_2_blockrefxxnewobj12 <= 32'd0;
                   KiKiwi_tnow <= 64'h0;
                   KiKiwi_old_pausemode_value <= 32'h2;
                   SyBitConverter_IsLittleEndian <= 1'h1;
                   s_axis_tready <= 1'h1;
                   EmTransceiver_dataplane <= 32'd0;
                   A_A_64_US_CC_SCALbx16_tuser_low <= 64'd0;
                   CS0_24_refxxarray18 <= 64'd0;
                   A_A_64_US_CC_SCALbx16_tuser_hi <= 64'd0;
                   CS0_19_refxxarray16 <= 64'd0;
                   A_sA_BOOL_CC_SCALbx16_tlast <= 1'd0;
                   CS0_14_refxxarray14 <= 1'd0;
                   A_A_8_US_CC_SCALbx16_tkeep <= 8'd0;
                   CS0_9_refxxarray12 <= 8'd0;
                   A_A_64_US_CC_SCALbx16_tdata <= 64'd0;
                   CS0_4_refxxarray10 <= 64'd0;
                   ET_cCZ_0_1_blockrefxxnewobj10 <= 32'd0;
                   Reference_Switch_Lite_DEFAULT_oqs <= 64'h55_0000;
                   Reference_Switch_Lite_LUT <= 64'd0;
                   A_64_US_CC_SCALbx10_SCALARP0_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARO1_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARN2_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARM3_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARL4_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARK5_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARJ6_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARI7_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARH8_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARG9_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARF10_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARE11_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARD12_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARC13_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARB14_0 <= 64'h1;
                   A_64_US_CC_SCALbx10_SCALARA15_0 <= 64'h1;
                   fastspilldup10 <= 64'd0;
                   CS0_3_refxxarray20 <= 64'd0;
                   end 
                  //End structure HPR out/Protocols.dll


       end 
      

// 3 vectors of width 1
// 10 vectors of width 32
// 24 vectors of width 64
// 1 vectors of width 8
// Total state bits in module = 1867 bits.
// 192 continuously assigned (wire/non-state) bits 
// Total number of leaf cells = 0
endmodule

//  
// LCP delay estimations included: turn off with -vnl-lcp-delay-estimate=disable
//HPR L/S (orangepath) auxiliary reports.
//KiwiC compilation report
//Kiwi Scientific Acceleration (KiwiC .net/CIL/C# to Verilog/SystemC compiler): Version alpha 2.15h : 27th-June-2016
//17/07/2016 21:43:56
//Cmd line args:  /Users/nik/xoghol/CL/NaaS/NaaS_github/emu/bitbucket-hprls2/kiwipro/kiwic/distro/lib/kiwic.exe out/Reference_Switch_Lite.dll out/Emu.dll out/Transceiver.dll out/NetFPGA.dll out/Protocols.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl out/Reference_Switch_Lite.v


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
//KiwiC: front end input processing of class or method called Emu/Transceiver
//
//root_walk start thread at a static method (used as an entry point). Method name=.cctor uid=cctor14
//
//KiwiC start_thread (or entry point) id=cctor14
//
//Root method elaborated: specificf=S_kickoff_collate leftover=1+2
//
//KiwiC: front end input processing of class or method called Reference_Switch_Lite
//
//root_walk start thread at a static method (used as an entry point). Method name=.cctor uid=cctor16
//
//KiwiC start_thread (or entry point) id=cctor16
//
//Root method elaborated: specificf=S_kickoff_collate leftover=1+3
//
//KiwiC: front end input processing of class or method called Reference_Switch_Lite
//
//root_compiler: start elaborating class 'Reference_Switch_Lite'
//
//elaborating class 'Reference_Switch_Lite'
//
//compiling static method as entry point: style=Root idl=Reference_Switch_Lite/EntryPoint
//
//Performing root elaboration of method EntryPoint
//
//KiwiC start_thread (or entry point) id=EntryPoint10
//
//root_compiler class done: Reference_Switch_Lite
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
//   gtrace-loglevel=20
//
//   intcil-loglevel=20
//
//   firstpass-loglevel=20
//
//   root=$attributeroot
//
//   ?>?=srcfile, out/Reference_Switch_Lite.dll, out/Emu.dll, out/Transceiver.dll, out/NetFPGA.dll, out/Protocols.dll
//
//END OF KIWIC REPORT FILE
//

//----------------------------------------------------------

//Report from enumbers:::
//Concise expression alias report.
//
//  -- No expression aliases to report
//

//----------------------------------------------------------

//Report from verilog_render:::
//3 vectors of width 1
//
//10 vectors of width 32
//
//24 vectors of width 64
//
//1 vectors of width 8
//
//Total state bits in module = 1867 bits.
//
//192 continuously assigned (wire/non-state) bits 
//
//Total number of leaf cells = 0
//

//Major Statistics Report:
//Thread .cctor uid=cctor10 has 3 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor12 has 2 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor14 has 14 CIL instructions in 1 basic blocks
//Thread .cctor uid=cctor16 has 6 CIL instructions in 1 basic blocks
//Thread EntryPoint uid=EntryPoint10 has 6 CIL instructions in 2 basic blocks
//Thread mpc10 has 2 bevelab control states (pauses)
// eof (HPR L/S Verilog)
