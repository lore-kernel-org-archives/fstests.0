Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41828 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718AbbCQRdF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 17 Mar 2015 13:33:05 -0400
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] generic/067: add a testcase to check some inline truncation behaviors
Date: Tue, 17 Mar 2015 10:32:51 -0700
Message-Id: <1426613572-2405-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch introduces a new testcase, generic/067, to test several truncation
cases under the inline feature supported by filesystems.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/generic/067     | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/067.out |  41 ++++++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 156 insertions(+)
 create mode 100755 tests/generic/067
 create mode 100644 tests/generic/067.out

diff --git a/tests/generic/067 b/tests/generic/067
new file mode 100755
index 0000000..97f34b6
--- /dev/null
+++ b/tests/generic/067
@@ -0,0 +1,114 @@
+#! /bin/bash
+# FS QA Test No. generic/067
+#
+# Test small truncation to check inline operations.
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
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_MNT/testfile
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# aligned inline truncation
+$XFS_IO_PROG -t -f \
+-c "pwrite -S 0x58 0 120"       `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
+-c "fsync"	\
+-c "truncate 0"                 `# truncate     |                        |` \
+-c "truncate 160"               `# truncate     |                        |` \
+-c "close"      \
+$testfile | _filter_xfs_io
+
+echo "==== aligned inline truncation ==="
+hexdump -C $testfile
+_scratch_remount
+hexdump -C $testfile
+rm $testfile
+
+# aligned out-of-inline truncation
+$XFS_IO_PROG -t -f \
+-c "pwrite -S 0x58 0 120"       `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
+-c "fsync"	\
+-c "truncate 0"                 `# truncate     |                        |` \
+-c "truncate 8192"              `# truncate     |                        |` \
+-c "close"      \
+$testfile | _filter_xfs_io
+
+echo "==== aligned out-of-inline truncation ==="
+hexdump -C $testfile
+_scratch_remount
+hexdump -C $testfile
+rm $testfile
+
+# unaligned inline truncation
+$XFS_IO_PROG -t -f \
+-c "pwrite -S 0x58 0 120"       `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
+-c "fsync"	\
+-c "truncate 4"                 `# truncate     |XXXX                    |` \
+-c "truncate 160"               `# truncate     |XXXX                    |` \
+-c "close"      \
+$testfile | _filter_xfs_io
+
+echo "==== unaligned inline truncation ==="
+hexdump -C $testfile
+_scratch_remount
+hexdump -C $testfile
+rm $testfile
+
+# unaligned out-of-inline truncation
+$XFS_IO_PROG -t -f \
+-c "pwrite -S 0x58 0 120"       `# write        |XXXXXXXXXXXXXXXXXXXXXXXX|` \
+-c "fsync"	\
+-c "truncate 4"                 `# truncate     |XXXX                    |` \
+-c "truncate 8192"              `# truncate     |XXXX                    |` \
+-c "close"      \
+$testfile | _filter_xfs_io
+
+echo "==== unaligned out-of-inline truncation ==="
+hexdump -C $testfile
+_scratch_remount
+hexdump -C $testfile
+rm $testfile
+
+status=0
+exit
+
diff --git a/tests/generic/067.out b/tests/generic/067.out
new file mode 100644
index 0000000..4cef439
--- /dev/null
+++ b/tests/generic/067.out
@@ -0,0 +1,41 @@
+QA output created by 067
+wrote 120/120 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== aligned inline truncation ===
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000000a0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000000a0
+wrote 120/120 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== aligned out-of-inline truncation ===
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00002000
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00002000
+wrote 120/120 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== unaligned inline truncation ===
+00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
+00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000000a0
+00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
+00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000000a0
+wrote 120/120 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== unaligned out-of-inline truncation ===
+00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
+00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00002000
+00000000  58 58 58 58 00 00 00 00  00 00 00 00 00 00 00 00  |XXXX............|
+00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00002000
diff --git a/tests/generic/group b/tests/generic/group
index e5db772..91c5870 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -69,6 +69,7 @@
 064 auto quick prealloc
 065 metadata auto quick
 066 metadata auto quick
+067 auto quick rw
 068 other auto freeze dangerous stress
 069 rw udf auto quick
 070 attr udf auto quick stress
-- 
2.1.1

