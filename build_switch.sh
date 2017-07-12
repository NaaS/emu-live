#!/bin/bash
# Build the Reference_Switch_Lite to run it on a host.
# Nik Sultana, Cambridge University Computer Lab, July 2016

export CSC_FLAGS=-define:ON_HOST
make out/Reference_Switch_Lite.dll
make -f emu_on_pax/Makefile out/Wrapped_Switch.dll
