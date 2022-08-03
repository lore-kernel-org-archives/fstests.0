Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25842C19F2A
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 04:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiHCEv7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbiHCEvy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 00:51:54 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAC57233
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 21:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659502311; i=@fujitsu.com;
        bh=/W5KNz3iUAJcrZVrUM2CwYRMxC1mppbAqnNnx7/tO2Q=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=XPUzY2KGLlf39bobqwbRNBUP6EyyA3wSR9ssIhzNAkIDkNr4zv6JU9fi2velI1Euq
         LpsoGGXLYbTV2G5e3cNuK5BhT5R4KEwrUUYzUNNJBWzkFX0UHTo0a9zksdiF7tI/NC
         DyzNq0t1I7uci6pjPZus/JnKAcmnOYtfbArAGlF56dt/CfSbwF0pw2fXf8tgDrhbsK
         oAfUz5lAhGLTJPIOkPQA6zabnZTqeOKli6n54TAE0ixEGBWTNIRndWkA9u7fUi/O6j
         Vr6nthrKhQLsxA7mhKcvBF5Pfzo1mWD2VUCqiMtzHnhm+e/6d+fZ8Npt85aEApqN+P
         XyFK3NDHeGkdA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRWlGSWpSXmKPExsViZ8ORqPvs38s
  kgy1L1SxOt+xld2D0+LxJLoAxijUzLym/IoE14/Gf5UwFG6wqbhz7z9bA+Nagi5GLQ0jgEqPE
  mQ2zWSCco0wS/1YcYIVw9gBl9n1k62Lk5GAT0JG4sOAvK4gtIiAr8X/GaiYQmxnI3vV8AViNs
  ICjxLFf3WBxFgEVie7fX8BsXgEXid7JkxlBbAkBBYkpD98zg9icAq4Ss6/cBpspBFRz4WE3G0
  S9oMTJmU9YIOZLSBx88QKongOoV0liZnc8xJgKiVmz2pggbDWJq+c2MU9gFJyFpHsWku4FjEy
  rGK2TijLTM0pyEzNzdA0NDHQNDU11jY11Dc0t9RKrdBP1Ukt1y1OLS3SN9BLLi/VSi4v1iitz
  k3NS9PJSSzYxAoM4pVhx8w7GiSt/6h1ilORgUhLllfzzMkmILyk/pTIjsTgjvqg0J7X4EKMMB
  4eSBK8zSE6wKDU9tSItMwcYUTBpCQ4eJRFeRpA0b3FBYm5xZjpE6hSjPcfahgN7mTmmzv63n5
  ljOZic+bXtALMQS15+XqqUOO/Vv0BtAiBtGaV5cENhCeASo6yUMC8jAwODEE9BalFuZgmq/Ct
  GcQ5GJWHeaSDLeTLzSuB2vwI6iwnoLB2uFyBnlSQipKQamNj3RviWbup3XxV/tMS/RpDNsvuf
  uuoz1nLXnuk833dm3nv0LO3DXr/lXrOkA0TlZzff3Z3wVCFeaoF352qjZVwStfej8t+fZIn//
  GjjklaRyy2Kd7saxcsOHLSMqr+2lK903pqeYMfOtgs6/q7e0W/PTtx1Lyyxa6Fcu2bvcp652V
  zGLZf19i1iWWyWcepn2GPWjDmHzA7uDd68NSXCoZU5qytYTHDtt7JHSzN77IX0xJjrZ9+tPKD
  wtOmH/hfG7FvrN8aFFj3TXNogeO/6Oz7/D4cf/zD6vnT6n9XxyZ731E58X/Jci43tuMFxt6mp
  f3Ms+H5d5MxdoM7JV6rnf2qvUevnTa+tPD4KrXF/ocRSnJFoqMVcVJwIAIqR7W17AwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-10.tower-565.messagelabs.com!1659502310!358935!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25171 invoked from network); 3 Aug 2022 04:51:50 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-10.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Aug 2022 04:51:50 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 52E6F100190
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 05:51:50 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 46073100043
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 05:51:50 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 05:51:48 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v4 1/3] xfs: add memory failure test for dax mode
Date:   Wed, 3 Aug 2022 04:51:29 +0000
Message-ID: <1659502291-19-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659502291-19-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1659502291-19-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make sure memory failure mechanism works when filesystem is mounted with
dax option.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 .gitignore                      |   1 +
 src/Makefile                    |   3 +-
 src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++++++++++++++++
 tests/xfs/900                   |  50 ++++++++++
 tests/xfs/900.out               |   9 ++
 5 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_cow_memory_failure.c
 create mode 100755 tests/xfs/900
 create mode 100644 tests/xfs/900.out

diff --git a/.gitignore b/.gitignore
index c1d75b019..ad9f45437 100644
--- a/.gitignore
+++ b/.gitignore
@@ -147,6 +147,7 @@ tags
 /src/t_holes
 /src/t_immutable
 /src/t_mmap_collision
+/src/t_mmap_cow_memory_failure
 /src/t_mmap_cow_race
 /src/t_mmap_dio
 /src/t_mmap_fallocate
diff --git a/src/Makefile b/src/Makefile
index 665edcf9f..5f565e73c 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -18,7 +18,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
-	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale
+	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
+	t_mmap_cow_memory_failure
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_mmap_cow_memory_failure.c b/src/t_mmap_cow_memory_failure.c
new file mode 100644
index 000000000..bb3fd3fbd
--- /dev/null
+++ b/src/t_mmap_cow_memory_failure.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Fujitsu Limited.  All Rights Reserved. */
+#include <errno.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <semaphore.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/sem.h>
+#include <time.h>
+#include <unistd.h>
+
+sem_t *sem;
+
+void sigbus_handler(int signal)
+{
+	printf("Process is killed by signal: %d\n", signal);
+	sem_post(sem);
+}
+
+void mmap_read_file(char *filename, off_t offset, size_t size)
+{
+	int fd;
+	char *map, *dummy;
+	struct timespec ts;
+
+	fd = open(filename, O_RDWR);
+	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, offset);
+	dummy = malloc(size);
+
+	/* make sure page fault happens */
+	memcpy(dummy, map, size);
+
+	/* ready */
+	sem_post(sem);
+
+	usleep(200000);
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ts.tv_sec += 3;
+	/* wait for injection done */
+	sem_timedwait(sem, &ts);
+
+	free(dummy);
+	munmap(map, size);
+	close(fd);
+}
+
+void mmap_read_file_then_poison(char *filename, off_t offset, size_t size,
+		off_t poisonOffset, size_t poisonSize)
+{
+	int fd, error;
+	char *map, *dummy;
+
+	/* wait for parent preparation done */
+	sem_wait(sem);
+
+	fd = open(filename, O_RDWR);
+	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, offset);
+	dummy = malloc(size);
+
+	/* make sure page fault happens */
+	memcpy(dummy, map, size);
+
+	printf("Inject poison...\n");
+	error = madvise(map + poisonOffset, poisonSize, MADV_HWPOISON);
+	if (error)
+		printf("madvise() has fault: %d, errno: %d\n", error, errno);
+
+	free(dummy);
+	munmap(map, size);
+	close(fd);
+}
+
+int main(int argc, char *argv[])
+{
+	char *pReadFile = NULL, *pPoisonFile = NULL;
+	size_t mmapSize, poisonSize;
+	off_t mmapOffset = 0, poisonOffset = 0;
+	long pagesize = sysconf(_SC_PAGESIZE);
+	int c;
+	pid_t pid;
+
+	if (pagesize < 1) {
+		fprintf(stderr, "sysconf(_SC_PAGESIZE): failed to get page size\n");
+		abort();
+	}
+
+	/* default mmap / poison size, in unit of System Page Size */
+	mmapSize = poisonSize = pagesize;
+
+	while ((c = getopt(argc, argv, "o::s::O::S::R:P:")) != -1) {
+		switch (c) {
+		/* mmap offset */
+		case 'o':
+			mmapOffset = atoi(optarg) * pagesize;
+			break;
+		/* mmap size */
+		case 's':
+			mmapSize = atoi(optarg) * pagesize;
+			break;
+		/* madvice offset */
+		case 'O':
+			poisonOffset = atoi(optarg) * pagesize;
+			break;
+		/* madvice size */
+		case 'S':
+			poisonSize = atoi(optarg) * pagesize;
+			break;
+		/* filename for mmap read */
+		case 'R':
+			pReadFile = optarg;
+			break;
+		/* filename for poison read */
+		case 'P':
+			pPoisonFile = optarg;
+			break;
+		default:
+			printf("Unknown option: %c\n", c);
+			exit(1);
+		}
+	}
+
+	if (!pReadFile || !pPoisonFile) {
+		printf("Usage: \n"
+		       "  %s [-o mmapOffset] [-s mmapSize] [-O mmapOffset] [-S mmapSize] -R readFile -P poisonFile\n"
+		       "  (offset and size are both in unit of System Page Size: %ld)\n",
+				basename(argv[0]), pagesize);
+		exit(0);
+	}
+	if (poisonSize < mmapSize)
+		mmapSize = poisonSize;
+
+	/* fork and mmap files */
+	pid = fork();
+	if (pid == 0) {
+		/* handle SIGBUS */
+		signal(SIGBUS, sigbus_handler);
+		sem = sem_open("sync", O_CREAT, 0666, 0);
+
+		/* mread & do memory failure on poison file */
+		mmap_read_file_then_poison(pPoisonFile, mmapOffset, mmapSize,
+				poisonOffset, poisonSize);
+
+		sem_close(sem);
+	} else {
+		sem = sem_open("sync", O_CREAT, 0666, 0);
+
+		/* mread read file, wait for child process to be killed */
+		mmap_read_file(pReadFile, mmapOffset, mmapSize);
+		sem_close(sem);
+	}
+	exit(0);
+}
diff --git a/tests/xfs/900 b/tests/xfs/900
new file mode 100755
index 000000000..def1ab51e
--- /dev/null
+++ b/tests/xfs/900
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Fujitsu Limited.  All Rights Reserved.
+#
+# FS QA Test No. 900
+#
+# Test memory failure mechanism when dax enabled
+#
+. ./common/preamble
+_begin_fstest auto quick dax
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_check_dmesg
+_require_scratch_reflink
+_require_cp_reflink
+_require_xfs_scratch_rmapbt
+_require_scratch_dax_mountopt "dax"
+_require_test_program "t_mmap_cow_memory_failure"
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount "-o dax" >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+echo "Create the original files"
+filesize=65536
+_pwrite_byte 0x61 0 $filesize $testdir/testfile >> $seqres.full
+_scratch_cycle_mount "dax"
+
+echo "Inject memory failure (1 page)"
+# create two processes:
+#  process1: mread 1 page to cause page fault, and wait
+#  process2: mread 1 page to cause page fault, then inject poison on this page
+$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/testfile
+
+echo "Inject memory failure (2 pages)"
+$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/testfile
+
+_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
+_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/900.out b/tests/xfs/900.out
new file mode 100644
index 000000000..f974e59f1
--- /dev/null
+++ b/tests/xfs/900.out
@@ -0,0 +1,9 @@
+QA output created by 900
+Format and mount
+Create the original files
+Inject memory failure (1 page)
+Inject poison...
+Process is killed by signal: 7
+Inject memory failure (2 pages)
+Inject poison...
+Process is killed by signal: 7
-- 
2.37.1

