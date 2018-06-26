Received: from mail.kernel.org ([198.145.29.99]:49098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933915AbeF0O37 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Jun 2018 10:29:59 -0400
From: fdmanana@kernel.org
Subject: [PATCH] fstests: test power failure on btrfs while qgroups rescan is in progress
Date: Wed, 27 Jun 2018 00:43:27 +0100
Message-Id: <20180626234327.15691-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if a power failure happens on a filesystem with quotas (qgroups)
enabled while the quota rescan kernel thread is running, we will be able
to mount the filesystem after the power failure.

This test is motivated by a recent regression introduced in the linux
kernel's 4.18 merge window and is fixed by a patch with the title:

  "Btrfs: fix mount failure when qgroup rescan is in progress"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/166     | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/166.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 60 insertions(+)
 create mode 100755 tests/btrfs/166
 create mode 100644 tests/btrfs/166.out

diff --git a/tests/btrfs/166 b/tests/btrfs/166
new file mode 100755
index 00000000..c74b0861
--- /dev/null
+++ b/tests/btrfs/166
@@ -0,0 +1,57 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 166
+#
+# Test that if a power failure happens on a filesystem with quotas (qgroups)
+# enabled while the quota rescan kernel thread is running, we will be able
+# to mount the filesystem after the power failure.
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
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+_scratch_mkfs  >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Enable qgroups on the filesystem. This will start the qgroup rescan kernel
+# thread.
+_run_btrfs_util_prog quota enable $SCRATCH_MNT
+
+# Simulate a power failure, while the qgroup rescan kernel thread is running,
+# and then mount the filesystem to check that mounting the filesystem does not
+# fail.
+_flakey_drop_and_remount
+
+_unmount_flakey
+_cleanup_flakey
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/166.out b/tests/btrfs/166.out
new file mode 100644
index 00000000..1b1db1f8
--- /dev/null
+++ b/tests/btrfs/166.out
@@ -0,0 +1,2 @@
+QA output created by 166
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 9988cedd..e68aa1b7 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -168,3 +168,4 @@
 163 auto quick volume
 164 auto quick volume
 165 auto quick subvol
+166 auto quick qgroup
-- 
2.11.0

