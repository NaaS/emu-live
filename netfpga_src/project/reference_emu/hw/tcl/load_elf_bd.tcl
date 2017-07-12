#
# Copyright (c) 2015 University of Cambridge
# All rights reserved.
#
#
#  Description:
#        Vivado TCL script to insert compiled elf files into the project
#        and associate it with the microblaze in the system. The script generates
#        bitstreams with microblaze BRAM initialized with the elf file.
#        useage:
#        $ vivado -source tcl/load_elf_bd.tcl 
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

# open project
open_project project/${design}.xpr

set bd_file [get_files -regexp -nocase {.*emu.bd}]
set elf_file ../sw/embedded/project/SDK_Workspace/${design}/Debug/${design}.elf

open_bd_design $bd_file

# insert acceptance_test elf if it is not inserted yet
if {[llength [get_files *${design}.elf]]} {
	puts "ELF File [get_files *acceptance_test.elf] is already associated"
} else {
	add_files -norecurse -force ${elf_file} 
	set_property SCOPED_TO_REF [current_bd_design] [get_files -all -of_objects [get_fileset sources_1] ${elf_file}]
	set_property SCOPED_TO_CELLS mbsys/microblaze_0 [get_files -all -of_objects [get_fileset sources_1] ${elf_file}]
}

# Create bitstream with up-to-date elf files
reset_run impl_1 -prev_step
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
open_run impl_1
write_bitstream -force ../bitfiles/${design}.bit

exit
