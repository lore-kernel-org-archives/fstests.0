Received: from aserp2120.oracle.com ([141.146.126.78]:52936 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbeE1JtO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 05:49:14 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 1/4] fstests: btrfs: add seed sprout functionality test
Date: Mon, 28 May 2018 17:51:45 +0800
Message-Id: <20180528095148.30828-2-anand.jain@oracle.com>
In-Reply-To: <20180528095148.30828-1-anand.jain@oracle.com>
References: <20180528095148.30828-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Create a seed device and add the sprout device to it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1->v2: Use functions to do the respective operations. Add data
verification.

 common/config       |  1 +
 tests/btrfs/161     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/161.out |  9 ++++++
 tests/btrfs/group   |  1 +
 4 files changed, 101 insertions(+)
 create mode 100755 tests/btrfs/161
 create mode 100644 tests/btrfs/161.out

diff --git a/common/config b/common/config
index af360cefc804..f0735cb0153d 100644
--- a/common/config
+++ b/common/config
@@ -235,6 +235,7 @@ case "$HOSTOS" in
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
 	export BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
+	export BTRFS_TUNE_PROG="`set_prog_path btrfstune`"
         export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
         export MKFS_NFS_PROG="false"
         export MKFS_CIFS_PROG="false"
diff --git a/tests/btrfs/161 b/tests/btrfs/161
new file mode 100755
index 000000000000..009e95354e85
--- /dev/null
+++ b/tests/btrfs/161
@@ -0,0 +1,90 @@
+#! /bin/bash
+# FS QA Test 161 seed sprout functionality test
+#
+#  Create a seed device, mount it and, add a new device to create a
+#  sprout filesystem.
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+
+DEV_SEED=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+DEV_SPROUT=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+
+create_seed()
+{
+	_mkfs_dev $DEV_SEED
+	run_check _mount $DEV_SEED $SCRATCH_MNT
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar >\
+		/dev/null
+	echo -- golden --
+	od -x $SCRATCH_MNT/foobar
+	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_scratch_unmount
+	$BTRFS_TUNE_PROG -S 1 $DEV_SEED
+	run_check _mount $DEV_SEED $SCRATCH_MNT
+}
+
+create_sprout()
+{
+	_run_btrfs_util_prog device add -f $DEV_SPROUT $SCRATCH_MNT
+	_scratch_unmount
+	run_check _mount $DEV_SPROUT $SCRATCH_MNT
+	echo -- sprout --
+	od -x $SCRATCH_MNT/foobar
+	_scratch_unmount
+}
+
+create_seed
+create_sprout
+
+_scratch_dev_pool_put
+
+status=0
+exit
diff --git a/tests/btrfs/161.out b/tests/btrfs/161.out
new file mode 100644
index 000000000000..363b8217f45c
--- /dev/null
+++ b/tests/btrfs/161.out
@@ -0,0 +1,9 @@
+QA output created by 161
+-- golden --
+0000000 abab abab abab abab abab abab abab abab
+*
+1000000
+-- sprout --
+0000000 abab abab abab abab abab abab abab abab
+*
+1000000
diff --git a/tests/btrfs/group b/tests/btrfs/group
index f04ee8d5297c..fe83631f0f33 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -163,3 +163,4 @@
 158 auto quick raid scrub
 159 auto quick
 160 auto quick
+161 auto quick
-- 
2.7.0

