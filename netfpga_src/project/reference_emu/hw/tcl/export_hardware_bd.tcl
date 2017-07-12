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


set design [lindex $argv 0] 

open_project project/$design.xpr

set bd_file [get_files -regexp -nocase {.*emu.bd}] 

open_bd_design $bd_file
open_run impl_1
export_hardware $bd_file [get_runs impl_1] -bitstream -dir ../sw/embedded/project

exit

