Received: from mail.kernel.org ([198.145.29.99]:52364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeG3NO5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Jul 2018 09:14:57 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs: test send with prealloc extent beyond EOF and hole punching
Date: Mon, 30 Jul 2018 12:40:17 +0100
Message-Id: <20180730114017.5237-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation produces correct results if a file
that has a prealloc (unwritten) extent beyond its EOF gets a hole punched
in a section of that prealloc extent.

This test is motivated by a bug found in btrfs which is fixed by a patch
for the linux kernel titled:

 "Btrfs: send, fix incorrect file layout after hole punching beyond eof"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/169     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/169.out | 13 +++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 97 insertions(+)
 create mode 100755 tests/btrfs/169
 create mode 100644 tests/btrfs/169.out

diff --git a/tests/btrfs/169 b/tests/btrfs/169
new file mode 100755
index 00000000..80eb5ab3
--- /dev/null
+++ b/tests/btrfs/169
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 169
+#
+# Test that an incremental send operation produces correct results if a file
+# that has a prealloc (unwritten) extent beyond its EOF gets a hole punched
+# in a section of that prealloc extent.
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
+_require_xfs_io_command "fpunch"
+_require_xfs_io_command "falloc" "-k"
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
+# Create our test file with a prealloc extent of 4Mb starting at offset 0,
+# then write 1Mb of data into offset 0.
+$XFS_IO_PROG -f -c "falloc -k 0 4M" \
+	     -c "pwrite -S 0xea 0 1M" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 2>&1 \
+	| _filter_scratch
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
+    | _filter_scratch
+
+# Now punch a hole starting at an offset that corresponds to the file's current
+# size (1Mb) and ends at an offset smaller then the end offset of the prealloc
+# extent we allocated earlier (3Mb < 4Mb).
+$XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 2>&1 \
+	| _filter_scratch
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+		 $SCRATCH_MNT/snap2 2>&1 | _filter_scratch
+
+echo "File digest in the original filesystem:"
+md5sum $SCRATCH_MNT/snap2/foobar | _filter_scratch
+
+# Now recreate the filesystem by receiving both send streams and verify we get
+# the same file content that the original filesystem had.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT
+
+echo "File digest in the new filesystem:"
+md5sum $SCRATCH_MNT/snap2/foobar | _filter_scratch
+
+status=0
+exit
diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
new file mode 100644
index 00000000..ba77bf0a
--- /dev/null
+++ b/tests/btrfs/169.out
@@ -0,0 +1,13 @@
+QA output created by 169
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+At subvol SCRATCH_MNT/snap1
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
+At subvol SCRATCH_MNT/snap2
+File digest in the original filesystem:
+d31659e82e87798acd4669a1e0a19d4f  SCRATCH_MNT/snap2/foobar
+At subvol snap1
+At snapshot snap2
+File digest in the new filesystem:
+d31659e82e87798acd4669a1e0a19d4f  SCRATCH_MNT/snap2/foobar
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 5b132651..b616c73d 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -171,3 +171,4 @@
 166 auto quick qgroup
 167 auto quick replace volume
 168 auto quick send
+169 auto quick send
-- 
2.11.0

