//
// Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
//                          Junior University
// Copyright (C) 2010, 2011 Adam Covington
// Copyright (C) 2015 Noa Zilberman
// Copyright (C) 2016 Salvator Galea
// All rights reserved.
//
// This software was developed by
// Stanford University and the University of Cambridge Computer Laboratory
// under National Science Foundation under Grant No. CNS-0855268,
// the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
// by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
// as part of the DARPA MRC research programme.
//
// @NETFPGA_LICENSE_HEADER_START@
//
// Licensed to NetFPGA C.I.C. (NetFPGA) under one or more contributor
// license agreements.  See the NOTICE file distributed with this work for
// additional information regarding copyright ownership.  NetFPGA licenses this
// file to you under the NetFPGA Hardware-Software License, Version 1.0 (the
// "License"); you may not use this file except in compliance with the
// License.  You may obtain a copy of the License at:
//
//   http://www.netfpga-cic.org
//
// Unless required by applicable law or agreed to in writing, Work distributed
// under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
//
// @NETFPGA_LICENSE_HEADER_END@
//
/*******************************************************************************
 *  File:
 *        emu_output_port_lookup.v
 *
 *  Library:
 *        hw/std/cores/emu_output_port_lookup
 *
 *  Module:
 *        emu_output_port_lookup
 *
 *  Author:
 *        Adam Covington
 *        Modified by Noa Zilberman, Salvator Galea
 * 		
 *  Description:
 *        Output port lookup for the reference Emu project
 *
 */


`include "output_port_lookup_cpu_regs_defines.v"

module emu_output_port_lookup
#(
	//Master AXI Stream Data Width
	parameter C_M_AXIS_DATA_WIDTH=256,
	parameter C_S_AXIS_DATA_WIDTH=256,
	parameter C_M_AXIS_TUSER_WIDTH=128,
	parameter C_S_AXIS_TUSER_WIDTH=128,
	parameter SRC_PORT_POS=16,
	parameter DST_PORT_POS=24,

	// AXI Registers Data Width
	parameter C_S_AXI_DATA_WIDTH    = 32,          
	parameter C_S_AXI_ADDR_WIDTH    = 12,          
	parameter C_BASEADDR            = 32'h00000000


)
(
	// Global Ports
	input axis_aclk,
	input axis_resetn,

	// Master Stream Ports (ports to OQs)
	output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
	output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tkeep,
	output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
	output m_axis_tvalid,
	input  m_axis_tready,
	output m_axis_tlast,

	// Slave Stream Ports (ports from IA)
	input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
	input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tkeep,
	input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
	input  s_axis_tvalid,
	output s_axis_tready,
	input  s_axis_tlast,

	// Slave AXI Ports
	input                                     S_AXI_ACLK,
	input                                     S_AXI_ARESETN,
	input      [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_AWADDR,
	input                                     S_AXI_AWVALID,
	input      [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_WDATA,
	input      [C_S_AXI_DATA_WIDTH/8-1 : 0]   S_AXI_WSTRB,
	input                                     S_AXI_WVALID,
	input                                     S_AXI_BREADY,
	input      [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_ARADDR,
	input                                     S_AXI_ARVALID,
	input                                     S_AXI_RREADY,
	output                                    S_AXI_ARREADY,
	output     [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_RDATA,
	output     [1 : 0]                        S_AXI_RRESP,
	output                                    S_AXI_RVALID,
	output                                    S_AXI_WREADY,
	output     [1 :0]                         S_AXI_BRESP,
	output                                    S_AXI_BVALID,
	output                                    S_AXI_AWREADY
);

	reg      [`REG_ID_BITS]		id_reg;
	reg      [`REG_VERSION_BITS]	version_reg;
	wire     [`REG_RESET_BITS]	reset_reg;
	reg      [`REG_FLIP_BITS]	ip2cpu_flip_reg;
	wire     [`REG_FLIP_BITS]	cpu2ip_flip_reg;
	reg      [`REG_PKTIN_BITS]	pktin_reg;
	wire				pktin_reg_clear;
	reg      [`REG_PKTOUT_BITS]	pktout_reg;
	wire				pktout_reg_clear;
	reg      [`REG_DEBUG_BITS]	ip2cpu_debug_reg;
	wire     [`REG_DEBUG_BITS]	cpu2ip_debug_reg;

	wire clear_counters;
	wire reset_registers;

	function integer log2;
	input integer number;
	begin
		log2=0;
		while(2**log2<number) begin
			log2=log2+1;
		end
	end
	endfunction // log2

	// ------------ Internal Params --------
	localparam CAM_DEPTH		= 16;
	localparam CAM_WIDTH		= 104;
	localparam CAM_DEPTH_BITS	= log2(CAM_DEPTH);

	//------------- Wires ------------------
	wire [63:0] m_axis_tdata_256;  
	wire [7:0] m_axis_tkeep_256;   
	wire m_axis_tlast_256;   
	wire m_axis_tvalid_256;   
	wire m_axis_tready_256;  
	wire [63:0] m_axis_tuser_hi_256;
	wire [63:0] m_axis_tuser_low_256;

	wire [63:0] s_axis_tdata_256;  
	wire [7:0] s_axis_tkeep_256;   
	wire s_axis_tlast_256;   
	wire s_axis_tvalid_256;   
	wire s_axis_tready_256;  
	wire [63:0] s_axis_tuser_hi_256;
	wire [63:0] s_axis_tuser_low_256;  

	reg reset;

	always @(posedge axis_aclk) reset <= #1 ~axis_resetn;

	//-------------------- Modules and Logic ---------------------------

	Emu the_Emu
	(  
		.reset(reset),   
		.clk(axis_aclk),   

		.s_axis_tkeep(s_axis_tkeep),   
		.s_axis_tlast(s_axis_tlast),   
		.s_axis_tvalid(s_axis_tvalid),   
		.s_axis_tready(s_axis_tready),  
		.s_axis_tuser_hi(s_axis_tuser[127:64]),
		.s_axis_tuser_low(s_axis_tuser[63:0]),


		// Outputs
		.raw_bw_mem(),
		.processed_bw_mem(),
		.total_entries(),
		// Inputs
		.timer_resolution(32'd100),
		.bw_resolution(32'd4),
		.rst(reset),
		.clear()

	);


endmodule // output_port_lookup
