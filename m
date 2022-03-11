Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD40C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Mar 2022 15:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiCKPTw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCKPTv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Mar 2022 10:19:51 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C32831B01A7
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 07:18:46 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AhWRtla615TbKv1jWiVUlVQxRtCTFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShTQEnWEeXjvXaK2IYWv1f9BzYIq19EIOvZWEzIIyHQM5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyLi7JbMlBKun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpwm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AbgdtIaCjOSryiIblHelK55DYdb4zR+YMi2TC?=
 =?us-ascii?q?1yhKKCC9Ffbo7vxG/c5rrSMc5wxhO03I9eruBEDEewK5yXcX2/h2AV7BZniFhI?=
 =?us-ascii?q?LAFugLhuGOrwEIWReOkdK1vp0BT0ERMrPN5CBB/KPHCReDYqod6ejC4Ka1nv3f?=
 =?us-ascii?q?0nsoaQlrbptr5wB/Bh3zKDwNeCB2QYo+CIGH5tdK4x6peXEsZMy9AXUfG8fZod?=
 =?us-ascii?q?mjruOaXTc2Qw4g9BKVjS6lrJrzEx2j1B8YVD9VhZcOmFK16DDE2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122552737"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Mar 2022 23:18:25 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id BA8DA4D169FF
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 23:18:19 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 23:18:19 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 23:18:20 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 11 Mar 2022 23:18:18 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH 1/3] xfs: add memory failure test for dax mode
Date:   Fri, 11 Mar 2022 23:18:14 +0800
Message-ID: <20220311151816.2174870-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
References: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: BA8DA4D169FF.A3F15
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
 src/t_mmap_cow_memory_failure.c | 154 ++++++++++++++++++++++++++++++++
 tests/xfs/900                   |  48 ++++++++++
 tests/xfs/900.out               |   9 ++
 5 files changed, 214 insertions(+), 1 deletion(-)
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
index 00000000..e2266ced
--- /dev/null
+++ b/src/t_mmap_cow_memory_failure.c
@@ -0,0 +1,154 @@
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
+#define KiB(a) ((a)*1024)
+#define MiB(a) (KiB(a)*1024)
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
+void mmap_read_file_then_posion(char *filename, off_t offset, size_t size,
+		off_t posionOffset, size_t posionSize)
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
+	printf("Inject posion...\n");
+	error = madvise(map + posionOffset, posionSize, MADV_HWPOISON);
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
+	char *pReadFile = NULL, *pPosionFile = NULL;
+	/* mmap range, in unit of 4KiB */
+	size_t mmapSize = KiB(4);
+	off_t mmapOffset = 0;
+	/* posion range, in unit of 4KiB */
+	size_t posionSize = KiB(4);
+	off_t posionOffset = 0;
+	int c;
+	pid_t pid;
+
+	while ((c = getopt(argc, argv, "o::s::O::S::R:P:")) != -1) {
+		switch (c) {
+		// mmap offset, in unit of 4KiB
+		case 'o':
+			mmapOffset = atoi(optarg) * KiB(4);
+			break;
+		// mmap size
+		case 's':
+			mmapSize = atoi(optarg) * KiB(4);
+			break;
+		// madvice offset
+		case 'O':
+			posionOffset = atoi(optarg) * KiB(4);
+			break;
+		// madvice size
+		case 'S':
+			posionSize = atoi(optarg) * KiB(4);
+			break;
+		// filename for mmap read
+		case 'R':
+			pReadFile = optarg;
+			break;
+		// filename for posion read
+		case 'P':
+			pPosionFile = optarg;
+			break;
+		default:
+			printf("Unknown option: %c\n", c);
+			exit(1);
+		}
+	}
+
+	if (!pReadFile || !pPosionFile) {
+		printf("Usage: \n"
+		       "  %s [-o mmapOffset] [-s mmapSize] [-O mmapOffset] [-S mmapSize] -R readFile -P posionFile\n",
+				basename(argv[0]));
+		exit(0);
+	}
+	if (posionSize < mmapSize)
+		mmapSize = posionSize;
+
+	// fork and mmap files
+	pid = fork();
+	if (pid == 0) {
+		/* handle SIGBUS */
+		signal(SIGBUS, sigbus_handler);
+		sem = sem_open("sync", O_CREAT, 0666, 0);
+
+		/* mread & do memory failure on posion file */
+		mmap_read_file_then_posion(pPosionFile, mmapOffset, mmapSize,
+				posionOffset, posionSize);
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
index 00000000..51529db5
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
+#  process1: mread 4k to cause page fault, and wait
+#  process2: mread 4k to cause page fault, then inject posion on this 4k page
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
+Inject posion...
+Process is killed by signal: 7
+Inject memory failure (2 pages)
+Inject posion...
+Process is killed by signal: 7
-- 
2.35.1



