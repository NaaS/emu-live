/*
Testbench for NaughtyQ.v
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

`timescale 1ns / 1ps

`define V_DRIVEN 1

module nq_test;

reg clk = 0;
always #1 clk = !clk;

reg reset;

`define NQ_COMMAND_WIDTH 3
`define NQ_RESET_ZEROES_DATA 1

localparam IDX_WIDTH = 4;
localparam DATA_WIDTH = 8;
wire ready;
wire crashed;
wire [IDX_WIDTH-1:0] idx_out;
wire [DATA_WIDTH-1:0] data_out;

`ifdef K_DRIVEN
wire [`NQ_COMMAND_WIDTH:0] command;
wire enable;
wire [IDX_WIDTH-1:0] idx_in;
wire [DATA_WIDTH-1:0] data_in;
`elsif V_DRIVEN
reg [`NQ_COMMAND_WIDTH:0] command;
reg enable;
reg [IDX_WIDTH-1:0] idx_in;
reg [DATA_WIDTH-1:0] data_in;
`endif

NaughtyQ
 #(.IDX_WIDTH(IDX_WIDTH),
   .DATA_WIDTH(DATA_WIDTH))
 nq
  (.clock(clk),
   .reset(reset),
   .command(command),
   .enable(enable),
   .ready(ready),
   .crashed(crashed),
   .idx_in(idx_in),
   .data_in(data_in),
   .idx_out(idx_out),
   .data_out(data_out));

`ifdef K_DRIVEN
// FIXME not parametric.
NaughtyQ_KL_Test nq_kl_test
   (.NQ_enable(enable),
    .NQ_ready(ready),
    .NQ_command(command),
    .NQ_idx_out(idx_out),
    .NQ_data_out(data_out),
    .NQ_idx_in(idx_in),
    .NQ_data_in(data_in),
    .clk(clk),
    .reset(reset));
`endif

integer idx;

initial begin
  $dumpfile("nq_test.vcd");
  $dumpvars(0,nq_test);

  for (idx = 0; idx <= nq.MAX_DEPTH_IDX; idx = idx + 1) begin
    $dumpvars(0,nq_test.nq.memory[idx]);
  end

`ifdef K_DRIVEN
  reset = 1;
  #4
  reset = 0;
  // FIXME add a "start" signal to KL_Test?
`elsif V_DRIVEN
  #2 reset = 1;
  #4 reset = 0;

  #2 command <= nq.ENLIST_COMMAND;
     data_in <= 8'd2;
     enable <= 1;
  #2 enable <= 0;

  #4 command <= nq.ENLIST_COMMAND;
     data_in <= 8'd3;
     enable <= 1;
  #2 enable <= 0;

  // We should observe the wrap-around now.
  for (idx = 0; idx <= nq.MAX_DEPTH_IDX; idx = idx + 1) begin
    #4 command <= nq.ENLIST_COMMAND;
       data_in <= idx;
       enable <= 1;
    #2 enable <= 0;
  end

  reset = 1;
  #4 reset = 0;

  command <= nq.READDATA_COMMAND;
  enable <= 1;
  #2 enable <= 0;
  // We should see the module signal a crash.

  reset = 1;
  #4 reset = 0;

  // We should observe the wrap-around again.
  for (idx = 0; idx <= 4/*FIXME const*/ + nq.MAX_DEPTH_IDX; idx = idx + 1) begin
    #4 command <= nq.ENLIST_COMMAND;
       data_in <= idx;
       enable <= 1;
    #2 enable <= 0;
  end

  #4 command <= nq.BACKOFQUEU_COMMAND;
     idx_in <= 4;
     enable <= 1;
  #2 enable <= 0;

  #4 command <= nq.BACKOFQUEU_COMMAND;
     idx_in <= 12;
     enable <= 1;
  #2 enable <= 0;

  #4 command <= nq.BACKOFQUEU_COMMAND;
     idx_in <= 4;
     enable <= 1;
  #2 enable <= 0;

  // Expect idempotence.
  #4 command <= nq.BACKOFQUEU_COMMAND;
     idx_in <= 4;
     enable <= 1;
  #2 enable <= 0;

  // Scan the queue's contents.
  for (idx = 0; idx <= nq.MAX_DEPTH_IDX; idx = idx + 1) begin
    #4 command <= nq.READDATA_COMMAND;
       idx_in <= idx;
       enable <= 1;
    #2 enable <= 0;
  end

  #20 $finish;
`endif
end

endmodule
