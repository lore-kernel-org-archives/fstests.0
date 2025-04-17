Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A961B393D
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859539; cv=none; b=heKHRYGQYk7aqeV0SI1dL9Qy0g7GTNjUR8swoD+ohI6NMhDVFgIZ8OJp4aOPiPhMNtgtKDOh1mEWtspQ421emncWeAJZcDnxJi11I4UZKdqjT1J/X4L1lwrKXdkPlHwPaYG1R2eXSzs5/LotluTHLDWYnwSDSD/7KzWJOOrl0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859539; c=relaxed/simple;
	bh=ZVqJhy8Qar4y4pyLtnzCBH3CL/W9a8SVAis3eifu3Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPeCrVwE+ybFF7yFTuzxNFAa/76xsR8uhFI0T+wxeFPcz0Hq8NqsCpBYS4k4fan52iUUkhdyiZRpSAfMlKvWVIYUrKTQKp5CFwvOcgrxaVn371II4LA+9lyUz9ZasSGHRUCOPjStXSkLBRtKoJA4y2KbL7z23zg9+Iy+7oRP9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uO8MxBdJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uO8MxBdJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223f4c06e9fso3053875ad.1
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744859537; x=1745464337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cxB+EmTQNpWq3nR2vK61HfFx+LKG5cO3usTRS6GuUE=;
        b=uO8MxBdJC1BF21w3cTFZcqxkseatN6MtZ4gddyFbIzQgyQwjIPx5G1Alqqeze8vdlS
         Jda9kxma/BNk+05qdtklXXeLtFM++9iXj/keuQDjxXWAXhawZxhDj7flzVZuxn1diWjZ
         DLZZ33HE+quh4Qw4+aY0pUzJ12WaYBCd2Ub/j77ZkyL6x6Av1AM4ym9fxzbPgttIvUR/
         2zq600Uoe2oyvLVk6Ut+tTxhIqtQXK1EIHPUaNGPI/Ss+kDOF0x7ADkyioz07w7TA8V5
         WdnVFiFTztGASP8uNxGC62EDlXDoqKXjBEEr/gu6lO5WcEOYdM38l3GZ0PRzEnnZP2qL
         Qhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859537; x=1745464337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cxB+EmTQNpWq3nR2vK61HfFx+LKG5cO3usTRS6GuUE=;
        b=SnrLBDHT/9Fx7oYNbUqy7GdezC/0xzlTOEKSILQtWAzbPHy5NdfCJs+d4SSyPKLDvD
         fGy6hu8bUCCv3X5h5aomcUEGIWGALLbOwGxvISwN3rks9CjmJ6jlPfZZnRfVGdA2xIP+
         9g7ac/2P5tcHGcNQCTslRi6fdU3k76oETYQhJdgNVPHGAjMVD0ikFmnh0fiYcQaVd8sF
         ND6kOMDLqajCagdGvTPvHK4Vot+87TY97QyfK2+mHEyu3GleDv7mcYXp804pRWpa8i69
         ppRcyeMIMmCoxVFhdvsEvlwU/muyFpxFwN+ZregszCBh2n/oT1d3lHf0h+QvtZSAVLLj
         pPvg==
X-Gm-Message-State: AOJu0YyhVXasmWYKuJzSy4tHOIXRDPOFQZJFaU9FU1B4kGMFPF1qivSH
	+eFUWeMBEGmWxBnf1VjiLdKpKX4IY0w/MVZXyJSUQYQ+7LA+R23YQ5DKOULNObFQssuqRxJU6b4
	c
X-Gm-Gg: ASbGnctDUwWObU3eCChWvdzqwoMAgNeu3C4Ab+3gHaJ0bA6Bb1ZgAn5+dSeaxvJMGMS
	9ISzHYvtGlKAjiDioHeIefzJHmIEtwqrIEbmiRSEPHeHu3vxFdeomtUmWUbkyKOXCEnW+Se+50M
	ltWLvAL7H2dFPEsqy3T8r3R1MU4DTdVCznUZ8vvrzUUzZR1Mga69Tc6QZKvDLVOf8ZSiTyeP6/W
	ictBMRwZIvAFsuGqvxFrnBt88vMFiyPCGUajxihl5UksUcZCglIfpcx46FaXwpcAytLcLDxrrG2
	8YO3NRUV+G4OVkbUuOByxTXNkDys+6C5qnMgX41p0/Hb/VXZb1EPhdamplvnEQQWaqpIYvP6CPo
	COtyqBfrYSaFj/zoOHDgZLfM=
X-Google-Smtp-Source: AGHT+IEC8f2w1SVdi6C7QtDtvYO6XL/c1fH9rUzGu3cvRMCNApUCcOwNZDR+QuTQfC80794ZP1tKVw==
X-Received: by 2002:a17:903:22d1:b0:223:517a:d5a9 with SMTP id d9443c01a7336-22c419f11bbmr13766165ad.15.1744859537293;
        Wed, 16 Apr 2025 20:12:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef0e9bsm22436385ad.31.2025.04.16.20.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:12:13 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YB2-3FJf;
	Thu, 17 Apr 2025 13:12:11 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mG2-4ACf;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 27/28] scaleread: remove dead test code
Date: Thu, 17 Apr 2025 13:01:08 +1000
Message-ID: <20250417031208.1852171-28-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

scaleread.{c,sh} is a one-off test case for a "will-it-scale" page
cache read workload from NASA back in 2003. This has not been
directly exercised by fstests since it was added 20 years ago.
The scaleread.c source code isn't even built by src/Makefile, so
it is definitely stale, dead code. Remove it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/Makefile     |   2 +-
 src/scaleread.c  | 224 -----------------------------------------------
 src/scaleread.sh |  64 --------------
 3 files changed, 1 insertion(+), 289 deletions(-)
 delete mode 100644 src/scaleread.c
 delete mode 100644 src/scaleread.sh

diff --git a/src/Makefile b/src/Makefile
index 6a31ceb01..fe7441068 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -37,7 +37,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
 	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment
 
-EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
+EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
 	      soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk
 
diff --git a/src/scaleread.c b/src/scaleread.c
deleted file mode 100644
index 4a1def005..000000000
--- a/src/scaleread.c
+++ /dev/null
@@ -1,224 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2003-2004 Silicon Graphics, Inc.
- * All Rights Reserved.
- */
-/*
- * Test scaling of multiple processes opening/reading
- * a number of small files simultaneously.
- *	- create <f> files
- *	- fork <n> processes
- *	- wait for all processes ready
- *	- start all proceses at the same time
- *	- each processes opens , read, closes each file
- *	- option to resync each process at each file
- *
- *	test [-c cpus] [-b bytes] [-f files] [-v] [-s] [-S]
- *			OR
- *	test -i [-b bytes] [-f files] 
- */
-#include <unistd.h>
-#include <string.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <fcntl.h>
-#include <stdlib.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-
-void do_initfiles(void);
-void slave(int);
-
-#define VPRINT(x...)	do { if(verbose) fprintf(x);} while(0)
-#define perrorx(s) do {perror(s); exit(1);} while (0)
-
-long bytes=8192;
-int cpus=1;
-int init=0;
-int strided=0;
-int files=1;
-int blksize=512;
-int syncstep=0;
-int verbose=0;
-
-typedef struct {
-        volatile long   go;
-        long            fill[15];
-        volatile long   rdy[512];
-} share_t;
-
-share_t	*sharep;
-
-
-int
-runon(int cpu)
-{
-#ifdef sys_sched_setaffinity
-	unsigned long mask[8];
-	
-	if (cpu < 0 || cpu >= 512)
-		return -1;
-	memset(mask, 0, sizeof(mask));
-	mask[cpu/64] |= 1UL<<(cpu&63);
-
-	if (syscall(sys_sched_setaffinity, 0, sizeof(mask), mask))
-		return -1;
-#endif
-	return 0;
-}
-
-long
-scaled_atol(char *p)
-{
-	long val;
-	char  *pe;
-
-	val = strtol(p, &pe, 0);
-	if (*pe == 'K' || *pe == 'k')
-		val *= 1024L;
-	else if (*pe == 'M' || *pe == 'm')
-		val *= 1024L*1024L;
-	else if (*pe == 'G' || *pe == 'g')
-		val *= 1024L*1024L*1024L;
-	else if (*pe == 'p' || *pe == 'P')
-		val *= getpagesize();
-	return val;
-}
-
-
-int
-main(int argc, char** argv) {
-        int shmid;
-        static  char            optstr[] = "c:b:f:sSivH";
-        int                     notdone, stat, i, j, c, er=0;
-
-        opterr=1;
-        while ((c = getopt(argc, argv, optstr)) != EOF)
-                switch (c) {
-                case 'c':
-                        cpus = atoi(optarg);
-                        break;
-                case 'b':
-                        bytes = scaled_atol(optarg);
-                        break;
-                case 'f':
-                        files = atoi(optarg);
-                        break;
-                case 'i':
-                        init++;
-                        break;
-                case 's':
-                        syncstep++;
-                        break;
-                case 'S':
-                        strided++;
-                        break;
-                case 'v':
-                        verbose++;
-                        break;
-                case '?':
-                        er = 1;
-                        break;
-                }
-        if (er) {
-                printf("usage: %s %s\n", argv[0], optstr);
-                exit(1);
-        }
-
-
-	if ((shmid = shmget(IPC_PRIVATE, sizeof (share_t), IPC_CREAT|SHM_R|SHM_W))  == -1)
-		perrorx("shmget failed");
-	sharep = (share_t*)shmat(shmid, (void*)0, SHM_R|SHM_W);
-	memset(sharep, -1, sizeof (share_t));
-
-	if (init) {
-		do_initfiles();
-		exit(0);
-	}
-        for (i=0; i<cpus; i++) {
-                if (fork() == 0)
-                        slave(i);
-        }
-
-	for (i=0; i<files; i++) {
-		VPRINT(stderr, "%d:", i);
-		notdone = cpus;
-		do {
-			for (j=0; j<cpus; j++) {
-				if (sharep->rdy[j] == i) {
-					sharep->rdy[j] = -1;
-					VPRINT(stderr, " %d", j);
-					notdone--;
-				}
-			}
-		} while (notdone);
-		VPRINT(stderr, "\n");
-		sharep->go = i;
-		if (!syncstep)
-			break;
-	}
-	VPRINT(stderr, "\n");
-
-        while (wait(&stat)> 0)
-		VPRINT(stderr, ".");
-	VPRINT(stderr, "\n");
-
-	exit(0);
-}
-
-void 
-slave(int id)
-{
-	int	i, fd, byte;
-	char	*buf, filename[32];
-
-	runon (id+1);
-	buf = malloc(blksize);
-	bzero(buf, blksize);
-	for (i=0; i<files; i++) {
-		if (!i || syncstep) {
-			sharep->rdy[id] = i;
-			while(sharep->go != i);
-		}
-		sprintf(filename, "/tmp/tst.%d", (strided ? ((i + id) % files) : i));
-		if ((fd = open (filename, O_RDONLY)) < 0) {
-			perrorx(filename);
-		}
-	
-		for (byte=0; byte<bytes; byte+=blksize) {
-			if (read (fd, buf, blksize) != blksize)
-				perrorx("read of file failed");
-		}
-		close(fd);
-	}
-	exit(0);
-}
-
-void
-do_initfiles(void)
-{
-	int	i, fd, byte;
-	char	*buf, filename[32];
-
-	buf = malloc(blksize);
-	bzero(buf, blksize);
-
-	for (i=0; i<files; i++) {
-		sprintf(filename, "/tmp/tst.%d", i);
-		unlink(filename);
-		if ((fd = open (filename, O_RDWR|O_CREAT, 0644)) < 0)
-			perrorx(filename);
-	
-		for (byte=0; byte<bytes; byte+=blksize) {
-			if (write (fd, buf, blksize) != blksize)
-				perrorx("write of file failed");
-		}
-		close(fd);
-	}
-	sync();
-}
-
-
diff --git a/src/scaleread.sh b/src/scaleread.sh
deleted file mode 100644
index 691b8eb12..000000000
--- a/src/scaleread.sh
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2003-2004 Silicon Graphics, Inc.  All Rights Reserved.
-#
-
-help() {
-cat <<END
-Measure scaling of multiple cpus readin the same set of files.
-(NASA testcase).
-	Usage:  $0 [-b <bytes>] [-f <files>] [-s] [-B] [-v] cpus ...
-			or
-		$0 -i [-b <bytes>] [-f <files>] 
-
-	  -b file size in bytes
-	  -f number of files
-	  -s keep processes synchronized when reading files
-	  -B use bcfree to free buffer cache pages before each run
-END
-exit 1
-}
-
-err () {
-	echo "ERROR - $*"
-	exit 1
-}
-
-BYTES=8192
-FILES=10
-SYNC=""
-VERBOSE=""
-STRIDED=""
-BCFREE=0
-INIT=0
-OPTS="f:b:vsiSBH"
-while getopts "$OPTS" c ; do
-	case $c in
-		H)  help;;
-		f)  FILES=${OPTARG};;
-		b)  BYTES=${OPTARG};;
-		i)  INIT=1;;
-		B)  BCFREE=1;;
-		S)  STRIDED="-S";;
-		s)  SYNC="-s";;
-		v)  VERBOSE="-v";;
-		\?) help;;
-	esac
-
-done
-shift `expr $OPTIND - 1`
-
-if [ $INIT -gt 0 ] ; then
-	echo "Initializing $BYTES bytes, $FILES files"
-	./scaleread $VERBOSE -i -b $BYTES -f $FILES 
-	sync
-else
-	[ $# -gt 0 ] || help
-	echo "Testing $BYTES bytes, $FILES files"
-	for CPUS in $* ; do
-		[ $BCFREE -eq 0 ] || bcfree -a
-		/usr/bin/time -f "$CPUS:  %e wall,    %S sys,   %U user" ./scaleread \
-			$SYNC $STRIDED $VERBOSE -b $BYTES -f $FILES -c $CPUS
-	done
-fi
-
-- 
2.45.2

