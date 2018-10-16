Received: from szxga04-in.huawei.com ([45.249.212.190]:14079 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbeJPPVm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Oct 2018 11:21:42 -0400
From: "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [PATCH v2 4/4] overlay: add fsck.overlay exception tests
Date: Tue, 16 Oct 2018 15:45:59 +0800
Message-ID: <20181016074559.24728-5-yi.zhang@huawei.com>
In-Reply-To: <20181016074559.24728-1-yi.zhang@huawei.com>
References: <20181016074559.24728-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, amir73il@gmail.com
Cc: guaneryu@gmail.com, miklos@szeredi.hu, yi.zhang@huawei.com, miaoxie@huawei.com
List-ID: <fstests@vger.kernel.org>

Introduce some exception test cases for fsck.overlay which runs on
invalid/unnormal underlying dirs or invalid input parameters to test
exception handling processes.

This patch also change _overlay_fsck_dirs() helper function to be able
to receive empty underlying dir arguments, which is used by this test
to cover the case of incomplete underlying dirs.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 common/overlay        |   8 +-
 tests/overlay/063     | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/063.out |  10 +++
 tests/overlay/group   |   1 +
 4 files changed, 234 insertions(+), 2 deletions(-)
 create mode 100755 tests/overlay/063
 create mode 100644 tests/overlay/063.out

diff --git a/common/overlay b/common/overlay
index 4cc2829..2896594 100644
--- a/common/overlay
+++ b/common/overlay
@@ -195,12 +195,16 @@ _overlay_fsck_dirs()
 	local lowerdir=$1
 	local upperdir=$2
 	local workdir=$3
+	local dirs=""
 	shift 3
 
 	[[ ! -x "$FSCK_OVERLAY_PROG" ]] && return 0
 
-	$FSCK_OVERLAY_PROG -o lowerdir=$lowerdir -o upperdir=$upperdir \
-			   -o workdir=$workdir $*
+	[[ -n "$lowerdir" ]] && dirs=$(echo -n "-o lowerdir=$lowerdir")
+	[[ -n "$upperdir" ]] && dirs=$(echo -n "$dirs -o upperdir=$upperdir")
+	[[ -n "$workdir" ]] && dirs=$(echo -n "$dirs -o workdir=$workdir")
+
+	$FSCK_OVERLAY_PROG $dirs $*
 }
 
 # Run fsck and check the return value
diff --git a/tests/overlay/063 b/tests/overlay/063
new file mode 100755
index 0000000..e2c771a
--- /dev/null
+++ b/tests/overlay/063
@@ -0,0 +1,217 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Huawei.  All Rights Reserved.
+#
+# FS QA Test No. 063
+#
+# Exception test: test fsck.overlay runs on invalid underlying
+# dirs or with invalid input options.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1        # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	$CHATTR_PROG -i $upperdir/testdir
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs overlay
+_supported_os Linux
+_require_scratch_nocheck
+_require_attrs
+_require_command "$FSCK_OVERLAY_PROG" fsck.overlay
+_require_chattr i
+
+# remove all files from previous tests
+_scratch_mkfs
+
+# Create a whiteout
+make_whiteout()
+{
+	for arg in $*; do
+		mknod $arg c 0 0
+	done
+}
+
+# Create a redirect directory
+make_redirect_dir()
+{
+	local target=$1
+	local value=$2
+
+	mkdir -p $target
+	$SETFATTR_PROG -n $OVL_XATTR_REDIRECT -v $value $target
+}
+
+# Create test directories
+lowerdir=$OVL_BASE_SCRATCH_MNT/lower
+lowerdir2=$OVL_BASE_SCRATCH_MNT/lower2
+upperdir=$OVL_BASE_SCRATCH_MNT/upper
+workdir=$OVL_BASE_SCRATCH_MNT/workdir
+
+make_test_dirs()
+{
+	rm -rf $lowerdir $lowerdir2 $upperdir $workdir
+	mkdir -p $lowerdir $lowerdir2 $upperdir $workdir
+}
+
+# Test incomplete underlying dirs, should fail
+echo "+ Invalid input"
+make_test_dirs
+
+none_dir=""
+
+_run_check_fsck $FSCK_USAGE $lowerdir "$none_dir" "$none_dir"
+_run_check_fsck $FSCK_USAGE $lowerdir $upperdir "$none_dir"
+_run_check_fsck $FSCK_USAGE "$none_dir" $upperdir $workdir
+
+
+# Test invalid underlying dirs, should fail
+echo "+ Invalid input(2)"
+make_test_dirs
+
+invalid_dir=$OVL_BASE_SCRATCH_MNT/invalid_dir
+
+_run_check_fsck $FSCK_ERROR $lowerdir $upperdir $invalid_dir
+_run_check_fsck $FSCK_ERROR $lowerdir $invalid_dir $workdir
+_run_check_fsck $FSCK_ERROR $invalid_dir $upperdir $workdir
+
+
+# Test conflict input options, should fail
+echo "+ Invalid input(3)"
+make_test_dirs
+
+_run_check_fsck $FSCK_USAGE $lowerdir $upperdir $workdir -pn
+_run_check_fsck $FSCK_USAGE $lowerdir $upperdir $workdir -yn
+_run_check_fsck $FSCK_USAGE $lowerdir $upperdir $workdir -py
+_run_check_fsck $FSCK_USAGE $lowerdir $upperdir $workdir -pyn
+
+
+# Test upperdir and workdir belong to different base filesystems, should fail
+echo "+ Invalid workdir"
+make_test_dirs
+
+test_workdir=$OVL_BASE_TEST_DIR/work
+mkdir -p $test_workdir
+_run_check_fsck $FSCK_ERROR $lowerdir $upperdir $test_workdir
+rm -rf $test_workdir
+
+
+# Test upperdir is subdir of workdir and vice versa, should fail
+echo "+ Invalid workdir(2)"
+make_test_dirs
+
+test_workdir=$upperdir/work
+test_upperdir=$workdir/upper
+mkdir -p $test_workdir $test_upperdir
+
+_run_check_fsck $FSCK_ERROR $lowerdir $upperdir $test_workdir
+_run_check_fsck $FSCK_ERROR $lowerdir $test_upperdir $workdir
+
+
+# Test upper layer is read-only, should fail in "!no" mode, and should
+# return the real consistent result in "no" mode.
+echo "+ Upper read-only"
+make_test_dirs
+
+test_lowerdir=$OVL_BASE_TEST_DIR/lower
+mkdir -p $test_lowerdir
+
+# Let upper layer read-only
+$MOUNT_PROG -o remount,ro $OVL_BASE_SCRATCH_MNT > /dev/null 2>&1
+# Refuse to check read-only upper layer
+_run_check_fsck $FSCK_ERROR $test_lowerdir $upperdir $workdir
+_run_check_fsck $FSCK_ERROR $test_lowerdir $upperdir $workdir -p
+_run_check_fsck $FSCK_ERROR $test_lowerdir $upperdir $workdir -y
+# Allow to use "no" mode scan read-only upper layer
+_run_check_fsck $FSCK_OK $test_lowerdir $upperdir $workdir -n
+$MOUNT_PROG -o remount,rw $OVL_BASE_SCRATCH_MNT > /dev/null 2>&1
+
+# Make a simple inconsistency on the upper layer and expect return failure
+make_whiteout $upperdir/invalid
+$MOUNT_PROG -o remount,ro $OVL_BASE_SCRATCH_MNT > /dev/null 2>&1
+_run_check_fsck $FSCK_UNCORRECTED $test_lowerdir $upperdir $workdir -n
+$MOUNT_PROG -o remount,rw $OVL_BASE_SCRATCH_MNT > /dev/null 2>&1
+rm -rf $test_lowerdir
+
+
+# Test lower layer is read-only, should sacn each layer and return
+# the real consistent result.
+echo "+ Lower read-only"
+make_test_dirs
+
+test_lowerdir=$OVL_BASE_TEST_DIR/lower
+mkdir -p $test_lowerdir
+
+# Let lower layer read-only
+$MOUNT_PROG -o remount,ro $OVL_BASE_TEST_DIR > /dev/null 2>&1
+# Allow check read-only lower layers in all modes
+_run_check_fsck $FSCK_OK $test_lowerdir $upperdir $workdir -p
+$MOUNT_PROG -o remount,rw $OVL_BASE_TEST_DIR > /dev/null 2>&1
+
+# Make a simple inconsistency on the read-only lower layer and expect
+# return failure.
+make_whiteout $test_lowerdir/invalid
+$MOUNT_PROG -o remount,ro $OVL_BASE_TEST_DIR > /dev/null 2>&1
+_run_check_fsck $FSCK_UNCORRECTED $test_lowerdir $upperdir $workdir -p
+$MOUNT_PROG -o remount,rw $OVL_BASE_TEST_DIR > /dev/null 2>&1
+rm -rf $test_lowerdir
+
+
+# Test one of the lower layers is read-only, should sacn each layer and
+# return the real consistent result.
+echo "+ Lower read-only(2)"
+make_test_dirs
+
+test_lowerdir=$OVL_BASE_TEST_DIR/lower
+mkdir -p $test_lowerdir
+
+# Let lower layer read-only
+$MOUNT_PROG -o remount,ro $OVL_BASE_TEST_DIR > /dev/null 2>&1
+# Make a simple inconsistency on the bottom read-write lower layer
+# and expect return success (consistent middle read-only layer should
+# not affect the result).
+make_whiteout $lowerdir2/invalid
+_run_check_fsck $FSCK_NONDESTRUCT $test_lowerdir:$lowerdir2 $upperdir $workdir -p
+$MOUNT_PROG -o remount,rw $OVL_BASE_TEST_DIR > /dev/null 2>&1
+
+# Make a simple inconsistency on the middle read-only lower layer
+# and expect return failure.
+make_whiteout $test_lowerdir/invalid
+$MOUNT_PROG -o remount,ro $OVL_BASE_TEST_DIR > /dev/null 2>&1
+_run_check_fsck $FSCK_UNCORRECTED $test_lowerdir:$lowerdir2 $upperdir $workdir -p
+$MOUNT_PROG -o remount,rw $OVL_BASE_TEST_DIR > /dev/null 2>&1
+rm -rf $test_lowerdir
+
+
+# Test encounter error when try to fix some inconsistency, should fail
+echo "+ Encounter error"
+make_test_dirs
+
+# Make a simple inconsistency and set immutable flag to simulate fix error
+make_redirect_dir $upperdir/testdir "invalid"
+
+$CHATTR_PROG +i $upperdir/testdir
+_run_check_fsck $(($FSCK_UNCORRECTED+$FSCK_ERROR)) $lowerdir $upperdir $workdir -p
+$CHATTR_PROG -i $upperdir/testdir
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/063.out b/tests/overlay/063.out
new file mode 100644
index 0000000..2c5dd37
--- /dev/null
+++ b/tests/overlay/063.out
@@ -0,0 +1,10 @@
+QA output created by 063
++ Invalid input
++ Invalid input(2)
++ Invalid input(3)
++ Invalid workdir
++ Invalid workdir(2)
++ Upper read-only
++ Lower read-only
++ Lower read-only(2)
++ Encounter error
diff --git a/tests/overlay/group b/tests/overlay/group
index b308427..668329d 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -65,3 +65,4 @@
 060 auto quick metacopy
 061 auto quick copyup
 062 auto stress fsck
+063 auto quick fsck
-- 
2.5.0
