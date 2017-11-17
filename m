Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753239AbdKXLbs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 24 Nov 2017 06:31:48 -0500
From: fdmanana@kernel.org
Subject: [PATCH] btrfs: test send for files with multiple hard links renamed
Date: Fri, 17 Nov 2017 14:49:05 +0000
Message-Id: <20171117144905.17903-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation works if a file that has multiple
hard links has some of its hard links renamed in the send snapshot, with
one of them getting the same path that some other inode had in the send
snapshot.

At the moment this test fails on btrfs and a fix is provived by a linux
kernel patch titled:

  "Btrfs: incremental send, fix wrong unlink path after renaming file"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/155     | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/155.out |   6 +++
 tests/btrfs/group   |   1 +
 3 files changed, 154 insertions(+)
 create mode 100755 tests/btrfs/155
 create mode 100644 tests/btrfs/155.out

diff --git a/tests/btrfs/155 b/tests/btrfs/155
new file mode 100755
index 00000000..37c23260
--- /dev/null
+++ b/tests/btrfs/155
@@ -0,0 +1,147 @@
+#! /bin/bash
+# FS QA Test No. btrfs/155
+#
+# Test that an incremental send operation works if a file that has multiple
+# hard links has some of its hard links renamed in the send snapshot, with one
+# of them getting the same path that some other inode had in the send snapshot.
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
+mkdir $SCRATCH_MNT/a
+touch $SCRATCH_MNT/a/f1
+mkdir -p $SCRATCH_MNT/a/b/c
+ln $SCRATCH_MNT/a/f1 $SCRATCH_MNT/a/b/c/f1l1
+touch $SCRATCH_MNT/a/b/f2
+mkdir $SCRATCH_MNT/d
+mv $SCRATCH_MNT/a/b/c/f1l1 $SCRATCH_MNT/d/f1l1_2
+ln $SCRATCH_MNT/a/b/f2 $SCRATCH_MNT/a/f2l1
+ln $SCRATCH_MNT/a/b/f2 $SCRATCH_MNT/d/f2l2
+mv $SCRATCH_MNT/a/f1 $SCRATCH_MNT/d/f1_2
+
+# Filesystem looks like:
+#
+# .                                                      (ino 256)
+# |---- a/                                               (ino 257)
+# |     |---- b/                                         (ino 259)
+# |     |     |---- c/                                   (ino 260)
+# |     |     |---- f2                                   (ino 261)
+# |     |
+# |     |---- f2l1                                       (ino 261)
+# |
+# |---- d/                                               (ino 262)
+#       |---- f1l1_2                                     (ino 258)
+#       |---- f2l2                                       (ino 261)
+#       |---- f1_2                                       (ino 258)
+#
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+mv $SCRATCH_MNT/d $SCRATCH_MNT/a/b/d2
+mv $SCRATCH_MNT/a/f2l1 $SCRATCH_MNT/d
+mkdir $SCRATCH_MNT/a/f2l1
+ln $SCRATCH_MNT/a/b/d2/f1_2 $SCRATCH_MNT/a/b/f1l2
+mv $SCRATCH_MNT/a/b $SCRATCH_MNT/a/f2l1/b2
+mv $SCRATCH_MNT/a/f2l1/b2/d2 $SCRATCH_MNT/a/f2l1/b2/c/d3
+mv $SCRATCH_MNT/a/f2l1/b2/c/d3/f2l2 $SCRATCH_MNT/a/f2l1/b2/c/d3/f2l2_2
+
+# Filesystem now looks like:
+#
+# .                                                      (ino 256)
+# |---- a/                                               (ino 257)
+# |     |---- f2l1/                                      (ino 263)
+# |             |---- b2/                                (ino 259)
+# |                   |---- c/                           (ino 260)
+# |                   |     |---- d3                     (ino 262)
+# |                   |           |---- f1l1_2           (ino 258)
+# |                   |           |---- f2l2_2           (ino 261)
+# |                   |           |---- f1_2             (ino 258)
+# |                   |
+# |                   |---- f2                           (ino 261)
+# |                   |---- f1l2                         (ino 258)
+# |
+# |---- d                                                (ino 261)
+#
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+		 $SCRATCH_MNT/mysnap2 > /dev/null
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+		 $SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
+
+$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
+	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
+
+# Now recreate the filesystem by receiving both send streams and verify we get
+# the same content that the original filesystem had.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
+# The incremental send operation below used to issue an unlink operation for the
+# path "d/f2l1" after it orphanized inode 262 (renamed it to o262-7-0) and after
+# it created the link named "d" for inode 261, which made the receiver fail on
+# the unlink operation with error code ENOTDIR. That unlink operation should
+# have had the path "o262-7-0/f2l2" instead.
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+status=0
+exit
diff --git a/tests/btrfs/155.out b/tests/btrfs/155.out
new file mode 100644
index 00000000..7dc5e9a2
--- /dev/null
+++ b/tests/btrfs/155.out
@@ -0,0 +1,6 @@
+QA output created by 155
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index c98cf823..b9879e6a 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -157,3 +157,4 @@
 152 auto quick metadata qgroup send
 153 auto quick qgroup
 154 auto quick
+155 auto quick send
-- 
2.11.0

