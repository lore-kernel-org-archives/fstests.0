Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbfEQPes (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 May 2019 11:34:48 -0400
From: fdmanana@kernel.org
Subject: [PATCH v2] fstests: generic, fsync fuzz tester with fsstress
Date: Fri, 17 May 2019 16:34:31 +0100
Message-Id: <20190517153431.29521-1-fdmanana@kernel.org>
In-Reply-To: <20190515150221.16647-1-fdmanana@kernel.org>
References: <20190515150221.16647-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, jack@suse.sz, guaneryu@gmail.com, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Run fsstress, fsync every file and directory, simulate a power failure and
then verify that all files and directories exist, with the same data and
metadata they had before the power failure.

This test has found already 2 bugs in btrfs, that caused mtime and ctime of
directories not being preserved after replaying the log/journal and loss
of a directory's attributes (such a UID and GID) after replaying the log.
The patches that fix the btrfs issues are titled:

  "Btrfs: fix wrong ctime and mtime of a directory after log replay"
  "Btrfs: fix fsync not persisting changed attributes of a directory"

Running this test 1000 times:

- on xfs, no issues were found

- on ext4 it has resulted in about a dozen journal checksum errors (on a
  5.0 kernel) that resulted in failure to mount the filesystem after the
  simulated power failure with dmflakey, which produces the following
  error in dmesg/syslog:

    [Mon May 13 12:51:37 2019] JBD2: journal checksum error
    [Mon May 13 12:51:37 2019] EXT4-fs (dm-0): error loading journal

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Fixed a few typos in the changelog, add missing _require_test and changed
    the find command to replace '-type f,d' with '\( -type f -o -type d \)'
    since not all versions of the find utility accept the former syntax.

 tests/generic/547     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/547.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/547
 create mode 100644 tests/generic/547.out

diff --git a/tests/generic/547 b/tests/generic/547
new file mode 100755
index 00000000..bcce8fe8
--- /dev/null
+++ b/tests/generic/547
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 547
+#
+# Run fsstress, fsync every file and directory, simulate a power failure and
+# then verify that all files and directories exist, with the same data and
+# metadata they had before the power failure.
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
+_require_test
+_require_scratch
+_require_fssum
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+fssum_files_dir=$TEST_DIR/generic-test-$seq
+rm -fr $fssum_files_dir
+mkdir $fssum_files_dir
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+mkdir $SCRATCH_MNT/test
+args=`_scale_fsstress_args -p 4 -n 100 $FSSTRESS_AVOID -d $SCRATCH_MNT/test`
+args="$args -f mknod=0 -f symlink=0"
+echo "Running fsstress with arguments: $args" >>$seqres.full
+$FSSTRESS_PROG $args >>$seqres.full
+
+# Fsync every file and directory.
+find $SCRATCH_MNT/test \( -type f -o -type d \) -exec $XFS_IO_PROG -c fsync {} \;
+
+# Compute a digest of the filesystem (using the test directory only, to skip
+# fs specific directories such as "lost+found" on ext4 for example).
+$FSSUM_PROG -A -f -w $fssum_files_dir/fs_digest $SCRATCH_MNT/test
+
+# Simulate a power failure and mount the filesystem to check that all files and
+# directories exist and have all data and metadata preserved.
+_flakey_drop_and_remount
+
+# Compute a new digest and compare it to the one we created previously, they
+# must match.
+$FSSUM_PROG -r $fssum_files_dir/fs_digest $SCRATCH_MNT/test
+
+_unmount_flakey
+
+status=0
+exit
diff --git a/tests/generic/547.out b/tests/generic/547.out
new file mode 100644
index 00000000..0f6f1131
--- /dev/null
+++ b/tests/generic/547.out
@@ -0,0 +1,2 @@
+QA output created by 547
+OK
diff --git a/tests/generic/group b/tests/generic/group
index 47e81d96..49639fc9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -549,3 +549,4 @@
 544 auto quick clone
 545 auto quick cap
 546 auto quick clone enospc log
+547 auto quick log
-- 
2.11.0
