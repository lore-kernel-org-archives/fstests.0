Received: from synology.com ([59.124.61.242]:53995 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757775AbdADLAR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Jan 2017 06:00:17 -0500
From: robbieko <robbieko@synology.com>
Subject: [PATCH v3 1/4] xfstests: btrfs/131: add test for an incremental send with name collision
Date: Wed,  4 Jan 2017 18:53:27 +0800
Message-Id: <1483527210-2530-2-git-send-email-robbieko@synology.com>
In-Reply-To: <1483527210-2530-1-git-send-email-robbieko@synology.com>
References: <1483527210-2530-1-git-send-email-robbieko@synology.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Robbie Ko <robbieko@synology.com>
List-ID: <fstests@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

Test that an incremental send operation doesn't work because
there's a name collision in the destination and it's not checked
corretly before the rename operation applies.

This test exercises scenarios used to fail in btrfs and are fixed by
the following patch for the linux kernel:

"Btrfs: incremental send, do not skip generation inconsistency check for inode 256."

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
V3: remove "run_" based helpers
V2: improve the change log

 tests/btrfs/131     | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/131.out |   9 ++++
 tests/btrfs/group   |   1 +
 3 files changed, 125 insertions(+)
 create mode 100755 tests/btrfs/131
 create mode 100644 tests/btrfs/131.out

diff --git a/tests/btrfs/131 b/tests/btrfs/131
new file mode 100755
index 0000000..ed01662
--- /dev/null
+++ b/tests/btrfs/131
@@ -0,0 +1,115 @@
+#! /bin/bash
+# FS QA Test No. btrfs/131
+#
+# Test that an incremental send operation doesn't work because
+# there's a name collision in the destination and it's not checked
+# corretly before the rename operation applies.
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
+mkdir $SCRATCH_MNT/a1
+mkdir $SCRATCH_MNT/a2
+
+# Filesystem looks like:
+#
+# .                                                             (ino 256)
+# |--- a1/                                                      (ino 257)
+# |
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
diff --git a/tests/btrfs/131.out b/tests/btrfs/131.out
new file mode 100644
index 0000000..3bea480
--- /dev/null
+++ b/tests/btrfs/131.out
@@ -0,0 +1,9 @@
+QA output created by 131
+At subvol SCRATCH_MNT/mysnap1
+At subvol mysnap1
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index f3a7a4f..a7a070a 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -133,3 +133,4 @@
 128 auto quick send
 129 auto quick send
 130 auto clone send
+131 auto quick send
-- 
1.9.1

