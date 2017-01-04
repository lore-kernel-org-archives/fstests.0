Received: from synology.com ([59.124.61.242]:53994 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758101AbdADLAR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Jan 2017 06:00:17 -0500
From: robbieko <robbieko@synology.com>
Subject: [PATCH v3 3/4] xfstests: btrfs/133: add test for incremental send with rmdir applied on wrong name
Date: Wed,  4 Jan 2017 18:53:29 +0800
Message-Id: <1483527210-2530-4-git-send-email-robbieko@synology.com>
In-Reply-To: <1483527210-2530-1-git-send-email-robbieko@synology.com>
References: <1483527210-2530-1-git-send-email-robbieko@synology.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Robbie Ko <robbieko@synology.com>
List-ID: <fstests@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

Test that an incremental send operation doesn't work for rmdir
because it uses the wrong name to delete.

This test exercises scenarios used to fail in btrfs and are fixed by
the following patch for the linux kernel:

"Btrfs: incremental send, skip check overwritten if parents' generation are different"

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
V3: remove "run_" based helpers
V2: improve the change log

 tests/btrfs/133     | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/133.out |   9 ++++
 tests/btrfs/group   |   1 +
 3 files changed, 133 insertions(+)
 create mode 100755 tests/btrfs/133
 create mode 100644 tests/btrfs/133.out

diff --git a/tests/btrfs/133 b/tests/btrfs/133
new file mode 100755
index 0000000..a7375c9
--- /dev/null
+++ b/tests/btrfs/133
@@ -0,0 +1,123 @@
+#! /bin/bash
+# FS QA Test No. btrfs/133
+#
+# Test that an incremental send operation doesn't work for rmdir
+# because it uses the wrong name to delete.
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
+touch $SCRATCH_MNT/f
+mkdir $SCRATCH_MNT/d1
+mkdir $SCRATCH_MNT/d259_old
+mv $SCRATCH_MNT/d1 $SCRATCH_MNT/d259_old/d1
+
+# Filesystem looks like:
+#
+# .                                                             (ino 256)
+# |--- f                                                        (ino 257)
+# |
+# |--- d259_old/                                                (ino 259)
+# |    |--- d1/                                                 (ino 258)
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
+mkdir $SCRATCH_MNT/dir258
+mkdir $SCRATCH_MNT/dir259
+mv $SCRATCH_MNT/d1 $SCRATCH_MNT/dir259/d1
+
+# Filesystem now looks like:
+#
+# .                                                             (ino 256)
+# |--- dir258                                                   (ino 258)
+# |
+# |--- dir259/                                                  (ino 259)
+# |    |--- d1/                                                 (ino 257)
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
diff --git a/tests/btrfs/133.out b/tests/btrfs/133.out
new file mode 100644
index 0000000..ae53750
--- /dev/null
+++ b/tests/btrfs/133.out
@@ -0,0 +1,9 @@
+QA output created by 133
+At subvol SCRATCH_MNT/mysnap1
+At subvol mysnap1
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 1b12382..779caec 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -135,3 +135,4 @@
 130 auto clone send
 131 auto quick send
 132 auto quick send
+133 auto quick send
-- 
1.9.1

