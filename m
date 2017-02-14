Received: from mail.kernel.org ([198.145.29.136]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751517AbdBNUgb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Feb 2017 15:36:31 -0500
From: fdmanana@kernel.org
Subject: [PATCH] fstests: add test for truncate after a mix of dio and buffered writes
Date: Tue, 14 Feb 2017 20:36:17 +0000
Message-Id: <1487104577-14110-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we have a file with a hole, do a mix of direct IO and
buffered writes to it and truncate the file to a size that lies in the
middle of the hole, after unmounting and mounting again the filesystem,
the file has a correct size and no data loss happened.

This test is motivated by a bug found in btrfs when used with the
no-holes feature (i.e. MKFS_OPTIONS="-O no-holes") which is fixed by
the following patch for the linux kernel:

  Btrfs: fix data loss after truncate when using the no-holes feature

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/409     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/409.out |  9 +++++++
 tests/generic/group   |  1 +
 3 files changed, 85 insertions(+)
 create mode 100755 tests/generic/409
 create mode 100644 tests/generic/409.out

diff --git a/tests/generic/409 b/tests/generic/409
new file mode 100755
index 0000000..8d3fd33
--- /dev/null
+++ b/tests/generic/409
@@ -0,0 +1,75 @@
+#! /bin/bash
+# FSQA Test No. 409
+#
+# Test that if we have a file with a hole, do a mix of direct IO and buffered
+# writes to it and truncate the file to a size that lies in the middle of the
+# hole, after unmounting and mounting again the filesystem, the file has a
+# correct size and no data loss happened.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2017 SUSE Linux Products GmbH. All Rights Reserved.
+# Author: Filipe Manana <fdmanana@suse.com>
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
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Create out test file with two extents and a hole between those extents.
+# The extent that lies beyond the hole must be written using direct IO and later
+# we truncate the file to a size that lies within the hole's range.
+$XFS_IO_PROG -f -c "pwrite -S 0x01 0K 32K" $SCRATCH_MNT/foo | _filter_xfs_io
+$XFS_IO_PROG -d -c "pwrite -S 0x02 -b 32K 64K 32K" $SCRATCH_MNT/foo \
+	| _filter_xfs_io
+
+# Now truncate our file to a smaller size that lies behind the offset used by
+# the previous direct IO write and that lies in a file hole.
+$XFS_IO_PROG -c "truncate 60K" $SCRATCH_MNT/foo
+
+# Now get file digests before unmounting the filesystem and after mounting it
+# again. The digests should match (same file data and size in both cases).
+echo "File digest before unmounting the filesystem:"
+md5sum $SCRATCH_MNT/foo | _filter_scratch
+_scratch_cycle_mount
+echo "File digest after mounting again the filesystem:"
+md5sum $SCRATCH_MNT/foo | _filter_scratch
+
+status=0
+exit
diff --git a/tests/generic/409.out b/tests/generic/409.out
new file mode 100644
index 0000000..02a7dc5
--- /dev/null
+++ b/tests/generic/409.out
@@ -0,0 +1,9 @@
+QA output created by 409
+wrote 32768/32768 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 32768/32768 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File digest before unmounting the filesystem:
+3c5ca3c3ab42f4b04d7e7eb0b0d4d806  SCRATCH_MNT/foo
+File digest after mounting again the filesystem:
+3c5ca3c3ab42f4b04d7e7eb0b0d4d806  SCRATCH_MNT/foo
diff --git a/tests/generic/group b/tests/generic/group
index d0bc47d..074b494 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -411,3 +411,4 @@
 406 auto quick dangerous
 407 auto quick clone metadata
 408 auto quick clone dedupe metadata
+409 auto quick metadata
-- 
2.7.0.rc3

