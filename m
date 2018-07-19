Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731442AbeGSSql (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Jul 2018 14:46:41 -0400
From: fdmanana@kernel.org
Subject: [PATCH] fstests: add test for fsync after renaming hard links of same file
Date: Thu, 19 Jul 2018 19:02:20 +0100
Message-Id: <20180719180220.20183-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we have a file with 2 (or more) hard links in the same parent
directory, rename of the hard links, rename one of the other hard links to
the old name of the hard link we renamed before, create a new file in the
same parent directory with the old name of second hard link we renamed,
fsync fsync this new file and power fail, we will be able to mount again
the filesystem and the new file and all hard links exist.

This test is motivated by a bug found in btrfs, where mounting the
filesystem after the power failure resulted in failure with an errno
value of EEXIST, which is fixed by a patch for the linux kernel titled:

  "Btrfs: fix mount failure after fsync due to hard link recreation"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/502     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/502.out | 11 +++++++
 tests/generic/group   |  1 +
 3 files changed, 91 insertions(+)
 create mode 100755 tests/generic/502
 create mode 100644 tests/generic/502.out

diff --git a/tests/generic/502 b/tests/generic/502
new file mode 100755
index 00000000..a60ac9a7
--- /dev/null
+++ b/tests/generic/502
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 502
+#
+# Test that if we have a file with 2 (or more) hard links in the same parent
+# directory, rename of the hard links, rename one of the other hard links to
+# the old name of the hard link we renamed before, create a new file in the
+# same parent directory with the old name of second hard link we renamed, fsync
+# fsync this new file and power fail, we will be able to mount again the
+# filesystem and the new file and all hard links exist.
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
+# Create our test file with 2 hard links in the same parent directory.
+mkdir $SCRATCH_MNT/testdir
+touch $SCRATCH_MNT/testdir/foo
+ln $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar
+
+# Make sure everything done so far is durably persisted.
+sync
+
+# Now rename the first hard link (foo) to a new name and rename the second hard
+# link (bar) to the old name of the first hard link (foo).
+mv $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/qwerty
+mv $SCRATCH_MNT/testdir/bar $SCRATCH_MNT/testdir/foo
+
+# Create a new file, in the same parent directory, with the old name of the
+# second hard link (bar) and fsync this new file.
+touch $SCRATCH_MNT/testdir/bar
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/bar
+
+echo "Contents of test directory before the power failure:"
+ls -R $SCRATCH_MNT/testdir | _filter_scratch
+
+# Simulate a power failure and mount the filesystem to check that we are able to
+# mount it and we have the same files, with the same hard links, that we had
+# before the power failure and in the same order.
+_flakey_drop_and_remount
+
+echo "Contents of test directory after the power failure:"
+ls -R $SCRATCH_MNT/testdir | _filter_scratch
+
+_unmount_flakey
+_cleanup_flakey
+
+status=0
+exit
diff --git a/tests/generic/502.out b/tests/generic/502.out
new file mode 100644
index 00000000..0f43f0fb
--- /dev/null
+++ b/tests/generic/502.out
@@ -0,0 +1,11 @@
+QA output created by 502
+Contents of test directory before the power failure:
+SCRATCH_MNT/testdir:
+bar
+foo
+qwerty
+Contents of test directory after the power failure:
+SCRATCH_MNT/testdir:
+bar
+foo
+qwerty
diff --git a/tests/generic/group b/tests/generic/group
index 029c002c..d0b7dcf6 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -504,3 +504,4 @@
 499 auto quick rw collapse zero
 500 auto thin trim
 501 auto quick clone log
+502 auto quick log
-- 
2.11.0

