Received: from synology.com ([59.124.61.242]:58731 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935369AbdADLuQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Jan 2017 06:50:16 -0500
From: robbieko <robbieko@synology.com>
Subject: [PATCH v3 4/4] xfstests: btrfs/134: add test for incremental send which renames a directory already being deleted
Date: Wed,  4 Jan 2017 18:53:30 +0800
Message-Id: <1483527210-2530-5-git-send-email-robbieko@synology.com>
In-Reply-To: <1483527210-2530-1-git-send-email-robbieko@synology.com>
References: <1483527210-2530-1-git-send-email-robbieko@synology.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Robbie Ko <robbieko@synology.com>
List-ID: <fstests@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

Test that an incremental send operation dosen't work because
it tries to rename a directory which is already deleted.

This test exercises scenarios used to fail in btrfs and are fixed by
the following patch for the linux kernel:

"Btrfs: incremental send, add generation check for inode is waiting for move."

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
V3: remove "run_" based helpers
V2: improve the change log

 tests/btrfs/134     | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/134.out |   9 ++++
 tests/btrfs/group   |   1 +
 3 files changed, 134 insertions(+)
 create mode 100755 tests/btrfs/134
 create mode 100644 tests/btrfs/134.out

diff --git a/tests/btrfs/134 b/tests/btrfs/134
new file mode 100755
index 0000000..87c108e
--- /dev/null
+++ b/tests/btrfs/134
@@ -0,0 +1,124 @@
+#! /bin/bash
+# FS QA Test No. btrfs/134
+#
+# Test that an incremental send operation dosen't work because
+# it tries to rename a directory which is already deleted.
+#
+#-----------------------------------------------------------------------
+# Copyright (C) 2016 Synology Inc. All Rights Reserved.
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
+mkdir $SCRATCH_MNT/d1
+mkdir $SCRATCH_MNT/d4
+mkdir $SCRATCH_MNT/d3
+
+# Filesystem looks like:
+#
+# .                                                             (ino 256)
+# |--- d1                                                       (ino 257)
+# |--- d4                                                       (ino 258)
+# |--- d3                                                       (ino 259)
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
+mkdir $SCRATCH_MNT/d1
+mkdir $SCRATCH_MNT/d2
+mkdir $SCRATCH_MNT/d3
+mkdir $SCRATCH_MNT/d4
+mv $SCRATCH_MNT/d1 $SCRATCH_MNT/d3/d1
+mv $SCRATCH_MNT/d3 $SCRATCH_MNT/d4/d3
+mv $SCRATCH_MNT/d2 $SCRATCH_MNT/d1
+
+# Filesystem now looks like:
+#
+# .                                                             (ino 256)
+# |--- d1                                                       (ino 258)
+# |--- d4                                                       (ino 260)
+# |    |--- d3/                                                 (ino 259)
+# |    |    |--- d1/                                            (ino 257)
+#
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+    $SCRATCH_MNT/mysnap2 > /dev/null
+
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
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/1.snap > /dev/null
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$BTRFS_UTIL_PROG receive $SCRATCH_MNT -f $send_files_dir/2.snap > /dev/null
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/134.out b/tests/btrfs/134.out
new file mode 100644
index 0000000..700a78f
--- /dev/null
+++ b/tests/btrfs/134.out
@@ -0,0 +1,9 @@
+QA output created by 134
+At subvol SCRATCH_MNT/mysnap1
+At subvol mysnap1
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 779caec..831283e 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -136,3 +136,4 @@
 131 auto quick send
 132 auto quick send
 133 auto quick send
+134 auto quick send
-- 
1.9.1

