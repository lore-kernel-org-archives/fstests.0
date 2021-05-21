Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE40C43470
	for <linux-fstests@archiver.kernel.org>; Fri, 21 May 2021 08:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4519613D0
	for <linux-fstests@archiver.kernel.org>; Fri, 21 May 2021 08:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhEUIDy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 May 2021 04:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhEUIDh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 May 2021 04:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621584120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DAOwnSPi8UmJ9nFXsrvEYk6+SYHUOECMRt6qUCI+dXM=;
        b=arOEhF/6arM3MdyAc5VKKnwG4TQQuaniMMbLEt0g6UXnoLtxjNTXZE2JIqNq0ETiTHs2+U
        y91PnTsH9ar2kmwmZ/vi7NYx/HJDX0ln8IBX5iJW31FdiehQvn5Ff9ocQXOtIfn/c9mN86
        s3by2pRZD9YHeQvebj3+enYWdGynz3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-j1dN5iDpPha9nmQiTxPyPg-1; Fri, 21 May 2021 04:01:53 -0400
X-MC-Unique: j1dN5iDpPha9nmQiTxPyPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF42A800C60
        for <fstests@vger.kernel.org>; Fri, 21 May 2021 08:01:52 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0147D62466
        for <fstests@vger.kernel.org>; Fri, 21 May 2021 08:01:51 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfstests: mmap and copy file data with page overlapping
Date:   Fri, 21 May 2021 16:01:45 +0800
Message-Id: <20210521080145.1692547-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Mmap 2 pages of file, write 64 bytes to the first and second pages,
copy the data from the first page and then second page to the second
page offset with $pagesize - 64. Verify the data at the end.

       +-----------------------+
       |        (copy)         |
       |                       V
    +---------------+---------------+------------
    |AAAA| ........ |AAAA| ... |AAAA|AAAA|
    +---------------+---------------+------------
                       |            ^
                       |   (copy)   |
                       +------------+

This's also a regression test cover kernel commit: 4f06dd92b5d0
("fuse: fix write deadlock")

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 .gitignore                  |   1 +
 src/Makefile                |   3 +-
 src/t_mmap_writev_overlap.c | 134 ++++++++++++++++++++++++++++++++++++
 tests/generic/637           |  57 +++++++++++++++
 tests/generic/637.out       |   2 +
 tests/generic/group         |   1 +
 6 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_writev_overlap.c
 create mode 100755 tests/generic/637
 create mode 100644 tests/generic/637.out

diff --git a/.gitignore b/.gitignore
index 4cc9c807..1e56d7ca 100644
--- a/.gitignore
+++ b/.gitignore
@@ -142,6 +142,7 @@
 /src/t_mmap_stale_pmd
 /src/t_mmap_write_ro
 /src/t_mmap_writev
+/src/t_mmap_writev_overlap
 /src/t_mtab
 /src/t_ofd_locks
 /src/t_open_tmpfiles
diff --git a/src/Makefile b/src/Makefile
index cc0b9579..1279e4b9 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -17,7 +17,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
-	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc
+	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
+	t_mmap_writev_overlap
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_mmap_writev_overlap.c b/src/t_mmap_writev_overlap.c
new file mode 100644
index 00000000..e327e730
--- /dev/null
+++ b/src/t_mmap_writev_overlap.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 RedHat Inc.  All Rights Reserved.
+ *
+ * mmap a file, alloc blocks, reading&writing blocks with overlapping. For example:
+ *
+ * |<--- block --->|<--- block --->|
+ *  len             len
+ * +---------------+---------------+
+ * |AAAA| ........ |AAAA| ........ |
+ * +---------------+---------------+
+ *    |               |
+ *    |               `------------+
+ *    `-----------------------+    |
+ *                            |    |
+ *                            V    V
+ * +---------------+---------------+----+
+ * |AAAA| ........ |AAAA| ... |AAAA|AAAA|
+ * +---------------+---------------+----+
+ */
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr, "usage: %s [-b blocksize ] [-c count] [-l length] filename\n"
+	        "\tmmap $count * $blocksize bytes memory, pwritev $length bytes in each block. blocksize=4096, count=2, length=12 by default.\n"
+                "e.g: %s -b 4096 -c 2 -l 12 filename\n",
+	        progname, progname);
+        exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	char *filename = NULL;
+	size_t bsize = 4096;
+	size_t count = 2;
+	size_t length = 12;
+	int fd, i, c;
+	void *base;
+	char *buf, *cmp_buf;
+	struct iovec *iov;
+	int ret = 0;
+
+	while ((c = getopt(argc, argv, "b:l:c:")) != -1) {
+		char *endp;
+
+		switch (c) {
+		case 'b':
+			bsize = strtoul(optarg, &endp, 0);
+			break;
+		case 'c':
+			count = strtoul(optarg, &endp, 0);
+			break;
+		case 'l':
+			length = strtoul(optarg, &endp, 0);
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind == argc - 1)
+		filename = argv[optind];
+	else
+		usage(argv[0]);
+
+	if (length >= bsize) {
+		printf("-l length must be less than -b blocksize\n");
+		usage(argv[0]);
+	}
+
+	fd = open(filename, O_RDWR);
+	if (fd == -1) {
+		fprintf(stderr, "open %s failed:%s\n", filename, strerror(errno));
+		exit(1);
+	}
+	base = mmap(NULL, bsize * count, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (base == MAP_FAILED) {
+		fprintf(stderr, "mmap failed %s\n", strerror(errno));
+		exit(1);
+	}
+
+	/* Write each of blocks */
+	buf = malloc(length);
+	memset(buf, 0xAA, length);
+	for (i=0; i<count; i++) {
+		ret = pwrite(fd, buf, length, i * bsize);
+		if (ret == -1) {
+			fprintf(stderr, "pwrite failed %s\n", strerror(errno));
+			exit(1);
+		}
+	}
+
+	/* Copy from the beginning of each blocks ... */
+	iov = malloc(sizeof(struct iovec) * count);
+	for (i=0; i<count; i++) {
+		iov[i].iov_base = base + i * bsize;
+		iov[i].iov_len  = length;
+	}
+	/* ... Write to the last block with offset ($bsize - $length) */
+	ret = pwritev(fd, iov, count, bsize * count - length);
+	if (ret == -1) {
+		fprintf(stderr, "pwritev failed %s\n", strerror(errno));
+		exit(1);
+	}
+
+	/* Verify data */
+	cmp_buf = malloc(length);
+	for (i=0; i<count; i++) {
+		ret = pread(fd, cmp_buf, length, bsize * count + (i - 1) * length);
+		if (ret == -1) {
+			fprintf(stderr, "pread failed %s\n", strerror(errno));
+			exit(1);
+		}
+		if (memcmp(buf, cmp_buf, length))
+			printf("Find corruption\n");
+	}
+
+	munmap(base, bsize * count);
+	free(buf);
+	free(cmp_buf);
+	free(iov);
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/generic/637 b/tests/generic/637
new file mode 100755
index 00000000..dac2bf2c
--- /dev/null
+++ b/tests/generic/637
@@ -0,0 +1,57 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test 637
+#
+# This case mmaps several pages of a file, alloc pages, copy data with pages
+# overlapping, e.g:
+#       +-----------------------+
+#       |        (copy)         |
+#       |                       V
+#    +---------------+---------------+------------
+#    |AAAA| ........ |AAAA| ... |AAAA|AAAA|
+#    +---------------+---------------+------------
+#                       |            ^
+#                       |   (copy)   |
+#                       +------------+
+#
+# This's a regression test cover kernel commit:
+#   4f06dd92b5d0 ("fuse: fix write deadlock")
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_test_program "t_mmap_writev_overlap"
+
+pagesize=`getconf PAGE_SIZE`
+testfile=$TEST_DIR/mmap-writev-overlap
+$XFS_IO_PROG -f -c "truncate 0" $testfile
+$here/src/t_mmap_writev_overlap -b $pagesize -c 2 -l 64 $testfile
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/generic/637.out b/tests/generic/637.out
new file mode 100644
index 00000000..55a3d825
--- /dev/null
+++ b/tests/generic/637.out
@@ -0,0 +1,2 @@
+QA output created by 637
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 105763c4..b9614c69 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -639,3 +639,4 @@
 634 auto quick atime bigtime
 635 auto quick atime bigtime shutdown
 636 auto quick swap
+637 auto quick rw
-- 
2.31.1

