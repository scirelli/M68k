SHELL=bash

FILE:=gamehut
WORKDIR:=$(shell pwd)
WIN_BASE:=C:\users\root\My Documents\project

ASM68k=docker run --rm -t -v $(WORKDIR):/tmp scirelli/asm68k:latest

GENS_KMOD=docker run --rm -t --volume $(WORKDIR):/root/project scirelli/gens_kmod:latest

emu: $(WORKDIR)/bin/${FILE}.bin
	$(GENS_KMOD) "${WIN_BASE}\bin\${FILE}.bin"

#p    Produce pure binary output file
#i    Show an information window while assembling. Only compatible with pure 16-bit MSDOS.
#w    Write all equates to the listing file.
#v+   Write local labels to symbol file
#os+  Short branch optimisation
#op+  PC relative optimisation
#ow+  Print warnings
#oz+  Zero offset optimisation
#oaq+ Addq optimisation
#osq+ Subq optimisation
#omq+ Moveq optimisation
#ow+  Absolute word addressing optimisation
${FILE}.bin: ${FILE}.s
	$(ASM68k) /p /i /w /ov+ /oos+ /oop+ /oow+ /ooz+ /ooaq+ /oosq+ /oomq+ /ow+ ${FILE}.s,${FILE}.bin,${FILE}.sym

debug: ./${FILE}.s
	@cd src && \
	$(ASM68k) /i /w /ov+ /oos+ /oop+ /oow+ /ooz+ /ooaq+ /oosq+ /oomq+ /ow+ ${FILE}.s,${FILE}.db.bin,${FILE}.db

debugMame: debug
	@mame genesis -debug -cart ${FILE}.db.bin

all: ${FILE}

clean:
	rm ./bin/*
