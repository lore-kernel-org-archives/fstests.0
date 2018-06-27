Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:14599 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753165AbeF0IVL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:11 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-00083F-0x
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hK-0002it-W9
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/8] tests: convert various test dirs to setup preamble
Date: Wed, 27 Jun 2018 18:20:57 +1000
Message-Id: <20180627082103.9662-3-david@fromorbit.com>
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Convert all the test dirs with a very small number of tests in one
go.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/cifs/001  | 25 +++++++------------------
 tests/f2fs/001  | 25 +++++++------------------
 tests/nfs/001   | 28 +++++++---------------------
 tests/ocfs2/001 | 29 +++++++----------------------
 tests/perf/001  | 30 +++++++++++++-----------------
 tests/udf/102   | 29 ++++++++---------------------
 6 files changed, 49 insertions(+), 117 deletions(-)

diff --git a/tests/cifs/001 b/tests/cifs/001
index 193103bf8877..5bfc6ae46c92 100755
--- a/tests/cifs/001
+++ b/tests/cifs/001
@@ -6,27 +6,17 @@
 #
 # Sanity test for server-side copies initiated via CIFS_IOC_COPYCHUNK_FILE
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-
-_cleanup()
-{
-	rm -f $tmp.*
+# test exit cleanup goes here
+cleanup() {
 	rm -rf $TEST_DIR/$$
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
 _supported_fs cifs
 _supported_os Linux
 _require_cloner
@@ -49,5 +39,4 @@ for i in `seq 1 10`; do
 	diff $TEST_DIR/$$/src/${i} $TEST_DIR/$$/dest/${i}
 done
 
-status=0
-exit
+_success
diff --git a/tests/f2fs/001 b/tests/f2fs/001
index f9cd2cf089a3..c23c1cc6da36 100755
--- a/tests/f2fs/001
+++ b/tests/f2fs/001
@@ -15,25 +15,15 @@
 # In ext4, up to 132 bytes of data can be stored in 256 bytes-sized inode.
 # In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.
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
-    rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
+# include test specific environments here
 _supported_fs f2fs
 _supported_os Linux
 _require_scratch
@@ -65,5 +55,4 @@ hexdump -C $testfile
 rm $testfile
 rm $dummyfile
 
-status=0
-exit
+_success
diff --git a/tests/nfs/001 b/tests/nfs/001
index d7a79cb07d83..ca5d96093bf9 100755
--- a/tests/nfs/001
+++ b/tests/nfs/001
@@ -9,29 +9,17 @@
 # ERANGE. Upstream commit ed92d8c137b7 ("NFSv4: fix getacl ERANGE for some ACL
 # buffer sizes") fixed this bug.
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
-	rm -f $tmp.* $acltest.*
-}
+. common/setup_test
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() {
+	rm -f $acltest.*
+}
 
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs nfs
 _supported_os Linux
 _require_test_nfs_version 4
@@ -57,6 +45,4 @@ $NFS4_SETFACL_PROG -S $acltest.list $acltest.file
 $NFS4_GETFACL_PROG $acltest.file >>$seqres.full 2>&1
 $NFS4_GETFACL_PROG $acltest.file | wc -l
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/ocfs2/001 b/tests/ocfs2/001
index af304b8281a3..ad4ed58cd875 100755
--- a/tests/ocfs2/001
+++ b/tests/ocfs2/001
@@ -6,34 +6,21 @@
 #
 # Ensure that reflink works correctly with inline-data files.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-    cd /
-    rm -rf $tmp.*
-}
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# include test specific environments here
 . ./common/reflink
-
-# real QA test starts here
 _supported_os Linux
 _supported_fs ocfs2
 _require_scratch_reflink
 _require_cp_reflink
 
-rm -f $seqres.full
-
 echo "Format and mount"
 _scratch_mkfs --fs-features=local,unwritten,refcount,inline-data > $seqres.full 2>&1
 tunefs.ocfs2 --query '%H' $SCRATCH_DEV | grep -q 'inline-data' || \
@@ -69,6 +56,4 @@ echo "Verify the whole mess"
 _scratch_cycle_mount
 md5sum $testdir/file* | _filter_scratch
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/perf/001 b/tests/perf/001
index 5a6d9b29cb93..b28081eb1872 100755
--- a/tests/perf/001
+++ b/tests/perf/001
@@ -6,30 +6,26 @@
 #
 # Buffered random write performance test.
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-fio_config=$tmp.fio
-fio_results=$tmp.json
-status=1	# failure is the default!
-trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+# test exit cleanup goes here
+cleanup() { :; }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/perf
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
+. ./common/perf
 _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_block_device $SCRATCH_DEV
 _require_fio_results
 
-rm -f $seqres.full
+echo "Silence is golden"
+
+fio_config=$tmp.fio
+fio_results=$tmp.json
 
 _size=$((16 * $LOAD_FACTOR))
 cat >$fio_config <<EOF
@@ -60,5 +56,5 @@ $FIO_PROG --output-format=json --output=$fio_results $fio_config
 _scratch_unmount
 cat $fio_results >> $seqres.full
 _fio_results_compare $seq $fio_results
-echo "Silence is golden"
-status=0; exit
+
+_success
diff --git a/tests/udf/102 b/tests/udf/102
index acfa85c30387..e3ea7da75f64 100755
--- a/tests/udf/102
+++ b/tests/udf/102
@@ -7,28 +7,17 @@
 # This tests mkfs_udf/mkudffs and the device detection code
 # Modified from UDFQA test 031.
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
-    rm -f $tmp.*
-    cd /
-}
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
-_supported_fs udf 
+# include test specific environments here
+_supported_fs udf
 _supported_os Linux
-
 _require_scratch
 _setup_udf_scratchdir
 
@@ -37,6 +26,4 @@ _check_udf_filesystem $SCRATCH_DEV
 
 echo "Finished"
 
-# success, all done
-status=0
-exit
+_success
-- 
2.17.0

