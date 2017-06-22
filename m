Received: from mx1.redhat.com ([209.132.183.28]:48132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752635AbdFVFzi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Jun 2017 01:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66F20C0587DB
        for <fstests@vger.kernel.org>; Thu, 22 Jun 2017 05:55:37 +0000 (UTC)
Received: from dhcp-12-155.nay.redhat.com (dhcp-12-155.nay.redhat.com [10.66.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0B265C3FA
        for <fstests@vger.kernel.org>; Thu, 22 Jun 2017 05:55:36 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] generic: test writev with page fault when it processes iov
Date: Thu, 22 Jun 2017 13:55:33 +0800
Message-Id: <1498110933-12890-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We met a kernel assertion failure recently as below:

  XFS: Assertion failed: tp->t_blk_res_used <= tp->t_blk_res, file: fs/xfs/xfs_trans.c, line: 309

Eric Sandeen digged into it and find a good reproducer.

The problem comes when the several IO vectors are copied in, and
it runs into page faults, which stops the copy before all vectors
are copied. XFS sees this as a failed/short write, and so tries
to unmap the blocks & truncate away the pages in xfs_vm_write_end.

generic_perform_write is looping, and comes back around for the
other iovecs, but the page is still there, the buffer head is still
mapped, and so a new delalloc block isn't allocated - and ends up
being allocated at writeback time, despite the fact that we "should"
have accounted for it all at delalloc write time, and trips the
assert.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V3 did below changes:
1) #define DEF_IOV_CNT 3
2) check endptr after strtol()
3) exit if malloc/calloc fails
4) explain more about why no pre-writing before writev

Thanks,
Zorro

 .gitignore                |   1 +
 src/Makefile              |   2 +-
 src/writev_on_pagefault.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/441         |  61 +++++++++++++++++++++++++
 tests/generic/441.out     |   2 +
 tests/generic/group       |   1 +
 6 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 src/writev_on_pagefault.c
 create mode 100755 tests/generic/441
 create mode 100644 tests/generic/441.out

diff --git a/.gitignore b/.gitignore
index 39664b0..043e87f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -130,6 +130,7 @@
 /src/unwritten_sync
 /src/usemem
 /src/writemod
+/src/writev_on_pagefault
 /src/xfsctl
 /src/aio-dio-regress/aio-dio-extend-stat
 /src/aio-dio-regress/aio-dio-fcntl-race
diff --git a/src/Makefile b/src/Makefile
index 6b0e4b0..9d54fe7 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -9,7 +9,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	nametest permname randholes runas truncfile usemem \
 	mmapcat append_reader append_writer dirperf metaperf \
 	devzero feature alloc fault fstest t_access_root \
-	godown resvtest writemod makeextents itrash rename \
+	godown resvtest writemod writev_on_pagefault makeextents itrash rename \
 	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
 	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
diff --git a/src/writev_on_pagefault.c b/src/writev_on_pagefault.c
new file mode 100644
index 0000000..6247bdf
--- /dev/null
+++ b/src/writev_on_pagefault.c
@@ -0,0 +1,114 @@
+/*
+ * Takes page fault while writev is iterating over the vectors in the IOV
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/uio.h>
+#include <limits.h>
+
+#ifndef IOV_MAX
+#define IOV_MAX 1024
+#endif
+#define DEF_IOV_CNT 3
+
+
+void usage(char *progname)
+{
+	fprintf(stderr, "usage: %s [-i iovcnt] filename\n", progname);
+	fprintf(stderr, "\t-i iovcnt: the count of io vectors (max is 1024), 3 by default\n");
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd, i, c;
+	size_t ret;
+	struct iovec *iov;
+	int pagesz = 4096;
+	char *data = NULL;
+	char *filename = NULL;
+	int iov_cnt = DEF_IOV_CNT;
+
+
+	while ((c = getopt(argc, argv, "i:")) != -1) {
+		char *endp;
+
+		switch (c) {
+		case 'i':
+			iov_cnt = strtol(optarg, &endp, 0);
+			if (*endp) {
+				fprintf(stderr, "Invalid iov count %s\n", optarg);
+				usage(argv[0]);
+			}
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (iov_cnt > IOV_MAX || iov_cnt <= 0)
+		usage(argv[0]);
+
+	if (optind == argc - 1)
+		filename = argv[optind];
+	else
+		usage(argv[0]);
+
+	pagesz = getpagesize();
+	data = malloc(pagesz * iov_cnt);
+	if (!data) {
+		perror("malloc failed");
+		return 1;
+	}
+
+	/*
+	 * NOTE: no pre-writing/reading on the buffer before writev, to
+	 * stop page prefaulting
+	 */
+
+	iov = calloc(iov_cnt, sizeof(struct iovec));
+	if (!iov) {
+		perror("calloc failed");
+		return 1;
+	}
+
+	for (i = 0; i < iov_cnt; i++) {
+		(iov + i)->iov_base = (data + pagesz * i);
+		(iov + i)->iov_len  = 1;
+	}
+
+	if ((fd = open(filename, O_TRUNC|O_CREAT|O_RDWR, 0644)) < 0) {
+		perror("open failed");
+		return 1;
+	}
+
+	ret = writev(fd, iov, iov_cnt);
+	if (ret < 0)
+		perror("writev failed");
+	else
+		printf("wrote %d bytes\n", (int)ret);
+
+	close(fd);
+	return 0;
+}
diff --git a/tests/generic/441 b/tests/generic/441
new file mode 100755
index 0000000..89e12b0
--- /dev/null
+++ b/tests/generic/441
@@ -0,0 +1,61 @@
+#! /bin/bash
+# FS QA Test 441
+#
+# Takes page fault while writev is iterating over the vectors in the IOV
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
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
+_supported_os Linux
+_require_test
+_require_test_program "writev_on_pagefault"
+
+# This program use several vectors for writev(), the kernel goes over them
+# one at a time, copying them from userspace, getting the user data ready
+# for IO. If it takes a page fault while iterating over the vectors in the
+# IOV, it stops, and sends what it got so far. We try to find a bug at this
+# moment.
+$here/src/writev_on_pagefault $TEST_DIR/testfile.$seq
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/441.out b/tests/generic/441.out
new file mode 100644
index 0000000..2d5acf9
--- /dev/null
+++ b/tests/generic/441.out
@@ -0,0 +1,2 @@
+QA output created by 441
+wrote 3 bytes
diff --git a/tests/generic/group b/tests/generic/group
index ab1e9d3..5046c97 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -443,3 +443,4 @@
 438 auto
 439 auto quick punch
 440 auto quick encrypt
+441 auto quick rw
-- 
2.7.5

