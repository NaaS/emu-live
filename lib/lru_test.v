/*
Testbench for LRU.v
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

`timescale 1ns / 1ps

`define NQ_COMMAND_WIDTH 3

module lru_test;

reg clk = 0;
always #1 clk = !clk;

reg reset;

localparam NQ_DEPTH_IDX_WIDTH = 2;
localparam KEY_WIDTH_IN_OCTETS = 2;
localparam VALUE_WIDTH_IN_BITS = 8;
localparam MAX_BUCKET_SIZE = 1; // We can detect collisions because "full" gets set.

wire HC_lookup_ready;
wire HC_write_ready;
wire HC_match;
wire HC_full;
wire [VALUE_WIDTH_IN_BITS - 1 : 0] HC_value_out;
wire HC_lookup_enable;
wire HC_write_enable;
wire [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] HC_key_in;
wire [VALUE_WIDTH_IN_BITS - 1 : 0] HC_value_in;

wire NQ_ready;
wire NQ_crashed;
wire [NQ_DEPTH_IDX_WIDTH-1:0] NQ_idx_out;
wire [VALUE_WIDTH_IN_BITS-1:0] NQ_data_out;
wire [`NQ_COMMAND_WIDTH:0] NQ_command;
wire NQ_enable;
wire [NQ_DEPTH_IDX_WIDTH-1:0] NQ_idx_in;
wire [VALUE_WIDTH_IN_BITS-1:0] NQ_data_in;

HashCAM
 #(.KEY_WIDTH_IN_OCTETS(KEY_WIDTH_IN_OCTETS),
   .VALUE_WIDTH_IN_BITS(VALUE_WIDTH_IN_BITS),
   .MAX_BUCKET_SIZE(MAX_BUCKET_SIZE))
  hc
  (.reset(reset),
   .lookup_enable(HC_lookup_enable),
   .lookup_ready(HC_lookup_ready),
   .write_enable(HC_write_enable),
   .write_ready(HC_write_ready),
   .match(HC_match),
   .full(HC_full),
   .key_in(HC_key_in),
   .value_in(HC_value_in),
   .value_out(HC_value_out));

NaughtyQ
 #(.IDX_WIDTH(NQ_DEPTH_IDX_WIDTH),
   .DATA_WIDTH(VALUE_WIDTH_IN_BITS))
 nq
  (.clock(clk),
   .reset(reset),
   .command(NQ_command),
   .enable(NQ_enable),
   .ready(NQ_ready),
   .crashed(NQ_crashed),
   .idx_in(NQ_idx_in),
   .data_in(NQ_data_in),
   .idx_out(NQ_idx_out),
   .data_out(NQ_data_out));

LRU lru
   (.NQ_enable(NQ_enable),
    .NQ_ready(NQ_ready),
    .NQ_crashed(NQ_crashed),
    .NQ_command(NQ_command),
    .NQ_idx_out(NQ_idx_out),
    .NQ_data_out(NQ_data_out),
    .NQ_idx_in(NQ_idx_in),
    .NQ_data_in(NQ_data_in),
    .HC_write_enable(HC_write_enable),
    .HC_write_ready(HC_write_ready),
    .HC_lookup_enable(HC_lookup_enable),
    .HC_lookup_ready(HC_lookup_ready),
    .HC_match(HC_match),
    .HC_full(HC_full),
    .HC_key_in(HC_key_in),
    .HC_value_in(HC_value_in),
    .HC_value_out(HC_value_out),
    .clk(clk),
    .reset(reset));


initial begin
  $dumpfile("lru_test.vcd");
  $dumpvars(0, lru_test);

  #16
  reset = 1;
  #4
  reset = 0;
  // FIXME add a "start" signal to KL_Test?
end

endmodule
