Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934166AbeB1P5j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Feb 2018 10:57:39 -0500
From: fdmanana@kernel.org
Subject: [PATCH] generic: add test for fsync after renaming and linking special file
Date: Wed, 28 Feb 2018 15:57:34 +0000
Message-Id: <20180228155734.5899-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that when a fsync journal/log exists, if we rename a special file
(fifo, symbolic link or device), create a hard link for it with its old
name and then commit the journal/log, if a power loss happens the
filesystem will not fail to replay the journal/log when it is mounted
the next time.

This test is motivated by a bug found in btrfs, which is fixed by the
following patch for the linux kernel:

  "Btrfs: fix log replay failure after linking special file and fsync"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/479     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/479.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 115 insertions(+)
 create mode 100644 tests/generic/479
 create mode 100644 tests/generic/479.out

diff --git a/tests/generic/479 b/tests/generic/479
new file mode 100644
index 00000000..7e4ba7d0
--- /dev/null
+++ b/tests/generic/479
@@ -0,0 +1,112 @@
+#! /bin/bash
+# FSQA Test No. 479
+#
+# Test that when a fsync journal/log exists, if we rename a special file (fifo,
+# symbolic link or device), create a hard link for it with its old name and then
+# commit the journal/log, if a power loss happens the filesystem will not fail
+# to replay the journal/log when it is mounted the next time.
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
+
+rm -f $seqres.full
+
+run_test()
+{
+	local file_type=$1
+
+	_scratch_mkfs >>$seqres.full 2>&1
+	_require_metadata_journaling $SCRATCH_DEV
+	_init_flakey
+	_mount_flakey
+
+	mkdir $SCRATCH_MNT/testdir
+	case $file_type in
+	symlink)
+		ln -s xxx $SCRATCH_MNT/testdir/foo
+		;;
+	fifo)
+		mkfifo $SCRATCH_MNT/testdir/foo
+		;;
+	dev)
+		mknod $SCRATCH_MNT/testdir/foo c 0 0
+		;;
+	*)
+		_fail "Invalid file type argument: $file_type"
+	esac
+	# Make sure everything done so far is durably persisted.
+	sync
+
+	# Create a file and fsync it just to create a journal/log. This file
+	# must be in the same directory as our special file "foo".
+	touch $SCRATCH_MNT/testdir/f1
+	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/f1
+
+	# Rename our special file and then create link that has its old name.
+	mv $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar
+	ln $SCRATCH_MNT/testdir/bar $SCRATCH_MNT/testdir/foo
+
+	# Create a second file and fsync it. This is just to durably persist the
+	# fsync journal/log which is typically modified by the previous rename
+	# and link operations. This file does not need to be placed in the same
+	# directory as our special file.
+	touch $SCRATCH_MNT/f2
+	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/f2
+
+	# Simulate a power failure and mount the filesystem to check that
+	# replaying the fsync log/journal succeeds, that is the mount operation
+	# does not fail.
+	_flakey_drop_and_remount
+	_unmount_flakey
+	_cleanup_flakey
+}
+
+run_test symlink
+run_test fifo
+run_test dev
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/479.out b/tests/generic/479.out
new file mode 100644
index 00000000..290f18b3
--- /dev/null
+++ b/tests/generic/479.out
@@ -0,0 +1,2 @@
+QA output created by 479
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 1e808865..3b9b47e3 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -481,3 +481,4 @@
 476 auto rw
 477 auto quick exportfs
 478 auto quick
+479 auto quick metadata
-- 
2.11.0

