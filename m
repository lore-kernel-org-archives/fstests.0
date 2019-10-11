Return-Path: <SRS0=yvB5=YE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9281C47404
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Oct 2019 21:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBC0206CD
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Oct 2019 21:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jln633fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJKVlc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:41:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53924 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfJKVlc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Oct 2019 17:41:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BLY1nZ001845;
        Fri, 11 Oct 2019 21:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ZdAf3uh1wRdXwHYopo4LFBY++FlQ/4RIAolQrgIW8MI=;
 b=Jln633feHp84gTdqkZ8xJLVsIe8TKb6C2cExh2EIHAR8UI+7DjWg206t8YBSEBnqoEnt
 vS0mXAVcJWHoC1Je7lnOTUv0tq369i8MzBtaEZwSkxpHPvAgvV50zOUEAsATnYdDbuPd
 0TXKY0JuQw18BkOUgYkvyqyfO4KAiZK1KMdTXl7240Py6ghZ72Y8YwVNHMELTCEfswLI
 GaDxg58cUBxt7Hil9xClUMa33ShE2IuSsETptBouLtb3BDwKqaVhnXEBzeOavUF8HA2X
 1HXC8VGVrSEAol4ydPF6S5Itn6t0gqY3IYoC2u9ib9Yf/i9SbPaDG5VdPis8hRDSawyU UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vejkv4716-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 21:41:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BLWu65167996;
        Fri, 11 Oct 2019 21:41:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vjdymt226-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 21:41:22 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9BLfM5U014722;
        Fri, 11 Oct 2019 21:41:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 14:41:21 -0700
Date:   Fri, 11 Oct 2019 14:41:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     fstests <fstests@vger.kernel.org>
Subject: [PATCH v2] generic: check reflink multiple mmap write
Message-ID: <20191011214120.GI13097@magnolia>
References: <20191010041440.GH13097@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010041440.GH13097@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110174
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Add a test to make sure that we can handle multiple memory mappings to a
physical storage extent shared by multiple files, and that we can handle
the copy on write operation without error.  Make sure we can also handle
mappings at different offsets in the page cache.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
v2: test at different offsets
---
 src/Makefile                |    2 -
 src/mmap-write-concurrent.c |  155 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/945           |  104 +++++++++++++++++++++++++++++
 tests/generic/945.out       |   31 +++++++++
 tests/generic/group         |    1 
 5 files changed, 292 insertions(+), 1 deletion(-)
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
index 00000000..38364de8
--- /dev/null
+++ b/src/mmap-write-concurrent.c
@@ -0,0 +1,155 @@
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
+struct file_info {
+	char			*mapping;
+	off_t			file_offset;
+	off_t			file_length;
+	int			fd;
+};
+
+int
+main(
+	int			argc,
+	char			*argv[])
+{
+	struct file_info	*fi;
+	size_t			length;
+	char			*endptr;
+	unsigned int		nr_files;
+	unsigned int		i;
+	char			*buf;
+	int			ret;
+
+	if (argc < 4) {
+		printf("Usage: %s len offset file [offset file]...\n", argv[0]);
+		return 1;
+	}
+
+	/* Parse mwrite length. */
+	errno = 0;
+	length = strtoul(argv[1], &endptr, 0);
+	if (errno) {
+		perror(argv[1]);
+		return 1;
+	}
+	if (*endptr != '\0') {
+		fprintf(stderr, "%s: not a proper file length?\n", argv[2]);
+		return 1;
+	}
+
+	/* Allocate file info */
+	nr_files = (argc - 2) / 2;
+
+	fi = calloc(nr_files, sizeof(struct file_info));
+	if (!fi) {
+		perror("calloc file info");
+		return 1;
+	}
+
+	buf = malloc(length);
+	if (!buf) {
+		perror("malloc buf");
+		return 1;
+	}
+
+	for (i = 0; i < nr_files; i++) {
+		struct stat	statbuf;
+		char		*offset = argv[((i + 1) * 2)];
+		char		*fname = argv[((i + 1) * 2) + 1];
+
+		/* Open file, create mapping for the range we want. */
+		fi[i].fd = open(fname, O_RDWR);
+		if (fi[i].fd < 0) {
+			perror(fname);
+			return 1;
+		}
+
+		/* Parse mwrite offset */
+		errno = 0;
+		fi[i].file_offset = strtoul(offset, &endptr, 0);
+		if (errno) {
+			perror(argv[1]);
+			return 1;
+		}
+
+		/* Remember file size */
+		ret = fstat(fi[i].fd, &statbuf);
+		if (ret) {
+			perror(fname);
+			return 1;
+		}
+		fi[i].file_length = statbuf.st_size;
+
+		if (fi[i].file_offset + length > fi[i].file_length) {
+			fprintf(stderr, "%s: file must be %llu bytes\n",
+				fname,
+				(unsigned long long)fi[i].file_offset + length);
+			return 1;
+		}
+
+		/* Create the mapping */
+		fi[i].mapping = mmap(NULL, fi[i].file_length,
+				PROT_READ | PROT_WRITE, MAP_SHARED,
+				fi[i].fd, 0);
+		if (fi[i].mapping == MAP_FAILED) {
+			perror(fname);
+			return 1;
+		}
+
+		/*
+		 * Make sure the mapping for region we're going to write is
+		 * already populated in the page cache.
+		 */
+		memcpy(buf, fi[i].mapping + fi[i].file_offset, length);
+	}
+
+	/* Dirty the same region in each file to test COW. */
+	for (i = 0; i < nr_files; i++) {
+		memset(buf, 0x62 + i, length);
+		memcpy(fi[i].mapping + fi[i].file_offset, buf, length);
+	}
+	for (i = 0; i < nr_files; i++) {
+		ret = msync(fi[i].mapping, fi[i].file_offset + length, MS_SYNC);
+		if (ret) {
+			perror("msync");
+			return 1;
+		}
+	}
+
+	/* Close everything. */
+	for (i = 0; i < nr_files; i++) {
+		ret = munmap(fi[i].mapping, fi[i].file_length);
+		if (ret) {
+			perror("munmap");
+			return 1;
+		}
+
+		ret = close(fi[i].fd);
+		if (ret) {
+			perror("close");
+			return 1;
+		}
+	}
+
+	/* Free everything. */
+	free(buf);
+	free(fi);
+
+	return 0;
+}
diff --git a/tests/generic/945 b/tests/generic/945
new file mode 100755
index 00000000..38b5883c
--- /dev/null
+++ b/tests/generic/945
@@ -0,0 +1,104 @@
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
+	for i in $(seq 1 8); do
+		md5sum $testdir/file$i | _filter_test_dir
+		echo $testdir/file$i >> $seqres.full
+		od -tx1 -Ad -c $testdir/file$i >> $seqres.full
+	done
+}
+
+testdir=$TEST_DIR/test-$seq
+rm -rf $testdir
+mkdir $testdir
+
+echo "Create the original files"
+blksz=65536
+filesz=$((blksz * 4))
+_pwrite_byte 0x61 0 $filesz $testdir/file1 >> $seqres.full
+_cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
+_cp_reflink $testdir/file1 $testdir/file3 >> $seqres.full
+_cp_reflink $testdir/file1 $testdir/file4 >> $seqres.full
+_reflink_range $testdir/file1 0 $testdir/file5 $blksz $filesz >> $seqres.full
+_reflink_range $testdir/file1 0 $testdir/file6 $((blksz * 2)) $filesz >> $seqres.full
+_reflink_range $testdir/file1 0 $testdir/file7 $((blksz * 3)) $filesz >> $seqres.full
+_reflink_range $testdir/file1 0 $testdir/file8 $((blksz * 4)) $filesz >> $seqres.full
+_test_cycle_mount
+
+echo "Compare files before cow" | tee -a $seqres.full
+compare
+
+echo "mwrite all copies" | tee -a $seqres.full
+off=$(( (filesz / 2) - 168 ))
+len=337
+./src/mmap-write-concurrent $len \
+		$off $testdir/file1 \
+		$off $testdir/file2 \
+		$off $testdir/file3 \
+		$off $testdir/file4 \
+		$((off + blksz)) $testdir/file5 \
+		$((off + (blksz * 2))) $testdir/file6 \
+		$((off + (blksz * 3))) $testdir/file7 \
+		$((off + (blksz * 4))) $testdir/file8 \
+		168 $testdir/file1 \
+		$((blksz - 168)) $testdir/file2 \
+		$((filesz - 777)) $testdir/file3 \
+		$(((blksz * 3) - 168)) $testdir/file4 \
+
+
+echo "Compare files before remount" | tee -a $seqres.full
+compare
+_test_cycle_mount
+
+echo "Compare files after remount" | tee -a $seqres.full
+compare
+
+echo "Check for non-shared extents" | tee -a $seqres.full
+$FILEFRAG_PROG -v $testdir/file1 $testdir/file2 $testdir/file3 $testdir/file4 \
+		  $testdir/file5 $testdir/file6 $testdir/file7 $testdir/file8 \
+		  | grep '^[[:space:]]*[0-9]*:' > $testdir/fiemap
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
index 00000000..ad1e21ff
--- /dev/null
+++ b/tests/generic/945.out
@@ -0,0 +1,31 @@
+QA output created by 945
+Create the original files
+Compare files before cow
+c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file1
+c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file2
+c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file3
+c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file4
+74e6b9b1a03fdf09293c089b002800f8  TEST_DIR/test-945/file5
+c14f20b97155e3fc11a17532d02ad9df  TEST_DIR/test-945/file6
+22eb46e0f4a3742c8d86346845b7bc80  TEST_DIR/test-945/file7
+4d292f06cec9d3f1bece4822cd5ef532  TEST_DIR/test-945/file8
+mwrite all copies
+Compare files before remount
+c1b46135a2620ae6da21bbfd4cbb3cba  TEST_DIR/test-945/file1
+16f0bc0f97c42d2ad903c519095b8126  TEST_DIR/test-945/file2
+eb71e3135ca2abf33bb9081e2b49a876  TEST_DIR/test-945/file3
+2678dfcb77bed4dc29e19836bef82e5b  TEST_DIR/test-945/file4
+2802d75dbee4f29d62124aa7b473edca  TEST_DIR/test-945/file5
+acd58cf3d33ef905e26800a0e049223c  TEST_DIR/test-945/file6
+1b68d203e5a1c1b45a9510bedcd1e126  TEST_DIR/test-945/file7
+9479709b697ced2e3a57c17bc1b97373  TEST_DIR/test-945/file8
+Compare files after remount
+c1b46135a2620ae6da21bbfd4cbb3cba  TEST_DIR/test-945/file1
+16f0bc0f97c42d2ad903c519095b8126  TEST_DIR/test-945/file2
+eb71e3135ca2abf33bb9081e2b49a876  TEST_DIR/test-945/file3
+2678dfcb77bed4dc29e19836bef82e5b  TEST_DIR/test-945/file4
+2802d75dbee4f29d62124aa7b473edca  TEST_DIR/test-945/file5
+acd58cf3d33ef905e26800a0e049223c  TEST_DIR/test-945/file6
+1b68d203e5a1c1b45a9510bedcd1e126  TEST_DIR/test-945/file7
+9479709b697ced2e3a57c17bc1b97373  TEST_DIR/test-945/file8
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
