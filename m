Received: from mail.kernel.org ([198.145.29.99]:57690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387918AbeGWJLJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Jul 2018 05:11:09 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs: test send with snapshots that have files deleted while open
Date: Mon, 23 Jul 2018 09:11:03 +0100
Message-Id: <20180723081103.4959-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that we are able to do send operations when one of the source
snapshots (or subvolume) has a file that is deleted while there is still
a open file descriptor for that file.

This test is motivated by a bug found in btrfs which is fixed by a patch
for the linux kernel titled:

  "Btrfs: fix send failure when root has deleted files still open"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/168     | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/168.out |  13 +++++
 tests/btrfs/group   |   1 +
 3 files changed, 150 insertions(+)
 create mode 100755 tests/btrfs/168
 create mode 100644 tests/btrfs/168.out

diff --git a/tests/btrfs/168 b/tests/btrfs/168
new file mode 100755
index 00000000..9a159d61
--- /dev/null
+++ b/tests/btrfs/168
@@ -0,0 +1,136 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 168
+#
+# Test that we are able to do send operations when one of the source snapshots
+# (or subvolume) has a file that is deleted while there is still a open file
+# descriptor for that file.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	rm -fr $send_files_dir
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
+_require_btrfs_command "property"
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
+# Create a subvolume used for first full send test and used to create two
+# snapshots for the incremental send test.
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/sv1 | _filter_scratch
+
+# Create some test files.
+$XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/sv1/foo >>$seqres.full
+$XFS_IO_PROG -f -c "pwrite -S 0x7b 0 90K" $SCRATCH_MNT/sv1/bar >>$seqres.full
+$XFS_IO_PROG -f -c "pwrite -S 0xea 0 256K" $SCRATCH_MNT/sv1/baz >>$seqres.full
+
+# Flush the previous buffered writes, since setting a subvolume to RO mode
+# does not do it and we want to check if the data is correctly transmitted by
+# the send operations.
+sync
+
+# Keep an open file descriptor on file bar.
+exec 73<$SCRATCH_MNT/sv1/bar
+
+# While the file descriptor is open, delete the file, set the subvolume to
+# read-only mode and see if a full send operation succeeds.
+unlink $SCRATCH_MNT/sv1/bar
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro true
+$FSSUM_PROG -A -f -w $send_files_dir/sv1.fssum $SCRATCH_MNT/sv1
+$BTRFS_UTIL_PROG send -f $send_files_dir/sv1.send $SCRATCH_MNT/sv1 2>&1 \
+	| _filter_scratch
+
+# Now that the we did the full send, close the file descriptor and set the
+# subvolume back to read-write mode.
+exec 73>&-
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro false
+
+# Now try an incremental send operation while there's an open file descriptor
+# for a file that was deleted from the send snapshot (while it was in read-write
+# mode).
+
+# Create a snapshot of the subvolume, to be used later as the parent snapshot
+# for an incremental send operation.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap1 \
+	| _filter_scratch
+
+# First do a full send of this snapshot.
+$FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
+$BTRFS_UTIL_PROG send -f $send_files_dir/snap1.send $SCRATCH_MNT/snap1 2>&1 \
+	| _filter_scratch
+
+# Modify file baz, to check that the incremental send operation does not miss
+# that this file has changed.
+$XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" $SCRATCH_MNT/sv1/baz >>$seqres.full
+
+# Create a second snapshot of the subvolume, to be used later as the send
+# snapshot of an incremental send operation.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap2 \
+	| _filter_scratch
+
+# Temporarily turn the second snapshot to read-write mode and then open a file
+# descriptor on its foo file.
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap2 ro false
+exec 73<$SCRATCH_MNT/snap2/foo
+
+# Delete the foo file from the second snapshot while holding the file descriptor
+# open.
+unlink $SCRATCH_MNT/snap2/foo
+
+# Set the second snapshot back to RO mode, so that we can use it for the
+# incremental send operation.
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap2 ro true
+
+# Do the incremental send while there's an open file descriptor on file foo from
+# the second snapshot.
+$FSSUM_PROG -A -f -w $send_files_dir/snap2.fssum $SCRATCH_MNT/snap2
+$BTRFS_UTIL_PROG send -f $send_files_dir/snap2.send -p $SCRATCH_MNT/snap1 \
+	$SCRATCH_MNT/snap2 2>&1 | _filter_scratch
+
+# Now that the incremental send is done close the file descriptor on snap2/foo.
+exec 73>&-
+
+# Recreate the filesystem using the send streams and check all files exist,
+# except for the ones we deleted while holding an open file descriptor on them,
+# and with correct data and metadata (size, timestamps, ownership, permissions).
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/sv1.send $SCRATCH_MNT
+$FSSUM_PROG -r $send_files_dir/sv1.fssum $SCRATCH_MNT/sv1
+$BTRFS_UTIL_PROG receive -f $send_files_dir/snap1.send $SCRATCH_MNT
+$FSSUM_PROG -r $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
+$BTRFS_UTIL_PROG receive -f $send_files_dir/snap2.send $SCRATCH_MNT
+$FSSUM_PROG -r $send_files_dir/snap2.fssum $SCRATCH_MNT/snap2
+
+status=0
+exit
diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
new file mode 100644
index 00000000..6cfce8cd
--- /dev/null
+++ b/tests/btrfs/168.out
@@ -0,0 +1,13 @@
+QA output created by 168
+Create subvolume 'SCRATCH_MNT/sv1'
+At subvol SCRATCH_MNT/sv1
+Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
+At subvol SCRATCH_MNT/snap1
+Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
+At subvol SCRATCH_MNT/snap2
+At subvol sv1
+OK
+At subvol snap1
+OK
+At snapshot snap2
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 5cff3bd6..5b132651 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -170,3 +170,4 @@
 165 auto quick subvol
 166 auto quick qgroup
 167 auto quick replace volume
+168 auto quick send
-- 
2.11.0

