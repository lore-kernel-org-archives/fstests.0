Received: from mail.kernel.org ([198.145.29.99]:57788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeC0IeF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Mar 2018 04:34:05 -0400
From: fdmanana@kernel.org
Subject: [PATCH] fstests: test btrfs fsync after hole punching with no-holes mode
Date: Mon, 26 Mar 2018 23:59:21 +0100
Message-Id: <20180326225921.10096-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that when we have the no-holes mode enabled and a specific metadata
layout, if we punch a hole and fsync the file, at replay time the whole
hole was preserved.

This issue is fixed by the following btrfs patch for the linux kernel:

  "Btrfs: fix fsync after hole punching when using no-holes feature"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/159     | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/159.out |   5 +++
 tests/btrfs/group   |   1 +
 3 files changed, 106 insertions(+)
 create mode 100755 tests/btrfs/159
 create mode 100644 tests/btrfs/159.out

diff --git a/tests/btrfs/159 b/tests/btrfs/159
new file mode 100755
index 00000000..6083975a
--- /dev/null
+++ b/tests/btrfs/159
@@ -0,0 +1,100 @@
+#! /bin/bash
+# FSQA Test No. 159
+#
+# Test that when we have the no-holes mode enabled and a specific metadata
+# layout, if we punch a hole and fsync the file, at replay time the whole
+# hole was preserved.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
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
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmflakey
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_dm_target flakey
+_require_xfs_io_command "fpunch"
+
+rm -f $seqres.full
+
+# We create the filesystem with a node size of 64Kb because we need to create a
+# specific metadata layout in order to trigger the bug we are testing. At the
+# moment the node size can not be smaller then the system's page size, so given
+# that the largest possible page size is 64Kb and by default the node size is
+# set to the system's page size value, we explictly create a filesystem with a
+# 64Kb node size.
+_scratch_mkfs -O no-holes -n $((64 * 1024)) >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test file with 831 extents of 256Kb each. Before each extent, there
+# is a 256Kb hole (except for the first extent, which starts at offset 0). This
+# creates two leafs in the filesystem tree, with the extent at offset 216530944
+# being the last item in the first leaf and the extent at offset 217055232 being
+# the first item in the second leaf.
+for ((i = 0; i <= 831; i++)); do
+	offset=$((i * 2 * 256 * 1024))
+	$XFS_IO_PROG -f -c "pwrite -S 0xab -b 256K $offset 256K" \
+		$SCRATCH_MNT/foobar >/dev/null
+done
+
+# Now persist everything done so far.
+sync
+
+# Now punch a hole that covers part of the extent at offset 216530944.
+$XFS_IO_PROG -c "fpunch $((216530944 + 128 * 1024 - 4000)) 256K" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foobar
+
+echo "File digest before power failure:"
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+# Simulate a power failure and mount the filesystem to check that replaying the
+# fsync log/journal succeeds and our test file has the expected content.
+_flakey_drop_and_remount
+
+echo "File digest after power failure and log replay:"
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+_unmount_flakey
+_cleanup_flakey
+
+status=0
+exit
diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
new file mode 100644
index 00000000..3317e516
--- /dev/null
+++ b/tests/btrfs/159.out
@@ -0,0 +1,5 @@
+QA output created by 159
+File digest before power failure:
+c5c0a13588a639529c979c57c336f441  SCRATCH_MNT/foobar
+File digest after power failure and log replay:
+c5c0a13588a639529c979c57c336f441  SCRATCH_MNT/foobar
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 8007e07e..ba766f6b 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -161,3 +161,4 @@
 156 auto quick trim
 157 auto quick raid
 158 auto quick raid scrub
+159 auto quick
-- 
2.11.0

