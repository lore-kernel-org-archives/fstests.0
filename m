Received: from aserp2120.oracle.com ([141.146.126.78]:52960 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754524AbeE1JtR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 05:49:17 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 2/4] fstests: btrfs: nested seed device test
Date: Mon, 28 May 2018 17:51:46 +0800
Message-Id: <20180528095148.30828-3-anand.jain@oracle.com>
In-Reply-To: <20180528095148.30828-1-anand.jain@oracle.com>
References: <20180528095148.30828-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test case to verify that a sprout device can be a seed device

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/162     | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/162.out |   9 +++++
 tests/btrfs/group   |   1 +
 3 files changed, 113 insertions(+)
 create mode 100755 tests/btrfs/162
 create mode 100644 tests/btrfs/162.out

diff --git a/tests/btrfs/162 b/tests/btrfs/162
new file mode 100755
index 000000000000..fe63fb3ad704
--- /dev/null
+++ b/tests/btrfs/162
@@ -0,0 +1,103 @@
+#! /bin/bash
+# FS QA Test 162 nested seed device test
+#
+# Steps:
+# Create a seed device
+# Create a sprout device
+# Make the sprout device a seed device and create a sprout device again
+#
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
+DEV_SPROUT_SEED=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+DEV_SPROUT=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
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
+}
+
+create_sprout_seed()
+{
+	run_check _mount $DEV_SEED $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $DEV_SPROUT_SEED $SCRATCH_MNT
+	_scratch_unmount
+	$BTRFS_TUNE_PROG -S 1 $DEV_SPROUT_SEED
+}
+
+create_next_sprout()
+{
+	run_check _mount -o device=$DEV_SEED $DEV_SPROUT_SEED $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $DEV_SPROUT $SCRATCH_MNT
+	_scratch_unmount
+	run_check _mount -o device=$DEV_SEED,device=$DEV_SPROUT_SEED \
+		$DEV_SPROUT $SCRATCH_MNT
+	echo -- sprout --
+	od -x $SCRATCH_MNT/foobar
+}
+
+create_seed
+create_sprout_seed
+create_next_sprout
+
+_scratch_dev_pool_put
+
+status=0
+exit
diff --git a/tests/btrfs/162.out b/tests/btrfs/162.out
new file mode 100644
index 000000000000..ada7cc5507bd
--- /dev/null
+++ b/tests/btrfs/162.out
@@ -0,0 +1,9 @@
+QA output created by 162
+-- gloden --
+0000000 abab abab abab abab abab abab abab abab
+*
+1000000
+-- sprout --
+0000000 abab abab abab abab abab abab abab abab
+*
+1000000
diff --git a/tests/btrfs/group b/tests/btrfs/group
index fe83631f0f33..cdc8ad32036e 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -164,3 +164,4 @@
 159 auto quick
 160 auto quick
 161 auto quick
+162 auto quick
-- 
2.7.0

