#
# Copyright (c) 2015 University of Cambridge
# All rights reserved.
#
# This software was developed by Stanford University and the University of Cambridge Computer Laboratory 
# under National Science Foundation under Grant No. CNS-0855268,
# the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
# by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
# as part of the DARPA MRC research programme.
#
# Use of this source code is governed by the Apache 2.0 license; see LICENSE file
#

#Create system input and output ports
create_bd_port -dir I fpga_sysclk_n
create_bd_port -dir I fpga_sysclk_p
create_bd_port -dir I -type rst reset
set_property -dict [list CONFIG.POLARITY {ACTIVE_HIGH}] [get_bd_ports reset]
create_bd_port -dir I sfp_refclk_n
create_bd_port -dir I sfp_refclk_p

create_bd_port -dir O eth0_rx_led
create_bd_port -dir O eth0_tx_led
create_bd_port -dir I eth0_rxp
create_bd_port -dir I eth0_rxn
create_bd_port -dir O eth0_txp
create_bd_port -dir O eth0_txn
create_bd_port -dir O eth0_tx_disable
create_bd_port -dir I eth0_abs
create_bd_port -dir I eth0_tx_fault

create_bd_port -dir O eth1_rx_led
create_bd_port -dir O eth1_tx_led
create_bd_port -dir I eth1_rxp
create_bd_port -dir I eth1_rxn
create_bd_port -dir O eth1_txp
create_bd_port -dir O eth1_txn
create_bd_port -dir O eth1_tx_disable
create_bd_port -dir I eth1_abs
create_bd_port -dir I eth1_tx_fault

create_bd_port -dir O eth2_rx_led
create_bd_port -dir O eth2_tx_led
create_bd_port -dir I eth2_rxp
create_bd_port -dir I eth2_rxn
create_bd_port -dir O eth2_txp
create_bd_port -dir O eth2_txn
create_bd_port -dir O eth2_tx_disable
create_bd_port -dir I eth2_abs
create_bd_port -dir I eth2_tx_fault

create_bd_port -dir O eth3_rx_led
create_bd_port -dir O eth3_tx_led
create_bd_port -dir I eth3_rxp
create_bd_port -dir I eth3_rxn
create_bd_port -dir O eth3_txp
create_bd_port -dir O eth3_txn
create_bd_port -dir O eth3_tx_disable
create_bd_port -dir I eth3_abs
create_bd_port -dir I eth3_tx_fault

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart
create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_fpga
create_bd_port -dir O -from 1 -to 0 iic_reset

create_bd_port -dir I -from 0 -to 7 pcie_7x_mgt_rxn
create_bd_port -dir I -from 0 -to 7 pcie_7x_mgt_rxp
create_bd_port -dir O -from 0 -to 7 pcie_7x_mgt_txn
create_bd_port -dir O -from 0 -to 7 pcie_7x_mgt_txp

create_bd_port -dir I -type clk sys_clkp
create_bd_port -dir I -type clk sys_clkn
create_bd_port -dir I pcie_sys_resetn
