Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdHNQzZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 Aug 2017 12:55:25 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs: test incremental send with compression and extent cloning
Date: Thu, 10 Aug 2017 22:55:40 +0100
Message-Id: <20170810215540.12986-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send/receive operation will not fail when the
destination filesystem has compression enabled and the source filesystem
has a 4K extent at a file offset 0 that is not compressed and that is
shared.

This currently fails on btrfs and is fixed by the following patch for the
linux kernel:

  "Btrfs: incremental send, fix emission of invalid clone operations"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/149     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/149.out |  14 +++++++
 tests/btrfs/group   |   1 +
 3 files changed, 128 insertions(+)
 create mode 100755 tests/btrfs/149
 create mode 100644 tests/btrfs/149.out

diff --git a/tests/btrfs/149 b/tests/btrfs/149
new file mode 100755
index 00000000..432ec707
--- /dev/null
+++ b/tests/btrfs/149
@@ -0,0 +1,113 @@
+#! /bin/bash
+# FS QA Test No. btrfs/149
+#
+# Test that an incremental send/receive operation will not fail when the
+# destination filesystem has compression enabled and the source filesystem
+# has a 4K extent at a file offset 0 that is not compressed and that is
+# shared.
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
+
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -fr $send_files_dir
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_test
+_require_scratch
+_require_scratch_reflink
+_require_odirect
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -f $seqres.full
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o compress"
+
+# Write to our file using direct IO, so that this way the write ends up not
+# getting compressed, that is, we get a regular extent which is neither
+# inlined nor compressed.
+# Alternatively, we could have mounted the fs without compression enabled,
+# which would result as well in an uncompressed regular extent.
+$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4K" $SCRATCH_MNT/foobar | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+# Clone the regular (not inlined) extent.
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foobar 0 8K 4K" $SCRATCH_MNT/foobar \
+	| _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap2 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+		 $SCRATCH_MNT/mysnap1 2>&1 >/dev/null | _filter_scratch
+
+# Now do an incremental send of the second snapshot. The send stream can have
+# a clone operation to clone the extent at offset 0 to offset 8K. This operation
+# would fail on the receiver if it has compression enabled, since the write
+# operation of the extent at offset 0 was compressed because it was a buffered
+# write operation, and btrfs' clone implementation does not allow cloning inline
+# extents to offsets different from 0.
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+		 $SCRATCH_MNT/mysnap2 2>&1 >/dev/null | _filter_scratch
+
+echo "File digests in the original filesystem:"
+md5sum $SCRATCH_MNT/mysnap1/foobar | _filter_scratch
+md5sum $SCRATCH_MNT/mysnap2/foobar | _filter_scratch
+
+# Now recreate the filesystem by receiving both send streams and verify we get
+# the same file content that the original filesystem had.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o compress"
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+
+echo "File digests in the new filesystem:"
+md5sum $SCRATCH_MNT/mysnap1/foobar | _filter_scratch
+md5sum $SCRATCH_MNT/mysnap2/foobar | _filter_scratch
+
+status=0
+exit
diff --git a/tests/btrfs/149.out b/tests/btrfs/149.out
new file mode 100644
index 00000000..303de928
--- /dev/null
+++ b/tests/btrfs/149.out
@@ -0,0 +1,14 @@
+QA output created by 149
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 4096/4096 bytes at offset 8192
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+File digests in the original filesystem:
+1696b8fe138e867797eb6683cf13d99c  SCRATCH_MNT/mysnap1/foobar
+28feb14349a6f6c67a11967278ed7359  SCRATCH_MNT/mysnap2/foobar
+At subvol mysnap1
+File digests in the new filesystem:
+1696b8fe138e867797eb6683cf13d99c  SCRATCH_MNT/mysnap1/foobar
+28feb14349a6f6c67a11967278ed7359  SCRATCH_MNT/mysnap2/foobar
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 8240b532..70c3f057 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -151,3 +151,4 @@
 146 auto quick
 147 auto quick send
 148 auto quick rw
+149 auto quick send compress
-- 
2.11.0

