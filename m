Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932317AbeFKTvF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 11 Jun 2018 15:51:05 -0400
From: fdmanana@kernel.org
Subject: [PATCH] generic: add test for fsync of directory after creating hard link
Date: Mon, 11 Jun 2018 19:24:35 +0100
Message-Id: <20180611182435.18150-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we create a new hard link for a file which was previously
fsync'ed, fsync a parent directory of the new hard link and power fail,
the parent directory exists after mounting the filesystem again. The
parent directory must be a new directory, not yet persisted.

This test is motivated by a bug found in btrfs, where the fsync'ed parent
directory was lost after a power failure. The bug in btrfs is fixed by a
patch for the linux kernel titled:

 "Btrfs: sync log after logging new name"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/498     | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/498.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 68 insertions(+)
 create mode 100755 tests/generic/498
 create mode 100644 tests/generic/498.out

diff --git a/tests/generic/498 b/tests/generic/498
new file mode 100755
index 00000000..1cf73bda
--- /dev/null
+++ b/tests/generic/498
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 498
+#
+# Test that if we create a new hard link for a file which was previously
+# fsync'ed, fsync a parent directory of the new hard link and power fail,
+# the parent directory exists after mounting the filesystem again.
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
+mkdir $SCRATCH_MNT/A
+mkdir $SCRATCH_MNT/B
+mkdir $SCRATCH_MNT/A/C
+touch $SCRATCH_MNT/B/foo
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/B/foo
+# It is important the new hard link is located in a hierarchy of new directories
+# (not yet persisted).
+ln $SCRATCH_MNT/B/foo $SCRATCH_MNT/A/C/foo
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/A
+
+# Simulate a power failure and mount the filesystem to check that what we
+# explicitly fsync'ed exists.
+_flakey_drop_and_remount
+
+[ -d $SCRATCH_MNT/A ] || echo "directory A missing"
+[ -f $SCRATCH_MNT/B/foo ] || echo "file B/foo is missing"
+
+_unmount_flakey
+_cleanup_flakey
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/498.out b/tests/generic/498.out
new file mode 100644
index 00000000..31a5ff40
--- /dev/null
+++ b/tests/generic/498.out
@@ -0,0 +1,2 @@
+QA output created by 498
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 397f9c1c..83a6fdab 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -500,3 +500,4 @@
 495 auto quick swap
 496 auto quick swap
 497 auto quick swap collapse
+498 auto quick log
-- 
2.11.0

