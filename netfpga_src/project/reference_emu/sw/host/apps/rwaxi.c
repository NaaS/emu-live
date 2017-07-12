/*
 *
 * Copyright (c) 2015 Bjoern A. Zeeb
 * All rights reserved.
 *
 *  File:
 *        rwaxi.c
 *
 * $Id: rwaxi.c,v 1.3 2015/06/24 22:52:20 root Exp root $
 *
 * Author:
 *        Bjoern A. Zeeb
 *
 * This software was developed by Stanford University and the University of Cambridge Computer Laboratory 
 * under National Science Foundation under Grant No. CNS-0855268,
 * the University of Cambridge Computer Laboratory under EPSRC INTERNET Project EP/H040536/1 and
 * by the University of Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-11-C-0249 ("MRC2"), 
 * as part of the DARPA MRC research programme.
 *
 * Use of this source code is governed by the Apache 2.0 license; see LICENSE file
 *
*/

#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <net/if.h>

#include <err.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "nf_sume.h"

#define	SUME_DEFAULT_TEST_ADDR		0x44020000

#define	HAVE_ADDR			0x01
#define	HAVE_VALUE			0x02
#define	HAVE_IFACE			0x04

static void
usage(const char *progname)
{

	printf("Usage: %s -a <addr> [-w <value>] [-i <iface>]\n",
	    progname);
	_exit(1);
}

int
main(int argc, char *argv[])
{
	char *ifnam;
	struct sume_ifreq sifr;
	struct ifreq ifr;
	size_t ifnamlen;
	unsigned long l;
	uint32_t addr, value;
	int fd, flags, rc;

	flags = 0x00;
	addr = SUME_DEFAULT_TEST_ADDR;
	ifnam = SUME_IFNAM_DEFAULT;
	value = 0;
	while ((rc = getopt(argc, argv, "+a:hi:w:")) != -1) {
		switch (rc) {
		case 'a':
			l = strtoul(optarg, NULL, 0);
			if (l == ULONG_MAX || l > UINT32_MAX)
				errx(1, "Invalid address");
			addr = (uint32_t)l;
			flags |= HAVE_ADDR;
			break;
		case 'i':
			ifnam = optarg;
			flags |= HAVE_IFACE;
			break;
		case 'w':
			l = strtoul(optarg, NULL, 0);
			if (l == ULONG_MAX || l > UINT32_MAX)
				errx(1, "Invalid value");
			value = (uint32_t)l;
			flags |= HAVE_VALUE;
			break;
		case 'h':
		case '?':
		default:
			usage(argv[0]);
			/* NOT REACHED */
		}
	}

	ifnamlen = strlen(ifnam);
#if 0
	if ((flags & HAVE_IFACE) == 0)
		fprintf(stderr, "WARNING: using default interface %s\n", ifnam);
#endif
	if ((flags & HAVE_ADDR) == 0)
		fprintf(stderr, "WARNING: using default test address 0x%08x\n",
		    addr);

	fd = socket(AF_INET6, SOCK_DGRAM, 0);
	if (fd == -1) {
		fd = socket(AF_INET, SOCK_DGRAM, 0);
		if (fd == -1)
			err(1, "socket failed for AF_INET6 and AF_INET");
	}

	memset(&sifr, 0, sizeof(sifr));
	sifr.addr = addr;
	if ((flags & HAVE_VALUE) != 0)
		sifr.val = value;

	memset(&ifr, 0, sizeof(ifr));
	if (ifnamlen >= sizeof(ifr.ifr_name))
		errx(1, "Interface name too long");
	memcpy(ifr.ifr_name, ifnam, ifnamlen);
	ifr.ifr_name[ifnamlen] = '\0';
	ifr.ifr_data = (char *)&sifr;
	
	rc = ioctl(fd, SUME_IOCTL_CMD_READ_REG, &ifr);
	if (rc == -1)
		err(1, "ioctl");
	
	close(fd);

	if ((flags & HAVE_VALUE) != 0)
		printf("WROTE 0x%08x = 0x%04x\n", sifr.addr, sifr.val);
	else
		printf("READ 0x%08x = 0x%04x\n", sifr.addr, sifr.val);

	return (0);
}

/* end */
