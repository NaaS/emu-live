//-
// Copyright (c) 2015 Noa Zilberman
// All rights reserved.
//
// This software was developed by Stanford University and the University of Cambridge Computer Laboratory 
// under National Science Foundation under Grant No. CNS-0855268,
// the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
// by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
// as part of the DARPA MRC research programme.
//
//  Use of this source code is governed by the Apache 2.0 license; see LICENSE file
//

`timescale 1ns / 1ps

 module top_tb_bd ();

 
 localparam HALF_CORE_PERIOD = 2.5;
  
  reg  reset; 

  reg  fpga_sysclk;
  wire fpga_sysclk_p, fpga_sysclk_n;
 
 
 reference_emu_wrapper top_sim_bd_wrapper
 ( .fpga_sysclk_n 		(fpga_sysclk_p),
   .fpga_sysclk_p		(fpga_sysclk_n),
   .reset			(reset)
 );
 
 
 // rst - ACTIVE_HIGH 
 initial begin 
    reset = 1'b1;
    #(HALF_CORE_PERIOD * 2*200);
    reset = 1'b0;
    $display("Reset Deasserted");
 end

 //clk - 200MHz fpga_clk
   
 initial begin
   fpga_sysclk = 1'b0;
   #(HALF_CORE_PERIOD);
   forever
      #(HALF_CORE_PERIOD) fpga_sysclk = ~fpga_sysclk;
end 

assign fpga_sysclk_p = fpga_sysclk;
assign fpga_sysclk_n = ~fpga_sysclk; 

endmodule
