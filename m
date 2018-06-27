Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:14599 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752125AbeF0IVP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:15 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-00083H-2f
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-0002iz-1c
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 4/8] generic: convert some tests to new setup preamble
Date: Wed, 27 Jun 2018 18:20:59 +1000
Message-Id: <20180627082103.9662-5-david@fromorbit.com>
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Small initial batch to demonstrate conversion.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/001 | 49 +++++++++++++++++------------------------------
 tests/generic/002 | 25 +++++++-----------------
 tests/generic/003 | 30 ++++++++---------------------
 tests/generic/004 | 32 +++++++++----------------------
 tests/generic/005 | 44 ++++++++++++++++--------------------------
 tests/generic/006 | 34 ++++++++++++--------------------
 tests/generic/007 | 29 ++++++++--------------------
 tests/generic/008 | 27 +++++++++-----------------
 tests/generic/009 | 28 +++++++++------------------
 9 files changed, 97 insertions(+), 201 deletions(-)

diff --git a/tests/generic/001 b/tests/generic/001
index 046e54e374a4..58ef45ed7102 100755
--- a/tests/generic/001
+++ b/tests/generic/001
@@ -15,25 +15,29 @@
 # config has one line per file with filename and byte size, else use
 # the default one below.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() {
+    if $done_cleanup ; then
+	:
+    elif [ $status -eq 0 ]; then
+	$verbose && echo "cleanup"
+	cd /
+	rm -rf $TEST_DIR/$$
+	done_cleanup=true
+    fi
+}
 
-tmp=/tmp/$$
-here=`pwd`
-status=1
-done_cleanup=false
-trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
 _require_test
 
+done_cleanup=false
 verbose=true
 verify=$here/verify_fill
 
@@ -260,25 +264,9 @@ _check()
     $verbose && echo
 }
 
-_cleanup()
-{
-    # cleanup
-    #
-    if $done_cleanup
-    then
-	:
-    elif [ $status -eq 0 ]
-    then
-	$verbose && echo "cleanup"
-	cd /
-	rm -rf $TEST_DIR/$$
-	done_cleanup=true
-    fi
-}
-
 rm -f $seqres.full
 status=0
-_cleanup
+cleanup
 status=1
 done_cleanup=false
 
@@ -299,5 +287,4 @@ do
     fi
 done
 
-status=0
-exit
+_success
diff --git a/tests/generic/002 b/tests/generic/002
index 8242ea907c1b..9943a077fe6b 100755
--- a/tests/generic/002
+++ b/tests/generic/002
@@ -6,31 +6,20 @@
 #
 # simple inode link count test for a regular file
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
-tmp=/tmp/$$
-here=`pwd`
-status=0	# success is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
 
-_cleanup()
-{
-    rm -f $tmp.*
-}
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
 _require_test
 
-rm -f $seqres.full
-
 echo "Silence is goodness ..."
 
 # ensure target directory exists
@@ -62,4 +51,4 @@ do
 done
 
 # success, all done
-exit
+_success
diff --git a/tests/generic/003 b/tests/generic/003
index 767d70593c3f..d928b9392686 100755
--- a/tests/generic/003
+++ b/tests/generic/003
@@ -9,34 +9,22 @@
 # never updated on read-only subvolumes. (Regression test for bug fixed
 # with commit 93fd63c2f001ca6797c6b15b696a484b165b4800)
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
-    rm -rf $tmp.*
-}
+. common/setup_test
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
-# real QA test starts here
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_atime
 _require_relatime
 
-rm -f $seqres.full
+echo "Silence is golden"
 
 _stat() {
 	stat -c "%x;%y;%z" $1
@@ -189,6 +177,4 @@ _compare_stat_times NNN "$file3_stat_before_ro_mount" \
 
 # success, all done
 _scratch_unmount
-echo "Silence is golden"
-status=0
-exit
+_success
diff --git a/tests/generic/004 b/tests/generic/004
index 156d68aee19f..a4d3d5d9d32e 100755
--- a/tests/generic/004
+++ b/tests/generic/004
@@ -6,35 +6,23 @@
 #
 # Test O_TMPFILE opens, and linking them back into the namespace.
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
-    rm -f ${testfile}
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() {
+	rm -f ${testfile}
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
-
 _require_test
 _require_xfs_io_command "-T"
 _require_xfs_io_command "flink"
 
-rm -f $seqres.full
-
 testfile="${TEST_DIR}/tst-tmpfile-flink"
 
 # test creating a r/w tmpfile, do I/O and link it into the namespace
@@ -49,6 +37,4 @@ rm ${testfile}
 # test creating a r/o tmpfile.  Should fail
 $XFS_IO_PROG -Tr ${TEST_DIR} -c "close" 2>&1 | _filter_test_dir
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/generic/005 b/tests/generic/005
index 118fca20ed5d..ceff4117319e 100755
--- a/tests/generic/005
+++ b/tests/generic/005
@@ -9,28 +9,29 @@
 #
 # Note: On Linux, ELOOP limit used to be 32 but changed to 8, and lately
 # its become 5.  Who knows what it might be next.
-# 
+#
 # What we are looking for here is: no panic due to blowing the stack;
 # and that the ELOOP error code is returned at some point (the actual
 # limit point is unimportant, just checking that we do hit it).
-# 
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+#
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=0	# success is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() {
+    rm -f $TEST_DIR/symlink_{0,1,2,3,4}{0,1,2,3,4,5,6,7,8,9}
+    rm -f $TEST_DIR/symlink_self empty_file
 
-_cleanup()
-{
-    cd $TEST_DIR
-    rm -f symlink_{0,1,2,3,4}{0,1,2,3,4,5,6,7,8,9} symlink_self empty_file
-    cd /
 }
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_test_symlinks
+
 _touch()
 {
     touch $@ 2>&1 | grep -q 'Too many levels of symbolic links'
@@ -41,17 +42,6 @@ _touch()
     fi
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_require_test
-_require_test_symlinks
-
-_supported_os Linux
-
 cd $TEST_DIR
 
 o=empty_file
@@ -72,4 +62,4 @@ echo "*** touch recusive symlinks"
 echo ""
 _touch symlink_self
 
-exit
+_success
diff --git a/tests/generic/006 b/tests/generic/006
index ba99324a5846..9511aeb0b026 100755
--- a/tests/generic/006
+++ b/tests/generic/006
@@ -6,22 +6,21 @@
 #
 # permname
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=0	# success is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
+# test exit cleanup goes here
+cleanup() {
     rm -rf $TEST_DIR/permname.$$
 }
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs generic
+_supported_os Linux
+_require_test
+
 _count()
 {
     $AWK_PROG '
@@ -31,15 +30,6 @@ _count()
     '
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux
-_require_test
-
 mkdir $TEST_DIR/permname.$$
 
 echo ""
@@ -58,4 +48,4 @@ cd $TEST_DIR/permname.$$/b
 $here/src/permname -c 4 -l 6 -p 4 || echo "permname returned $?"
 find . | _count
 
-exit
+_success
diff --git a/tests/generic/007 b/tests/generic/007
index 9780e12e9e69..7a40418cdd56 100755
--- a/tests/generic/007
+++ b/tests/generic/007
@@ -9,32 +9,21 @@
 # and checks that error codes make sense with its
 # memory of the files created.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=0	# success is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-    rm -rf $TEST_DIR/$seq
+# test exit cleanup goes here
+cleanup() {
+	rm -rf $TEST_DIR/$seq
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
 _require_test
 
-status=1 # default failure 
 sourcefile=$tmp.nametest
 seed=1
 iterations=100000
@@ -53,6 +42,4 @@ mkdir $TEST_DIR/$seq
 cd $TEST_DIR/$seq
 $here/src/nametest -l $sourcefile -s $seed -i $iterations -z
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/generic/008 b/tests/generic/008
index 7d86c602a241..386c59d2e106 100755
--- a/tests/generic/008
+++ b/tests/generic/008
@@ -9,25 +9,18 @@
 # Primarily tests page boundries and boundries that are
 #  off-by-one to ensure we're only tossing what's expected
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/punch
-
-# real QA test starts here
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# Modify as appropriate.
+# include test specific environments here
+. ./common/punch
+_supported_fs generic
 _supported_os Linux
-
 _require_xfs_io_command "fzero"
 _require_test
 
@@ -38,6 +31,4 @@ _test_block_boundaries 2048 fzero _filter_xfs_io_unique $testfile
 _test_block_boundaries 4096 fzero _filter_xfs_io_unique $testfile
 _test_block_boundaries 65536 fzero _filter_xfs_io_unique $testfile
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/generic/009 b/tests/generic/009
index fa6ef4664c66..124e502b23f0 100755
--- a/tests/generic/009
+++ b/tests/generic/009
@@ -6,32 +6,22 @@
 #
 # Test fallocate FALLOC_FL_ZERO_RANGE
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
 . ./common/punch
-
-# real QA test starts here
+_supported_fs generic
 _supported_os Linux
+_require_test
 _require_xfs_io_command "fzero"
 _require_xfs_io_command "fiemap"
 _require_xfs_io_command "falloc"
-_require_test
 
 testfile=$TEST_DIR/009.$$
 
@@ -61,4 +51,4 @@ _test_generic_punch -k falloc fzero fzero fiemap _filter_fiemap $testfile
 # Delayed allocation multi zero range tests
 _test_generic_punch -d -k falloc fzero fzero fiemap _filter_fiemap $testfile
 
-status=0 ; exit
+_success
-- 
2.17.0

