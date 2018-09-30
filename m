Received: from userp2120.oracle.com ([156.151.31.85]:36460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeI3ILQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Sep 2018 04:11:16 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v6] test unaligned punch hole at ENOSPC
Date: Sun, 30 Sep 2018 09:39:52 +0800
Message-Id: <1538271592-4086-1-git-send-email-anand.jain@oracle.com>
In-Reply-To: <1538146248-1759-1-git-send-email-anand.jain@oracle.com>
References: <1538146248-1759-1-git-send-email-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Try to punch hole with unaligned size and offset when the FS is
full. Mainly holes are punched at locations which are unaligned
with the file extent boundaries when the FS is full by data.
As the punching holes at unaligned location will involve
truncating blocks instead of just dropping the extents, it shall
involve reserving data and metadata space for delalloc and so data
alloc fails as the FS is full.

btrfs_punch_hole()
 btrfs_truncate_block()
   btrfs_check_data_free_space() <-- ENOSPC

We don't fail punch hole if the holes are aligned with the file
extent boundaries as it shall involve just dropping the related
extents, without truncating data extent blocks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v5->v6:
 fix comments at two places in the test case
 drop -f when using xfs_io to punch hole
 sync after dd is dropped
 change log is slightly updated
v4->v5:
 Update the change log
 Drop the directio option for xfs_io
v3->v4:
 Add to the group punch
v2->v3:
 Add _require_xfs_io_command "fpunch"
 Add more logs to $seqfull.full
   mount options and
   group profile info
 Add sync after dd upto ENOSPC
 Drop fallocate -p and use xfs_io punch to create holes
 Use a testfile instead of filler file so that easy to trace
v1->v2: Use at least 256MB to test.
This test case fails on btrfs as of now.
 tests/btrfs/172     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/172.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/btrfs/172
 create mode 100644 tests/btrfs/172.out

diff --git a/tests/btrfs/172 b/tests/btrfs/172
new file mode 100755
index 000000000000..0dffb2dff40b
--- /dev/null
+++ b/tests/btrfs/172
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Oracle. All Rights Reserved.
+#
+# FS QA Test 172
+#
+# Test if the unaligned (by size and offset) punch hole is successful when FS
+# is at ENOSPC.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command "fpunch"
+
+_scratch_mkfs_sized $((256 * 1024 *1024)) >> $seqres.full
+
+# max_inline ensures data is not inlined within metadata extents
+_scratch_mount "-o max_inline=0,nodatacow"
+
+cat /proc/self/mounts | grep $SCRATCH_DEV >> $seqres.full
+$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
+
+extent_size=$(_scratch_btrfs_sectorsize)
+unalign_by=512
+echo extent_size=$extent_size unalign_by=$unalign_by >> $seqres.full
+
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 $((extent_size * 10))" \
+					$SCRATCH_MNT/testfile >> $seqres.full
+
+echo "Fill all space available for data and all unallocated space." >> $seqres.full
+dd status=none if=/dev/zero of=$SCRATCH_MNT/filler bs=512 >> $seqres.full 2>&1
+
+hole_offset=0
+hole_len=$unalign_by
+$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
+
+hole_offset=$(($extent_size + $unalign_by))
+hole_len=$(($extent_size - $unalign_by))
+$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
+
+hole_offset=$(($extent_size * 2 + $unalign_by))
+hole_len=$(($extent_size * 5))
+$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
new file mode 100644
index 000000000000..ce2de3f0d107
--- /dev/null
+++ b/tests/btrfs/172.out
@@ -0,0 +1,2 @@
+QA output created by 172
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index feffc45b6564..45782565c3b7 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -174,3 +174,4 @@
 169 auto quick send
 170 auto quick snapshot
 171 auto quick qgroup
+172 auto quick punch
-- 
1.8.3.1
