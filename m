Received: from mail.kernel.org ([198.145.29.99]:42456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOQfj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 15 Oct 2018 12:35:39 -0400
From: fdmanana@kernel.org
Subject: [PATCH] generic: test fsync after fallocate on a very small file
Date: Mon, 15 Oct 2018 09:51:17 +0100
Message-Id: <20181015085117.5767-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we have a very small file, with a size smaller than the
block size, then fallocate a very small range within the block size but
past the file's current size, fsync the file and then power fail, after
mounting the filesystem all the file data is there and the file size is
correct.

This test is motivated by a failure in btrfs where it triggered an
assertion when using the no-holes feature, that is, when running with
MKFS_OPTIONS="-O no-holes". The btrfs issue is fixed by a patch for the
linux kernel titled:

 "Btrfs: fix assertion on fsync of regular file when using no-holes
  feature"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/512     | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/512.out |  9 ++++++++
 tests/generic/group   |  1 +
 3 files changed, 71 insertions(+)
 create mode 100755 tests/generic/512
 create mode 100644 tests/generic/512.out

diff --git a/tests/generic/512 b/tests/generic/512
new file mode 100755
index 00000000..f4e13c68
--- /dev/null
+++ b/tests/generic/512
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 512
+#
+# Test that if we have a very small file, with a size smaller than the block
+# size, then fallocate a very small range within the block size but past the
+# file's current size, fsync the file and then power fail, after mounting the
+# filesystem all the file data is there and the file size is correct.
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
+_require_xfs_io_command "falloc"
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+$XFS_IO_PROG -f \
+	     -c "pwrite -S 0xb6 0 21" \
+	     -c "falloc 40 40" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Simulate a power failure and mount the filesystem. We expect no data loss
+# and a correct file size.
+_flakey_drop_and_remount
+
+echo "File content after power failure:"
+od -t x1 -A d $SCRATCH_MNT/foobar
+
+_unmount_flakey
+
+status=0
+exit
diff --git a/tests/generic/512.out b/tests/generic/512.out
new file mode 100644
index 00000000..19a0a1b1
--- /dev/null
+++ b/tests/generic/512.out
@@ -0,0 +1,9 @@
+QA output created by 512
+wrote 21/21 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File content after power failure:
+0000000 b6 b6 b6 b6 b6 b6 b6 b6 b6 b6 b6 b6 b6 b6 b6 b6
+0000016 b6 b6 b6 b6 b6 00 00 00 00 00 00 00 00 00 00 00
+0000032 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+0000080
diff --git a/tests/generic/group b/tests/generic/group
index 348214ac..d17a0248 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -514,3 +514,4 @@
 509 auto quick log
 510 auto quick log
 511 auto quick rw zero
+512 auto quick log prealloc
-- 
2.11.0
