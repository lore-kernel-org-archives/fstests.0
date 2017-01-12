Received: from mail.kernel.org ([198.145.29.136]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbdASMKM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Jan 2017 07:10:12 -0500
From: fdmanana@kernel.org
Subject: [PATCH v4 1/3] fstests: test btrfs incremental send after replacing a top level inode
Date: Thu, 12 Jan 2017 03:13:13 +0000
Message-Id: <1484190793-17277-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, Robbie Ko <robbieko@synology.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation does not fail when a new inode
replaces an old inode that has the same number but different generation,
and both are direct children of the subvolume/snapshot root.

This is fixed by the following patch for the linux kernel:

  "Btrfs: send, fix failure to rename top level inode due to name
   collision"

Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

v4: Improved changelog and added comments to the test that explain what is
    being tested and the problem.

 tests/btrfs/133     | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/133.out |   8 ++++
 tests/btrfs/group   |   1 +
 3 files changed, 136 insertions(+)
 create mode 100755 tests/btrfs/133
 create mode 100644 tests/btrfs/133.out

diff --git a/tests/btrfs/133 b/tests/btrfs/133
new file mode 100755
index 0000000..5839f17
--- /dev/null
+++ b/tests/btrfs/133
@@ -0,0 +1,127 @@
+#! /bin/bash
+# FS QA Test No. btrfs/133
+#
+# Test that an incremental send operation does not fail when a new inode
+# replaces an old inode that has the same number but different generation,
+# and both are direct children of the subvolume/snapshot root.
+#
+#-----------------------------------------------------------------------
+# Copyright (C) 2017 Synology Inc. All Rights Reserved.
+# Author: Robbie Ko <robbieko@synology.com>
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
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_test
+_require_scratch
+_require_fssum
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
+mkdir $SCRATCH_MNT/a1
+mkdir $SCRATCH_MNT/a2
+
+# Filesystem looks like:
+#
+# .                                                             (ino 256)
+# |--- a1/                                                      (ino 257)
+# |--- a2/                                                      (ino 258)
+#
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+    $SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send $SCRATCH_MNT/mysnap1 -f \
+    $send_files_dir/1.snap 2>&1 1>/dev/null | _filter_scratch
+
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+touch $SCRATCH_MNT/a2
+
+# Filesystem now looks like:
+#
+# .                                                             (ino 256)
+# |--- a2                                                       (ino 257)
+#
+# Notice that at this point inode 257 has a generation with value 7, which is
+# the generation value for a brand new filesystem.
+
+# Now create the second snapshot. This makes the filesystem's current generation
+# value to increase to the value 8, due to a transaction commit performed by the
+# snapshot creation ioctl.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+    $SCRATCH_MNT/mysnap2 > /dev/null
+
+# Now receive the first snapshot created in the first filesystem.
+# Before creating any inodes, the receive command creates the first snapshot,
+# which causes a transaction commit and therefore bumps the filesystem's current
+# generation to the value 9. All the inodes created end up getting a generation
+# value of 9 and the snapshot's root inode (256) gets a generation value of 8.
+$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap > /dev/null
+rm $send_files_dir/1.snap
+
+$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -A -f -w $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+$BTRFS_UTIL_PROG send $SCRATCH_MNT/mysnap1 -f \
+    $send_files_dir/1.snap 2>&1 1>/dev/null | _filter_scratch
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 $SCRATCH_MNT/mysnap2 \
+	-f $send_files_dir/2.snap 2>&1 1>/dev/null | _filter_scratch
+
+# Now recreate the filesystem by receiving both send streams and verify we get
+# the same content that the original filesystem had.
+# The receive for the second snapshot used to fail because the send stream had
+# an operation to rename the new inode 257 (generation 7) from its orphan name
+# to its final name (a2) before the operation to delete (rmdir) the inode 258.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap > /dev/null
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/2.snap > /dev/null
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+status=0
+exit
diff --git a/tests/btrfs/133.out b/tests/btrfs/133.out
new file mode 100644
index 0000000..97f29b1
--- /dev/null
+++ b/tests/btrfs/133.out
@@ -0,0 +1,8 @@
+QA output created by 133
+At subvol SCRATCH_MNT/mysnap1
+At subvol mysnap1
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3fbf706..0cdd413 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -134,3 +134,4 @@
 130 auto clone send
 131 auto quick
 132 auto enospc
+133 auto quick send
-- 
2.7.0.rc3

