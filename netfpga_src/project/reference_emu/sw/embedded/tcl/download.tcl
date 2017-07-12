
#
# Copyright (c) 2015 Digilent Inc.
# Copyright (c) 2015 Tinghui Wang (Steve)
# All rights reserved.
#
#  File:
#        download.tcl
#
#  Project:
#        acceptance_test
#
#  Author:
#        Tinghui Wang (Steve)
#
#  Description:
#        Downloads the acceptance test elf 
#
# Use of this source code is governed by the Apache 2.0 license; see LICENSE file
#

fpga -f [lindex $argv 0]
connect mb mdm
dow SDK_Workspace/project/Debug/project.elf
run
