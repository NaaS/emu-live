#
#	Copyright 2017	Salvator Galea	<salvator.galea@cl.cam.ac.uk>
#
#	This software was developed by the University of Cambridge,
#	Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
#
#	Use of this source code is governed by the Apache 2.0 license; see LICENSE file
#
#
#	Recipies for the NetFPGA-1G-CML platform
#

############################################
# Targets for:
#		- emu_memcached_binary_cml
#		- emu_memcached_ascii_cml
############################################
emu_memcached_binary_cml emu_memcached_ascii_cml: $$(subst _cml,.v,$$@)
	@echo "Compilation "$^" finished"
	@echo "Renaming module: "$(subst _cml,,$@)" to Emu"
#	Rename the module in the generated verilog file 'emu_Memcached' to 'Emu'
	sed -i 's/'$(subst _sume,,$@)'/Emu/' $< 
#	Copy the Emu to the lib folder of the NetFPGA dir
	@echo "Copying "$^" to emu_output_port_lookup_v1_0_0 folder as Emu.v"
	cp -f $< $(NF_ROOT)/lib/hw/std/pcores/nf10_emu_output_port_lookup_v1_00_a/hdl/verilog/Emu.v
#	Copy the correct opl to the lib folder of the NetFPGA
	@echo "Copying nf10_emu_output_port_lookup.v to nf10_emu_output_port_lookup_v1_00_a folder"
	cp -f ../netfpga_src/NetFPGA-1G-CML/opl_wrapper/nf10_emu_output_port_lookup_AXIS64_CAM.v $(NF_ROOT)/lib/hw/std/pcores/nf10_emu_output_port_lookup_v1_00_a/hdl/verilog/nf10_emu_output_port_lookup.v
#	Modify the .pao file in order to include the CAM IP core 
	@echo "Modify the .pao file to include the CAM IP core"
	sed -i 's/#lib nf10_emu_output_port_lookup_v1_00_a cam.v/lib nf10_emu_output_port_lookup_v1_00_a cam.v/' $(NF_ROOT)/lib/hw/std/pcores/nf10_emu_output_port_lookup_v1_00_a/data/nf10_emu_output_port_lookup_v2_1_0.pao
	cp -f ../netfpga_src/NetFPGA-1G-CML/opl_wrapper/nf10_emu_output_port_lookup_v2_1_0.bbd $(NF_ROOT)/lib/hw/std/pcores/nf10_emu_output_port_lookup_v1_00_a/data/


################################################
# Targets for:
#		- emu_reference_switch_lite_cml
################################################
emu_reference_switch_lite_cml: $$(subst _cml,.v,$$@)
#TODO put here the code for emu_ICMP_echo_cml
#	Rename the module in the generated verilog file 'emu_reference_switch_lite' to 'Emu'
	sed -i 's/'$(subst _sume,,$@)'/Emu/' $< 
#	Copy the Emu to the lib folder of the NetFPGA dir
	cp -f $< $(NF_ROOT)/lib/hw/std/pcores/nf10_emu_output_port_lookup_v1_00_a/hdl/verilog/Emu.v
#	Copy the correct opl to the lib folder of the NetFPGA
	cp -f ../netfpga_src/NetFPGA-1G-CML/opl_wrapper/nf10_emu_output_port_lookup_AXIS64.v $(NF_ROOT)/lib/hw/std/pcores/nf10_emu_output_port_lookup_v1_00_a/hdl/verilog/nf10_emu_output_port_lookup.v


################################################
# Targets for:
#		- install_cml
################################################
install_cml:
	@if [ -z $(NF_ROOT) ] || [ -z $(XILINX) ]; then \
		echo "**ERROR** : Source the settings from [path_to]/NetFPGA-1G-CML-live/bashrc_addon_NetFPGA_10G"; \
		echo "**ERROR** : Source the settings for Xilinx toolchain"; \
		exit 0; \
	else \
		rm -rf $(NF_ROOT)/lib/hw/std/pcores/nf10_emu_output_port_lookup_v1_00_a; \
		rm -rf $(NF_ROOT)/projects/reference_emu_nf1_cml; \
		echo "Modifying $(NF_ROOT)/bashrc_addon_NetFPGA_10G"; \
		sed -i 's/reference_nic/reference_emu_nf1_cml/' $(NF_ROOT)/bashrc_addon_NetFPGA_10G; \
		echo "Create nf10_emu_output_port_lookup_v1_00_a/ -> $(NF_ROOT)/lib/hw/std/pcores"; \
		cp -rf ../netfpga_src/NetFPGA-1G-CML/lib/nf10_emu_output_port_lookup_v1_00_a $(NF_ROOT)/lib/hw/std/pcores; \
		echo "Create reference_emu_nf1_cml/ -> $(NF_ROOT)/projects"; \
		cp -rf ../netfpga_src/NetFPGA-1G-CML/project/reference_emu_nf1_cml/ $(NF_ROOT)/projects/; \
		echo "Modifying the recipe in $(NF_ROOT)/Makefile"; \
		cp -rf ../netfpga_src/NetFPGA-1G-CML/NetFPGA-1G-CML-Makefile $(NF_ROOT)/Makefile; \
	fi


