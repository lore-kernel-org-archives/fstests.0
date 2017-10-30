Received: from mail-pf0-f174.google.com ([209.85.192.174]:49588 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdJ3Wdc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Oct 2017 18:33:32 -0400
From: Justin Maggard <jmaggard10@gmail.com>
Subject: [PATCH] btrfs: test if receive with qgroups corrupts metadata
Date: Mon, 30 Oct 2017 15:32:45 -0700
Message-Id: <20171030223245.21877-1-jmaggard@netgear.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: Justin Maggard <jmaggard@netgear.com>
List-ID: <fstests@vger.kernel.org>

This test case does some concurrent send/receives with qgroups enabled.
Currently (4.14-rc7) this usually results in btrfs check errors, and
often also results in a WARN_ON in record_root_in_trans().

Bisecting points to 6426c7ad697d (btrfs: qgroup: Fix qgroup accounting
when creating snapshot) as the culprit.

Signed-off-by: Justin Maggard <jmaggard@netgear.com>
---
 tests/btrfs/152     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/152.out |  13 +++++++
 tests/btrfs/group   |   1 +
 3 files changed, 116 insertions(+)
 create mode 100755 tests/btrfs/152
 create mode 100644 tests/btrfs/152.out

diff --git a/tests/btrfs/152 b/tests/btrfs/152
new file mode 100755
index 0000000..ebb88ed
--- /dev/null
+++ b/tests/btrfs/152
@@ -0,0 +1,102 @@
+#! /bin/bash
+# FS QA Test No. btrfs/152
+#
+# Test that incremental send/receive operations don't corrupt metadata when
+# qgroups are enabled.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (c) 2017 NETGEAR, Inc.  All Rights Reserved.
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
+_require_scratch
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Enable quotas
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+
+# Create 2 source and 4 destination subvolumes
+for subvol in subvol1 subvol2 recv1_1 recv1_2 recv2_1 recv2_2; do
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/$subvol | _filter_scratch
+done
+mkdir $SCRATCH_MNT/subvol{1,2}/.snapshots
+touch $SCRATCH_MNT/subvol{1,2}/foo
+
+# Create base snapshots and send them
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
+	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
+	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
+for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
+	$BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> /dev/null | \
+		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
+done
+
+# Now do 10 loops of concurrent incremental send/receives
+for i in `seq 1 10`; do
+	prev=$i
+	curr=$((i+1))
+
+	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
+		$SCRATCH_MNT/subvol1/.snapshots/${curr} > /dev/null
+	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol1/.snapshots/${prev} \
+		$SCRATCH_MNT/subvol1/.snapshots/${curr} 2> /dev/null | \
+		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv1_1) > /dev/null &
+	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol1/.snapshots/${prev} \
+		$SCRATCH_MNT/subvol1/.snapshots/${curr} 2> /dev/null | \
+		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv1_2) > /dev/null &
+
+	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
+		$SCRATCH_MNT/subvol2/.snapshots/${curr} > /dev/null
+	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol2/.snapshots/${prev} \
+		$SCRATCH_MNT/subvol2/.snapshots/${curr} 2> /dev/null | \
+		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv2_1) > /dev/null &
+	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol2/.snapshots/${prev} \
+		$SCRATCH_MNT/subvol2/.snapshots/${curr} 2> /dev/null | \
+		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv2_2) > /dev/null &
+	wait
+done
+
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
new file mode 100644
index 0000000..a95bb57
--- /dev/null
+++ b/tests/btrfs/152.out
@@ -0,0 +1,13 @@
+QA output created by 152
+Create subvolume 'SCRATCH_MNT/subvol1'
+Create subvolume 'SCRATCH_MNT/subvol2'
+Create subvolume 'SCRATCH_MNT/recv1_1'
+Create subvolume 'SCRATCH_MNT/recv1_2'
+Create subvolume 'SCRATCH_MNT/recv2_1'
+Create subvolume 'SCRATCH_MNT/recv2_2'
+Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/subvol1/.snapshots/1'
+Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/subvol2/.snapshots/1'
+At subvol 1
+At subvol 1
+At subvol 1
+At subvol 1
diff --git a/tests/btrfs/group b/tests/btrfs/group
index e17c275..fb94461 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -154,3 +154,4 @@
 149 auto quick send compress
 150 auto quick dangerous
 151 auto quick
+152 auto quick metadata qgroup send
-- 
2.1.4

