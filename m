Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41846 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932620AbbCQRdI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 17 Mar 2015 13:33:08 -0400
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs/001: introduce a testcaes for -ENOSPC with inline operation
Date: Tue, 17 Mar 2015 10:32:52 -0700
Message-Id: <1426613572-2405-2-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1426613572-2405-1-git-send-email-jaegeuk@kernel.org>
References: <1426613572-2405-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch introduces f2fs/001 to test -ENOSPC when inline operation was
activated.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/f2fs/001     | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/001.out | 21 ++++++++++++++
 tests/f2fs/group   |  6 ++++
 3 files changed, 108 insertions(+)
 create mode 100755 tests/f2fs/001
 create mode 100644 tests/f2fs/001.out
 create mode 100644 tests/f2fs/group

diff --git a/tests/f2fs/001 b/tests/f2fs/001
new file mode 100755
index 0000000..775b0f1
--- /dev/null
+++ b/tests/f2fs/001
@@ -0,0 +1,81 @@
+#! /bin/bash
+# FS QA Test No. f2fs/001
+#
+# Test -ENSPC wth inline operations.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Jaegeuk Kim.  All Rights Reserved.
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
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+_supported_fs f2fs
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_MNT/testfile
+dummyfile=$SCRATCH_MNT/dummyfile
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+echo "==== create small file ==="
+$XFS_IO_PROG -t -f \
+-c "pwrite -S 0x58 0 120" \
+-c "close" \
+$testfile | _filter_xfs_io
+
+echo "==== fill 100% partition ==="
+$XFS_IO_PROG -t -f \
+-c "falloc 0 8g" \
+-c "close" \
+$dummyfile | _filter_xfs_io
+
+echo "==== change i_size & write data ==="
+$XFS_IO_PROG \
+-c "truncate 4096" \
+-c "pwrite -S 0x58 8192 4096" \
+-c "close" \
+$testfile | _filter_xfs_io
+
+echo "==== check data contents ==="
+hexdump -C $testfile
+_scratch_remount
+hexdump -C $testfile
+
+rm $testfile
+rm $dummyfile
+
+status=0
+exit
diff --git a/tests/f2fs/001.out b/tests/f2fs/001.out
new file mode 100644
index 0000000..8862156
--- /dev/null
+++ b/tests/f2fs/001.out
@@ -0,0 +1,21 @@
+QA output created by 001
+==== create small file ===
+wrote 120/120 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== fill 100% partition ===
+fallocate: No space left on device
+==== change i_size & write data ===
+pwrite64: No space left on device
+==== check data contents ===
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+00000070  58 58 58 58 58 58 58 58  00 00 00 00 00 00 00 00  |XXXXXXXX........|
+00000080  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001000
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+00000070  58 58 58 58 58 58 58 58  00 00 00 00 00 00 00 00  |XXXXXXXX........|
+00000080  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001000
diff --git a/tests/f2fs/group b/tests/f2fs/group
new file mode 100644
index 0000000..daba9a3
--- /dev/null
+++ b/tests/f2fs/group
@@ -0,0 +1,6 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
+001 auto quick rw
-- 
2.1.1

