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
import random
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

cfg_set_s1={'dst-mac': 'BB:BB:BB:BB:BB:BB', 'dont-fragment': 'yes', 'protocol': 'binary', 'key': 'Test_1', 'success': 'yes', 'opaque': '00110022', 'request-id': 23, 'src-mac': 'AA:AA:AA:AA:AA:AA', 'src-port': 6666, 'src-ip': '192.168.100.100', 'flags': '\xaa', 'value': 'TestVal1', 'file': 'set_s1', 'dst-port': 7777, 'dst-ip': '192.168.100.1', 'type': 'set', 'expiration': 1, 'seqr':0, 'seqp':0, 'ack':0}

pkt_num	= 50
pkts	= []
pkta	= []
rtx	= []
cnt	= 100

cfg_set_s1['expiration']	= 20

for i in range(pkt_num):
	cfg_set_s1['flags']	= '\xaa'
	cfg_set_s1['dst-port']	= 7777+cnt
	cfg_set_s1['seqr']	= cnt+100000000
	cfg_set_s1['seqp']	= cnt
	# Use this function if you are using the emu_TCP_ping with RST-ACK response
	(request_packet, response_packet) = generateTCP_pingRA(cfg_set_s1)
	# Use this function if you are using the emu_TCP_ping with SYN-ACK response
	#(request_packet, response_packet) = generateTCP_pingSA(cfg_set_s1)
	if not isHW():
		request_packet.time	= ((i*(1e-8)) + (2e-6))
		response_packet.time	= ((i*(1e-8)) + (2e-6))
	else:
		nftest_send_phy('nf0', request_packet)
		nftest_expect_phy('nf0', response_packet)
	rtx.append(request_packet)
	rtx.append(response_packet)
	pkts.append(request_packet)
	pkta.append(response_packet)

	cnt = cnt + 1


scapy.all.wrpcap('TCP_RA_ECHO.pcap', rtx)

if not isHW():
    nftest_send_phy('nf0', pkts)
    nftest_expect_phy('nf0', pkta)


nftest_finish([])



