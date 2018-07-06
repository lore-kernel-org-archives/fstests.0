Received: from userp2130.oracle.com ([156.151.31.86]:43392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934247AbeGFF6g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Jul 2018 01:58:36 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] fstests: btrfs/168 verify device ready after device delete
Date: Fri,  6 Jul 2018 14:01:37 +0800
Message-Id: <20180706060137.1672-1-anand.jain@oracle.com>
In-Reply-To: <20180703084753.21116-1-anand.jain@oracle.com>
References: <20180703084753.21116-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test case verifies if the device ready return success after the
device delete.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1->v2: use _run_btrfs_util_prog instead of open coding it.

 tests/btrfs/168     | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/168.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 71 insertions(+)
 create mode 100755 tests/btrfs/168
 create mode 100644 tests/btrfs/168.out

diff --git a/tests/btrfs/168 b/tests/btrfs/168
new file mode 100755
index 000000000000..0d3e99839209
--- /dev/null
+++ b/tests/btrfs/168
@@ -0,0 +1,68 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018 Oracle. All Rights Reserved.
+#
+# FS QA Test 168
+#
+# Test if btrfs is still reported ready after the device delete
+#
+# This could be fixed by the following kernel commit:
+#  btrfs: fix missing superblock update in the device delete commit transaction
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
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+dev_1=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+dev_2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+
+# normal delete device and then check for ready
+run_check _scratch_pool_mkfs "-d single -m single"
+_scratch_mount
+_run_btrfs_util_prog device delete $dev_1 $SCRATCH_MNT
+_run_btrfs_util_prog device ready $dev_2
+
+_scratch_unmount
+# delete a seed device and then check for ready
+run_check $BTRFS_TUNE_PROG -S 1 $dev_2
+run_check _mount $dev_2 $SCRATCH_MNT
+_run_btrfs_util_prog device add -f $dev_1 $SCRATCH_MNT
+run_check mount -o rw,remount $dev_1 $SCRATCH_MNT
+_run_btrfs_util_prog device delete $dev_2 $SCRATCH_MNT
+_run_btrfs_util_prog device ready $dev_1
+
+_scratch_unmount
+_scratch_dev_pool_put
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
new file mode 100644
index 000000000000..893a41d859c8
--- /dev/null
+++ b/tests/btrfs/168.out
@@ -0,0 +1,2 @@
+QA output created by 168
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 5cff3bd6cc03..7bc3ea457992 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -170,3 +170,4 @@
 165 auto quick subvol
 166 auto quick qgroup
 167 auto quick replace volume
+168 auto quick volume
-- 
2.15.0

