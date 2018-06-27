Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:14599 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752575AbeF0IVM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:12 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-00083I-3Y
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-0002j2-2T
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 5/8] btrfs: convert some tests to new setup preamble
Date: Wed, 27 Jun 2018 18:21:00 +1000
Message-Id: <20180627082103.9662-6-david@fromorbit.com>
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Small initial batch to demonstrate conversion.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/btrfs/001 | 25 ++++++----------------
 tests/btrfs/002 | 28 ++++++++----------------
 tests/btrfs/003 | 41 ++++++++++++++---------------------
 tests/btrfs/004 | 24 ++++++---------------
 tests/btrfs/005 | 51 +++++++++++++++++--------------------------
 tests/btrfs/006 | 30 ++++++--------------------
 tests/btrfs/007 | 57 +++++++++++++++++++------------------------------
 tests/btrfs/008 | 30 +++++++++-----------------
 tests/btrfs/009 | 29 +++++++------------------
 9 files changed, 105 insertions(+), 210 deletions(-)

diff --git a/tests/btrfs/001 b/tests/btrfs/001
index b13a2470a0ed..771971135937 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -6,27 +6,16 @@
 #
 # Test btrfs's subvolume and snapshot support
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-    rm -f $tmp.*
-}
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-trap "_cleanup ; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# include test specific environments here
 . ./common/filter.btrfs
-
-# real QA test starts here
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
@@ -90,4 +79,4 @@ _scratch_cycle_mount
 echo "List root dir"
 ls $SCRATCH_MNT
 
-status=0 ; exit
+_success
diff --git a/tests/btrfs/002 b/tests/btrfs/002
index 87e21c02f68c..5d6b106bc090 100755
--- a/tests/btrfs/002
+++ b/tests/btrfs/002
@@ -6,29 +6,21 @@
 #
 # Extented btrfs snapshot test cases
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-    rm -f $tmp.*
-}
-
-trap "_cleanup ; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
+# include test specific environments here
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 
+echo "Silence is golden"
+
 _scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
 _scratch_mount
 
@@ -169,6 +161,4 @@ _save_checksum $SNAPNAME $tmp.$tname.sum
 _verify_checksum $SNAPNAME $tmp.$tname.sum
 
 _scratch_unmount || _fail "unmount failed"
-
-echo "Silence is golden"
-status=0; exit
+_success
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index 22aa57aad0b9..dac7ed919711 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -6,31 +6,20 @@
 #
 # btrfs vol tests
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-dev_removed=0
-removed_dev_htl=""
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-    if [ $dev_removed == 1 ]; then
-	_scratch_unmount
-	_devmgt_add "${removed_dev_htl}"
-    fi
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() {
+	if [ $dev_removed == 1 ]; then
+		_scratch_unmount
+		_devmgt_add "${removed_dev_htl}"
+	fi
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
+# include test specific environments here
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
@@ -38,7 +27,10 @@ _require_scratch_dev_pool 4
 _require_deletable_scratch_dev_pool
 _require_command "$WIPEFS_PROG" wipefs
 
-rm -f $seqres.full
+echo "Silence is golden"
+
+dev_removed=0
+removed_dev_htl=""
 
 # Test cases related to raid in btrfs
 _test_raid0()
@@ -172,5 +164,4 @@ _test_add
 _test_replace
 _test_remove
 
-echo "Silence is golden"
-status=0; exit
+_success
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 3f61a8f46140..99dd1f768d81 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -9,28 +9,18 @@
 # run filefrag to get the extent mapping and follow the backrefs.
 # We check to end up back at the original file with the correct offset.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1
-noise_pid=0
-
-_cleanup()
-{
+# test exit cleanup goes here
+cleanup() {
 	rm $tmp.running
 	wait
-	rm -f $tmp.*
 }
-trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
@@ -39,7 +29,7 @@ _require_btrfs_command inspect-internal logical-resolve
 _require_btrfs_command inspect-internal inode-resolve
 _require_command "$FILEFRAG_PROG" filefrag
 
-rm -f $seqres.full
+noise_pid=0
 
 FILEFRAG_FILTER='
 	if (/blocks? of (\d+) bytes/) {
diff --git a/tests/btrfs/005 b/tests/btrfs/005
index 15af46783298..4cebb57fbaba 100755
--- a/tests/btrfs/005
+++ b/tests/btrfs/005
@@ -6,22 +6,26 @@
 #
 # Btrfs Online defragmentation tests
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-here="`pwd`"
-tmp=/tmp/$$
-cnt=119
-filesize=48000
+. common/setup_test
 
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-}
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+. ./common/defrag
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+_require_defrag
+
+cnt=119
+filesize=48000
 
 _create_file()
 {
@@ -111,22 +115,6 @@ _rundefrag()
 	_check_scratch_fs
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/defrag
-
-# real QA test starts here
-_supported_fs btrfs
-_supported_os Linux
-_require_scratch
-
-rm -f $seqres.full
-
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-_require_defrag
-
 echo "defrag object | defragment range | defragment compress"
 echo "a single file | default | off"
 _rundefrag 1 1 1
@@ -155,5 +143,4 @@ _rundefrag 2 1 1
 echo "a filesystem | default | off"
 _rundefrag 3 1 1
 
-status=0
-exit
+_success
diff --git a/tests/btrfs/006 b/tests/btrfs/006
index 3edbb25a72a8..8eed1a2a1221 100755
--- a/tests/btrfs/006
+++ b/tests/btrfs/006
@@ -7,35 +7,21 @@
 # run basic btrfs information commands in various ways
 # sanity tests: filesystem show, label, sync, and device stats
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "== QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-}
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# get standard environment, filters and checks
-. ./common/rc
+# include test specific environments here
 . ./common/filter.btrfs
-
-# real QA test starts here
-
-# Modify as appropriate.
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_scratch_dev_pool
 
-rm -f $seqres.full
-
 FIRST_POOL_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
 LAST_POOL_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $NF}'`
 TOTAL_DEVS=`echo $SCRATCH_DEV_POOL | wc -w`
@@ -83,6 +69,4 @@ $BTRFS_UTIL_PROG device stats $LAST_POOL_DEV | \
     sed -e "s,$LAST_POOL_DEV,LAST_POOL_DEV,g" | \
     _filter_spaces
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index 09f2f011bc77..50ead03acf31 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -9,37 +9,23 @@
 # (incr) and send both snapshots to a temp file. Remake the file
 # system and receive from the files. Check both states with fssum.
 #
-# creator
-owner=list.btrfs@jan-o-sch.net
+. common/setup_test
 
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+# test exit cleanup goes here
+cleanup() { :; }
 
-tmp=`mktemp -d`
-status=1
-
-_cleanup()
-{
-	echo "*** unmount"
-	_scratch_unmount 2>/dev/null
-	rm -f $tmp.*
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
+_supported_fs generic
+_supported_os Linux
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_fssum
 _require_seek_data_hole
 
-rm -f $seqres.full
-
 workout()
 {
 	fsz=$1
@@ -57,18 +43,18 @@ workout()
 
 	_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
 
-	echo "# $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp/base.snap" \
+	echo "# $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp.base.snap" \
 		>> $seqres.full
-	$BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp/base.snap 2>> $seqres.full \
+	$BTRFS_UTIL_PROG send $SCRATCH_MNT/base > $tmp.base.snap 2>> $seqres.full \
 		|| _fail "failed: '$@'"
 	echo "# $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base\
-		$SCRATCH_MNT/incr > $tmp/incr.snap" >> $seqres.full
+		$SCRATCH_MNT/incr > $tmp.incr.snap" >> $seqres.full
 	$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base \
-		$SCRATCH_MNT/incr > $tmp/incr.snap 2>> $seqres.full \
+		$SCRATCH_MNT/incr > $tmp.incr.snap 2>> $seqres.full \
 		|| _fail "failed: '$@'"
 
-	run_check $FSSUM_PROG -A -f -w $tmp/base.fssum $SCRATCH_MNT/base
-	run_check $FSSUM_PROG -A -f -w $tmp/incr.fssum -x $SCRATCH_MNT/incr/base \
+	run_check $FSSUM_PROG -A -f -w $tmp.base.fssum $SCRATCH_MNT/base
+	run_check $FSSUM_PROG -A -f -w $tmp.incr.fssum -x $SCRATCH_MNT/incr/base \
 		$SCRATCH_MNT/incr
 
 	_scratch_unmount >/dev/null 2>&1
@@ -78,11 +64,11 @@ workout()
 		|| _fail "size=$fsz mkfs failed"
 	_scratch_mount "-o noatime"
 
-	_run_btrfs_util_prog receive $SCRATCH_MNT < $tmp/base.snap
-	run_check $FSSUM_PROG -r $tmp/base.fssum $SCRATCH_MNT/base
+	_run_btrfs_util_prog receive $SCRATCH_MNT < $tmp.base.snap
+	run_check $FSSUM_PROG -r $tmp.base.fssum $SCRATCH_MNT/base
 
-	_run_btrfs_util_prog receive $SCRATCH_MNT < $tmp/incr.snap
-	run_check $FSSUM_PROG -r $tmp/incr.fssum $SCRATCH_MNT/incr
+	_run_btrfs_util_prog receive $SCRATCH_MNT < $tmp.incr.snap
+	run_check $FSSUM_PROG -r $tmp.incr.fssum $SCRATCH_MNT/incr
 }
 
 echo "*** test send / receive"
@@ -91,7 +77,8 @@ fssize=`expr 2000 \* 1024 \* 1024`
 ops=200
 
 workout $fssize $ops
-
+echo "*** unmount"
+_scratch_unmount 2>/dev/null
 echo "*** done"
-status=0
-exit
+
+_success
diff --git a/tests/btrfs/008 b/tests/btrfs/008
index e7609de47580..288f6b97fdc0 100755
--- a/tests/btrfs/008
+++ b/tests/btrfs/008
@@ -6,37 +6,27 @@
 #
 # btrfs send ENOENT regression test, from a user report on linux-btrfs
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-tmp_dir=send_temp_$seq
-
-status=1	# failure is the default!
-
-_cleanup()
-{
+# test exit cleanup goes here
+cleanup() {
 	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/send/snapshots/backup2 > /dev/null 2>&1
 	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/send/snapshots/backup3 > /dev/null 2>&1
 	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/send > /dev/null 2>&1
 	rm -rf $TEST_DIR/$tmp_dir
-	rm -f $tmp.*
 }
 
-trap "_cleanup ; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
 
+echo "Silence is golden"
+
 _scratch_mkfs > /dev/null 2>&1
 
 #receive needs to be able to setxattrs, including the selinux context, if we use
@@ -46,6 +36,7 @@ export SELINUX_MOUNT_OPTIONS=""
 
 _scratch_mount
 
+tmp_dir=send_temp_$seq
 mkdir $TEST_DIR/$tmp_dir
 $BTRFS_UTIL_PROG subvolume create $TEST_DIR/$tmp_dir/send \
 	> $seqres.full 2>&1 || _fail "failed subvol create"
@@ -66,5 +57,4 @@ $BTRFS_UTIL_PROG send -f $TEST_DIR/$tmp_dir/blah $work_dir/snapshots/backup3 \
 $BTRFS_UTIL_PROG receive -vvvv -f $TEST_DIR/$tmp_dir/blah $SCRATCH_MNT \
 	>> $seqres.full 2>&1 || _fail "receive failed"
 
-echo "Silence is golden"
-status=0 ; exit
+_success
diff --git a/tests/btrfs/009 b/tests/btrfs/009
index 8b6e864f3ea8..3c11ba94921f 100755
--- a/tests/btrfs/009
+++ b/tests/btrfs/009
@@ -6,32 +6,20 @@
 #
 # Regression test to make sure we can't delete the default subvol
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
+# test exit cleanup goes here
+cleanup() { :; }
 
-status=1	# failure is the default!
-
-_cleanup()
-{
-	rm -f $tmp.*
-}
-
-trap "_cleanup ; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 
-rm -f $seqres.full
+echo "Silence is golden"
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
@@ -45,5 +33,4 @@ $BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/newvol >> $seqres.full 2>&1
 _scratch_unmount
 _try_scratch_mount || _fail "mount should have succeeded"
 
-echo "Silence is golden"
-status=0 ; exit
+_success
-- 
2.17.0

