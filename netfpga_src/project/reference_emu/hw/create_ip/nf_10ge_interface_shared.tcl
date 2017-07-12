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
# 
#  Use of this source code is governed by the Apache 2.0 license; see LICENSE file

# Set variables.

## CORE CONFIGURATION parameters
# should correspond to hdl params
set sharedLogic         "TRUE"
set tdataWidth          256


set convWidth [expr $tdataWidth/8]

if { $sharedLogic eq "True" || $sharedLogic eq "TRUE" || $sharedLogic eq "true" } {
   set supportLevel 1
} else {
   set supportLevel 0
}


create_ip -name axi_10g_ethernet -vendor xilinx.com -library ip -version 2.0 -module_name axi_10g_ethernet_shared
set_property -dict [list CONFIG.Management_Interface {false}] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.base_kr {BASE-R}] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.SupportLevel $supportLevel] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.autonegotiation {0}] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.fec {0}] [get_ips axi_10g_ethernet_shared]
set_property -dict [list CONFIG.Statistics_Gathering {0}] [get_ips axi_10g_ethernet_shared]




