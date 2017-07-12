/*
Testbench for PearsonHash.v
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*/

`timescale 1ns / 1ps

`define K_DRIVEN 1

module ph_test;

reg clk = 0;
always #1 clk = !clk;

reg reset;

localparam BLOCK_SIZE_IN_OCTETS = 8;

wire write_ready;
wire encipher_ready;
wire init_hash_ready;
wire block_ready;
wire [7:0] cipher_out;
wire [7:0] block_hash;

`ifdef K_DRIVEN
wire write_enable;
wire encipher_enable;
wire init_hash_enable;
wire block_enable;
wire [7:0] idx_in;
wire [7:0] key_byte_in;
wire [7:0] data_in;
wire [(BLOCK_SIZE_IN_OCTETS * 8) - 1:0] block_in;
`elsif V_DRIVEN
reg write_enable = 0;
reg encipher_enable = 0;
reg init_hash_enable = 0;
reg block_enable = 0;
reg [7:0] idx_in;
reg [7:0] key_byte_in;
reg [7:0] data_in;
reg [(BLOCK_SIZE_IN_OCTETS * 8) - 1:0] block_in;
`endif

PearsonHash
 #(.BLOCK_SIZE_IN_OCTETS(BLOCK_SIZE_IN_OCTETS))
  ph
  (.reset(reset),
   .write_enable(write_enable),
   .encipher_enable(encipher_enable),
   .write_ready(write_ready),
   .encipher_ready(encipher_ready),
   .init_hash_enable(init_hash_enable),
   .init_hash_ready(init_hash_ready),
   .idx_in(idx_in),
   .key_byte_in(key_byte_in),
   .data_in(data_in),
   .cipher_out(cipher_out),
   .block_ready(block_ready),
   .block_hash(block_hash),
   .block_in(block_in),
   .block_enable(block_enable));

`ifdef K_DRIVEN
PearsonHash_KL_Test ph_kl_test
   (.PH_cipher_out(cipher_out),
    .PH_encipher_ready(encipher_ready),
    .PH_encipher_enable(encipher_enable),
    .PH_data_in(data_in),
    .PH_write_ready(write_ready),
    .PH_write_enable(write_enable),
    .PH_init_hash_enable(init_hash_enable),
    .PH_init_hash_ready(init_hash_ready),
    .PH_key_byte_in(key_byte_in),
    .PH_idx_in(idx_in),
    .clk(clk),
    .reset(reset),
    .PH_block_ready(block_ready),
    .PH_block_hash(block_hash),
    .PH_block_in(block_in),
    .PH_block_enable(block_enable));
`endif

integer idx;

initial begin
  $dumpfile("ph_test.vcd");
  $dumpvars(0,ph_test);

  for (idx = 0; idx < 256; idx = idx + 1) begin
    $dumpvars(0,ph_test.ph.mejda[idx]);
  end

`ifdef K_DRIVEN
  #16
  reset = 1;
  #4
  reset = 0;
  // FIXME add a "start" signal to KL_Test?

`elsif V_DRIVEN
  #2
     data_in = 8'd10;
     reset = 1;
  #4 reset = 0;

  for (idx = 0; idx < 256; idx = idx + 1) begin
    #1 idx_in <= idx;
       key_byte_in <= 255 - idx;
       write_enable <= 1;
    #1 write_enable <= 0;
  end

    #1 data_in <= 8'd0;
       init_hash_enable <= 1;
    #1 init_hash_enable <= 0;

  for (idx = 0; idx < 256; idx = idx + 1) begin
    #1 data_in <= idx;
       encipher_enable <= 1;
    #1 encipher_enable <= 0;
  end

  for (idx = 0; idx < 256; idx = idx + 1) begin
    #1 data_in <= idx;
       encipher_enable <= 1;
    #1 encipher_enable <= 0;
  end

   #1 block_in <= 64'd901242;
      block_enable <= 1;
   #1 block_enable <= 0;

   #1 block_in <= 64'd10;
      block_enable <= 1;
   #1 block_enable <= 0;

   // Should see the same output as when we calculated this earlier.
   #1 block_in <= 64'd901242;
      block_enable <= 1;
   #1 block_enable <= 0;

   // As before.
   #1 block_in <= 64'd10;
      block_enable <= 1;
   #1 block_enable <= 0;
  #20 $finish;
`endif
end

endmodule
