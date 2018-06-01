Received: from userp2130.oracle.com ([156.151.31.86]:42718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeFAPy5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 Jun 2018 11:54:57 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 2/4] fstests: btrfs: nested seed device test
Date: Fri,  1 Jun 2018 23:57:24 +0800
Message-Id: <20180601155726.21308-3-anand.jain@oracle.com>
In-Reply-To: <20180601155726.21308-1-anand.jain@oracle.com>
References: <20180601155726.21308-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test case to verify that a sprout device can be a seed device

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2->v3: New line for the test subject
        Drop author name
        add _require_command "$BTRFS_TUNE_PROG" btrfstune
	rename to small letters for the local variables
v2: Born

 tests/btrfs/162     | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/162.out |   9 +++++
 tests/btrfs/group   |   1 +
 3 files changed, 113 insertions(+)
 create mode 100755 tests/btrfs/162
 create mode 100644 tests/btrfs/162.out

diff --git a/tests/btrfs/162 b/tests/btrfs/162
new file mode 100755
index 000000000000..93e4b3ca8f05
--- /dev/null
+++ b/tests/btrfs/162
@@ -0,0 +1,103 @@
+#! /bin/bash
+# FS QA Test 162
+#
+# Nested seed device test
+#  Create a seed device
+#  Create a sprout device
+#  Make the sprout device a seed device and create a sprout device again
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Oracle.  All Rights Reserved.
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
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_scratch_dev_pool 3
+
+_scratch_dev_pool_get 3
+
+dev_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+dev_sprout_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
+
+create_seed()
+{
+	_mkfs_dev $dev_seed
+	run_check _mount $dev_seed $SCRATCH_MNT
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar >\
+		/dev/null
+	echo -- gloden --
+	od -x $SCRATCH_MNT/foobar
+	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_scratch_unmount
+	$BTRFS_TUNE_PROG -S 1 $dev_seed
+}
+
+create_sprout_seed()
+{
+	run_check _mount $dev_seed $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $dev_sprout_seed $SCRATCH_MNT
+	_scratch_unmount
+	$BTRFS_TUNE_PROG -S 1 $dev_sprout_seed
+}
+
+create_next_sprout()
+{
+	run_check _mount -o device=$dev_seed $dev_sprout_seed $SCRATCH_MNT
+	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
+	_scratch_unmount
+	run_check _mount -o device=$dev_seed,device=$dev_sprout_seed \
+		$dev_sprout $SCRATCH_MNT
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

