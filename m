Received: from mx1.redhat.com ([209.132.183.28]:56682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfI0Kiv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 06:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F8818AC6F6
        for <fstests@vger.kernel.org>; Fri, 27 Sep 2019 10:38:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
Subject: [PATCH v3] generic: fallocate two bytes at block boundary
Date: Fri, 27 Sep 2019 12:38:46 +0200
Message-Id: <20190927103846.21296-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Max Reitz <mreitz@redhat.com>
List-ID: <fstests@vger.kernel.org>

Allocating two bytes at a block boundary with fallocate should allocate
both blocks involved.  Test this by writing data to both bytes
afterwards and see whether the on-disk size increases (it should not).

This is a regression test for the kernel patch "xfs: Fix tail rounding
in xfs_alloc_file_space()".

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
v3:
- Use test directory instead of scratch mount
- Add reference to the corresponding XFS patch to the commit message
- Add test to the "prealloc" group

v2:
- Use _get_file_block_size instead of manual stat -fc '%S'
- Use xfs_io instead of fallocate/dd
  (and require falloc support)
- Add the ' B' that was missing as allocated_size_after's unit in the
  error message
---
 tests/generic/568     | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/568.out |  4 +++
 tests/generic/group   |  1 +
 3 files changed, 65 insertions(+)
 create mode 100755 tests/generic/568
 create mode 100644 tests/generic/568.out

diff --git a/tests/generic/568 b/tests/generic/568
new file mode 100755
index 00000000..a3c0b4ae
--- /dev/null
+++ b/tests/generic/568
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test No. generic/568
+#
+# Test that fallocating an unaligned range allocates all blocks
+# touched by that range
+#
+seq=$(basename $0)
+seqres="$RESULT_DIR/$seq"
+echo "QA output created by $seq"
+
+here=$PWD
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f "$tmp".*
+	rm -f "$TEST_DIR/falloctest-$seq"
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_xfs_io_command "falloc"
+
+testfile="$TEST_DIR/falloctest-$seq"
+
+# Fallocate 2 bytes across a block boundary
+block_size=$(_get_file_block_size "$TEST_DIR")
+$XFS_IO_PROG -f -c "falloc $((block_size - 1)) 2" "$testfile"
+
+# Both the first blocks should be allocated now.  Check that by
+# inquiring whether the file grows when we write to the two bytes we
+# have just fallocated.
+
+allocated_size_before=$(($(stat -c '%b * %B' "$testfile")))
+
+$XFS_IO_PROG -c "pwrite $((block_size - 1)) 2" "$testfile" \
+	| _filter_xfs_io | sed -e "s/$((block_size - 1))/block_size - 1/"
+
+allocated_size_after=$(($(stat -c '%b * %B' "$testfile")))
+
+if [ $allocated_size_after -gt $allocated_size_before ]; then
+	echo "ERROR: File grew from ${allocated_size_before} B to" \
+	     "${allocated_size_after} B when writing to the fallocated range."
+else
+	echo "OK: File did not grow."
+fi
+
+status=0
+exit
diff --git a/tests/generic/568.out b/tests/generic/568.out
new file mode 100644
index 00000000..435a9630
--- /dev/null
+++ b/tests/generic/568.out
@@ -0,0 +1,4 @@
+QA output created by 568
+wrote 2/2 bytes at offset block_size - 1
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+OK: File did not grow.
diff --git a/tests/generic/group b/tests/generic/group
index 7cf4f6c4..dd971f0c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -570,3 +570,4 @@
 565 auto quick copy_range
 566 auto quick quota metadata
 567 auto quick rw punch
+568 auto quick rw prealloc
-- 
2.21.0
