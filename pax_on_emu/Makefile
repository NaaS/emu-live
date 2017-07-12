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
MY_DIR=pax_on_emu

PaxEmu_SRC=$(MY_DIR)/PaxEmu.cs
PaxEmu_TGT=$(OUTPUT_DIR)/PaxEmu.dll

$(PaxEmu_TGT): $(PaxEmu_SRC) $(RXTX_TGT) $(Pax_DLL)
	$(CSC) $(CSC_FLAGS) /target:library /r:$(KIWIDLL) /r:$(RXTX_TGT) /r:$(NF_TGT) $(patsubst %, /r:%, $(Pax_LIB)) -o $@ $<


# Modify some variables, since we want to include Pax.

#EMU_SOURCES += $(PaxEmu_SRC) # NOTE do NOT update EMU_SOURCES since its dependencies are calculated lazily, thus resulting in EMU_TARGETS containing (almost) duplicate elements, resulting in incorrect parameters being passed to the compiler.
EMU_TARGETS += $(PaxEmu_TGT)
NEW_APP_SOURCES += PaxEmu_Test.cs
APP_SOURCES += $(patsubst %, $(MY_DIR)/%, $(NEW_APP_SOURCES))
APP_TARGETS += $(patsubst %, $(OUTPUT_DIR)/%, $(NEW_APP_SOURCES:.cs=.v))
APP_MID_TARGETS += $(patsubst %, $(OUTPUT_DIR)/%, $(NEW_APP_SOURCES:.cs=.dll))

# Rather than overwriting rules (since it seems Make doesn't allow us to) we
# ensure that these rules don't overlap with those in the inclusions above.

out/%.dll: $(MY_DIR)/%.cs $(EMU_TARGETS)
	command time $(CSC) $(CSC_FLAGS) /target:library $(patsubst %, /r:%, $(EMU_TARGETS)) /r:$(KIWIDLL) $(patsubst %, /r:%, $(Pax_LIB)) -o $@ $<

# NOTE There appears to be a bug in Kiwi where irrelevant code isn't ignored,
#      but rather it influences the wires that appear in the resulting module.
#      I restrict the files provided to the Kiwi compiler to manually eliminate
#      dead code somewhat.
#      In an ideal world I'd use $(EMU_TARGETS) rather than $(REDUCED_TARGETS).
REDUCED_TARGETS=$(EMU_TGT) $(RXTX_TGT) $(NF_TGT) $(P_TGT) $(PaxEmu_TGT)

out/%.v: out/%.dll $(EMU_TARGETS)
	command time $(KIWIC) $< $(REDUCED_TARGETS) $(Pax_LIB) -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl $@
