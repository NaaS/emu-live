/*
FIFO queue where arbitrary nodes can be sent to the back of the queue (just as if they were naughty).
Nik Sultana, Cambridge University Computer Lab, January 2017

 This software was developed by the University of Cambridge,
 Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

 Use of this source code is governed by the Apache 2.0 license; see LICENSE file

Written for Verilog-2001. Since this language lacks structs I followed the idiom
that's used at: http://www.fpgacentral.com/group/verilog/c-structs-verilog-100998/
*/

// We use `NQ_COMMAND_WIDTH bits to encode command codes.
// We expect an enclosing module to define this.
`ifndef NQ_COMMAND_WIDTH
  // NOTE Hack, following section 2 of https://www.veripool.org/papers/Preproc_Good_Evil_SNUGBos10_paper.pdf
  `error_undefined_NQ_COMMAND_WIDTH
`endif

module NaughtyQ
 #(// IDX_WIDTH is used to calculate the queue's depth.
   parameter IDX_WIDTH = 3,
   // DATA_WIDTH is the width of the payload of each element in the queue.
   parameter DATA_WIDTH = 8)
  (// Control.
   input wire clock,
   input wire reset,
   input wire [`NQ_COMMAND_WIDTH:0] command,
   input wire enable,
   output reg ready,
   output reg crashed,
   // Data.
   input wire [IDX_WIDTH-1:0] idx_in,
   input wire [DATA_WIDTH-1:0] data_in,
   output reg [IDX_WIDTH-1:0] idx_out,
   output reg [DATA_WIDTH-1:0] data_out);

parameter MAX_DEPTH_IDX = 2**IDX_WIDTH - 1;

// Command codes for this module:
parameter NOP_COMMAND = `NQ_COMMAND_WIDTH'd0;
// Description: zeroes-out the outputs.
// Inputs: none.
// Outputs: none.
parameter ENLIST_COMMAND = `NQ_COMMAND_WIDTH'd1;
// Description: Add new element to the list (overwriting the data at the first element of the queue, and moving that node to be the last element).
// Inputs: enable, new data.
// Outputs: index, evicted data, ready.
localparam BACKOFQUEU_COMMAND = `NQ_COMMAND_WIDTH'd2;
// Description: Push an existing element to the back of the queue.
// Inputs: enable, index.
// Outputs: ready.
localparam READDATA_COMMAND = `NQ_COMMAND_WIDTH'd3;
// Description: Obtain the data of a specific index of the queue.
// Inputs: index, enable.
// Outputs: {key,value}, ready.


// NOTE Using "_F" to indicate that this is a field.
`define DATA_F_LSB 0
`define DATA_F_MSB (`DATA_F_LSB + DATA_WIDTH - 1)
`define DATA_F_WORD `DATA_F_MSB:`DATA_F_LSB

`define NEXT_NODE_F_LSB (`DATA_F_MSB + 1)
`define NEXT_NODE_F_MSB (`NEXT_NODE_F_LSB + IDX_WIDTH - 1)
`define NEXT_NODE_F_WORD `NEXT_NODE_F_MSB:`NEXT_NODE_F_LSB

`define PREV_NODE_F_LSB (`NEXT_NODE_F_MSB + 1)
`define PREV_NODE_F_MSB (`PREV_NODE_F_LSB + IDX_WIDTH - 1)
`define PREV_NODE_F_WORD `PREV_NODE_F_MSB:`PREV_NODE_F_LSB

reg [`PREV_NODE_F_MSB:`DATA_F_LSB] memory [MAX_DEPTH_IDX:0];
reg [IDX_WIDTH-1:0] memory_first_idx;
reg [IDX_WIDTH-1:0] memory_last_idx;

integer i;

// This is used to avoid having multiple invocations of a command if "enable" is
// kept high across several clock ticks.
reg awaiting_next_enable;

always @(negedge enable) begin
  ready <= 0;
  awaiting_next_enable <= 1;
`ifdef NQ_RESET_ZEROES_OUTPUTS
  // Using this mode we avoid using NOP_COMMAND explicitly.
  idx_out <= 0;
  data_out <= 0;
`endif
end

// Asynchronous reset.
always @(posedge clock or posedge reset) begin
  if (reset) begin
    ready <= 0;
    awaiting_next_enable <= 1;
    idx_out <= 0;
    data_out <= 0;

    crashed <= 0;

    // We run through the memory, turning it into a linear list.
    memory_first_idx = 0;
    memory_last_idx = MAX_DEPTH_IDX; // Must use = rather than <= here since the _idx values are used later in this block.
    memory[memory_first_idx][`PREV_NODE_F_WORD] <= MAX_DEPTH_IDX;
    memory[memory_first_idx][`NEXT_NODE_F_WORD] <= 1;
    memory[memory_last_idx][`PREV_NODE_F_WORD] <= MAX_DEPTH_IDX - 1;
    memory[memory_last_idx][`NEXT_NODE_F_WORD] <= 0;
`ifdef NQ_RESET_ZEROES_DATA
    memory[memory_first_idx][`DATA_F_WORD] <= 0;
    memory[memory_last_idx][`DATA_F_WORD] <= 0;
`endif
    for (i = 1; i < MAX_DEPTH_IDX; i = i + 1) begin
      memory[i][`PREV_NODE_F_WORD] <= i - 1;
      memory[i][`NEXT_NODE_F_WORD] <= i + 1;
`ifdef NQ_RESET_ZEROES_DATA
      memory[i][`DATA_F_WORD] <= 0;
`endif
    end

  end else if (enable && !crashed && awaiting_next_enable) begin
    awaiting_next_enable <= 0;
    case (command)
      NOP_COMMAND: begin
        idx_out <= 0;
        data_out <= 0;
        ready <= 1;
      end

      ENLIST_COMMAND: begin
        // Set outputs.
        idx_out <= memory_last_idx;
        data_out <= memory[memory_last_idx][`DATA_F_WORD];
        ready <= 1;

        // Update state.
        memory[memory_last_idx][`DATA_F_WORD] <= data_in;
        memory_first_idx <= memory_last_idx;
        memory_last_idx <= memory[memory_last_idx][`PREV_NODE_F_WORD];
      end

      BACKOFQUEU_COMMAND: begin
        // We get interesting bugs if this check isn't made.
        if (memory_first_idx != idx_in) begin
          memory_first_idx <= idx_in;
          memory[idx_in][`PREV_NODE_F_WORD] <= memory_last_idx;
          memory[idx_in][`NEXT_NODE_F_WORD] <= memory_first_idx;

          memory[memory[idx_in][`PREV_NODE_F_WORD]][`NEXT_NODE_F_WORD] <= memory[idx_in][`NEXT_NODE_F_WORD];
          memory[memory[idx_in][`NEXT_NODE_F_WORD]][`PREV_NODE_F_WORD] <= memory[idx_in][`PREV_NODE_F_WORD];

          memory[memory_last_idx][`NEXT_NODE_F_WORD] <= idx_in;
          memory[memory_first_idx][`PREV_NODE_F_WORD] <= idx_in;
        end
        ready <= 1;
      end

      READDATA_COMMAND: begin
        data_out <= memory[idx_in][`DATA_F_WORD];
        ready <= 1;
      end

      default:
        // For completeness.
        // The only way to recover from this state is to reset this module.
        crashed <= 1;
    endcase
  end
end

endmodule
