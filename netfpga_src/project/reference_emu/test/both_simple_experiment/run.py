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


# routerMAC = []
# routerIP = []
# for i in range(4):
#     routerMAC.append("00:ca:fe:00:00:0%d"%(i+1))
#     routerIP.append("192.168.%s.40"%i)


sentPkts_nf0 = []
sentPkts_nf1 = []
expectedPkts_nf0 = []
expectedPkts_nf1 = []
# pkt = make_IP_pkt(src_MAC="aa:bb:cc:dd:ee:ff", dst_MAC="00:ca:fe:00:00:01",
#                   EtherType=0x800, src_IP="192.168.0.1",
#                   dst_IP="192.168.1.1", pkt_len=60)
nf0_mac = "12:22:33:44:55:66"
nf1_mac = "22:22:33:44:55:66"
in_mac = "b2:b2:c3:d4:e5:f6"
out_mac = "a2:b2:c3:d4:e5:f6"
in_ip = "192.168.1.1"
out_ip = "10.0.0.4"
nf0_ip = "10.0.0.1"

# Syn packet from inside
#################################
pkt = make_MAC_hdr(src_MAC=in_mac, dst_MAC=nf1_mac, EtherType=0x800)/\
      make_IP_hdr(src_IP=in_ip, dst_IP=out_ip)/\
      TCP(sport=0x3333,dport=0x0050,flags="S")
pkt.time = ((1*(1e-8)) + (1e-6))
sentPkts_nf1.append(pkt)
ePkt = pkt.copy()
ePkt[Ether].src = nf0_mac
ePkt[Ether].dst = out_mac
ePkt[IP].src = nf0_ip
ePkt[TCP].sport = 1025
#ePkt = make_MAC_hdr(src_MAC=nf0_mac, dst_MAC=out_mac,
#                  EtherType=0x800)/make_IP_hdr(src_IP=nf0_ip,
#                  dst_IP=out_ip)/\
#                 TCP(sport=1025,dport=0x0050,flags="S")
expectedPkts_nf0.append(ePkt)
if isHW():
    nftest_expect_phy('nf0', ePkt)
    nftest_send_phy('nf1', pkt)

# Syn+Ack reply from outside
###################################
pkt = make_MAC_hdr(src_MAC=out_mac, dst_MAC=nf0_mac, EtherType=0x800)/\
      make_IP_hdr(src_IP=out_ip, dst_IP=nf0_ip)/\
      TCP(sport=0x0050,dport=1025,flags="SA")
pkt.time = ((2*(1e-8)) + (1e-6))
sentPkts_nf0.append(pkt)
ePkt = pkt.copy()
ePkt[Ether].src = nf1_mac
ePkt[Ether].dst = in_mac
ePkt[IP].dst = in_ip
ePkt[TCP].dport = 0x3333
expectedPkts_nf1.append(ePkt)
if isHW():
    nftest_expect_phy('nf1', ePkt)
    nftest_send_phy('nf0', pkt)

# Ack reply from inside
#################################
pkt = make_MAC_hdr(src_MAC=in_mac, dst_MAC=nf1_mac, EtherType=0x800)/\
      make_IP_hdr(src_IP=in_ip, dst_IP=out_ip)/\
      TCP(sport=0x3333,dport=0x0050,flags="A")
pkt.time = ((3*(1e-8)) + (1e-6))
sentPkts_nf1.append(pkt)
ePkt = pkt.copy()
ePkt[Ether].src = nf0_mac
ePkt[Ether].dst = out_mac
ePkt[IP].src = nf0_ip
ePkt[TCP].sport = 1025
expectedPkts_nf0.append(ePkt)
if isHW():
    nftest_expect_phy('nf0', ePkt)
    nftest_send_phy('nf1', pkt)

# Data from inside
#################################
payload = "Peter piper picked a peck of pickled peppers"
pkt = make_MAC_hdr(src_MAC=in_mac, dst_MAC=nf1_mac, EtherType=0x800)/\
      make_IP_hdr(src_IP=in_ip, dst_IP=out_ip)/\
      TCP(sport=0x3333,dport=0x0050,flags="")/payload
pkt.time = ((4*(1e-8)) + (1e-6))
sentPkts_nf1.append(pkt)
ePkt = pkt.copy()
ePkt[Ether].src = nf0_mac
ePkt[Ether].dst = out_mac
ePkt[IP].src = nf0_ip
ePkt[TCP].sport = 1025
expectedPkts_nf0.append(ePkt)
if isHW():
    nftest_expect_phy('nf0', ePkt)
    nftest_send_phy('nf1', pkt)

# Reply with data from outside
###################################
payload = "A peck of pickled peppers Peter Piper picked"
pkt = make_MAC_hdr(src_MAC=out_mac, dst_MAC=nf0_mac, EtherType=0x800)/\
      make_IP_hdr(src_IP=out_ip, dst_IP=nf0_ip)/\
      TCP(sport=0x0050,dport=1025,flags="A")/payload
pkt.time = ((5*(1e-8)) + (1e-6))
sentPkts_nf0.append(pkt)
ePkt = pkt.copy()
ePkt[Ether].src = nf1_mac
ePkt[Ether].dst = in_mac
ePkt[IP].dst = in_ip
ePkt[TCP].dport = 0x3333
expectedPkts_nf1.append(ePkt)
if isHW():
    nftest_expect_phy('nf1', ePkt)
    nftest_send_phy('nf0', pkt)

# Fin shutdown from inside
#################################
pkt = make_MAC_hdr(src_MAC=in_mac, dst_MAC=nf1_mac, EtherType=0x800)/\
      make_IP_hdr(src_IP=in_ip, dst_IP=out_ip)/\
      TCP(sport=0x3333,dport=0x0050,flags="FA")
pkt.time = ((6*(1e-8)) + (1e-6))
sentPkts_nf1.append(pkt)
ePkt = pkt.copy()
ePkt[Ether].src = nf0_mac
ePkt[Ether].dst = out_mac
ePkt[IP].src = nf0_ip
ePkt[TCP].sport = 1025
expectedPkts_nf0.append(ePkt)
if isHW():
    nftest_expect_phy('nf0', ePkt)
    nftest_send_phy('nf1', pkt)

# Fin+Ack from outside
###################################
pkt = make_MAC_hdr(src_MAC=out_mac, dst_MAC=nf0_mac, EtherType=0x800)/\
      make_IP_hdr(src_IP=out_ip, dst_IP=nf0_ip)/\
      TCP(sport=0x0050,dport=1025,flags="FA")
pkt.time = ((7*(1e-8)) + (1e-6))
sentPkts_nf0.append(pkt)
ePkt = pkt.copy()
ePkt[Ether].src = nf1_mac
ePkt[Ether].dst = in_mac
ePkt[IP].dst = in_ip
ePkt[TCP].dport = 0x3333
expectedPkts_nf1.append(ePkt)
if isHW():
    nftest_expect_phy('nf1', ePkt)
    nftest_send_phy('nf0', pkt)

# Ack from inside
#################################
pkt = make_MAC_hdr(src_MAC=in_mac, dst_MAC=nf1_mac, EtherType=0x800)/\
      make_IP_hdr(src_IP=in_ip, dst_IP=out_ip)/\
      TCP(sport=0x3333,dport=0x0050,flags="A")
pkt.time = ((8*(1e-8)) + (1e-6))
sentPkts_nf1.append(pkt)
ePkt = pkt.copy()
ePkt[Ether].src = nf0_mac
ePkt[Ether].dst = out_mac
ePkt[IP].src = nf0_ip
ePkt[TCP].sport = 1025
expectedPkts_nf0.append(ePkt)
if isHW():
    nftest_expect_phy('nf0', ePkt)
    nftest_send_phy('nf1', pkt)


if not isHW():
    nftest_send_phy('nf0', sentPkts_nf0)
    nftest_send_phy('nf1', sentPkts_nf1)
    nftest_expect_phy('nf0', expectedPkts_nf0)
    nftest_expect_phy('nf1', expectedPkts_nf1)

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




