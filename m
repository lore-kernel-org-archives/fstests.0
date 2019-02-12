Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbfBLSI0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Feb 2019 13:08:26 -0500
From: fdmanana@kernel.org
Subject: [PATCH 2/2] fstests: generic, test fsync after succession of renames and unlink
Date: Tue, 12 Feb 2019 18:08:20 +0000
Message-Id: <20190212180820.31014-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that after a combination of file renames, linking and creating a new
file with the old name of a renamed file, if we fsync the new file, after
a power failure we are able to mount the filesystem and all file names
correspond to the correct inodes.

This test is motivated by a bug found in btrfs, which is fixed by applying
the following two patches to the linux kernel:

 "[PATCH 1/2] Btrfs: fix fsync after succession of renames of different files"
 "[PATCH 2/2] Btrfs: fix fsync after succession of renames and unlink/rmdir"

The test passes on ext4, xfs and patched btrfs, however at least in a
5.0-rc5 linux kernel, it fails on f2fs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/527     | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/527.out |  4 +++
 tests/generic/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/527
 create mode 100644 tests/generic/527.out

diff --git a/tests/generic/527 b/tests/generic/527
new file mode 100755
index 00000000..aacccd91
--- /dev/null
+++ b/tests/generic/527
@@ -0,0 +1,71 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 527
+#
+# Test that after a combination of file renames, deletions, linking and creating
+# new files with names that were previously deleted, if we fsync the new file,
+# after a power failure we are able to mount the filesystem and all file names
+# correspond to the correct inodes.
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
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+mkdir $SCRATCH_MNT/testdir
+echo -n "foo" > $SCRATCH_MNT/testdir/fname1
+echo -n "hello" > $SCRATCH_MNT/testdir/fname2
+
+# Make sure everything done so far is durably persisted.
+sync
+
+# Rename, remove and link files such that one new name corresponds to the name
+# of a deleted file and one new file has the old name of the renamed file. Then
+# fsync only the new file.
+mv $SCRATCH_MNT/testdir/fname1 $SCRATCH_MNT/testdir/fname3
+rm -f $SCRATCH_MNT/testdir/fname2
+ln $SCRATCH_MNT/testdir/fname3 $SCRATCH_MNT/testdir/fname2
+echo -n "bar" > $SCRATCH_MNT/testdir/fname1
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/fname1
+
+# Simulate a power failure and mount the filesystem to check that all file names
+# exist and correspond to the correct inodes.
+_flakey_drop_and_remount
+
+echo "File fname1 data after power failure: $(cat $SCRATCH_MNT/testdir/fname1)"
+echo "File fname2 data after power failure: $(cat $SCRATCH_MNT/testdir/fname2)"
+echo "File fname3 data after power failure: $(cat $SCRATCH_MNT/testdir/fname3)"
+
+_unmount_flakey
+
+status=0
+exit
diff --git a/tests/generic/527.out b/tests/generic/527.out
new file mode 100644
index 00000000..3c34e1ff
--- /dev/null
+++ b/tests/generic/527.out
@@ -0,0 +1,4 @@
+QA output created by 527
+File fname1 data after power failure: bar
+File fname2 data after power failure: foo
+File fname3 data after power failure: foo
diff --git a/tests/generic/group b/tests/generic/group
index 492a5875..a38c578a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -529,3 +529,4 @@
 524 auto quick
 525 auto quick rw
 526 auto quick log
+527 auto quick log
-- 
2.11.0
