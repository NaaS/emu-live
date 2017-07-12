/*
Testbench for HashCAM.v
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

`timescale 1ns / 1ps

`define K_DRIVEN 1

module hc_test;

reg clk = 0;
always #1 clk = !clk;

reg reset;

localparam KEY_WIDTH_IN_OCTETS = 2;
localparam VALUE_WIDTH_IN_BITS = 8;
localparam MAX_BUCKET_SIZE = 1; // We can detect collisions because "full" gets set.

wire lookup_ready;
wire write_ready;
wire match;
wire full;
//wire blockhash_enable;
//wire [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] key_to_hash;
wire [VALUE_WIDTH_IN_BITS - 1 : 0] value_out;

`ifdef K_DRIVEN
wire lookup_enable;
wire write_enable;
//wire blockhash_ready;
//wire [7:0] key_hash;
wire [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] key_in;
wire [VALUE_WIDTH_IN_BITS - 1 : 0] value_in;
`elsif V_DRIVEN
reg lookup_enable;
reg write_enable;
//reg blockhash_ready;
//reg [7:0] key_hash;
reg [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] key_in;
reg [VALUE_WIDTH_IN_BITS - 1 : 0] value_in;
`endif

HashCAM
 #(.KEY_WIDTH_IN_OCTETS(KEY_WIDTH_IN_OCTETS),
   .VALUE_WIDTH_IN_BITS(VALUE_WIDTH_IN_BITS),
   .MAX_BUCKET_SIZE(MAX_BUCKET_SIZE))
  hc
  (.reset(reset),
   .lookup_enable(lookup_enable),
   .lookup_ready(lookup_ready),
   .write_enable(write_enable),
   .write_ready(write_ready),
   .match(match),
   .full(full),
//   .blockhash_enable(blockhash_enable),
//   .blockhash_ready(blockhash_ready),
//   .key_hash(key_hash),
//   .key_to_hash(key_to_hash),
   .key_in(key_in),
   .value_in(value_in),
   .value_out(value_out));

`ifdef K_DRIVEN
HashCAM_KL_Test hc_kl_test
   (.clk(clk),
    .reset(reset),
    .HC_match(match),
    .HC_full(full),
    .HC_write_ready(write_ready),
    .HC_write_enable(write_enable),
//    .block_ready(block_ready),
//    .block_hash(block_hash),
//    .block_in(block_in),
//    .block_enable(block_enable),
    .HC_lookup_ready(lookup_ready),
    .HC_lookup_enable(lookup_enable),
    .HC_key_in(key_in),
    .HC_value_in(value_in),
    .HC_value_out(value_out));
`endif

//generate
//genvar idx_bucket;
//for (idx_bucket = 0; idx_bucket < 256; idx_bucket++) begin
//  genvar idx_within_bucket;
//  for (idx_within_bucket = 0; idx_within_bucket < MAX_BUCKET_SIZE; idx_within_bucket++) begin
//    initial $dumpvars(0, hc_test.hc.mejda[idx_bucket][idx_within_bucket]);
//  end
//end
//endgenerate

integer idx;

initial begin
  $dumpfile("hc_test.vcd");
  $dumpvars(0,hc_test);
/*
  for (idx_bucket = 0; idx_bucket < 256; idx_bucket++) begin
    for (idx_within_bucket = 0; idx_within_bucket < MAX_BUCKET_SIZE; idx_within_bucket++) begin
      $dumpvars(0,hc_test.hc.mejda[idx_bucket][idx_within_bucket]);
    end
  end
*/

`ifdef K_DRIVEN
  #16
  reset = 1;
  #4
  reset = 0;
  // FIXME add a "start" signal to KL_Test?

`elsif V_DRIVEN
  #2
     reset = 1;
  #4 reset = 0;

  key_in <= 16'd10;
  lookup_enable <= 1;
  #4 lookup_enable <= 0;

  #2 key_in <= 16'd10;
  lookup_enable <= 1;
  #4 lookup_enable <= 0;

  #2 key_in <= 16'd10;
  value_in <= 8'd7;
  write_enable <= 1;
  #4 write_enable <= 0;

  #2 key_in <= 16'd10;
  lookup_enable <= 1;
  #4 lookup_enable <= 0;

  #2 key_in <= 16'd10;
  value_in <= 8'd7;
  write_enable <= 1;
  #4 write_enable <= 0;

  #2 key_in <= 16'd10;
  lookup_enable <= 1;
  #4 lookup_enable <= 0;



  #2 key_in <= 16'd10;
  value_in <= 8'd8;
  write_enable <= 1;
  #4 write_enable <= 0;

  #2 key_in <= 16'd10;
  lookup_enable <= 1;
  #4 lookup_enable <= 0;

  #2 key_in <= 16'd10;
  value_in <= 8'd7;
  write_enable <= 1;
  #4 write_enable <= 0;



  #2 key_in <= 16'd11;
  lookup_enable <= 1;
  #4 lookup_enable <= 0;

  #2 key_in <= 16'd12;
  value_in <= 8'd9;
  write_enable <= 1;
  #4 write_enable <= 0;

  // Start filling, causing collisions.
  for (idx = 0; idx < 300; idx = idx + 1) begin
    #2 key_in <= idx;
    value_in <= 8'd1;
    write_enable <= 1;
    #4 write_enable <= 0;
  end


  reset = 1;
  #2 reset = 0;


  #20 $finish;
`endif
end

endmodule
