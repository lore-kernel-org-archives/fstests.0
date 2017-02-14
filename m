Received: from mail.kernel.org ([198.145.29.136]:37200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdBNUgD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Feb 2017 15:36:03 -0500
From: fdmanana@kernel.org
Subject: [PATCH] fstests: add test for btrfs send/receive with sparse files
Date: Tue, 14 Feb 2017 20:35:53 +0000
Message-Id: <1487104553-13858-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that both a full and incremental btrfs send operation preserves file
holes.

This used to fail when the filesystem had the NO_HOLES feature enabled,
that is, when the test is run with MKFS_OPTIONS="-O no-holes".

This is fixed by the following patch for the linux kernel:

  "Btrfs: incremental send, fix unnecessary hole writes for sparse files"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/137     | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/137.out |  63 +++++++++++++++++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 205 insertions(+)
 create mode 100755 tests/btrfs/137
 create mode 100644 tests/btrfs/137.out

diff --git a/tests/btrfs/137 b/tests/btrfs/137
new file mode 100755
index 0000000..3ff2c6b
--- /dev/null
+++ b/tests/btrfs/137
@@ -0,0 +1,141 @@
+#! /bin/bash
+# FS QA Test No. btrfs/137
+#
+# Test that both incremental and full send operations preserve file holes.
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
+. ./common/punch
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_test
+_require_scratch
+_require_xfs_io_command "fiemap"
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -f $seqres.full
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Create the first test file.
+$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 4K" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Create a second test file with a 1Mb hole.
+$XFS_IO_PROG -f \
+     -c "pwrite -S 0xaa 0 4K" \
+     -c "pwrite -S 0xbb 1028K 4K" \
+     $SCRATCH_MNT/bar | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/snap1 >/dev/null
+
+# Now add one new extent to our first test file, increasing its size and leaving
+# a 1Mb hole between the first extent and this new extent.
+$XFS_IO_PROG -c "pwrite -S 0xbb 1028K 4K" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Now overwrite the last extent of our second test file.
+$XFS_IO_PROG -c "pwrite -S 0xcc 1028K 4K" $SCRATCH_MNT/bar | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+		 $SCRATCH_MNT/snap2 >/dev/null
+
+echo
+echo "File digests in the original filesystem:"
+md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
+md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
+
+echo
+echo "File snap1/foo fiemap results in the original filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/foo | _filter_fiemap
+echo
+echo "File snap1/bar fiemap results in the original filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/bar | _filter_fiemap
+echo
+echo "File snap2/foo fiemap results in the original filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/foo | _filter_fiemap
+echo
+echo "File snap2/bar fiemap results in the original filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/bar | _filter_fiemap
+echo
+
+# Create the send streams to apply later on a new filesystem.
+$BTRFS_UTIL_PROG send $SCRATCH_MNT/snap1 -f $send_files_dir/1.snap 2>&1 \
+	| _filter_scratch
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 \
+	-f $send_files_dir/2.snap 2>&1 | _filter_scratch
+
+# Create a new filesystem, receive the send streams and verify that the file
+# contents are the same as in the original filesystem and that the file holes
+# exists in both snapshots.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap >/dev/null
+$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/2.snap >/dev/null
+
+echo
+echo "File digests in the new filesystem:"
+md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
+md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
+
+echo
+echo "File snap1/foo fiemap results in the new filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/foo | _filter_fiemap
+echo
+echo "File snap1/bar fiemap results in the new filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/bar | _filter_fiemap
+echo
+echo "File snap2/foo fiemap results in the new filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/foo | _filter_fiemap
+echo
+echo "File snap2/bar fiemap results in the new filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/bar | _filter_fiemap
+
+status=0
+exit
diff --git a/tests/btrfs/137.out b/tests/btrfs/137.out
new file mode 100644
index 0000000..8554399
--- /dev/null
+++ b/tests/btrfs/137.out
@@ -0,0 +1,63 @@
+QA output created by 137
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 1052672
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 1052672
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 1052672
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+File digests in the original filesystem:
+3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
+f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
+f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
+d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
+
+File snap1/foo fiemap results in the original filesystem:
+0: [0..7]: data
+
+File snap1/bar fiemap results in the original filesystem:
+0: [0..7]: data
+1: [8..2055]: hole
+2: [2056..2063]: data
+
+File snap2/foo fiemap results in the original filesystem:
+0: [0..7]: data
+1: [8..2055]: hole
+2: [2056..2063]: data
+
+File snap2/bar fiemap results in the original filesystem:
+0: [0..7]: data
+1: [8..2055]: hole
+2: [2056..2063]: data
+
+At subvol SCRATCH_MNT/snap1
+At subvol SCRATCH_MNT/snap2
+At subvol snap1
+
+File digests in the new filesystem:
+3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
+f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
+f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
+d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
+
+File snap1/foo fiemap results in the new filesystem:
+0: [0..7]: data
+
+File snap1/bar fiemap results in the new filesystem:
+0: [0..7]: data
+1: [8..2055]: hole
+2: [2056..2063]: data
+
+File snap2/foo fiemap results in the new filesystem:
+0: [0..7]: data
+1: [8..2055]: hole
+2: [2056..2063]: data
+
+File snap2/bar fiemap results in the new filesystem:
+0: [0..7]: data
+1: [8..2055]: hole
+2: [2056..2063]: data
diff --git a/tests/btrfs/group b/tests/btrfs/group
index ea88ba4..009dea1 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -139,3 +139,4 @@
 134 auto quick send
 135 auto quick send
 136 auto convert
+137 auto quick send
-- 
2.7.0.rc3

