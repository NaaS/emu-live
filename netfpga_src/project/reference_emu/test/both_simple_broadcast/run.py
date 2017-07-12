#!/usr/bin/env python

#
# Copyright (c) 2015 University of Cambridge
# Copyright (c) 2015 Neelakandan Manihatty Bojan, Georgina Kalogeridou
# All rights reserved.
#
# This software was developed by Stanford University and the University of Cambridge Computer Laboratory 
# under National Science Foundation under Grant No. CNS-0855268,
# the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
# by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
# as part of the DARPA MRC research programme.
#
# Use of this source code is governed by the Apache 2.0 license; see LICENSE file
#
# Author:
#        Modified by Neelakandan Manihatty Bojan, Georgina Kalogeridou

import logging
logging.getLogger("scapy.runtime").setLevel(logging.ERROR)

from NFTest import *
import sys
import os
from scapy.layers.all import Ether, IP, TCP
from reg_defines_reference_emu import *

phy2loop0 = ('../connections/conn2', [])
nftest_init(sim_loop = [], hw_config = [phy2loop0])

if isHW():
   # reset_counters (triggered by Write only event) for all the modules 
   nftest_regwrite(SUME_INPUT_ARBITER_0_RESET(), 0x1)
   nftest_regwrite(SUME_OUTPUT_PORT_LOOKUP_0_RESET(), 0x101)
   nftest_regwrite(SUME_OUTPUT_QUEUES_0_RESET(), 0x1)
   nftest_regwrite(SUME_NF_10G_INTERFACE_SHARED_0_RESET(), 0x1)
   nftest_regwrite(SUME_NF_10G_INTERFACE_1_RESET(), 0x1)
   nftest_regwrite(SUME_NF_10G_INTERFACE_2_RESET(), 0x1)
   nftest_regwrite(SUME_NF_10G_INTERFACE_3_RESET(), 0x1)
   nftest_regwrite(SUME_NF_RIFFA_DMA_0_RESET(), 0x1)

   # Reset the switch table lookup counters (value is reset every time is read)
#   nftest_regread(SUME_OUTPUT_PORT_LOOKUP_0_LUTHIT())
#   nftest_regread(SUME_OUTPUT_PORT_LOOKUP_0_LUTMISS())

nftest_start()


routerMAC = []
routerIP = []
for i in range(4):
    routerMAC.append("00:ca:fe:00:00:0%d"%(i+1))
    routerIP.append("192.168.%s.40"%i)

num_broadcast = 20

pkts = []
for i in range(num_broadcast):
    pkt = make_IP_pkt(src_MAC="aa:bb:cc:dd:ee:ff", dst_MAC=routerMAC[0],
                      EtherType=0x800, src_IP="192.168.0.1",
                      dst_IP="192.168.1.1", pkt_len=60)

    pkt.time = ((i*(1e-8)) + (1e-6))
    pkts.append(pkt)
    if isHW():
        nftest_expect_phy('nf1', pkt)
        nftest_send_phy('nf0', pkt)
    
if not isHW():
    nftest_send_phy('nf0', pkts)
    nftest_expect_phy('nf1', pkts)
    nftest_expect_phy('nf2', pkts)
    nftest_expect_phy('nf3', pkts)

nftest_barrier()

#if isHW():
#    # Expecting the LUT_MISS counter to be incremented by 0x14, 20 packets
#    rres1=nftest_regread_expect(SUME_OUTPUT_PORT_LOOKUP_0_LUTMISS(), num_broadcast)
#    rres2=nftest_regread_expect(SUME_OUTPUT_PORT_LOOKUP_0_LUTHIT(), 0)
#    mres=[rres1,rres2]
#else:
#    nftest_regread_expect(SUME_OUTPUT_PORT_LOOKUP_0_LUTMISS(), num_broadcast) # lut_miss
#    nftest_regread_expect(SUME_OUTPUT_PORT_LOOKUP_0_LUTHIT(), 0) # lut_hit
mres=[]

nftest_finish(mres)




