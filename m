Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdFGPgi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Jun 2017 11:36:38 -0400
From: fdmanana@kernel.org
Subject: [PATCH] fstests: btrfs, test incremental send after renaming and linking file
Date: Wed,  7 Jun 2017 16:36:31 +0100
Message-Id: <20170607153631.23227-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation works correctly when an inode A
is renamed, a new hard link added to it and some other inode B is renamed
to the old name of inode A.

The btrfs bug is fixed by the following patch for the linux kernel:

  "Btrfs: send, fix invalid path after renaming and linking file"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/144     | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/144.out |   6 +++
 tests/btrfs/group   |   1 +
 3 files changed, 125 insertions(+)
 create mode 100755 tests/btrfs/144
 create mode 100644 tests/btrfs/144.out

diff --git a/tests/btrfs/144 b/tests/btrfs/144
new file mode 100755
index 00000000..c4c7be2a
--- /dev/null
+++ b/tests/btrfs/144
@@ -0,0 +1,118 @@
+#! /bin/bash
+# FS QA Test No. btrfs/144
+#
+# Test that an incremental send operation works correctly when an inode A is
+# renamed, a new hard link added to it and some other inode B is renamed to
+# the old name of inode A.
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
+touch $SCRATCH_MNT/f1
+touch $SCRATCH_MNT/f2
+touch $SCRATCH_MNT/f3
+
+# Filesystem looks like:
+#
+# .                                                             (ino 256)
+# |
+# |--- f1                                                       (ino 257)
+# |--- f2                                                       (ino 258)
+# |--- f3                                                       (ino 259)
+#
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+mv $SCRATCH_MNT/f3 $SCRATCH_MNT/f4
+ln $SCRATCH_MNT/f2 $SCRATCH_MNT/f5
+mv $SCRATCH_MNT/f2 $SCRATCH_MNT/f3
+mv $SCRATCH_MNT/f1 $SCRATCH_MNT/f2
+
+# Filesystem now looks like:
+#
+# .                                                             (ino 256)
+# |
+# |--- f2                                                       (ino 257)
+# |--- f3                                                       (ino 258)
+# |--- f4                                                       (ino 259)
+# |--- f5                                                       (ino 258)
+#
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+		 $SCRATCH_MNT/mysnap2 > /dev/null
+
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
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+status=0
+exit
diff --git a/tests/btrfs/144.out b/tests/btrfs/144.out
new file mode 100644
index 00000000..f9e34ddb
--- /dev/null
+++ b/tests/btrfs/144.out
@@ -0,0 +1,6 @@
+QA output created by 144
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 6f19619e..f6f20cb7 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -145,3 +145,4 @@
 141 auto quick
 142 auto quick
 143 auto quick
+144 auto quick send
-- 
2.11.0

