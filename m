Received: from aserp2130.oracle.com ([141.146.126.79]:35144 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDIF0k (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Apr 2018 01:26:40 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3] fstests: btrfs/159 superblock corruption test case
Date: Mon,  9 Apr 2018 13:28:30 +0800
Message-Id: <20180409052830.4772-1-anand.jain@oracle.com>
In-Reply-To: <20180329102848.12669-1-anand.jain@oracle.com>
References: <20180329102848.12669-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Verify if the superblock corruption is handled correctly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2->v3:
 Provide the disk to be corrupted as an arg, instead of swapping the devices,
  so drop mount_opt_minus_args().
 159.out slightly changed.
v1->v2:
 $subject slightly changed
 Added more info about the test-case
 Keep the stuff from the ./new btrfs
 Add mount_opt_minus_args() to get the options (if) set at the config file
 Move DEV_GOOD & DEV_BAD to where it starts to use
 To help debugging added run_check where possible
 Remove {} in the out file
 Use _filter_error_mount for mount fail cases other than -EINVAL

 tests/btrfs/159     | 149 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/159.out |  21 ++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 171 insertions(+)
 create mode 100755 tests/btrfs/159
 create mode 100644 tests/btrfs/159.out

diff --git a/tests/btrfs/159 b/tests/btrfs/159
new file mode 100755
index 000000000000..c3a50b58b0b9
--- /dev/null
+++ b/tests/btrfs/159
@@ -0,0 +1,149 @@
+#! /bin/bash
+# FS QA Test 159
+#
+# Test if the superblock corruption is handled correctly:
+# 	- Test fsid miss-match (csum ok) between primary and copy superblock
+#	Fixed by the ML patch:
+#	btrfs: check if the fsid in the primary sb and copy sb are same
+# 	- Test if the mount fails if the primary superblock csum is
+#		corrupted on any disk
+# 	- Test if the mount does not fail if the copy1 sb csum is corrupted
+#	Fixed by the ML patches:
+#	btrfs: verify superblock checksum during scan
+#	btrfs: verify checksum for all devices in mount context
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
+	_scratch_dev_pool_put
+}
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
+wipe()
+{
+	$WIPEFS_PROG -a $SCRATCH_DEV_POOL > /dev/null 2>&1
+}
+
+# Test for fsid miss-match (csum ok) with primary and copy superblock.
+check_copy1_fsid()
+{
+	local bytenr=67108864
+	echo -e "\\ncheck_copy1_fsid\\n" | tee -a $seqres.full
+
+	wipe
+	$MKFS_BTRFS_PROG -fq $EXTRA_DEV
+	_scratch_mkfs >> $seqres.full 2>&1
+	_reload_fs_module "btrfs"
+
+	run_check dd status=none of=$SCRATCH_DEV if=$EXTRA_DEV ibs=1 obs=1\
+			skip=$bytenr seek=$bytenr count=4K
+	$WIPEFS_PROG -a $EXTRA_DEV > /dev/null 2>&1
+
+	#must fail
+	_try_scratch_mount 2>&1 | _filter_scratch_pool
+	#If mount didn't fail
+	_scratch_unmount > /dev/null 2>&1
+}
+
+# Test if the mount fails if the primary superblock csum is corrupted.
+# arg 1 is dev to corrupt
+check_primary()
+{
+	local bytenr=65536
+	echo -e "\\ncheck_primary\\n" | tee -a $seqres.full
+
+	wipe
+	_scratch_pool_mkfs "-mraid1 -draid1"
+	_reload_fs_module "btrfs"
+
+	#corrupt primary superblock bytenr
+	od -j$bytenr -N1 -An -x $1 |\
+		dd status=none of=$1 ibs=1 obs=1 seek=$bytenr count=1 conv=fsync
+
+	#must fail
+	_try_scratch_mount "-o device=$EXTRA_DEV" 2>&1 | _filter_error_mount
+
+	#If mount didn't fail
+	_scratch_unmount > /dev/null 2>&1
+}
+
+# If copy1 is corrupted we still should be able to mount, check that.
+# arg 1 is dev to corrupt
+check_copy1()
+{
+	local bytenr=67108864
+	echo -e "\\ncheck_copy1" | tee -a $seqres.full
+
+	wipe
+	_scratch_pool_mkfs "-mraid1 -draid1"
+	_reload_fs_module "btrfs"
+
+	#corrupt copy1 superrblock bytenr
+	od -j$bytenr -N1 -An -x $1 |\
+		dd status=none of=$1 ibs=1 obs=1 seek=$bytenr count=1 conv=fsync
+
+	_try_scratch_mount "-o device=$EXTRA_DEV" 2>&1 | _filter_error_mount
+	_scratch_unmount
+}
+
+EXTRA_DEV=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+if [ $EXTRA_DEV == $SCRATCH_DEV ]; then
+	EXTRA_DEV=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+fi
+echo SCRATCH_DEV=$SCRATCH_DEV EXTRA_DEV=$EXTRA_DEV >> $seqres.full
+
+check_copy1_fsid
+check_primary $SCRATCH_DEV
+check_primary $EXTRA_DEV
+check_copy1 $SCRATCH_DEV
+check_copy1 $EXTRA_DEV
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
new file mode 100644
index 000000000000..9daf9f515e87
--- /dev/null
+++ b/tests/btrfs/159.out
@@ -0,0 +1,21 @@
+QA output created by 159
+
+check_copy1_fsid
+
+mount: wrong fs type, bad option, bad superblock on SCRATCH_DEV,
+       missing codepage or helper program, or other error
+
+       In some cases useful info is found in syslog - try
+       dmesg | tail or so.
+
+check_primary
+
+mount: Structure needs cleaning
+
+check_primary
+
+mount: Structure needs cleaning
+
+check_copy1
+
+check_copy1
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

