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
# @NETFPGA_LICENSE_HEADER_START@
#
# Licensed to NetFPGA C.I.C. (NetFPGA) under one or more contributor
# license agreements.  See the NOTICE file distributed with this work for
# additional information regarding copyright ownership.  NetFPGA licenses this
# file to you under the NetFPGA Hardware-Software License, Version 1.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at:
#
#   http://www.netfpga-cic.org
#
# Unless required by applicable law or agreed to in writing, Work distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
#
# @NETFPGA_LICENSE_HEADER_END@
#

# Hierachical cell : SUME 10g interface block design
proc create_hier_cell_nf_sume_sim_interface { parentCell coreName fstimName frecName} {

   # Check argument
   if { $parentCell eq "" || $coreName eq "" } {
      puts "ERROR: Empty argument(s)!"
      return
   }

   puts $fstimName	
   # Check argument
   if { $parentCell eq "" || $fstimName eq "" } {
      puts "ERROR: Empty argument(s)!"
      return
   }
	
   puts $frecName  
   # Check argument
   if { $parentCell eq "" || $frecName eq "" } {
      puts "ERROR: Empty argument(s)!"
      return
   }		
   
   # Get object for parentCell
   set parentObj [get_bd_cells $parentCell]
   if { $parentCell == "" } {
      puts "ERROR: Unable to find parent cell <$parentCell>!"
      return
   }

   # parentObj should be hier block
   set parentType [get_property TYPE $parentObj]
   if { $parentType ne "hier"} {
      puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>."
   }

   # Save current instance; Restore later
   set oldCurInst [current_bd_instance .]

   # Set parent object as current
   current_bd_instance $parentObj

   # Create cell and set as current instance
   set hier_obj [create_bd_cell -type hier $coreName]
   current_bd_instance $hier_obj

   # Create bd external ports
   create_bd_pin -dir I -type clk axis_aclk
   create_bd_pin -dir I axis_aresetn
   
   # non-std pins
   create_bd_pin -dir I stim_barrier_proceed
   create_bd_pin -dir O stim_activity_stim 
   create_bd_pin -dir O stim_barrier_req

   create_bd_pin -dir O rec_activity_rec  	
   

   # std ports 
   create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis
    create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis

   # create data path blocks
   # TX
   set axis_sim_stim_ip [create_bd_cell -type ip -vlnv NetFPGA:NetFPGA:axis_sim_stim:1.00 axis_sim_stim_ip]
   set_property -dict [list CONFIG.input_file $::env(NF_DESIGN_DIR)/test/$fstimName] $axis_sim_stim_ip	
  
   # RX
   set axis_sim_record_ip [create_bd_cell -type ip -vlnv NetFPGA:NetFPGA:axis_sim_record:1.00 axis_sim_record_ip]
   set_property -dict [list CONFIG.OUTPUT_FILE $::env(NF_DESIGN_DIR)/test/$frecName] $axis_sim_record_ip		
   
   
  
   # External port connections  
   # axis	 
   connect_bd_net [get_bd_pins axis_aclk] [get_bd_pins axis_sim_stim_ip/ACLK]  
   connect_bd_net [get_bd_pins axis_aresetn] [get_bd_pins axis_sim_stim_ip/ARESETN] 
 
   connect_bd_net [get_bd_pins axis_aclk] [get_bd_pins axis_sim_record_ip/axi_aclk] 
  
   # interfaces  
   connect_bd_intf_net [get_bd_intf_pin m_axis] [get_bd_intf_pins axis_sim_stim_ip/M_AXIS] 
   connect_bd_intf_net [get_bd_intf_pin s_axis] [get_bd_intf_pins axis_sim_record_ip/s_axis] 	  

   # non-std
   connect_bd_net [get_bd_pins stim_barrier_proceed] [get_bd_pins axis_sim_stim_ip/barrier_proceed]
   connect_bd_net [get_bd_pins stim_activity_stim] [get_bd_pins axis_sim_stim_ip/activity_stim]
   connect_bd_net [get_bd_pins stim_barrier_req] [get_bd_pins axis_sim_stim_ip/barrier_req]
 	
   connect_bd_net [get_bd_pins rec_activity_rec] [get_bd_pins axis_sim_record_ip/activity_rec]
   

   # Internal connection
   connect_bd_net [get_bd_pins axis_sim_record_ip/counter] [get_bd_pins axis_sim_stim_ip/counter]	

   # Restore current instance
   current_bd_instance $oldCurInst
}
