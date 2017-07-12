/*
A (binary) CAM that relies on an external 8-bit hash function.
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

Written for Verilog-2001. Since this language lacks structs I followed the idiom
that's used at: http://www.fpgacentral.com/group/verilog/c-structs-verilog-100998/
*/

module HashCAM
 #(parameter KEY_WIDTH_IN_OCTETS = 2,
   parameter VALUE_WIDTH_IN_BITS = 8,
   parameter MAX_BUCKET_SIZE = 10)
  (// control.
   input wire reset,
   input wire lookup_enable,
   output reg lookup_ready,
   input wire write_enable,
   output reg write_ready,
   output reg match,
   output reg full,
   /* Hash function is internalised, rather than connect to an external module,
      since it keeps logic simpler wrt concurrent reads and writes (both of which
      rely on obtainin a hash first).
   // control lines with the hash function.
   output reg blockhash_enable,
   input wire blockhash_ready,
   output wire [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] key_to_hash,
   input wire [7:0] key_hash,
   */
   // data.
   input wire [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] key_in,
   input wire [VALUE_WIDTH_IN_BITS - 1 : 0] value_in,
   output reg [VALUE_WIDTH_IN_BITS - 1 : 0] value_out);

// NOTE Using "_F" to indicate that this is a field.
reg live_F;
reg [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] key_F;
reg [VALUE_WIDTH_IN_BITS - 1 : 0] value_F;

// "live" field is a single bit wide.
`define LIVE_F_LSB 0
`define LIVE_F_MSB 0
`define LIVE_F_WORD `LIVE_F_MSB:`LIVE_F_LSB

`define KEY_F_LSB (`LIVE_F_MSB + 1)
`define KEY_F_MSB (`KEY_F_LSB + (KEY_WIDTH_IN_OCTETS * 8) - 1)
`define KEY_F_WORD `KEY_F_MSB:`KEY_F_LSB

`define VALUE_F_LSB (`KEY_F_MSB + 1)
`define VALUE_F_MSB (`VALUE_F_LSB + VALUE_WIDTH_IN_BITS - 1)
`define VALUE_F_WORD `VALUE_F_MSB:`VALUE_F_LSB

reg [`VALUE_F_MSB:`LIVE_F_LSB] mejda [255:0] [MAX_BUCKET_SIZE:0];

wire block_ready;
wire [7:0] block_hash;
reg block_enable = 0;
reg [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] block_in;

reg [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] captured_key_in;

//assign key_to_hash = key_in;

integer i;
integer j;
always @(posedge reset) begin
  full <= 0;
  lookup_ready <= 0;
  write_ready <= 0;
  match <= 0;
  //blockhash_enable <= 0;
  value_out <= 0;

  for (i = 0; i < 256; i = i + 1) begin
    for (j = 0; j < MAX_BUCKET_SIZE; j = j + 1) begin
      mejda[i][j] = 0;
    end
  end
end


// Reading from the hash table. -----------------------------------------------

PearsonHash
 #(.BLOCK_SIZE_IN_OCTETS(KEY_WIDTH_IN_OCTETS))
  ph_read
  (.reset(reset),
    // NOTE we don't customise the permutation used by PearsonHash.
    //      we don't use most features of this module.
   .write_enable( ),
   .write_ready( ),
   .encipher_enable( ),
   .encipher_ready( ),
   .init_hash_enable( ),
   .init_hash_ready( ),
   .idx_in( ),
   .key_byte_in( ),
   .data_in( ),
   .cipher_out( ),
   .block_ready(block_ready),
   .block_hash(block_hash),
   .block_in(block_in),
   .block_enable(block_enable));

// Phase 1: pass the key on to the hash function, and wait for the result.
always @(posedge lookup_enable) begin
  if (!block_ready && !block_enable && !lookup_ready && !reset) begin
    block_in <= key_in;
    captured_key_in <= key_in; // We store this since key_in might change by the time we hear back from the hash function.
    block_enable <= 1;
  end
end
// Phase 2: use the hash to identify the bucket.
//          then iterate through the bucket list(!) looking for a match.
integer lookup_idx;
reg found;
always @(posedge block_ready) begin
  if (lookup_enable // This signal must still be asserted.
      && !lookup_ready && !reset) begin
    lookup_idx = 0;
    found = 0;
    while (lookup_idx < MAX_BUCKET_SIZE && !found) begin
      if (mejda[block_hash][lookup_idx][`LIVE_F_WORD] &&
         (mejda[block_hash][lookup_idx][`KEY_F_WORD] == captured_key_in)) begin
        found = 1;
        match <= 1;
        value_out <= mejda[block_hash][lookup_idx][`VALUE_F_WORD];
      end

      lookup_idx = lookup_idx + 1;
    end

    // Start shutting the transaction down, but "releasing" the hash function
    // and indicating that the lookup has been completed.
    block_enable <= 0;
    lookup_ready <= 1;
  end
end
// Complete transaction's shut-down.
always @(negedge lookup_enable) begin
  match <= 0;
  lookup_ready <= 0;
end


// Writing to the hash table. ------------------------------------------------

wire wr_block_ready;
wire [7:0] wr_block_hash;
reg wr_block_enable = 0;
reg [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] wr_block_in;

reg [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] wr_captured_key_in;
reg [(KEY_WIDTH_IN_OCTETS * 8) - 1 : 0] wr_captured_value_in;

PearsonHash
 #(.BLOCK_SIZE_IN_OCTETS(KEY_WIDTH_IN_OCTETS))
  ph_write
  (.reset(reset),
    // NOTE we don't customise the permutation used by PearsonHash.
    //      we don't use most features of this module.
   .write_enable( ),
   .write_ready( ),
   .encipher_enable( ),
   .encipher_ready( ),
   .init_hash_enable( ),
   .init_hash_ready( ),
   .idx_in( ),
   .key_byte_in( ),
   .data_in( ),
   .cipher_out( ),
   .block_ready(wr_block_ready),
   .block_hash(wr_block_hash),
   .block_in(wr_block_in),
   .block_enable(wr_block_enable));

// Phase 1: pass the key on to the hash function, and wait for the result.
always @(posedge write_enable) begin
  if (!wr_block_ready && !wr_block_enable && !write_ready && !reset) begin
    wr_block_in <= key_in;

    // We store this since input smight change by the time we hear back from the hash function.
    wr_captured_key_in <= key_in;
    wr_captured_value_in <= value_in;

    wr_block_enable <= 1;
  end
end
// Phase 2: use the hash to identify the bucket.
//          then iterate through the bucket list(!) looking for a match.
integer wr_lookup_idx;
reg wr_found;
integer wr_vacant_idx;
reg wr_found_vacant;
always @(posedge wr_block_ready) begin
  if (write_enable // This signal must still be asserted.
      && !write_ready && !reset) begin
    // We start by carrying out a lookup. If it succeeds then we modify the
    // existing record, otherwise we need to assign a new one.
    wr_lookup_idx = 0;
    wr_found = 0;
    wr_found_vacant = 0;
    while (wr_lookup_idx < MAX_BUCKET_SIZE && !wr_found) begin

      if (!mejda[wr_block_hash][wr_lookup_idx][`LIVE_F_WORD]) begin
        wr_vacant_idx = wr_lookup_idx;
        wr_found_vacant = 1;
      end else if (mejda[wr_block_hash][wr_lookup_idx][`LIVE_F_WORD] &&
         (mejda[wr_block_hash][wr_lookup_idx][`KEY_F_WORD] == wr_captured_key_in)) begin
        wr_found = 1;
        mejda[wr_block_hash][wr_lookup_idx][`VALUE_F_WORD] <= wr_captured_value_in;
        match <= 1;
        value_out <= mejda[wr_block_hash][wr_lookup_idx][`VALUE_F_WORD];
      end

      wr_lookup_idx = wr_lookup_idx + 1;
    end

    if (!wr_found) begin
      if (!wr_found_vacant)
        full <= 1;
      else begin
        // Use the vacant place we saw earlier.
        mejda[wr_block_hash][wr_vacant_idx][`LIVE_F_WORD] <= 1;
        mejda[wr_block_hash][wr_vacant_idx][`KEY_F_WORD] <= wr_captured_key_in;
        mejda[wr_block_hash][wr_vacant_idx][`VALUE_F_WORD] <= wr_captured_value_in;
      end
    end

    // Start shutting the transaction down, but "releasing" the hash function
    // and indicating that the lookup has been completed.
    wr_block_enable <= 0;
    write_ready <= 1;
  end
end
// Complete transaction's shut-down.
always @(negedge write_enable) begin
  match <= 0;
  write_ready <= 0;
end

endmodule
