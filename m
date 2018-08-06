Received: from mail.kernel.org ([198.145.29.99]:46962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeHFKQj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 6 Aug 2018 06:16:39 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs: test writing into unwritten extent right before snapshotting
Date: Mon,  6 Aug 2018 09:08:39 +0100
Message-Id: <20180806080839.7590-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we write into an unwritten extent of a file when there is no
more space left to allocate in the filesystem and then snapshot the file's
subvolume, after a clean shutdown the data was not lost.

This test is motivated by a bug found by Robbie Ko for which there is a
fix whose patch title is:

  "Btrfs: fix unexpected failure of nocow buffered writes after
   snapshotting when low on space"

Reported-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/170     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/170.out |  8 ++++++
 tests/btrfs/group   |  1 +
 3 files changed, 84 insertions(+)
 create mode 100755 tests/btrfs/170
 create mode 100644 tests/btrfs/170.out

diff --git a/tests/btrfs/170 b/tests/btrfs/170
new file mode 100755
index 00000000..cf6886fd
--- /dev/null
+++ b/tests/btrfs/170
@@ -0,0 +1,75 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 170
+#
+# Test that if we write into an unwritten extent of a file when there is no
+# more space left to allocate in the filesystem and then snapshot the file's
+# subvolume, after a clean shutdown the data was not lost.
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
+_require_xfs_io_command "falloc" "-k"
+
+rm -f $seqres.full
+
+# Use a fixed size filesystem so that we can precisely fill the data block group
+# mkfs.btrfs creates and allocate all unused space for a new data block group.
+# It's important to not use the mixed block groups feature as well because we
+# later want to not have more space available for allocating data extents but
+# still have enough metadata space free for creating the snapshot.
+fs_size=$((2 * 1024 * 1024 * 1024)) # 2Gb
+_scratch_mkfs_sized $fs_size >>$seqres.full 2>&1
+
+# Mount without space cache so that we can precisely fill all data space and
+# unallocated space later (space cache v1 uses data block groups).
+_scratch_mount "-o nospace_cache"
+
+# Create our test file and allocate 1826.25Mb of space for it.
+# This will exhaust the existing data block group and all unallocated space on
+# this small fileystem (2Gb).
+$XFS_IO_PROG -f -c "falloc -k 0 1914961920" $SCRATCH_MNT/foobar
+
+# Write some data to the file and check its digest. This write will result in a
+# NOCOW write because there's no more space available to allocate and the file
+# has preallocated (unwritten) extents.
+$XFS_IO_PROG -c "pwrite -S 0xea -b 128K 0 128K" $SCRATCH_MNT/foobar | _filter_xfs_io
+
+echo "File digest after write:"
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+# Create a snapshot of the subvolume where our file is.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap 2>&1 \
+	| _filter_scratch
+
+# Cleanly unmount the filesystem.
+_scratch_unmount
+
+# Mount the filesystem again and verify the file has the same data it had before
+# we unmounted the filesystem (same digest).
+_scratch_mount
+echo "File digest after mounting the filesystem again:"
+md5sum $SCRATCH_MNT/foobar | _filter_scratch
+
+status=0
+exit
diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
new file mode 100644
index 00000000..4c5fd87a
--- /dev/null
+++ b/tests/btrfs/170.out
@@ -0,0 +1,8 @@
+QA output created by 170
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File digest after write:
+85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+File digest after mounting the filesystem again:
+85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
diff --git a/tests/btrfs/group b/tests/btrfs/group
index b616c73d..3d330eed 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -172,3 +172,4 @@
 167 auto quick replace volume
 168 auto quick send
 169 auto quick send
+170 auto quick snapshot
-- 
2.11.0

