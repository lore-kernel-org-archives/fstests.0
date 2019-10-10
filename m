Return-Path: <SRS0=mik5=YD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9CDECE597
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Oct 2019 04:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135962190F
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Oct 2019 04:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UiD9/2tP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbfJJEPY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:15:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46472 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732719AbfJJEPX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Oct 2019 00:15:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A4EFjX117844;
        Thu, 10 Oct 2019 04:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=WTgoT4PjCRwueIWtapUIa0sLiSyuWdFjAylEpBpAaxw=;
 b=UiD9/2tPD+bIXNbK6dIW9UFUeJvw/gqcFCJPzzNuBw/HwxA1LlK7lZAEYhT/89EsEGQS
 xZX6jE5eyZ59eJjGKd5NyNuOVwMCSCnJr60oocfCdiqW7TpdxN+ybVmZr1kfkF1zgQjz
 aaVUh7zr7o/dPnBJZ2jzn838fYMe5ZlLdDZN5Ydet8tvNMMZyw27C7Baf1KbkcsTx9hz
 P8pgKXAhTE5OcwHkbTdRMMCHgyOlzzo5LctWoIC0Rrywfx/pNo2RUEZseav3fHmiR0V4
 Bd8eM7Ywn2v1BYMoE4Wed8cj1ycevcalWXm64CiOioGJfpceHuUwFNhUiVlRfAR01iAv 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4qrgdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 04:14:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A4DnIV023593;
        Thu, 10 Oct 2019 04:14:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vhrxcqn2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 04:14:42 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9A4EfXu027332;
        Thu, 10 Oct 2019 04:14:41 GMT
Received: from localhost (/10.159.141.211)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 21:14:41 -0700
Date:   Wed, 9 Oct 2019 21:14:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     fstests <fstests@vger.kernel.org>
Subject: [PATCH] generic: check reflink multiple mmap write
Message-ID: <20191010041440.GH13097@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100037
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Add a test to make sure that we can handle multiple memory mappings to a
physical storage extent shared by multiple files, and that we can handle
the copy on write operation without error.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 src/Makefile                |    2 -
 src/mmap-write-concurrent.c |  157 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/945           |   89 ++++++++++++++++++++++++
 tests/generic/945.out       |   25 +++++++
 tests/generic/group         |    1 
 5 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 src/mmap-write-concurrent.c
 create mode 100755 tests/generic/945
 create mode 100644 tests/generic/945.out

diff --git a/src/Makefile b/src/Makefile
index ef7cfa63..5bc33e77 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -16,7 +16,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
-	t_ofd_locks t_locks_execve t_mmap_collision
+	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/mmap-write-concurrent.c b/src/mmap-write-concurrent.c
new file mode 100644
index 00000000..0eccea0a
--- /dev/null
+++ b/src/mmap-write-concurrent.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-newer
+/*
+ * Copyright (c) 2019 Oracle.
+ * All Rights Reserved.
+ *
+ * Create writable mappings to multiple files and write them all to test
+ * concurrent mmap writes to the same shared blocks.
+ */
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+
+int main(int argc, char *argv[])
+{
+	struct stat *statbuf;
+	off_t offset;
+	size_t length;
+	char *endptr;
+	char **mappings;
+	int *fds;
+	char *buf;
+	int i;
+	int ret;
+
+	if (argc < 4) {
+		printf("Usage: %s offset len file [files...]\n", argv[0]);
+		return 1;
+	}
+
+	/* Parse mwrite offset. */
+	errno = 0;
+	offset = strtoul(argv[1], &endptr, 0);
+	if (errno) {
+		perror(argv[1]);
+		return 1;
+	}
+	if (*endptr != '\0') {
+		fprintf(stderr, "%s: not a proper file offset?\n", argv[1]);
+		return 1;
+	}
+
+	/* Parse mwrite length. */
+	errno = 0;
+	length = strtoul(argv[2], &endptr, 0);
+	if (errno) {
+		perror(argv[1]);
+		return 1;
+	}
+	if (*endptr != '\0') {
+		fprintf(stderr, "%s: not a proper file length?\n", argv[2]);
+		return 1;
+	}
+
+	mappings = calloc(argc - 3, sizeof(char *));
+	if (!mappings) {
+		perror("calloc maps");
+		return 1;
+	}
+
+	fds = calloc(argc - 3, sizeof(int));
+	if (!fds) {
+		perror("calloc fds");
+		return 1;
+	}
+
+	buf = malloc(length);
+	if (!buf) {
+		perror("malloc buf");
+		return 1;
+	}
+
+	statbuf = calloc(argc - 3, sizeof(struct stat));
+	if (!statbuf) {
+		perror("calloc statbuf");
+		return 1;
+	}
+
+	for (i = 0; i < argc - 3; i++) {
+		char *fname = argv[i + 3];
+
+		/* Open file, create mapping for the range we want. */
+		fds[i] = open(fname, O_RDWR);
+		if (fds[i] < 0) {
+			perror(fname);
+			return 1;
+		}
+
+		ret = fstat(fds[i], &statbuf[i]);
+		if (ret) {
+			perror(fname);
+			return 1;
+		}
+
+		if (offset + length > statbuf[i].st_size) {
+			fprintf(stderr, "%s: file must be %llu bytes\n",
+					fname,
+					(unsigned long long)offset + length);
+			return 1;
+		}
+
+		mappings[i] = mmap(NULL, statbuf[i].st_size,
+				PROT_READ | PROT_WRITE, MAP_SHARED,
+				fds[i], 0);
+		if (mappings[i] == MAP_FAILED) {
+			perror(fname);
+			return 1;
+		}
+
+		/*
+		 * Make sure the mapping for region we're going to write is
+		 * already populated in the page cache.
+		 */
+		memcpy(buf, mappings[i] + offset, length);
+	}
+
+	/* Dirty the same region in each file to test COW. */
+	for (i = 0; i < argc - 3; i++) {
+		memset(buf, 0x58 + i, length);
+		memcpy(mappings[i] + offset, buf, length);
+	}
+	for (i = 0; i < argc - 3; i++) {
+		ret = msync(mappings[i], offset + length, MS_SYNC);
+		if (ret) {
+			perror("msync");
+			return 1;
+		}
+	}
+
+	/* Close everything. */
+	for (i = 0; i < argc - 3; i++) {
+		ret = munmap(mappings[i], statbuf[i].st_size);
+		if (ret) {
+			perror("munmap");
+			return 1;
+		}
+
+		ret = close(fds[i]);
+		if (ret) {
+			perror("close");
+			return 1;
+		}
+	}
+
+	/* Free everything. */
+	free(statbuf);
+	free(buf);
+	free(fds);
+	free(mappings);
+
+	return 0;
+}
diff --git a/tests/generic/945 b/tests/generic/945
new file mode 100755
index 00000000..53e26966
--- /dev/null
+++ b/tests/generic/945
@@ -0,0 +1,89 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-newer
+# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 945
+#
+# Make sure that we can handle multiple mmap writers to the same file.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.* $testdir
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+_require_command "$FILEFRAG_PROG" filefrag
+_require_test_reflink
+_require_cp_reflink
+
+rm -f $seqres.full
+
+compare() {
+	md5sum $testdir/file1 | _filter_test_dir
+	md5sum $testdir/file2 | _filter_test_dir
+	md5sum $testdir/file3 | _filter_test_dir
+	md5sum $testdir/file4 | _filter_test_dir
+
+	cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match"
+	cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match"
+	cmp -s $testdir/file1 $testdir/file4 || echo "Files 1-4 do not match"
+}
+
+testdir=$TEST_DIR/test-$seq
+rm -rf $testdir
+mkdir $testdir
+
+echo "Create the original files"
+filesz=$((65536 * 4))
+_pwrite_byte 0x61 0 $filesz $testdir/file1 >> $seqres.full
+_cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
+_cp_reflink $testdir/file1 $testdir/file3 >> $seqres.full
+_cp_reflink $testdir/file1 $testdir/file4 >> $seqres.full
+_test_cycle_mount
+
+echo "Compare files before cow"
+compare
+
+echo "mwrite all copies"
+off=$(( (filesz / 2) - 168 ))
+len=337
+./src/mmap-write-concurrent $off $len $testdir/file1 $testdir/file2 \
+		$testdir/file3 $testdir/file4
+
+echo "Compare files before remount"
+compare
+_test_cycle_mount
+
+echo "Compare files after remount"
+compare
+
+echo "Check for non-shared extents"
+$FILEFRAG_PROG -v $testdir/file1 $testdir/file2 $testdir/file3 \
+		$testdir/file4 | grep '^[[:space:]]*[0-9]*:' > $testdir/fiemap
+cat $testdir/fiemap >> $seqres.full
+grep -q 'shared' $testdir/fiemap || \
+		echo "Expected to find shared extents"
+
+grep -q -v 'shared' $testdir/fiemap || \
+		echo "Expected to find non-shared extents"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/945.out b/tests/generic/945.out
new file mode 100644
index 00000000..ba79ddfc
--- /dev/null
+++ b/tests/generic/945.out
@@ -0,0 +1,25 @@
+QA output created by 945
+Create the original files
+Compare files before cow
+c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file1
+c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file2
+c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file3
+c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file4
+mwrite all copies
+Compare files before remount
+83f84225313027ef51fea4f86239d432  TEST_DIR/test-945/file1
+d9d86b794e7d626ccee90392518c9048  TEST_DIR/test-945/file2
+c0dae8b7541aad8ef4ed3b9ffd20e9a3  TEST_DIR/test-945/file3
+094457223ea2751265e617631f5f4aa9  TEST_DIR/test-945/file4
+Files 1-2 do not match
+Files 1-3 do not match
+Files 1-4 do not match
+Compare files after remount
+83f84225313027ef51fea4f86239d432  TEST_DIR/test-945/file1
+d9d86b794e7d626ccee90392518c9048  TEST_DIR/test-945/file2
+c0dae8b7541aad8ef4ed3b9ffd20e9a3  TEST_DIR/test-945/file3
+094457223ea2751265e617631f5f4aa9  TEST_DIR/test-945/file4
+Files 1-2 do not match
+Files 1-3 do not match
+Files 1-4 do not match
+Check for non-shared extents
diff --git a/tests/generic/group b/tests/generic/group
index 4584667f..f77c5b21 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -576,3 +576,4 @@
 715 dangerous_norepair
 716 dangerous_norepair
 720 dangerous_norepair
+945 auto quick rw clone
