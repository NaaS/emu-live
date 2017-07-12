#  Building the Emu framework.
#  Nik Sultana, Cambridge University Computer Lab, July 2016
#
#  This software was developed by the University of Cambridge,
#  Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
# 
#  Use of this source code is governed by the Apache 2.0 license; see LICENSE file

include Makefile.emu
include Makefile.pax

#NOTE this Makefile is to be run from the root (Emu) directory.
MY_DIR=emu_on_pax

PaxWrap_SRC=$(MY_DIR)/Pax_Wrap.cs
PaxWrap_TGT=$(OUTPUT_DIR)/Pax_Wrap.dll

# NOTE overwriting Pax_DLL from Makefile.pax
PaxLite_DLL = $(PAX)/Bin/Pax_Lite.dll
Pax_DLL = $(PAX)/Bin/Pax.exe
PDN_DLL = $(PAX)/Bin/PacketDotNet.dll


$(PaxWrap_TGT): $(PaxWrap_SRC) $(RXTX_TGT) $(NF_TGT) $(Pax_DLL) $(PDN_DLL)
	$(CSC) $(CSC_FLAGS) /target:library /r:$(KIWIDLL) /r:$(RXTX_TGT) /r:$(NF_TGT) /r:$(PaxLite_DLL) /r:$(Pax_DLL) /r:$(PDN_DLL) -o $@ $<

out/%.dll: $(MY_DIR)/%.cs $(EMU_TARGETS) $(APP_MID_TARGETS) $(RXTX_TGT) $(NF_TGT) $(Pax_DLL) $(PDN_DLL) $(PaxWrap_TGT)
	command time $(CSC) $(CSC_FLAGS) /target:library $(patsubst %, /r:%, $(EMU_TARGETS)) $(patsubst %, /r:%, $(APP_MID_TARGETS)) /r:$(RXTX_TGT) /r:$(NF_TGT) /r:$(PaxLite_DLL) /r:$(Pax_DLL) /r:$(PDN_DLL) /r:$(PaxWrap_TGT) -o $@ $<
