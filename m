Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AA6C433E6
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Jan 2021 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A832251E
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Jan 2021 22:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhADWWK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Jan 2021 17:22:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhADWWK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jan 2021 17:22:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MIsNA129842;
        Mon, 4 Jan 2021 22:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lLhYFDkoh9MAL5GO+JA0SGKLK66Y27QX7jqqUOgMEfM=;
 b=OcWDwIilQPV8tdnTV2TpbIrToHt+VvTQs4+OEcwrYGKu7iKMldxYiZW1870XIc0nuIIN
 ALjbkR3D98+IjapQwt0WbUYz3JuprJlTycr50mI/eGFvm+P9Zr0lhFNPk9nZb7cB/XX6
 P5Aq4fudhIq+EO6IPClrDOP6AWD9/PLEO1bYgOY+prqUrXiCcWR5O3CDv1Lx4R8Kd1Cd
 SYL2Be28GTWEVH0pDJBSCYYOv7R9c8jggNU9QZbdmgKQXNhk94iOi06xAWeDbkNVo0w3
 iwR/q8syuhM2x8uDAkGsU36gz+BTnBFp6+azPdbnNMuPVcXNYh9KVPGxcyovcvZr7z/g qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35tgskpecn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 22:21:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MLIxW109759;
        Mon, 4 Jan 2021 22:21:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 35v2axucex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 22:21:19 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104MLD7U030106;
        Mon, 4 Jan 2021 22:21:13 GMT
Received: from localhost (/10.159.152.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 14:21:12 -0800
Date:   Mon, 4 Jan 2021 14:21:11 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     eguan@linux.alibaba.com, fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/2] src/dmiperf: Remove obsolete dmiperf
Message-ID: <20210104222111.GD6919@magnolia>
References: <20201209050816.1240404-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209050816.1240404-1-yangx.jy@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040133
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 09, 2020 at 01:08:15PM +0800, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Looks fine to me...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  .gitignore    |   1 -
>  src/Makefile  |   2 +-
>  src/dmiperf.c | 275 --------------------------------------------------
>  3 files changed, 1 insertion(+), 277 deletions(-)
>  delete mode 100644 src/dmiperf.c
> 
> diff --git a/.gitignore b/.gitignore
> index 041cc2d9..f988a44a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -66,7 +66,6 @@
>  /src/dirhash_collide
>  /src/dirperf
>  /src/dirstress
> -/src/dmiperf
>  /src/e4compact
>  /src/fault
>  /src/feature
> diff --git a/src/Makefile b/src/Makefile
> index 32940142..80f7b892 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -11,7 +11,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	mmapcat append_reader append_writer dirperf metaperf \
>  	devzero feature alloc fault fstest t_access_root \
>  	godown resvtest writemod writev_on_pagefault makeextents itrash rename \
> -	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
> +	multi_open_unlink unwritten_sync genhashnames t_holes \
>  	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
>  	holetest t_truncate_self af_unix t_mmap_stale_pmd \
>  	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
> diff --git a/src/dmiperf.c b/src/dmiperf.c
> deleted file mode 100644
> index 4026dcfb..00000000
> --- a/src/dmiperf.c
> +++ /dev/null
> @@ -1,275 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2006 Silicon Graphics, Inc.
> - * All Rights Reserved.
> - */
> -
> -#include <sys/types.h>
> -#include <sys/param.h>
> -#include <sys/stat.h>
> -#include <sys/time.h>
> -#include <dirent.h>
> -#include <malloc.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <math.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <attr/attributes.h>
> -
> -typedef unsigned int uint_t;
> -
> -/*
> - * Loop over directory sizes:
> - *	make m directories
> - *	touch n files in each directory
> - *	write y bytes to all files in each directory
> - *	set DMF attribute on x files in each directory
> - * Change directory sizes by multiplication or addition.
> - * Allow control of starting & stopping sizes, name length, target directory.
> - * Print size and wallclock time (ms per file).
> - * Output can be used to make graphs (gnuplot)
> - */
> -
> -static uint_t	addval;
> -static uint_t	dirchars;
> -static char	*directory;
> -static uint_t	firstsize;
> -static uint_t	lastsize;
> -static uint_t	minchars;
> -static double	mulval;
> -static uint_t	nchars;
> -static uint_t	ndirs;
> -static uint_t	pfxchars;
> -static off64_t	fsize;
> -static char	*buffer;
> -static size_t	bsize;
> -
> -static int	mkfile(char *, char *);
> -static void	filename(int, int, char *);
> -static int	hexchars(uint_t);
> -static uint_t	nextsize(uint_t);
> -static double	now(void);
> -static void	usage(void);
> -
> -/*
> - * Maximum size allowed, this is pretty nuts.
> - * The largest one we've ever built has been about 2 million.
> - */
> -#define	MAX_DIR_SIZE	(16 * 1024 * 1024)
> -#define	DFL_FIRST_SIZE	1
> -#define	DFL_LAST_SIZE	(1024 * 1024)
> -#define	MAX_DIR_COUNT	1024
> -#define	MIN_DIR_COUNT	1
> -
> -#define DMFATTRLEN	22
> -#define DMFATTRNAME	"SGI_DMI_DMFATTR"
> -
> -int
> -main(int argc, char **argv)
> -{
> -	int		c;
> -	uint_t		cursize;
> -	int		i;
> -	int		j;
> -	char		name[NAME_MAX + 1];
> -	char		attr[DMFATTRLEN];
> -	double		stime;
> -
> -	while ((c = getopt(argc, argv, "a:b:c:d:f:l:m:n:s:")) != -1) {
> -		switch (c) {
> -		case 'a':
> -			addval = (uint_t)atoi(optarg);
> -			break;
> -		case 'b':
> -			bsize = (size_t)atol(optarg);
> -			break;
> -		case 'c':
> -			nchars = (uint_t)atoi(optarg);
> -			break;
> -		case 'd':
> -			directory = optarg;
> -			break;
> -		case 'f':
> -			firstsize = (uint_t)atoi(optarg);
> -			break;
> -		case 'l':
> -			lastsize = (uint_t)atoi(optarg);
> -			break;
> -		case 'm':
> -			mulval = atof(optarg);
> -			break;
> -		case 'n':
> -			ndirs = (uint_t)atoi(optarg);
> -			break;
> -		case 's':
> -			fsize = (off64_t)atol(optarg);
> -			break;
> -		case '?':
> -		default:
> -			usage();
> -			exit(1);
> -		}
> -	}
> -	if (!addval && !mulval)
> -		mulval = 2.0;
> -	else if ((addval && mulval) || mulval < 0.0) {
> -		usage();
> -		exit(1);
> -	}
> -	if (!bsize)
> -		bsize = 1024 * 1024;
> -	buffer = memalign(getpagesize(), bsize);
> -	memset(buffer, 0xfeed, bsize);
> -	memset(attr, 0xaaaaaaa, sizeof(attr));
> -
> -	if (!directory)
> -		directory = ".";
> -	else {
> -		if (mkdir(directory, 0777) < 0 && errno != EEXIST) {
> -			perror(directory);
> -			exit(1);
> -		}
> -		if (chdir(directory) < 0) {
> -			perror(directory);
> -			exit(1);
> -		}
> -	}
> -	if (firstsize == 0)
> -		firstsize = DFL_FIRST_SIZE;
> -	else if (firstsize > MAX_DIR_SIZE)
> -		firstsize = MAX_DIR_SIZE;
> -	if (lastsize == 0)
> -		lastsize = DFL_LAST_SIZE;
> -	else if (lastsize > MAX_DIR_SIZE)
> -		lastsize = MAX_DIR_SIZE;
> -	if (lastsize < firstsize)
> -		lastsize = firstsize;
> -	minchars = hexchars(lastsize - 1);
> -	if (nchars < minchars)
> -		nchars = minchars;
> -	else if (nchars >= NAME_MAX + 1)
> -		nchars = NAME_MAX;
> -	if (ndirs > MAX_DIR_COUNT)
> -		ndirs = MAX_DIR_COUNT;
> -	if (ndirs < MIN_DIR_COUNT)
> -		ndirs = MIN_DIR_COUNT;
> -	dirchars = hexchars(ndirs);
> -	pfxchars = nchars - minchars;
> -	if (pfxchars)
> -		memset(&name[dirchars + 1], 'a', pfxchars);
> -
> -	cursize = firstsize;
> -	for (j = 0; j < ndirs; j++) {
> -		filename(0, j, name);
> -		name[dirchars] = '\0';
> -		mkdir(name, 0777);
> -		stime = now();
> -		for (i = 0; i < cursize; i++) {
> -			filename((i + j) % cursize, j, name);
> -			close(mkfile(name, attr));
> -		}
> -		printf("%d %.3f\n", cursize,
> -			(now() - stime) * 1.0e3 / (cursize * ndirs));
> -		cursize = nextsize(cursize);
> -	}
> -	return 0;
> -}
> -
> -static int
> -mkfile(char *name, char *attr)
> -{
> -	int		fd;
> -	ssize_t		wrote, wsize;
> -	off64_t		bytes = fsize;
> -
> -	if ((fd = open(name, O_WRONLY | O_CREAT | O_EXCL | O_DIRECT, 0666)) < 0) {
> -		perror("open");
> -		exit(1);
> -	}
> -	if (attr_setf(fd, DMFATTRNAME, attr, DMFATTRLEN, ATTR_ROOT) < 0) {
> -		perror("attr_setf");
> -		exit(1);
> -	}
> -	while (bytes > 0) {
> -		wsize = (bsize < bytes) ? bsize : bytes;
> -		if ((wrote = write(fd, buffer, wsize)) < 0) {
> -			perror("write");
> -			exit(1);
> -		}
> -		bytes -= wrote;
> -	}
> -	return fd;
> -}
> -
> -static void
> -filename(int idx, int dir, char *name)
> -{
> -	static char	hexc[16] = "0123456789abcdef";
> -	int		i;
> -
> -	for (i = dirchars - 1; i >= 0; i--)
> -		*name++ = hexc[(dir >> (4 * i)) & 0xf];
> -	*name++ = '/';
> -	name += pfxchars;		/* skip pfx a's */
> -	for (i = minchars - 1; i >= 0; i--)
> -		*name++ = hexc[(idx >> (4 * i)) & 0xf];
> -	*name = '\0';
> -}
> -
> -static int
> -hexchars(uint_t maxval)
> -{
> -	if (maxval < 16)
> -		return 1;
> -	if (maxval < 16 * 16)
> -		return 2;
> -	if (maxval < 16 * 16 * 16)
> -		return 3;
> -	if (maxval < 16 * 16 * 16 * 16)
> -		return 4;
> -	if (maxval < 16 * 16 * 16 * 16 * 16)
> -		return 5;
> -	if (maxval < 16 * 16 * 16 * 16 * 16 * 16)
> -		return 6;
> -	if (maxval < 16 * 16 * 16 * 16 * 16 * 16 * 16)
> -		return 7;
> -	return 8;
> -}
> -
> -static uint_t
> -nextsize(uint_t cursize)
> -{
> -	double	n;
> -
> -	n = cursize;
> -	if (addval)
> -		n += addval;
> -	else
> -		n *= mulval;
> -	if (n > (double)lastsize + 0.5)
> -		return lastsize + 1;	/* i.e. out of bounds */
> -	else if ((uint_t)n == cursize)
> -		return cursize + 1;
> -	else
> -		return (uint_t)n;
> -}
> -
> -static double
> -now(void)
> -{
> -	struct timeval	tv;
> -
> -	gettimeofday(&tv, NULL);
> -	return (double)tv.tv_sec + 1.0e-6 * (double)tv.tv_usec;
> -}
> -
> -static void
> -usage(void)
> -{
> -	fprintf(stderr,
> -		"usage: dirperf [-d dir] [-a addstep | -m mulstep] [-f first] "
> -		"[-l last] [-c nchars] [-n ndirs] [-s size]\n");
> -}
> -- 
> 2.23.0
> 
> 
> 
