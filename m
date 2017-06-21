Received: from mx1.redhat.com ([209.132.183.28]:54814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752579AbdFUIXi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Jun 2017 04:23:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 890B9C04D29A
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2017 08:23:32 +0000 (UTC)
Received: from dhcp-12-155.nay.redhat.com (dhcp-12-155.nay.redhat.com [10.66.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C75D086340
        for <fstests@vger.kernel.org>; Wed, 21 Jun 2017 08:23:30 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic: test writev with pega fault when it processes iov
Date: Wed, 21 Jun 2017 16:23:26 +0800
Message-Id: <1498033406-15392-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We met a kernel assertion failure recently as below:

  XFS: Assertion failed: tp->t_blk_res_used <= tp->t_blk_res, file: fs/xfs/xfs_trans.c, line: 309

The problem comes when the several IO vectors are copied in, and
it runs into page faults.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

Although I'm trying to add writev/readv test to fsstress, and it has tiny
chance to cover this bug (very hard to reproduce). But I still think using
a special case to cover this part is better.

Thanks,
Zorro

 .gitignore                |  1 +
 src/Makefile              |  2 +-
 src/writev_on_pagefault.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/441         | 61 ++++++++++++++++++++++++++++++++++++++
 tests/generic/441.out     |  2 ++
 tests/generic/group       |  1 +
 6 files changed, 140 insertions(+), 1 deletion(-)
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
index 0000000..54845c3
--- /dev/null
+++ b/src/writev_on_pagefault.c
@@ -0,0 +1,74 @@
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
+
+#define IOV_CNT	3
+
+void
+usage(char *progname)
+{
+	fprintf(stderr, "usage: %s filename\n", progname);
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd, i;
+	size_t ret;
+	struct iovec *iov;
+	int pagesz = 4096;
+	char *data = NULL;
+
+	if (argc != 2)
+		usage(argv[0]);
+
+	pagesz = getpagesize();
+	data = malloc(pagesz * IOV_CNT);
+
+	/* no pre-writing on the buffer before writev */
+
+        iov = calloc(IOV_CNT, sizeof(struct iovec));
+        for (i = 0; i < IOV_CNT; i++) {
+	        (iov + i)->iov_base = (data + pagesz * i);
+	        (iov + i)->iov_len  = 1;
+        }
+
+        if ((fd = open(argv[1], O_TRUNC|O_CREAT|O_RDWR, 0644)) < 0) {
+	        perror("open failed");
+	        return 1;
+        }
+
+
+        ret = writev(fd, iov, IOV_CNT);
+        if (ret < 0)
+	        perror("writev failed");
+        else
+	        printf("wrote %d bytes\n", (int)ret);
+
+        close(fd);
+        return 0;
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

