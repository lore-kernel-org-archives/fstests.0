Received: from userp2130.oracle.com ([156.151.31.86]:48434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeC2KNN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Mar 2018 06:13:13 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] fstests: btrfs: 159 superblock courruption test case
Date: Thu, 29 Mar 2018 18:10:03 +0800
Message-Id: <20180329101003.10663-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Verify if the superblock corruption is handled correctly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/159     | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/159.out |  35 +++++++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 178 insertions(+)
 create mode 100755 tests/btrfs/159
 create mode 100644 tests/btrfs/159.out

diff --git a/tests/btrfs/159 b/tests/btrfs/159
new file mode 100755
index 000000000000..f42ba4b777e7
--- /dev/null
+++ b/tests/btrfs/159
@@ -0,0 +1,142 @@
+#! /bin/bash
+# FS QA Test 159
+#
+# Test if the superblock corruption is handled correctly.
+#   - Check and validate superblock csum in mount and scan context
+#   - Check and validate superblock for all disks in the fs
+#   - Make sure if the copies are really a copy of the primary superblock
+#
+#---------------------------------------------------------------------
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
+#---------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_scratch_dev_pool_put
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/module
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch_dev_pool 2
+_require_loadable_fs_module "btrfs"
+_require_command "$WIPEFS_PROG" wipefs
+
+_scratch_dev_pool_get 2
+
+MNT_OPT=$(echo $MOUNT_OPTIONS | cut -d" " -f2-)
+DEV_GOOD=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+DEV_BAD=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+
+wipe()
+{
+	$WIPEFS_PROG -a $DEV_GOOD > /dev/null 2>&1
+	$WIPEFS_PROG -a $DEV_BAD > /dev/null 2>&1
+}
+
+# If copy1 fsid does not match with primary fail the scan thus the mount as well
+check_copy1_fsid()
+{
+	local bytenr=67108864
+	echo -e "\\ncheck_copy1_fsid\\n{" | tee -a $seqres.full
+
+	wipe
+	$MKFS_BTRFS_PROG -fq $DEV_GOOD
+	$MKFS_BTRFS_PROG -fq $DEV_BAD
+	_reload_fs_module "btrfs"
+
+	dd status=none of=$DEV_BAD if=$DEV_GOOD ibs=1 obs=1 skip=$bytenr seek=$bytenr count=4K|\
+		tee -a $seqres.full
+
+	_mount -o $MNT_OPT $DEV_BAD $SCRATCH_MNT 2>&1 | _filter_scratch_pool
+
+	echo -e "good\\n}" | tee -a $seqres.full
+}
+
+# As in Linux kernel 4.16 if the primary is corrupted mount will fail.
+# Which might change in the long run.
+check_primary()
+{
+	local bytenr=65536
+	echo -e "\\ncheck_primary\\n{" | tee -a $seqres.full
+
+	wipe
+	_scratch_pool_mkfs "-mraid1 -draid1"
+	_reload_fs_module "btrfs"
+
+	#To corrupt a disk block, read in hex, write in dec
+	od -j$bytenr -N1 -An -x $DEV_BAD |\
+		dd status=none of=$DEV_BAD ibs=1 obs=1 seek=$bytenr count=1|\
+		tee -a $seqres.full
+	_mount -o $MNT_OPT,device=$DEV_GOOD $DEV_BAD $SCRATCH_MNT 2>&1 | _filter_scratch_pool
+
+	echo -e "good\\n}" | tee -a $seqres.full
+}
+
+# If copy1 or copy2 is corrupted we still should be able to mount
+check_copy1()
+{
+	local bytenr=67108864
+	echo -e "\\ncheck_copy1\\n{" | tee -a $seqres.full
+
+	wipe
+	_scratch_pool_mkfs "-mraid1 -draid1"
+	_reload_fs_module "btrfs"
+
+	#corrupt the disk block bytenr, read in hex, write in dec
+	od -j$bytenr -N1 -An -x $DEV_BAD |\
+		dd status=none of=$DEV_BAD ibs=1 obs=1 seek=$bytenr count=1|\
+		tee -a $seqres.full
+	_mount -o $MNT_OPT,device=$DEV_GOOD $DEV_BAD $SCRATCH_MNT 2>&1 | _filter_scratch_pool
+
+	echo -e "good\\n}" | tee -a $seqres.full
+
+	_scratch_unmount
+}
+
+check_copy1_fsid
+
+check_primary
+check_copy1
+
+echo -e "\\nReverse the good and bad device"
+# Generally devid 1 is used to read tree at the mount time, now reverse the
+# devid on which the corrupt superblock will reside.
+dev_tmp=$DEV_GOOD
+DEV_GOOD=$DEV_BAD
+DEV_BAD=$dev_tmp
+check_primary
+check_copy1
+
+status=0
+exit
diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
new file mode 100644
index 000000000000..f8f776f28870
--- /dev/null
+++ b/tests/btrfs/159.out
@@ -0,0 +1,35 @@
+QA output created by 159
+
+check_copy1_fsid
+{
+mount: wrong fs type, bad option, bad superblock on SCRATCH_DEV,
+       missing codepage or helper program, or other error
+
+       In some cases useful info is found in syslog - try
+       dmesg | tail or so.
+good
+}
+
+check_primary
+{
+mount: mount SCRATCH_DEV on /scratch failed: Structure needs cleaning
+good
+}
+
+check_copy1
+{
+good
+}
+
+Reverse the good and bad device
+
+check_primary
+{
+mount: mount SCRATCH_DEV on /scratch failed: Structure needs cleaning
+good
+}
+
+check_copy1
+{
+good
+}
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 8007e07e9cbd..ba766f6b84f8 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -161,3 +161,4 @@
 156 auto quick trim
 157 auto quick raid
 158 auto quick raid scrub
+159 auto quick
-- 
2.7.0

