Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1787DC433FE
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 01:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbiETBfp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 21:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344536AbiETBfo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 21:35:44 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 413AC98
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:35:42 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3At1lehqndi7KFZ1v+6MHy2F3o5gydJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2NSymQWW22FPKmDN2OmKotyPoWw8k4A7J/WxoMxTFM4+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCLj6pLKkB2aG5fr67A0ZK0sBqUW4fp6Gn1?=
 =?us-ascii?q?V3eIXJSpLbR2Zge+yhrWhRYFRam4LRCXwFNpH/Cg+kneCVrB7Ka0vip7ivbdwt?=
 =?us-ascii?q?ArcTOgSdRoGW/ckVA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AcjX1HapKCrhkLNCi71ULV/0aV5rPeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj+fxG+85rsyMc6QxhIU3I9urhBEDtex/hHNtOkOws1NSZLW7bUQ?=
 =?us-ascii?q?mTXeJfBOLZqlWKcUDDH6xmpMNdmsNFaeEYY2IUsS+D2njbLz8/+qj7zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2fqYRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2fSIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl92ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124361784"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 May 2022 09:35:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A1D0C4D17192
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 09:35:36 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 May 2022 09:35:36 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 20 May 2022 09:35:36 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v3 1/3] xfs: add memory failure test for dax mode
Date:   Fri, 20 May 2022 09:35:32 +0800
Message-ID: <20220520013534.2894233-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
References: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A1D0C4D17192.AD2E1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make sure memory failure mechanism works when filesystem is mounted with
dax option.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 .gitignore                      |   1 +
 src/Makefile                    |   3 +-
 src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++++++++++++++++
 tests/xfs/900                   |  48 ++++++++++
 tests/xfs/900.out               |   9 ++
 5 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_cow_memory_failure.c
 create mode 100755 tests/xfs/900
 create mode 100644 tests/xfs/900.out

diff --git a/.gitignore b/.gitignore
index ba0c572b..1d26b28a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -146,6 +146,7 @@ tags
 /src/t_holes
 /src/t_immutable
 /src/t_mmap_collision
+/src/t_mmap_cow_memory_failure
 /src/t_mmap_cow_race
 /src/t_mmap_dio
 /src/t_mmap_fallocate
diff --git a/src/Makefile b/src/Makefile
index 111ce1d9..d702e200 100644
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
index 00000000..4b2c1b8a
--- /dev/null
+++ b/src/t_mmap_cow_memory_failure.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Fujitsu Corporation. */
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
index 00000000..da11230a
--- /dev/null
+++ b/tests/xfs/900
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
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
diff --git a/tests/xfs/900.out b/tests/xfs/900.out
new file mode 100644
index 00000000..d861bf1f
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
2.35.1



