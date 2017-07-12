#
# Copyright (c) 2015 Noa Zilberman
# All rights reserved.
#
#  File:
#        Makefile
#
#  Project:
#        reference projects
#
#
#  Description:
#        This makefile is used to generate and compile SDK project for NetFPGA reference projects.
#
# This software was developed by Stanford University and the University of Cambridge Computer Laboratory 
# under National Science Foundation under Grant No. CNS-0855268,
# the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
# by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
# as part of the DARPA MRC research programme.
#
# 
#  Use of this source code is governed by the Apache 2.0 license; see LICENSE file
#
# Vivado Launch Script
################################################################################


HW = hw
SW = sw/embedded/
TEST = test

all:    clean
	make -C ${HW} project
	make -C ${HW} export_to_sdk
	make -C ${SW} project
	make -C ${SW} compile
	make -C ${HW} load_elf

clean:
	make -C ${HW} distclean
	make -C ${SW} distclean
	rm -rfv vivado*;\

