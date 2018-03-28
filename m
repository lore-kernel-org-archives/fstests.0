Received: from mail.kernel.org ([198.145.29.99]:56680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeDBOWp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 2 Apr 2018 10:22:45 -0400
From: fdmanana@kernel.org
Subject: [PATCH v2] fstests: test btrfs fsync after hole punching with no-holes mode
Date: Wed, 28 Mar 2018 12:55:30 +0100
Message-Id: <20180328115530.15563-1-fdmanana@kernel.org>
In-Reply-To: <20180326225921.10096-1-fdmanana@kernel.org>
References: <20180326225921.10096-1-fdmanana@kernel.org>
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

V2: Made the test work when selinux is enabled, and made it use direct IO
    writes to ensure 256K extents.

 tests/btrfs/159     | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/159.out |   9 ++++
 tests/btrfs/group   |   1 +
 3 files changed, 125 insertions(+)
 create mode 100755 tests/btrfs/159
 create mode 100644 tests/btrfs/159.out

diff --git a/tests/btrfs/159 b/tests/btrfs/159
new file mode 100755
index 00000000..eb667692
--- /dev/null
+++ b/tests/btrfs/159
@@ -0,0 +1,115 @@
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
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_dm_target flakey
+_require_xfs_io_command "fpunch"
+_require_odirect
+
+rm -f $seqres.full
+
+run_test()
+{
+	local punch_offset=$1
+
+	# We create the filesystem with a node size of 64Kb because we need to
+	# create a specific metadata layout in order to trigger the bug we are
+	# testing. At the moment the node size can not be smaller then the
+	# system's page size, so given that the largest possible page size is
+	# 64Kb and by default the node size is set to the system's page size
+	# value, we explicitly create a filesystem with a 64Kb node size.
+	_scratch_mkfs -O no-holes -n $((64 * 1024)) >>$seqres.full 2>&1
+	_require_metadata_journaling $SCRATCH_DEV
+	_init_flakey
+	_mount_flakey
+
+	# Create our test file with 832 extents of 256Kb each. Before each
+	# extent, there is a 256Kb hole (except for the first extent, which
+	# starts at offset 0). This creates two leafs in the filesystem tree.
+	# We use direct IO to ensure we get exactly 256K extents (with buffered
+	# IO we can get writeback triggered at any time and therefore get
+	# extents smaller than 256K).
+	for ((i = 0; i <= 831; i++)); do
+		local offset=$((i * 2 * 256 * 1024))
+		$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b 256K $offset 256K" \
+			$SCRATCH_MNT/foobar >/dev/null
+	done
+
+	# Make sure everything done so far is durably persisted.
+	sync
+
+	# Now punch a hole that covers part of the extent at offset
+	# "$punch_offset".
+	# We want to punch a hole that starts in the middle of the last extent
+	# item in the first leaf. On a system without selinux enabled that is
+	# the extent that starts at offset 216530944, while on a system with it
+	# enabled it is the extent that starts at offset 216006656 (because
+	# selinux causes a xattr item to be added to our test file).
+	$XFS_IO_PROG -c "fpunch $((punch_offset + 128 * 1024 - 4000)) 256K" \
+		     -c "fsync" \
+		     $SCRATCH_MNT/foobar
+
+	echo "File digest before power failure:"
+	md5sum $SCRATCH_MNT/foobar | _filter_scratch
+	# Simulate a power failure and mount the filesystem to check that
+	# replaying the fsync log/journal succeeds and our test file has the
+	# expected content.
+	_flakey_drop_and_remount
+	echo "File digest after power failure and log replay:"
+	md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+	_unmount_flakey
+	_cleanup_flakey
+}
+
+run_test 216006656
+run_test 216530944
+
+status=0
+exit
diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
new file mode 100644
index 00000000..a4be9182
--- /dev/null
+++ b/tests/btrfs/159.out
@@ -0,0 +1,9 @@
+QA output created by 159
+File digest before power failure:
+f049865ed45b1991dc9a299b47d51dbf  SCRATCH_MNT/foobar
+File digest after power failure and log replay:
+f049865ed45b1991dc9a299b47d51dbf  SCRATCH_MNT/foobar
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

