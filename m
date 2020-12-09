Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52799C4361B
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 05:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213C623A75
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 05:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgLIFT1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Dec 2020 00:19:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12760 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgLIFT1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Dec 2020 00:19:27 -0500
X-IronPort-AV: E=Sophos;i="5.78,404,1599494400"; 
   d="scan'208";a="102208404"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Dec 2020 13:18:36 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 983F64CE5CF8;
        Wed,  9 Dec 2020 13:18:32 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 9 Dec 2020 13:18:31 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 9 Dec 2020 13:18:31 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <eguan@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 1/2] src/dmiperf: Remove obsolete dmiperf
Date:   Wed, 9 Dec 2020 12:58:01 +0800
Message-ID: <20201209045802.1239715-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 983F64CE5CF8.AACCA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/Makefile  |   2 +-
 src/dmiperf.c | 275 --------------------------------------------------
 2 files changed, 1 insertion(+), 276 deletions(-)
 delete mode 100644 src/dmiperf.c

diff --git a/src/Makefile b/src/Makefile
index 32940142..80f7b892 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -11,7 +11,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	mmapcat append_reader append_writer dirperf metaperf \
 	devzero feature alloc fault fstest t_access_root \
 	godown resvtest writemod writev_on_pagefault makeextents itrash rename \
-	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
+	multi_open_unlink unwritten_sync genhashnames t_holes \
 	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
 	holetest t_truncate_self af_unix t_mmap_stale_pmd \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
diff --git a/src/dmiperf.c b/src/dmiperf.c
deleted file mode 100644
index 4026dcfb..00000000
--- a/src/dmiperf.c
+++ /dev/null
@@ -1,275 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2006 Silicon Graphics, Inc.
- * All Rights Reserved.
- */
-
-#include <sys/types.h>
-#include <sys/param.h>
-#include <sys/stat.h>
-#include <sys/time.h>
-#include <dirent.h>
-#include <malloc.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <math.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <attr/attributes.h>
-
-typedef unsigned int uint_t;
-
-/*
- * Loop over directory sizes:
- *	make m directories
- *	touch n files in each directory
- *	write y bytes to all files in each directory
- *	set DMF attribute on x files in each directory
- * Change directory sizes by multiplication or addition.
- * Allow control of starting & stopping sizes, name length, target directory.
- * Print size and wallclock time (ms per file).
- * Output can be used to make graphs (gnuplot)
- */
-
-static uint_t	addval;
-static uint_t	dirchars;
-static char	*directory;
-static uint_t	firstsize;
-static uint_t	lastsize;
-static uint_t	minchars;
-static double	mulval;
-static uint_t	nchars;
-static uint_t	ndirs;
-static uint_t	pfxchars;
-static off64_t	fsize;
-static char	*buffer;
-static size_t	bsize;
-
-static int	mkfile(char *, char *);
-static void	filename(int, int, char *);
-static int	hexchars(uint_t);
-static uint_t	nextsize(uint_t);
-static double	now(void);
-static void	usage(void);
-
-/*
- * Maximum size allowed, this is pretty nuts.
- * The largest one we've ever built has been about 2 million.
- */
-#define	MAX_DIR_SIZE	(16 * 1024 * 1024)
-#define	DFL_FIRST_SIZE	1
-#define	DFL_LAST_SIZE	(1024 * 1024)
-#define	MAX_DIR_COUNT	1024
-#define	MIN_DIR_COUNT	1
-
-#define DMFATTRLEN	22
-#define DMFATTRNAME	"SGI_DMI_DMFATTR"
-
-int
-main(int argc, char **argv)
-{
-	int		c;
-	uint_t		cursize;
-	int		i;
-	int		j;
-	char		name[NAME_MAX + 1];
-	char		attr[DMFATTRLEN];
-	double		stime;
-
-	while ((c = getopt(argc, argv, "a:b:c:d:f:l:m:n:s:")) != -1) {
-		switch (c) {
-		case 'a':
-			addval = (uint_t)atoi(optarg);
-			break;
-		case 'b':
-			bsize = (size_t)atol(optarg);
-			break;
-		case 'c':
-			nchars = (uint_t)atoi(optarg);
-			break;
-		case 'd':
-			directory = optarg;
-			break;
-		case 'f':
-			firstsize = (uint_t)atoi(optarg);
-			break;
-		case 'l':
-			lastsize = (uint_t)atoi(optarg);
-			break;
-		case 'm':
-			mulval = atof(optarg);
-			break;
-		case 'n':
-			ndirs = (uint_t)atoi(optarg);
-			break;
-		case 's':
-			fsize = (off64_t)atol(optarg);
-			break;
-		case '?':
-		default:
-			usage();
-			exit(1);
-		}
-	}
-	if (!addval && !mulval)
-		mulval = 2.0;
-	else if ((addval && mulval) || mulval < 0.0) {
-		usage();
-		exit(1);
-	}
-	if (!bsize)
-		bsize = 1024 * 1024;
-	buffer = memalign(getpagesize(), bsize);
-	memset(buffer, 0xfeed, bsize);
-	memset(attr, 0xaaaaaaa, sizeof(attr));
-
-	if (!directory)
-		directory = ".";
-	else {
-		if (mkdir(directory, 0777) < 0 && errno != EEXIST) {
-			perror(directory);
-			exit(1);
-		}
-		if (chdir(directory) < 0) {
-			perror(directory);
-			exit(1);
-		}
-	}
-	if (firstsize == 0)
-		firstsize = DFL_FIRST_SIZE;
-	else if (firstsize > MAX_DIR_SIZE)
-		firstsize = MAX_DIR_SIZE;
-	if (lastsize == 0)
-		lastsize = DFL_LAST_SIZE;
-	else if (lastsize > MAX_DIR_SIZE)
-		lastsize = MAX_DIR_SIZE;
-	if (lastsize < firstsize)
-		lastsize = firstsize;
-	minchars = hexchars(lastsize - 1);
-	if (nchars < minchars)
-		nchars = minchars;
-	else if (nchars >= NAME_MAX + 1)
-		nchars = NAME_MAX;
-	if (ndirs > MAX_DIR_COUNT)
-		ndirs = MAX_DIR_COUNT;
-	if (ndirs < MIN_DIR_COUNT)
-		ndirs = MIN_DIR_COUNT;
-	dirchars = hexchars(ndirs);
-	pfxchars = nchars - minchars;
-	if (pfxchars)
-		memset(&name[dirchars + 1], 'a', pfxchars);
-
-	cursize = firstsize;
-	for (j = 0; j < ndirs; j++) {
-		filename(0, j, name);
-		name[dirchars] = '\0';
-		mkdir(name, 0777);
-		stime = now();
-		for (i = 0; i < cursize; i++) {
-			filename((i + j) % cursize, j, name);
-			close(mkfile(name, attr));
-		}
-		printf("%d %.3f\n", cursize,
-			(now() - stime) * 1.0e3 / (cursize * ndirs));
-		cursize = nextsize(cursize);
-	}
-	return 0;
-}
-
-static int
-mkfile(char *name, char *attr)
-{
-	int		fd;
-	ssize_t		wrote, wsize;
-	off64_t		bytes = fsize;
-
-	if ((fd = open(name, O_WRONLY | O_CREAT | O_EXCL | O_DIRECT, 0666)) < 0) {
-		perror("open");
-		exit(1);
-	}
-	if (attr_setf(fd, DMFATTRNAME, attr, DMFATTRLEN, ATTR_ROOT) < 0) {
-		perror("attr_setf");
-		exit(1);
-	}
-	while (bytes > 0) {
-		wsize = (bsize < bytes) ? bsize : bytes;
-		if ((wrote = write(fd, buffer, wsize)) < 0) {
-			perror("write");
-			exit(1);
-		}
-		bytes -= wrote;
-	}
-	return fd;
-}
-
-static void
-filename(int idx, int dir, char *name)
-{
-	static char	hexc[16] = "0123456789abcdef";
-	int		i;
-
-	for (i = dirchars - 1; i >= 0; i--)
-		*name++ = hexc[(dir >> (4 * i)) & 0xf];
-	*name++ = '/';
-	name += pfxchars;		/* skip pfx a's */
-	for (i = minchars - 1; i >= 0; i--)
-		*name++ = hexc[(idx >> (4 * i)) & 0xf];
-	*name = '\0';
-}
-
-static int
-hexchars(uint_t maxval)
-{
-	if (maxval < 16)
-		return 1;
-	if (maxval < 16 * 16)
-		return 2;
-	if (maxval < 16 * 16 * 16)
-		return 3;
-	if (maxval < 16 * 16 * 16 * 16)
-		return 4;
-	if (maxval < 16 * 16 * 16 * 16 * 16)
-		return 5;
-	if (maxval < 16 * 16 * 16 * 16 * 16 * 16)
-		return 6;
-	if (maxval < 16 * 16 * 16 * 16 * 16 * 16 * 16)
-		return 7;
-	return 8;
-}
-
-static uint_t
-nextsize(uint_t cursize)
-{
-	double	n;
-
-	n = cursize;
-	if (addval)
-		n += addval;
-	else
-		n *= mulval;
-	if (n > (double)lastsize + 0.5)
-		return lastsize + 1;	/* i.e. out of bounds */
-	else if ((uint_t)n == cursize)
-		return cursize + 1;
-	else
-		return (uint_t)n;
-}
-
-static double
-now(void)
-{
-	struct timeval	tv;
-
-	gettimeofday(&tv, NULL);
-	return (double)tv.tv_sec + 1.0e-6 * (double)tv.tv_usec;
-}
-
-static void
-usage(void)
-{
-	fprintf(stderr,
-		"usage: dirperf [-d dir] [-a addstep | -m mulstep] [-f first] "
-		"[-l last] [-c nchars] [-n ndirs] [-s size]\n");
-}
-- 
2.23.0



