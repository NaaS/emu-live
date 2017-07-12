#  Building the Emu framework.
#  Nik Sultana, Cambridge University Computer Lab, July 2016
#
#  This software was developed by the University of Cambridge,
#  Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
#
#  Use of this source code is governed by the Apache 2.0 license; see LICENSE file

include Makefile.emu

out/Nat.dll: $(EMU_TARGETS) Nat/*.cs Nat/EmuUtil/*.cs Nat/Nat.sln Nat/Nat.csproj Nat/EmuUtil/EmuUtil.csproj
	xbuild /p:Configuration=Kiwi Nat/Nat.sln
	cp Nat/bin/Kiwi/Nat.dll out/
	cp Nat/bin/Kiwi/EmuUtil.dll out/

out/%.dll: %.cs $(EMU_TARGETS)
	time $(CSC) $(CSC_FLAGS) /target:library $(patsubst %, /r:%, $(EMU_TARGETS)) /r:$(KIWIDLL) -o $@ $<

out/Nat.v: out/Nat.dll $(EMU_TARGETS)
	time $(KIWIC) $^ out/EmuUtil.dll -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl $@
	fsharpi Nat/PostKiwiTransform.fsx -- out/Nat.v
	mv out/Nat.v out/Nat.v.orig
	mv out/Nat.v.out out/Nat.v

# NOTE There appears to be a bug in Kiwi where irrelevant code isn't ignored,
#      but rather it influences the wires that appear in the resulting module.
#      I restrict the files provided to the Kiwi compiler to manually eliminate
#      dead code somewhat.
#      In an ideal world I'd use $(EMU_TARGETS) rather than $(REDUCED_TARGETS).
REDUCED_TARGETS=$(EMU_TGT) $(RXTX_TGT) $(NF_TGT) $(P_TGT)

out/%.v: out/%.dll $(EMU_TARGETS)
	command time $(KIWIC) $< $(REDUCED_TARGETS) -bevelab-default-pause-mode=hard -vnl-resets=synchronous -vnl-roundtrip=disable -res2-loadstore-port-count=0 -restructure2=disable -conerefine=disable -vnl $@
