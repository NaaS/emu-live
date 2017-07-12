#!/bin/bash
# Run the Reference_Switch_Lite on a host.
# Copyright (C) Nik Sultana, Cambridge University Computer Lab, July 2016
#
# This software was developed by the University of Cambridge,
# Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
#
# Use of this source code is governed by the Apache 2.0 license; see LICENSE file
#
# PAX: path to Pax repo
# HPRLS: path to Kiwi's repo
# EMU: path to Emu repo

cd ${PAX}
sudo \
MONO_PATH=${MONO_PATH}:${EMU}/out/:${HPRLS}/kiwipro/kiwic/distro/support/ \
mono Bin/Pax.exe examples/tallyer_wiring.json \
${EMU}/out/Wrapped_Switch.dll
cd -
