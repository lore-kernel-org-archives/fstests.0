Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:2669 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753262AbeF0IVN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:13 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-00083K-4R
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-0002j5-3J
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 6/8] ext4: convert some tests to new setup preamble
Date: Wed, 27 Jun 2018 18:21:01 +1000
Message-Id: <20180627082103.9662-7-david@fromorbit.com>
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Small initial batch to demonstrate conversion.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/ext4/001 | 26 +++++++-------------------
 tests/ext4/002 | 41 +++++++++++++----------------------------
 tests/ext4/003 | 25 +++++++------------------
 tests/ext4/004 | 46 ++++++++++++++++------------------------------
 tests/ext4/005 | 29 +++++++----------------------
 tests/ext4/006 | 38 +++++++++++++-------------------------
 tests/ext4/007 | 34 ++++++++++------------------------
 tests/ext4/008 | 28 +++++++---------------------
 tests/ext4/009 | 34 ++++++++++------------------------
 9 files changed, 90 insertions(+), 211 deletions(-)

diff --git a/tests/ext4/001 b/tests/ext4/001
index bf2d16b42b3c..deba9128d833 100755
--- a/tests/ext4/001
+++ b/tests/ext4/001
@@ -6,28 +6,16 @@
 #
 # Test fallocate FALLOC_FL_ZERO_RANGE
 #
-seqfull=$0
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
 . ./common/punch
-
-# real QA test starts here
 _supported_fs ext4
 _supported_os Linux
 _require_xfs_io_command "fzero"
@@ -50,4 +38,4 @@ _test_generic_punch -k falloc fzero fzero fiemap _filter_fiemap $testfile
 # Delayed allocation multi zero range tests
 _test_generic_punch -d -k falloc fzero fzero fiemap _filter_fiemap $testfile
 
-status=0 ; exit
+_success
diff --git a/tests/ext4/002 b/tests/ext4/002
index c4fb3bde8ce1..c1324dc04609 100755
--- a/tests/ext4/002
+++ b/tests/ext4/002
@@ -26,26 +26,24 @@
 #
 # Ref: http://thread.gmane.org/gmane.comp.file-systems.ext4/20682
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1        # failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs ext4
+_supported_os Linux
+_require_xfs_io_command "falloc"
+_require_test
 
 # Test specific macros.
 BIT_NOT_SET=0   # inode flag - 0x400000 bit is not set.
 BIT_SET=1       # inode flag - 0x400000 bit is set.
 
-# Generic test cleanup function.
-_cleanup()
-{
-  cd /
-  rm -f $tmp.*
-}
-
 # Ext4 uses the EOFBLOCKS_FL bit when fallocating blocks with KEEP_SIZE
 # enabled. The only time this bit should be set is when extending the allocated
 # blocks further than what the i_size represents. In the situations wherein the
@@ -97,18 +95,6 @@ _check_ext4_eof_flag()
   fi
 }
 
-# Get standard environment, filters and checks.
-. ./common/rc
-. ./common/filter
-
-# Prerequisites for the test run.
-_supported_fs ext4
-_supported_os Linux
-_require_xfs_io_command "falloc"
-_require_test
-
-# Real QA test starts here.
-rm -f $seqres.full
 
 # Remove any leftover files from last run.
 rm -f ${TEST_DIR}/test_?
@@ -162,5 +148,4 @@ ${XFS_IO_PROG} -f -d                    \
     ${TEST_DIR}/test_6 | _filter_xfs_io_unique
 _check_ext4_eof_flag test_6 ${BIT_NOT_SET}
 
-status=0
-exit ${status}
+_success
diff --git a/tests/ext4/003 b/tests/ext4/003
index 19fe4b4c1f7d..7e5dfca9468e 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -8,30 +8,20 @@
 # b5b6077 ext4: fix wrong assert in ext4_mb_normalize_request()
 # This testcase checks whether this bug has been fixed.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-    _scratch_unmount
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs ext4
 _supported_os Linux
-
 _require_scratch
 _require_scratch_ext4_feature "bigalloc"
 
-rm -f $seqres.full
-
 $MKFS_EXT4_PROG -F -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
 	>> $seqres.full 2>&1
 _scratch_mount
@@ -39,5 +29,4 @@ _scratch_mount
 $XFS_IO_PROG -f -c "pwrite 0 256m -b 1M" $SCRATCH_MNT/testfile 2>&1 | \
 	_filter_xfs_io
 
-status=0
-exit
+_success
diff --git a/tests/ext4/004 b/tests/ext4/004
index e34aaa517b61..775afed4bc2c 100755
--- a/tests/ext4/004
+++ b/tests/ext4/004
@@ -6,26 +6,26 @@
 #
 # Test "dump | restore"(as opposed to a tape)
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
 	# remove the generated data, which is much and meaningless.
 	rm -rf $restore_dir
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs ext4
+_supported_os Linux
+_require_test
+_require_scratch
+_require_command "$DUMP_PROG" dump
+_require_command "$RESTORE_PROG" restore
+
+echo "Silence is golden"
 
 dump_dir=$SCRATCH_MNT/dump_restore_dir
 restore_dir=$TEST_DIR/dump_restore_dir
@@ -49,19 +49,6 @@ workout()
 	rm -rf restoresymtable
 }
 
-# real QA test starts here
-_supported_fs ext4
-_supported_os Linux
-
-_require_test
-_require_scratch
-
-_require_command "$DUMP_PROG" dump
-_require_command "$RESTORE_PROG" restore
-
-rm -f $seqres.full
-echo "Silence is golden"
-
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
 rm -rf $restore_dir $TEST_DIR/restoresymtable
@@ -69,5 +56,4 @@ rm -rf $restore_dir $TEST_DIR/restoresymtable
 workout
 diff -r $dump_dir $restore_dir
 
-status=0
-exit
+_success
diff --git a/tests/ext4/005 b/tests/ext4/005
index db37c2eaa51e..a1e3f08eb1f4 100755
--- a/tests/ext4/005
+++ b/tests/ext4/005
@@ -11,33 +11,20 @@
 # ext4: be more strict when migrating to non-extent based file
 # ext4: correctly migrate a file with a hole at the beginning
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs ext4
 _supported_os Linux
 _require_scratch
 _require_command "$CHATTR_PROG" chattr
 
-rm -f $seqres.full
-
 echo "Silence is golden"
 
 _scratch_mkfs >>$seqres.full 2>&1
@@ -63,6 +50,4 @@ $CHATTR_PROG -e $testfile >>$seqres.full 2>&1
 # results in i_blocks corruption
 $XFS_IO_PROG -c "pwrite 0 4k" $testfile >>$seqres.full 2>&1
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/ext4/006 b/tests/ext4/006
index 63e42f58906f..3881090efa51 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -8,40 +8,30 @@
 # the kernel reacts, how e2fsck fares in fixing the mess, and then
 # try more kernel accesses to see if it really fixed things.
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
-    cd /
-    #rm -f $tmp.*
-}
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# get standard environment, filters and checks
+# include test specific environments here
 . ./common/rc
 . ./common/filter
 . ./common/attr
 . ./common/populate
 . ./common/fuzzy
-
-if [ ! -x "$(which e2fuzz)" ]; then
-	_notrun "Couldn't find e2fuzz"
-fi
-
-# real QA test starts here
 _supported_fs ext4
 _supported_os Linux
-
 _require_scratch
 _require_attrs
 _require_populate_commands
 
+if [ ! -x "$(which e2fuzz)" ]; then
+	_notrun "Couldn't find e2fuzz"
+fi
+
 repair_scratch() {
 	fsck_pass="$1"
 
@@ -75,7 +65,6 @@ repair_scratch() {
 	return 1
 }
 
-rm -f $seqres.full
 echo "See interesting results in $seqres.full" | sed -e "s,$RESULT_DIR,RESULT_DIR,g"
 SRCDIR=`pwd`
 test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-b 32 -v"
@@ -144,5 +133,4 @@ if [ "$(wc -l < "$ROUND2_LOG")" -ne 8 ]; then
 fi
 echo "finished fuzzing" | tee -a "$seqres.full"
 
-status=0
-exit
+_success
diff --git a/tests/ext4/007 b/tests/ext4/007
index b7f7c6ce517e..be81135b18fa 100755
--- a/tests/ext4/007
+++ b/tests/ext4/007
@@ -7,35 +7,22 @@
 # Create and populate an ext4 filesystem, corrupt the primary superblock, then
 # see how the kernel and e2fsck deal with it.
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
-    cd /
-    #rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/attr
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
+. ./common/attr
 _supported_fs ext4
 _supported_os Linux
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
 
-rm -f $seqres.full
 TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
@@ -103,5 +90,4 @@ umount "${SCRATCH_MNT}"
 echo "+ check fs (2)"
 e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
 
-status=0
-exit
+_success
diff --git a/tests/ext4/008 b/tests/ext4/008
index c553760dd333..6f35511bd366 100755
--- a/tests/ext4/008
+++ b/tests/ext4/008
@@ -7,35 +7,22 @@
 # Create and populate an ext4 filesystem, corrupt a group descriptor, then
 # see how the kernel and e2fsck deal with it.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
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
-    #rm -f $tmp.*
-}
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# include test specific environments here
 . ./common/attr
-
-# real QA test starts here
 _supported_fs ext4
 _supported_os Linux
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
 
-rm -f $seqres.full
 TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
@@ -84,5 +71,4 @@ umount "${SCRATCH_MNT}"
 echo "+ check fs (2)"
 e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
 
-status=0
-exit
+_success
diff --git a/tests/ext4/009 b/tests/ext4/009
index 9a2cd0f3c669..94da5e91900a 100755
--- a/tests/ext4/009
+++ b/tests/ext4/009
@@ -7,36 +7,23 @@
 # Create and populate an ext4 filesystem, corrupt a block bitmap, then
 # see how the kernel and e2fsck deal with it.
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
-    cd /
-    #rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/attr
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
+. ./common/attr
 _supported_fs ext4
 _supported_os Linux
-
 _require_xfs_io_command "falloc"
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
 
-rm -f $seqres.full
 TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
@@ -94,5 +81,4 @@ umount "${SCRATCH_MNT}"
 echo "+ check fs (2)"
 e2fsck -fn "${SCRATCH_DEV}" >> $seqres.full 2>&1 || _fail "fsck should not fail"
 
-status=0
-exit
+_success
-- 
2.17.0

