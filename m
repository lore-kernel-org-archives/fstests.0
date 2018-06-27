Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:9706 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752575AbeF0IVQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:16 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-00083O-5L
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-0002j8-4D
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 7/8] overlay: convert some tests to new setup preamble
Date: Wed, 27 Jun 2018 18:21:02 +1000
Message-Id: <20180627082103.9662-8-david@fromorbit.com>
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Small initial batch to demonstrate conversion.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/overlay/001 | 26 +++++---------------------
 tests/overlay/002 | 26 +++++---------------------
 tests/overlay/003 | 31 +++++++------------------------
 tests/overlay/004 | 26 +++++---------------------
 tests/overlay/005 | 32 ++++++++------------------------
 tests/overlay/006 | 27 ++++++---------------------
 tests/overlay/007 | 26 ++++++--------------------
 tests/overlay/008 | 27 ++++++---------------------
 tests/overlay/009 | 29 ++++++++---------------------
 9 files changed, 56 insertions(+), 194 deletions(-)

diff --git a/tests/overlay/001 b/tests/overlay/001
index ade7a73a6cb2..4f2131ac0b49 100755
--- a/tests/overlay/001
+++ b/tests/overlay/001
@@ -9,29 +9,15 @@
 # Kernel commit 0480334fa604 ("ovl: use O_LARGEFILE in ovl_copy_up()")
 # fixed bug when copying up large file from lower dir.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 _require_scratch
@@ -60,6 +46,4 @@ for f in $SCRATCH_MNT/*; do
 	$XFS_IO_PROG -c "open" $f >>$seqres.full
 done
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/overlay/002 b/tests/overlay/002
index dd96cf0d3ab4..c677db1c6ffe 100755
--- a/tests/overlay/002
+++ b/tests/overlay/002
@@ -11,29 +11,15 @@
 # memory access) when the lower or upper directory belonged to a btrfs file
 # system.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 _require_scratch
@@ -52,6 +38,4 @@ _scratch_mount
 # This should work and not result in a crash.
 $XFS_IO_PROG -c "pwrite 0 64k" -c "fsync" $SCRATCH_MNT/foobar | _filter_xfs_io
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/overlay/003 b/tests/overlay/003
index 878ecbe7e974..5f753546242d 100755
--- a/tests/overlay/003
+++ b/tests/overlay/003
@@ -12,35 +12,21 @@
 # prevents mounting overlayfs like this since v4.6-rc1.
 # No harm to keep this test as a sanity check.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
-
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 _require_scratch
 
+echo "Silence is golden"
+
 # Remove all files from previous tests
 _scratch_mkfs
 
@@ -77,7 +63,4 @@ ls ${SCRATCH_MNT}/
 # unmount overlayfs but not base fs
 $UMOUNT_PROG $SCRATCH_MNT
 
-echo "Silence is golden"
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/overlay/004 b/tests/overlay/004
index 216df203fe50..03115bb8ffd8 100755
--- a/tests/overlay/004
+++ b/tests/overlay/004
@@ -6,29 +6,15 @@
 #
 # Test file copy up on overlayfs by changing mode bits.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 _require_scratch
@@ -78,6 +64,4 @@ $UMOUNT_PROG $SCRATCH_MNT
 stat -c %a ${upperdir}/attr_file1
 ls ${upperdir}/
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/overlay/005 b/tests/overlay/005
index 902eda18c8fe..13733c8ee50d 100755
--- a/tests/overlay/005
+++ b/tests/overlay/005
@@ -8,35 +8,20 @@
 # when unmount the underlying fs.
 # Kernel commit ab79efab0 fixed this issue.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() {
 	_destroy_loop_device $fs_loop_dev
 	_destroy_loop_device $upper_loop_dev
 	rm -f $lower_img
 	rm -f $upper_img
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
-
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 # Use non-default scratch underlying overlay dirs, we need to check
@@ -44,6 +29,8 @@ _supported_os Linux
 _require_scratch_nocheck
 _require_loop
 
+echo "Silence is golden"
+
 # Remove all files from previous tests
 _scratch_mkfs
 
@@ -96,7 +83,4 @@ _overlay_check_scratch_dirs $lowerd $upperd $workd
 $UMOUNT_PROG ${OVL_BASE_SCRATCH_MNT}/uppermnt
 $UMOUNT_PROG ${OVL_BASE_SCRATCH_MNT}/lowermnt
 
-# success, all done
-echo "Silence is golden"
-status=0
-exit
+_success
diff --git a/tests/overlay/006 b/tests/overlay/006
index 72aa451a3c0b..ab48d70c36e7 100755
--- a/tests/overlay/006
+++ b/tests/overlay/006
@@ -10,28 +10,15 @@
 # Upstream commit 45d117389696 ("ovl: ignore lower entries when checking purity
 # of non-directory entries") fixed the issue
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
+# remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 _require_scratch
@@ -57,6 +44,4 @@ rm $SCRATCH_MNT/uppertestdir/lowertestfile
 # no file no whiteout file in upptestdir
 ls $SCRATCH_MNT/uppertestdir
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/overlay/007 b/tests/overlay/007
index 5dffc83276bb..1f9366dd8ed4 100755
--- a/tests/overlay/007
+++ b/tests/overlay/007
@@ -9,29 +9,17 @@
 # Upstream commit ce9113bbcbf4 ("ovl: fix getcwd() failure after unsuccessful
 # rmdir") fixed this issue
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
+# test exit cleanup goes here
+cleanup() {
 	rm -rf $TEST_DIR/$seq
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
+# remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 _require_test
@@ -46,6 +34,4 @@ rmdir ../$seq >>$seqres.full 2>&1
 # getcwd should return the correct current dir
 pwd | _filter_test_dir
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/overlay/008 b/tests/overlay/008
index 29fa509bd8cf..a12bc792ee08 100755
--- a/tests/overlay/008
+++ b/tests/overlay/008
@@ -10,28 +10,15 @@
 # This upstream kernel patch fixed the issue
 # d0e13f5 ovl: fix uid/gid when creating over whiteout
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
+# remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 _require_scratch
@@ -65,6 +52,4 @@ rm -f $SCRATCH_MNT/testfile
 _user_do "mkdir $SCRATCH_MNT/testfile"
 stat -c %U:%G-%F $SCRATCH_MNT/testfile
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/overlay/009 b/tests/overlay/009
index 7fe25f2da172..d9e37313bbe8 100755
--- a/tests/overlay/009
+++ b/tests/overlay/009
@@ -9,32 +9,21 @@
 # This is fixed by kernel commit named as
 # ovl: fix dentry leak for default_permissions
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
+# remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs overlay
 _supported_os Linux
 _require_scratch
 
+echo "Silence is golden"
+
 # Remove all files from previous tests
 _scratch_mkfs
 
@@ -48,6 +37,4 @@ _scratch_mount -o default_permissions
 cat $SCRATCH_MNT/testfile
 
 # overlay will be unmounted by test harness and kernel BUG if dentry leaked
-echo "Silence is golden"
-status=0
-exit
+_success
-- 
2.17.0

