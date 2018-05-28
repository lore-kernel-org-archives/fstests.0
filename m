Received: from aserp2130.oracle.com ([141.146.126.79]:35300 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbeE1JtR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 05:49:17 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 3/4] fstests: btrfs: seed device replace test
Date: Mon, 28 May 2018 17:51:47 +0800
Message-Id: <20180528095148.30828-4-anand.jain@oracle.com>
In-Reply-To: <20180528095148.30828-1-anand.jain@oracle.com>
References: <20180528095148.30828-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test case to verify that a seed device can be replaced

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/163     | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/163.out |   9 +++++
 tests/btrfs/group   |   1 +
 3 files changed, 124 insertions(+)
 create mode 100755 tests/btrfs/163
 create mode 100644 tests/btrfs/163.out

diff --git a/tests/btrfs/163 b/tests/btrfs/163
new file mode 100755
index 000000000000..e59f1deae42e
--- /dev/null
+++ b/tests/btrfs/163
@@ -0,0 +1,114 @@
+#! /bin/bash
+# FS QA Test 163 seed device replace test
+#
+# Test case to verify that a seed device can be replaced
+#
+# Steps:
+#  Create a seed device
+#  Create a sprout device
+#  Remount RW
+#  Run device replace on the seed device
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Oracle.  All Rights Reserved.
+# Author: Anand Jain <anand.jain@oracle.com>
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
+. ./common/filter.btrfs
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch_dev_pool 3
+
+_scratch_dev_pool_get 3
+
+DEV_SEED=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+DEV_SPROUT=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+DEV_REPLACE_TGT=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
+
+create_seed()
+{
+	_mkfs_dev $DEV_SEED
+	run_check _mount $DEV_SEED $SCRATCH_MNT
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar >\
+		/dev/null
+	echo -- gloden --
+	od -x $SCRATCH_MNT/foobar
+	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_scratch_unmount
+	$BTRFS_TUNE_PROG -S 1 $DEV_SEED
+	run_check _mount $DEV_SEED $SCRATCH_MNT
+}
+
+add_sprout()
+{
+	_run_btrfs_util_prog device add -f $DEV_SPROUT $SCRATCH_MNT
+	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+}
+
+replace_seed()
+{
+	_run_btrfs_util_prog replace start -fB $DEV_SEED $DEV_REPLACE_TGT $SCRATCH_MNT
+	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_scratch_unmount
+	run_check _mount $DEV_REPLACE_TGT $SCRATCH_MNT
+	echo -- sprout --
+	od -x $SCRATCH_MNT/foobar
+	_scratch_unmount
+
+}
+
+seed_is_mountable()
+{
+	run_check _mount $DEV_SEED $SCRATCH_MNT
+	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_scratch_unmount
+}
+
+create_seed
+add_sprout
+replace_seed
+
+seed_is_mountable
+
+_scratch_dev_pool_put
+
+status=0
+exit
diff --git a/tests/btrfs/163.out b/tests/btrfs/163.out
new file mode 100644
index 000000000000..50f46da6df86
--- /dev/null
+++ b/tests/btrfs/163.out
@@ -0,0 +1,9 @@
+QA output created by 163
+-- gloden --
+0000000 abab abab abab abab abab abab abab abab
+*
+1000000
+-- sprout --
+0000000 abab abab abab abab abab abab abab abab
+*
+1000000
diff --git a/tests/btrfs/group b/tests/btrfs/group
index cdc8ad32036e..2b7b0caf407e 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -165,3 +165,4 @@
 160 auto quick
 161 auto quick
 162 auto quick
+163 auto quick
-- 
2.7.0

