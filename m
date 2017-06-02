Received: from mail-oi0-f43.google.com ([209.85.218.43]:34877 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdFBIXu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Jun 2017 04:23:50 -0400
Received: by mail-oi0-f43.google.com with SMTP id l18so83177704oig.2
        for <fstests@vger.kernel.org>; Fri, 02 Jun 2017 01:23:49 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] generic: test Btrfs delalloc accounting overflow
Date: Fri,  2 Jun 2017 01:23:41 -0700
Message-Id: <49a0c7551c337566be29b2c073ba0be57779d321.1496391726.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

This is a regression test for "[PATCH] Btrfs: fix delalloc accounting
leak caused by u32 overflow". It creates a bunch of delalloc extents and
merges them together to make sure the accounting is done right.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/generic/438     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/438.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100755 tests/generic/438
 create mode 100644 tests/generic/438.out

diff --git a/tests/generic/438 b/tests/generic/438
new file mode 100755
index 00000000..8edac03d
--- /dev/null
+++ b/tests/generic/438
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FS QA Test 438
+#
+# Test delayed allocation with a large number of extents that are merged.
+# Regression test for patch "Btrfs: fix delalloc accounting leak caused by u32
+# overflow".
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Facebook.  All Rights Reserved.
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
+test_file="$TEST_DIR/$seq"
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.* "$test_file"
+}
+
+. ./common/rc
+. ./common/filter
+
+rm -f $seqres.full
+
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+# Create 32k extents. All of these extents will be accounted as outstanding and
+# reserved.
+for ((i = 0; i < 32 * 1024; i++)); do
+	xfs_io -f -c "pwrite $((2 * 4096 * i)) 4096" "$test_file" >>"$seqres.full"
+done
+
+# Fill in the gaps between the created extents. The outstanding extents will
+# all be merged into 1, but there will still be 32k reserved.
+for ((i = 0; i < 32 * 1024; i++)); do
+	xfs_io -f -c "pwrite $((2 * 4096 * i + 1)) 4096" "$test_file" >>"$seqres.full"
+done
+
+# Flush the delayed allocations.
+sync
+
+# Make sure that we didn't leak any metadata space.
+if [[ $FSTYP = btrfs ]]; then
+	uuid="$(findmnt -n -o UUID "$TEST_DIR")"
+	cd "/sys/fs/btrfs/$uuid/allocation"
+	echo "$(($(cat metadata/bytes_may_use) - $(cat global_rsv_reserved))) bytes leaked" | grep -v '^0 '
+fi
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/generic/438.out b/tests/generic/438.out
new file mode 100644
index 00000000..4968f4d7
--- /dev/null
+++ b/tests/generic/438.out
@@ -0,0 +1,2 @@
+QA output created by 438
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 438c2990..c804b05d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -440,3 +440,4 @@
 435 auto encrypt
 436 auto quick rw
 437 auto quick
+438 auto
-- 
2.13.0

