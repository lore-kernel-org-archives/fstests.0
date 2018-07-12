Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeGLJxD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Jul 2018 05:53:03 -0400
From: fdmanana@kernel.org
Subject: [PATCH v2] generic: add test for fsync after cloning file range
Date: Thu, 12 Jul 2018 01:38:11 +0100
Message-Id: <20180712003811.16506-1-fdmanana@kernel.org>
In-Reply-To: <20180712003310.16260-1-fdmanana@kernel.org>
References: <20180712003310.16260-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we do a buffered write to a file, fsync it, clone a range
from another file into our file that overlaps the previously written
range, fsync the file again and then power fail, after we mount again the
filesystem, no file data was lost or corrupted.

This test is motivated by a bug found in btrfs, which is fixed by a patch
for the linux kernel titled:

  "Btrfs: fix file data corruption after cloning a range and fsync"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Fixed title of referenced btrfs patch.

 tests/generic/500     | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/500.out |  5 ++++
 tests/generic/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/500
 create mode 100644 tests/generic/500.out

diff --git a/tests/generic/500 b/tests/generic/500
new file mode 100755
index 00000000..b7baca34
--- /dev/null
+++ b/tests/generic/500
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 500
+#
+# Test that if we do a buffered write to a file, fsync it, clone a range from
+# another file into our file that overlaps the previously written range, fsync
+# the file again and then power fail, after we mount again the filesystem, no
+# file data was lost or corrupted.
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
+. ./common/reflink
+. ./common/dmflakey
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch_reflink
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+$XFS_IO_PROG -f -c "pwrite -S 0x18 9000K 6908K" $SCRATCH_MNT/foo >>$seqres.full
+$XFS_IO_PROG -f -c "pwrite -S 0x20 2572K 156K" $SCRATCH_MNT/bar >>$seqres.full
+
+# We clone from file foo into a range of file bar that overlaps the existing
+# extent at file bar. The destination offset of the reflink operation matches
+# the eof position of file bar minus 4Kb.
+$XFS_IO_PROG -c "fsync" \
+	     -c "reflink ${SCRATCH_MNT}/foo 0 2724K 15908K" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/bar >>$seqres.full
+
+echo "File bar digest before power failure:"
+md5sum $SCRATCH_MNT/bar | _filter_scratch
+
+# Simulate a power failure and mount the filesystem to check that no file data
+# was lost or corrupted.
+_flakey_drop_and_remount
+
+echo "File bar digest after power failure:"
+md5sum $SCRATCH_MNT/bar | _filter_scratch
+
+_unmount_flakey
+_cleanup_flakey
+
+status=0
+exit
diff --git a/tests/generic/500.out b/tests/generic/500.out
new file mode 100644
index 00000000..f590154e
--- /dev/null
+++ b/tests/generic/500.out
@@ -0,0 +1,5 @@
+QA output created by 500
+File bar digest before power failure:
+95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
+File bar digest after power failure:
+95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
diff --git a/tests/generic/group b/tests/generic/group
index b2a093f4..a84321dd 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -502,3 +502,4 @@
 497 auto quick swap collapse
 498 auto quick log
 499 auto quick rw collapse zero
+500 auto quick clone log
-- 
2.11.0

