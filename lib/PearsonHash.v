/*
Pearson hashing.
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

Can operate in byte-stream mode and (parameter-sized) block mode, simultaneously.
Can have its table and stream seed updated at any time.
*/

module PearsonHash
 #(parameter BLOCK_SIZE_IN_OCTETS = 8)
  (// control.
   input wire reset,
   input wire write_enable,
   input wire encipher_enable,
   input wire init_hash_enable,
   input wire block_enable,
   output reg block_ready,
   output reg init_hash_ready,
   output reg write_ready,
   output reg encipher_ready,
   // data.
   input wire [(BLOCK_SIZE_IN_OCTETS*8)-1:0] block_in,
   output reg [7:0] block_hash,
   input wire [7:0] idx_in,
   input wire [7:0] key_byte_in,
   input wire [7:0] data_in,
   output reg [7:0] cipher_out);

// The table we use to calculate the hash.
reg [7:0] mejda [255:0];

reg [7:0] buffer;
integer block_byte_idx;

// Unlike SystemVerilog, Verilog-2001 doesn' allow us to have arrays as ports,
// so I convert a compound input wire into a more convenient array form here.
integer j;
integer k;
reg [7:0] block_in_bytearray [BLOCK_SIZE_IN_OCTETS-1:0];
always @(block_in) begin
  for (j = 0; j < BLOCK_SIZE_IN_OCTETS; j = j + 1) begin
    for (k = 0; k < 8; k = k + 1) begin
      block_in_bytearray[j][k] = block_in[(j * 8) + k];
    end
  end
end

integer i;

always @(posedge reset) begin
  write_ready <= 0;
  encipher_ready <= 0;
  init_hash_ready <= 0;
  cipher_out <= data_in;
  for (i = 0; i < 256; i = i + 1) begin
    mejda[i] = i;
  end
end

// Update our table.
always @(posedge write_enable) begin
  if (!write_ready && !reset) begin
    mejda[idx_in] <= key_byte_in;
    write_ready <= 1;
  end
end
always @(negedge write_enable) begin
  write_ready <= 0;
end

// Hash.
always @(posedge encipher_enable) begin
  if (!encipher_ready && !reset) begin
    cipher_out <= mejda[cipher_out ^ data_in];
    encipher_ready <= 1;
  end
end
always @(negedge encipher_enable) begin
  encipher_ready <= 0;
end

// Initialise.
always @(posedge init_hash_enable) begin
  if (!init_hash_ready && !reset) begin
    cipher_out <= data_in;
    init_hash_ready <= 1;
  end
end
always @(negedge init_hash_enable) begin
  init_hash_ready <= 0;
end

// Block-hash.
always @(posedge block_enable) begin
  if (!block_ready && !reset) begin
    buffer = block_in[7:0];
    for (block_byte_idx = 1; block_byte_idx < BLOCK_SIZE_IN_OCTETS; block_byte_idx = block_byte_idx + 1) begin
      buffer = mejda[buffer ^ block_in_bytearray[block_byte_idx]];
    end
    block_hash = buffer;
    block_ready <= 1;
  end
end
always @(negedge block_enable) begin
  block_ready <= 0;
end
endmodule
