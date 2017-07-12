#
#	Copyright 2016	Salvator Galea	<salvator.galea@cl.cam.ac.uk>
#	All rights reserved
#
#	This software was developed by the University of Cambridge,
#	Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

#	Use of this source code is governed by the Apache 2.0 license; see LICENSE file
#

SHELL 	?= /bin/bash
KIWI	?= $(HPRLS)/kiwipro/kiwic/distro
KIWIDLL	?= $(KIWI)/support/Kiwi.dll

MONO	?= mono
KIWIC	?= $(MONO) $(KIWI)/lib/kiwic.exe
CSC	?= gmcs

ENABLE_THREADS	?= -compose=disable 
HIDE_REGS	?= enable
KIWI_FLAGS	?= -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=$(HIDE_REGS) $(ENABLE_THREADS)

# Choose the desired type of design, block design (vb) or verilog based design (bd)
DESIGN_TYPE	:= vb


# Check for the enviroment variables
ifndef SUME_FOLDER
ifndef NF_ROOT
$(error SUME_FOLDER or NF_ROOT is not set)
endif
else
SELF_DIR	:= $(dir $(lastword $(MAKEFILE_LIST)))
LIB_HW_emu_opl	:= $(SUME_FOLDER)/lib/hw/std/cores/emu_output_port_lookup_v1_0_0
emu_OPL_tcl	:= $(LIB_HW_emu_opl)/emu_output_port_lookup.tcl
cam_wrapper	:= $(SUME_FOLDER)/lib/hw/xilinx/cores/cam_v1_1_0/hdl/verilog/cam_wrapper.v 
endif


#.PHONY: clean
.ONESHELL:
.SECONDEXPANSION:
.MAKEFILES : Makefile 1G-CML.mk

# $(call set_clock_freq,CLK_FREQ,DESIGN_TYPE)
#  args:
#	CLK_FREQ	: should be a number
#	DESIGN_TYPE	: vb -- for verilog based designs
#			  bd -- for block designs
#  def:
# 	Sets the correct frequency for the project 
define set_clock_freq
 if [ "$(2)" = "bd" ]; then \
   sed -i 's/CLKOUT2_REQUESTED_OUT_FREQ.*{.*}/CLKOUT2_REQUESTED_OUT_FREQ {$(1)\.000}/' $(NF_DESIGN_DIR)/hw/tcl/reference_emu_bd.tcl; \
   sed -i 's/CLKOUT2_REQUESTED_OUT_FREQ.*{.*}/CLKOUT2_REQUESTED_OUT_FREQ {$(1)\.000}/' $(NF_DESIGN_DIR)/hw/tcl/reference_emu_sim_bd.tcl; \
   echo "Modify "$(NF_DESIGN_DIR)"/hw/tcl/reference_emu_bd.tcl \t\t-- Change clock frequency to $(1)Hz."; \
   echo "Modify "$(NF_DESIGN_DIR)"/hw/tcl/reference_emu_sim_bd.tcl \t-- Change clock frequency to $(1)Hz."; \
 elif [ "$(2)" = "vb" ]; then \
   sed -i -e 's/CLKOUT1_REQUESTED_OUT_FREQ[^}]*/CLKOUT1_REQUESTED_OUT_FREQ {$(1)\.000/' $(NF_DESIGN_DIR)/hw/tcl/reference_emu.tcl; \
   sed -i -e's/CLKOUT1_REQUESTED_OUT_FREQ[^}]*/CLKOUT1_REQUESTED_OUT_FREQ {$(1)\.000/' $(NF_DESIGN_DIR)/hw/tcl/reference_emu_sim.tcl; \
   echo "Modify "$(NF_DESIGN_DIR)"/hw/tcl/reference_emu.tcl \t-- Change clock frequency to $(1)Hz."; \
   echo "Modify "$(NF_DESIGN_DIR)"/hw/tcl/reference_emu_sim.tcl \t-- Change clock frequency to $(1)Hz."; \
 else \
   echo "No clock modifications"; \
 fi
endef

# $(call copy_OPL_to_lib,OPL_NAME)
#  args:
#	OPL_NAME	: choose a name from this directory , /netfpga_src/NetFPGA-SUME/opl_wrapper
#			  emu_output_port_lookup_AXIS256_CAM_THREADS.v
#			  emu_output_port_lookup_AXIS256_CAM.v
#			  emu_output_port_lookup_AXIS64_CAM.v
#			  emu_output_port_lookup_AXIS256.v
#			  emu_output_port_lookup_AXIS64.v
#  def:
#	Copies the correct OPL to the emu lib for the particular project
define copy_OPL_to_lib
 cp -f ../netfpga_src/NetFPGA-SUME/opl_wrapper/$(1) $(LIB_HW_emu_opl)/hdl/emu_output_port_lookup.v; \
 echo "Copy $(1) \t-- "$(LIB_HW_emu_opl)"/hdl/emu_output_port_lookup.v"
endef

# $(call CAM,ARG1,ARG2)
#  args:
#	ARG1	: YES [default: NO]
#	ARG2	: BRAM [default: SRL16]
#	ARG3	: TERNARY [default: TERNARY_MODE_OFF]
#  def:
#	Comments in/out the line for the command to add the CAM IP core
#	Ternary Modes require SRL16 (C_MEM_TYPE=0)
define CAM
 @if [ "$(1)" = "YES" ]; then \
  sed -i 's/[#]*ipx::add_subcore xilinx:xilinx:cam/ipx::add_subcore xilinx:xilinx:cam/' $(emu_OPL_tcl); \
  echo "Modify "$(emu_OPL_tcl)"\t-- CAM IP core included"; \
  if [ "$(2)" = "BRAM" ]; then \
   sed -i -r 's/(\.C_MEM_TYPE.*)[0-9]/\11/' $(cam_wrapper); \
   echo "Modify "$(cam_wrapper)"\t-- BRAM implementation"; \
  else \
   sed -i -r 's/(\.C_MEM_TYPE.*)[0-9]/\10/' $(cam_wrapper); \
   echo "Modify "$(cam_wrapper)"\t-- SRL16 implemntation"; \
  fi; \
  if [ "$(3)" = "TERNARY" ]; then \
   sed -i -r 's/(\.C_TERNARY_MODE.*)[0-9]/\11/' $(cam_wrapper); \
   echo "Modify "$(cam_wrapper)"\t-- TERNARY_MODE ON"; \
  else \
   sed -i -r 's/(\.C_TERNARY_MODE.*)[0-9]/\10/' $(cam_wrapper); \
   echo "Modify "$(cam_wrapper)"\t-- TERNARY_MODE OFF"; \
  fi; \
 else \
  sed -i 's/ipx::add_subcore xilinx:xilinx:cam/#ipx::add_subcore xilinx:xilinx:cam/' $(emu_OPL_tcl); \
  echo "Modify "$(emu_OPL_tcl)"\t-- CAM IP core NOT included"; \
 fi
endef

# ---------------------------------
# --	NetFPGA-1G-CML Projects
# ---------------------------------
include 1G-CML.mk

# ---------------------------------
# --	NetFPGA-SUME Projects
# ---------------------------------
emu_memcached_ascii_sume emu_memcached_binary_sume emu_reference_switch_sume emu_reference_switch_threads_sume emu_memcached_binary_v2_sume emu_memcached_ascii_v2_sume: $$(subst _sume,.v,$$@)
	@echo "\nKiwi Compilation finished : "$^" "
#	Rename the module in the generated verilog file 'emu_*_*_sume' to 'Emu'
	@sed -i 's/'.*module.*$(subst _sume,,$@)'/module Emu/' $< 
#	Copy the Emu to the lib folder of the NetFPGA dir
	@echo "Copy $^\t\t-- "$(SUME_FOLDER)/lib/hw/std/cores/"emu_output_port_lookup_v1_0_0/hdl/Emu.v"
	@cp -fp $< $(LIB_HW_emu_opl)/hdl/Emu.v
#	Copy the correct opl to the lib folder of the NetFPGA
	@if [ $@ = "emu_reference_switch_sume" ] || [ $@ = "emu_memcached_binary_v2_sume" ] || [ $@ = "emu_memcached_ascii_v2_sume" ]; then \
		$(call copy_OPL_to_lib,"emu_output_port_lookup_AXIS256_CAM.v"); \
		$(call set_clock_freq,200,$(DESIGN_TYPE)); \
	elif [ $@ = "emu_reference_switch_threads_sume" ]; then \
		$(call copy_OPL_to_lib,"emu_output_port_lookup_AXIS256_CAM_THREADS.v"); \
		$(call set_clock_freq,200,$(DESIGN_TYPE)); \
	else	\
		$(call copy_OPL_to_lib,"emu_output_port_lookup_AXIS64_CAM.v"); \
		$(call set_clock_freq,100,$(DESIGN_TYPE)); \
	fi
	$(call CAM,YES,BRAM)
	@echo "Update SUME IP cores library"
	@make -C $(LIB_HW_emu_opl)/

emu_reference_switch_lite_sume emu_reference_switch_lite_v2_sume emu_ICMP_echo_sume emu_DNS_server_sume emu_DNS_DBG_sume emu_TCP_pingRA_sume emu_TCP_pingSA_sume: $$(subst _sume,.v,$$@)
	@echo "\nKiwi Compilation finished : "$^" "
#	Rename the module in the generated verilog file 'emu_*_*_sume' to 'Emu'
	@sed -i 's/'.*module.*$(subst _sume,,$@)'/module Emu/' $< 
#	Copy the Emu to the lib folder of the NetFPGA dir
	@echo "Copy $^\t\t-- "$(SUME_FOLDER)/lib/hw/std/cores/"emu_output_port_lookup_v1_0_0/hdl/Emu.v"
	@cp -fp $< $(LIB_HW_emu_opl)/hdl/Emu.v
#	Copy the correct opl to the lib folder of the NetFPGA
	@if [ $@ = "emu_reference_switch_lite_v2_sume" ]; then \
		$(call copy_OPL_to_lib,"emu_output_port_lookup_AXIS256.v"); \
		$(call set_clock_freq,200,$(DESIGN_TYPE)); \
	else	\
		$(call copy_OPL_to_lib,"emu_output_port_lookup_AXIS64.v"); \
		$(call set_clock_freq,100,$(DESIGN_TYPE)); \
	fi
#	Comment out the CAM if needed
	$(call CAM,NO)
	@echo "Update SUME IP cores library"
	@make -C $(LIB_HW_emu_opl)/


Nat: Nat.v
#	Rename the module in the generated verilog file 'out_Nat' to 'Emu'
	sed -i 's/out_Nat/Emu/' Nat.v
#	Copy the Emu to the lib folder of the NetFPGA dir
	cp -f Nat.v $(SUME_FOLDER)/lib/hw/std/cores/emu_output_port_lookup_v1_0_0/hdl/Emu.v
#	Copy the correct opl to the lib folder of the NetFPGA
	cp -f ../netfpga_src/opl_wrapper/emu_output_port_lookup_AXIS64.v $(SUME_FOLDER)/lib/hw/std/cores/emu_output_port_lookup_v1_0_0/hdl/emu_output_port_lookup.v
	make -C $(SUME_FOLDER)/lib/hw/std/cores/emu_output_port_lookup_v1_0_0/

%.v: %.dll
	$(KIWIC) $< $(KIWI_FLAGS) -vnl $@

%.dll: %.cs
	$(CSC) /target:library /r:$(KIWIDLL) $<


install_sume:
	@if [ -z $(SUME_FOLDER) ] || [ -z $(XILINX_PATH) ]; then \
		echo "**ERROR** : Source the settings from [path_to]/NetFPGA-SUME/tools/settings.sh"; \
		echo "**ERROR** : Source the settings for Xilinx toolchain"; \
		exit 0; \
	else \
		rm -rf $(LIB_HW_emu_opl); \
		rm -rf $(SUME_FOLDER)/projects/reference_emu; \
		echo "Modify $(SUME_FOLDER)/tools/settings.sh"; \
		sed -i 's/.*export NF_PROJECT_NAME=.*/export NF_PROJECT_NAME=reference_emu/' $(SUME_FOLDER)/tools/settings.sh; \
		echo "Create emu_output_port_lookup_v1_0_0 core -> $(SUME_FOLDER)/lib/hw/std/cores"; \
		cp -rf ../netfpga_src/NetFPGA-SUME/lib/emu_output_port_lookup_v1_0_0 $(SUME_FOLDER)/lib/hw/std/cores; \
		echo "Create reference_emu project -> $(SUME_FOLDER)/projects"; \
		cp -rf ../netfpga_src/NetFPGA-SUME/project/reference_emu $(SUME_FOLDER)/projects; \
		if [ "$(DESIGN_TYPE)" = "vb" ];  then \
			echo "Create [Verilog Based design, $(DESIGN_TYPE)] $(SUME_FOLDER)/projects/reference_emu/hw"; \
			echo "Create [Verilog Based design, $(DESIGN_TYPE)] $(SUME_FOLDER)/projects/reference_emu/sw"; \
			cp -Rf $(SUME_FOLDER)/projects/reference_emu/hw_vb/* $(SUME_FOLDER)/projects/reference_emu/hw/; \
			cp -Rf $(SUME_FOLDER)/projects/reference_emu/sw_vb/* $(SUME_FOLDER)/projects/reference_emu/sw/; \
		else \
			echo "Create [Blobk Design, $(DESIGN_TYPE)] $(SUME_FOLDER)/projects/reference_emu/hw"; \
			echo "Create [Block Design, $(DESIGN_TYPE)] $(SUME_FOLDER)/projects/reference_emu/sw"; \
			cp -Rf $(SUME_FOLDER)/projects/reference_emu/hw_bd/* $(SUME_FOLDER)/projects/reference_emu/hw; \
			cp -Rf $(SUME_FOLDER)/projects/reference_emu/sw_bd/* $(SUME_FOLDER)/projects/reference_emu/sw; \
		fi; \
		if ! grep -q "emu_output_port_lookup_v1_0_0" $(SUME_FOLDER)/Makefile; then \
			echo "Modify the recipe in $(SUME_FOLDER)/Makefile"; \
			sed -i '/nf_axis_converter_v1_0_0\//a\\tmake -C $$(LIB_HW_DIR)/std/cores/emu_output_port_lookup_v1_0_0/' $(SUME_FOLDER)/Makefile; \
		fi; \
		echo ""; \
		echo "INFO: source $(SUME_FOLDER)/tools/settings.sh"; \
		echo "INFO: make -C $(SUME_FOLDER)"; \
	fi



clean_kiwi:
	- rm -f *.v 
	- rm -f *.dll 
	- rm -f *.rpt 
	- rm -f *.eps 
	- rm -f *.h
	- rm -f *.cpp 
	- rm -rf obj 


clean_cml:
	- make -C $(NF_DESIGN_DIR) simclean
	- make -C $(NF_DESIGN_DIR) clean

clean_sume:
	- make -C $(NF_DESIGN_DIR) clean






