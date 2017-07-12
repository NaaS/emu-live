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
import sys, struct
import os
from scapy.layers.all import Ether, IP, TCP, DNS
from reg_defines_reference_emu import *
from memlib import * 
from memcached_pcapgen import * 


phy2loop0 = ('../connections/conn', [])
nftest_init(sim_loop = [], hw_config = [phy2loop0])


nftest_start()

cfg_set_s1={'dst-mac': 'BB:BB:BB:BB:BB:BB', 'dont-fragment': 'yes', 'protocol': 'binary', 'key': 'www.facebook.com', 'success': 'yes', 'opaque': '00110022', 'request-id': 23, 'src-mac': 'AA:AA:AA:AA:AA:AA', 'src-port': 6666, 'src-ip': '1.1.1.1', 'flags': '\xaa', 'value': '192.168.0.1', 'file': 'set_s1', 'dst-port': 11211, 'dst-ip': '2.2.2.2', 'type': 'set', 'expiration': 1}

debug_set={'dst-mac': 'DE:AD:BE:EF:DE:AD', 'src-mac': 'DA:DA:DA:DA:DA:DA','op_code':'\x00\x00', 'operand_0':'\x01', 'operand_1':'\x00', 'value':'\x00\x00\x00\x00\x00\x00\x00\x00', 'success':'yes', 'error_code':'\x00', 'operand_2':'\x00', 'operand_3':'\x00'}

pkt_num		= 10
dns_names_list	= ['www.google.com', 'www.facebook.com', 'www.cl.cam.ac.uk', 'www.londonservice.com', 'www.cambridge.co.uk', 'www.in.gr', 'www.worldwildlife.org']
ips_list	= ['192.168.0.0', '192.168.0.1', '192.168.0.2', '192.168.0.3', '192.168.0.4', '192.168.0.5', '192.168.0.6']
ips_list_dns	= [[192,168,0,0], [192,168,0,1], [192,168,0,2], [192,168,0,3], [192,168,0,4], [192,168,0,5], [192,168,0,6]]
pkts		= []
pkta		= []
rtx		= []

OP_CODE = {	'NOP'		:'\x00',\
		'READ'		:'\xAA',\
		'WRITE'		:'\xBB',\
		'COPY'		:'\xCC',\
		'INC'		:'\xDD',\
		'DEC'		:'\xEE',\
		'MOVE'		:'\xFF',\
		'EQ'		:'\xAB',\
		'LESS'		:'\xBC',\
		'WRITE_ARR'	:'\x10',\
		'READ_ARR'	:'\x20',\
		'MOVE_ARR_TO_ARR':'\x30',\
		'MOVE_ARR_TO_VAR':'\x40',\
		'MOVE_VAR_TO_ARR':'\x50',\
		'EXEC'		:'\x66' }


REG = {	'NON'		:'\x00',\
	'DNS_pkt_cnt'	:'\x01',\
	'pkt_in_cnt'	:'\x02',\
	'GPR_0'		:'\x03',\
	'GPR_1'		:'\x04',\
	'GPR_2'		:'\x05',\
	'GPR_3'		:'\x06',\
	'PC'		:'\x07' };

# ****************************************************************
# WARNING: meta length () disagrees with actual length ()
# This error will appear in the results of the simulation tests
# The logs from the simulation are correct
# Maybe there is bug in the axitools.py
# ****************************************************************

#######################################################################################
# WARNING	the sim tests will PASS but with warnings on size mismatch of the packets
# 		this is caused mainly from the scappy which translates the compresed domain names
#######################################################################################
def nf_transaction(mode):
	if(mode=='dns'):
		(request_packet, response_packet) = generateDNS(cfg_set_s1)
	else:
		(request_packet, response_packet) = generateDebug(debug_set)
	if not isHW():
		request_packet.time = (((1e-8)) + (2e-6))
		response_packet.time = (((1e-8)) + (2e-6))
	else:
		nftest_send_phy('nf0', request_packet)
		nftest_expect_phy('nf0', response_packet)
	rtx.append(request_packet)
	rtx.append(response_packet)
	pkts.append(request_packet)
	pkta.append(response_packet)

def DNS_queries(i):
	cfg_set_s1['request-id']= i;
	cfg_set_s1['key']	= dns_names_list[i]
	cfg_set_s1['value']	= ips_list_dns[i]
	nf_transaction('dns')
#######################################################################################

#######################################################################################
def pkt5_RD_WR_pkt5_RD():
	num=2

	for i in range(num):
		DNS_queries(i)

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['DNS_pkt_cnt']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', num )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	# DEBUG PACKET -- WRITE -- OP CODE
	debug_set['op_code']	= OP_CODE['WRITE']
	debug_set['operand_0']	= REG['DNS_pkt_cnt']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	for i in range(num):
		DNS_queries(i)

		## DEBUG PACKET -- READ OP CODE
		debug_set['op_code']	= OP_CODE['READ']
		debug_set['operand_0']	= REG['DNS_pkt_cnt']
		debug_set['operand_1']	= REG['NON']
		debug_set['operand_2']	= REG['NON']
		debug_set['operand_3']	= REG['NON']
		debug_set['value']	= struct.pack('>Q', i+1 )
		debug_set['success']	= 'yes'
		nf_transaction('debug')
#######################################################################################

#######################################################################################
def pkt5_CP_CPerr():
	num=5

	for i in range(num):
		DNS_queries(i)

	## DEBUG PACKET -- COPY -- OP CODE
	debug_set['op_code']	= OP_CODE['COPY']
	debug_set['operand_0']	= struct.pack('B', 0 ) # INDEX
	debug_set['operand_1']	= struct.pack('B', len('\xFF\xFF\xFF\xFF\xAA\xBB\xCC\xDD')) # Length
	debug_set['value']	= '\xFF\xFF\xFF\xFF\xAA\xBB\xCC\xDD' # Bytecode arbitary
	debug_set['success']	= 'yes'
	(request_packet, response_packet) = generateDebug(debug_set)
	nf_transaction('debug')

	## DEBUG PACKET -- COPY error out of bound index -- OP CODE
	debug_set['op_code']	= OP_CODE['COPY']
	debug_set['operand_0']	= struct.pack('B', 255) # INDEX - out of bound
	debug_set['operand_1']	= struct.pack('B', len('\xFF\xFF\xFF\xFF\xAA\xBB\xCC\xDD')) # Length
	debug_set['value']	= '\xFF\xFF\xFF\xFF\xAA\xBB\xCC\xDD' # Bytecode arbitary
	debug_set['success']	= 'no'
	nf_transaction('debug')


	## DEBUG PACKET -- COPY error out of bound length -- OP CODE
	debug_set['op_code']	= OP_CODE['COPY']
	debug_set['operand_0']	= struct.pack('B', 0) # INDEX
	debug_set['operand_1']	= struct.pack('B', 255) # Length - out of bound
	debug_set['value']	= '\xFF\xFF\xFF\xFF\xAA\xBB\xCC\xDD' # Bytecode
	debug_set['success']	= 'no'
	(request_packet, response_packet) = generateDebug(debug_set)
	nf_transaction('debug')
#######################################################################################

#######################################################################################
def pkt5_RDerr_WRerr():
	num=5
	for i in range(num):
		DNS_queries(i)

	## DEBUG PACKET -- READ error -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= '\xFF'
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 )
	debug_set['success']	= 'no'
	nf_transaction('debug')

	## DEBUG PACKET -- WRITE error -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= '\xFF'
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 )
	debug_set['success']	= 'no'
	nf_transaction('debug')
#######################################################################################

#######################################################################################
def pkt5_RD_INC_RD_DEC_RD():
	num=5
	inc=20
	dec=10
	for i in range(num):
		DNS_queries(i)

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['pkt_in_cnt']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', num )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- INC -- OP CODE
	debug_set['op_code']	= OP_CODE['INC']
	debug_set['operand_0']	= REG['pkt_in_cnt']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', inc )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['pkt_in_cnt']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', num+inc )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- DEC -- OP CODE
	debug_set['op_code']	= OP_CODE['DEC']
	debug_set['operand_0']	= REG['pkt_in_cnt']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', dec )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['pkt_in_cnt']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', num+inc-dec )
	debug_set['success']	= 'yes'
	nf_transaction('debug')


#######################################################################################

def pkt5_EQ_RD_LESS_RD():
	num=5
	for i in range(num):
		DNS_queries(i)

	## DEBUG PACKET -- EQ -- OP CODE
	debug_set['op_code']	= OP_CODE['EQ']
	debug_set['operand_0']	= REG['DNS_pkt_cnt']
	debug_set['operand_1']	= REG['pkt_in_cnt']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['GPR_0']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 1 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- LESS -- OP CODE
	debug_set['op_code']	= OP_CODE['LESS']
	debug_set['operand_0']	= REG['DNS_pkt_cnt']
	debug_set['operand_1']	= REG['pkt_in_cnt']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['GPR_0']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')
#######################################################################################


def WRARR_RDARR_WR_MOVEVAR2ARR_RDARR():
	indx=5

	# DEBUG PACKET -- WRITE -- OP CODE
	debug_set['op_code']	= OP_CODE['WRITE']
	debug_set['operand_0']	= REG['GPR_1'] # Register
	debug_set['operand_1']	= REG['NON'] 
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', indx ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- WRITE_ARR -- OP CODE
	debug_set['op_code']	= OP_CODE['WRITE_ARR']
	debug_set['operand_0']	= REG['GPR_2'] # Register - index X=0
	debug_set['operand_1']	= REG['GPR_1'] # Register - index Y=5
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 236545123265 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ_ARR -- OP CODE
	debug_set['op_code']	= OP_CODE['READ_ARR']
	debug_set['operand_0']	= REG['GPR_2'] # Register - index X=0
	debug_set['operand_1']	= REG['GPR_1'] # Register - index Y=5
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 236545123265 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- WRITE -- OP CODE
	debug_set['op_code']	= OP_CODE['WRITE']
	debug_set['operand_0']	= REG['GPR_3'] # Register
	debug_set['operand_1']	= REG['NON'] 
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 8965900 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- WRITE -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['GPR_3']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 8965900 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- INC -- OP CODE
	debug_set['op_code']	= OP_CODE['INC']
	debug_set['operand_0']	= REG['GPR_1']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 10 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['GPR_1']
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 10+indx )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- MOVE_VAR_TO_ARR -- OP CODE
	debug_set['op_code']	= OP_CODE['MOVE_VAR_TO_ARR']
	debug_set['operand_0']	= REG['GPR_3']	# Register 
	debug_set['operand_1']	= REG['GPR_2']	# Register - index X=0
	debug_set['operand_2']	= REG['GPR_1']	# Register - index Y=10+indx
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 10+indx )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ_ARR -- OP CODE
	debug_set['op_code']	= OP_CODE['READ_ARR']
	debug_set['operand_0']	= REG['GPR_2'] # Register - index X=0
	debug_set['operand_1']	= REG['GPR_1'] # Register - index Y=10+indx
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 8965900 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')
#######################################################################################


#######################################################################################
def WR_WRARR_CP_EXEC_RD():
	num=5
	i=0
	# DEBUG PACKET -- WRITE -- OP CODE
	debug_set['op_code']	= OP_CODE['WRITE']
	debug_set['operand_0']	= REG['GPR_1'] 
	debug_set['operand_1']	= REG['NON'] 
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 10 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- WRITE_ARR -- OP CODE
	debug_set['op_code']	= OP_CODE['WRITE_ARR']
	debug_set['operand_0']	= REG['GPR_0']	# Register - index X=0
	debug_set['operand_1']	= REG['GPR_1'] 	# Register - index Y=10
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 100 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- COPY -- OP CODE
	debug_set['op_code']	= OP_CODE['COPY']
	debug_set['operand_0']	= '\x00' # Literal index
        code =  OP_CODE['MOVE_ARR_TO_VAR']+REG['GPR_0']+REG['GPR_1']+REG['GPR_3']+\
		OP_CODE['DEC']+REG['GPR_3']+'\x01'+OP_CODE['NOP']
	#'\x40\x03\x04\x06\xEE\x06\x01\x00'
	debug_set['operand_1']	= struct.pack('B', len(code) )
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= code  # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- EXEC -- OP CODE
	debug_set['op_code']	= OP_CODE['EXEC']
	debug_set['operand_0']	= '\x00' # Literal index
	debug_set['operand_1']	= REG['NON'] 
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['GPR_3']	# Register - index X=0
	debug_set['operand_1']	= REG['NON'] 	# Register - index Y=10
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 99 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')
#######################################################################################


def CP_CP_EXEC_RD_pkt5_RD():
	num=1

	## DEBUG PACKET -- COPY -- OP CODE
	#  0 ~ '\xDD\x01\x01\x50\x01\x03\x04\xDD\x04\x01\x00'
        code =  OP_CODE['INC']+REG['DNS_pkt_cnt']+struct.pack('B', num )+\
		OP_CODE['MOVE_VAR_TO_ARR']+REG['DNS_pkt_cnt']+REG['GPR_0']+REG['GPR_1']+\
		OP_CODE['INC']+REG['GPR_1']+'\x01'+OP_CODE['EXEC']+'\x01'+OP_CODE['NOP']

	debug_set['op_code']	= OP_CODE['COPY']
	debug_set['operand_0']	= '\x00' # Literal index
	debug_set['operand_1']	= struct.pack('B', len(code) )
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= code  # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- COPY -- OP CODE
	# 1 ~ '\xDD\x01\x01\x50\x01\x03\x04\xDD\x04\x01\x00'
	code =  OP_CODE['MOVE_ARR_TO_VAR']+REG['GPR_0']+REG['GPR_0']+REG['GPR_2']+\
		OP_CODE['INC']+REG['GPR_2']+struct.pack('B', num )+\
		OP_CODE['EQ']+REG['GPR_2']+REG['DNS_pkt_cnt']+OP_CODE['NOP']

	debug_set['op_code']	= OP_CODE['COPY']
	debug_set['operand_0']	= '\x01' # Literal index
	debug_set['operand_1']	= struct.pack('B', len(code) )
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= code  # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- EXEC -- OP CODE
	debug_set['op_code']	= OP_CODE['EXEC']
	debug_set['operand_0']	= '\x00' # Literal index
	debug_set['operand_1']	= REG['NON']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['GPR_0']	# Register - index X=0
	debug_set['operand_1']	= REG['NON'] 	# Register - index Y=10
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	for i in range(num):
		DNS_queries(i)

	## DEBUG PACKET -- EQ -- OP CODE
	debug_set['op_code']	= OP_CODE['EQ']
	debug_set['operand_0']	= REG['DNS_pkt_cnt']
	debug_set['operand_1']	= REG['GPR_2']
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 0 )
	debug_set['success']	= 'yes'
	nf_transaction('debug')

	## DEBUG PACKET -- READ -- OP CODE
	debug_set['op_code']	= OP_CODE['READ']
	debug_set['operand_0']	= REG['GPR_0']	# Register - index X=0
	debug_set['operand_1']	= REG['NON'] 	# Register - index Y=10
	debug_set['operand_2']	= REG['NON']
	debug_set['operand_3']	= REG['NON']
	debug_set['value']	= struct.pack('>Q', 1 ) # Value
	debug_set['success']	= 'yes'
	nf_transaction('debug')
#######################################################################################






CP_CP_EXEC_RD_pkt5_RD()

#WR_WRARR_CP_EXEC_RD()

#WRARR_RDARR_WR_MOVEVAR2ARR_RDARR()

#pkt5_EQ_RD_LESS_RD()

#pkt5_RD_INC_RD_DEC_RD()

#pkt5_RDerr_WRerr()

#pkt5_CP_CPerr()

#pkt5_RD_WR_pkt5_RD()


scapy.all.wrpcap('DNS', rtx)

if not isHW():
    nftest_send_phy('nf0', pkts)
    nftest_expect_phy('nf0', pkta)



nftest_finish([])



