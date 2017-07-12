#!/usr/bin/env python
#
#
# Copyright (C) 2017 Salvator Galea <salvator.galea@cl.cam.ac.uk>
# All rights reserved.
#
# This software was developed by Stanford University and the University of Cambridge Computer Laboratory 
# under National Science Foundation under Grant No. CNS-0855268,
# the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
# by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
# as part of the DARPA MRC research programme.
#
# @NETFPGA_LICENSE_HEADER_START@
#
# Licensed to NetFPGA C.I.C. (NetFPGA) under one or more contributor
# license agreements.  See the NOTICE file distributed with this work for
# additional information regarding copyright ownership.  NetFPGA licenses this
# file to you under the NetFPGA Hardware-Software License, Version 1.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at:
#
#   http://www.netfpga-cic.org
#
# Unless required by applicable law or agreed to in writing, Work distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
#
# @NETFPGA_LICENSE_HEADER_END@
#

import logging
logging.getLogger("scapy.runtime").setLevel(logging.ERROR)

from NFTest import *
import sys
import os
from scapy.layers.all import Ether, IP, TCP
from reg_defines_reference_emu import *
from memlib import * 
from memcached_pcapgen import * 

phy2loop0 = ('../connections/conn', [])
nftest_init(sim_loop = [], hw_config = [phy2loop0])


nftest_start()

cfg_set_s1={'dst-mac': 'BB:BB:BB:BB:BB:BB', 'dont-fragment': 'yes', 'request-id': 23, 'src-mac': 'AA:AA:AA:AA:AA:AA', 'src-port': 6666, 'src-ip': '1.1.1.1', 'playload': '\xaa', 'dst-port': 11211, 'dst-ip': '2.2.2.2', 'size': 10}

pkt_num	= 10
pkts	= []
pkta	= []
rtx	= []

for i in range(pkt_num):
	cfg_set_s1['playload'] = "%x" % (ord('a')+i)
	(request_packet, response_packet) = generateICMP(cfg_set_s1)
	if not isHW():
		request_packet.time = ((i*(1e-8)) + (2e-6))
		response_packet.time = ((i*(1e-8)) + (2e-6))
	rtx.append(request_packet)
	rtx.append(response_packet)
	pkts.append(request_packet)
	pkta.append(response_packet)
	if isHW():
		nftest_send_phy('nf0', request_packet)
		nftest_expect_phy('nf0', response_packet)

scapy.all.wrpcap('ICMP_ECHO.pcap', rtx)

if not isHW():
    nftest_send_phy('nf0', pkts)
    nftest_expect_phy('nf0', pkta)

nftest_barrier()

nftest_finish([])



