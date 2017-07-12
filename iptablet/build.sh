#!/bin/bash
#
#Build script for iptablet
#Nik Sultana, Cambridge University Computer Lab
#This software was developed by the University of Cambridge,
#Computer Laboratory under EPSRC NaaS Project EP/K034723/1 
#
#Use of this source code is governed by the Apache 2.0 license; see LICENSE file

DEFAULT_TARGET=iptablet.byte

if [ -z $1 ]
then
  TARGET=${DEFAULT_TARGET}
else
  TARGET="${1}"
fi

echo "building ${TARGET}"

# NOTE could add -dont-catch-errors to have exceptions pass through catches.
ocamlbuild -cflag -g -lflag -g -tag thread -use-ocamlfind -use-menhir \
  -package dynlink \
  -package str \
  -package getopt \
  -package ipaddr \
  -no-hygiene \
  ${TARGET}
