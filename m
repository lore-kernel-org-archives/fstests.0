Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:2669 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753259AbeF0IVR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:17 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-00083Q-6J
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-0002jB-58
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 8/8] xfs: convert some tests to new setup preamble
Date: Wed, 27 Jun 2018 18:21:03 +1000
Message-Id: <20180627082103.9662-9-david@fromorbit.com>
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Small initial batch to demonstrate conversion.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/001 | 38 ++++++++++++--------------------------
 tests/xfs/002 | 35 ++++++++++-------------------------
 tests/xfs/003 | 19 ++++++++-----------
 tests/xfs/004 | 43 ++++++++++++++-----------------------------
 tests/xfs/005 | 30 +++++++-----------------------
 tests/xfs/006 | 27 ++++++---------------------
 tests/xfs/007 | 30 +++++++-----------------------
 tests/xfs/008 | 42 +++++++++++++++---------------------------
 tests/xfs/009 | 46 +++++++++++++++++++---------------------------
 9 files changed, 98 insertions(+), 212 deletions(-)

diff --git a/tests/xfs/001 b/tests/xfs/001
index ac86c3b1e484..fc61d6e8b284 100755
--- a/tests/xfs/001
+++ b/tests/xfs/001
@@ -8,20 +8,19 @@
 # write the value 0, each bit and finally the entry beyond the maximum legal
 # value. Also makes sure a core write and hex input still work.
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs xfs
+_supported_os Linux
+_require_scratch_nocheck
+_require_xfs_mkfs_crc
 
 _do_bit_test()
 {
@@ -39,18 +38,6 @@ _do_bit_test()
 	echo
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-
-# Modify as appropriate.
-_supported_fs xfs
-_supported_os Linux
-_require_scratch_nocheck
-_require_xfs_mkfs_crc
-
 _scratch_mkfs -m crc=0 >/dev/null 2>&1
 _scratch_mount
 
@@ -79,5 +66,4 @@ _scratch_xfs_db -x -c "inode $FILE_INO" -c "write core.gen 0xa5"
 _scratch_xfs_db -x -c "inode $FILE_INO" -c "write core.gen 0"
 _scratch_xfs_db -x -c "inode $FILE_INO" -c "write core.gen #5a5a"
 _scratch_xfs_db -x -c "inode $FILE_INO" -c "write core.gen #a5a5"
-status=0
-exit
+_success
diff --git a/tests/xfs/002 b/tests/xfs/002
index bd1c0a7a07f9..f64408afb3c1 100755
--- a/tests/xfs/002
+++ b/tests/xfs/002
@@ -13,26 +13,15 @@
 # for further explanation.  (NB: while the commit log was good, the
 # patch had a bug which was subsequently fixed)
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
-    rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# Modify as appropriate.
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
 _supported_fs xfs
 _supported_os Linux
 _require_scratch_nocheck
@@ -41,8 +30,6 @@ _require_no_large_scratch_dev
 # So we can explicitly turn it _off_:
 _require_xfs_mkfs_crc
 
-rm -f $seqres.full
-
 _scratch_mkfs_xfs -m crc=0 -d size=128m >> $seqres.full 2>&1 || _fail "mkfs failed"
 
 # Scribble past a couple V4 secondary superblocks to populate sb_crc
@@ -56,6 +43,4 @@ _scratch_mount
 # This should pass
 $XFS_GROWFS_PROG $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "growfs failed"
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/xfs/003 b/tests/xfs/003
index 1ce3e5ce71a1..ca24e2be40cf 100755
--- a/tests/xfs/003
+++ b/tests/xfs/003
@@ -6,20 +6,15 @@
 #
 # exercise xfs_db bug #784078
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
-trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
 _supported_fs xfs
 _supported_os Linux
 _require_test
@@ -67,3 +62,5 @@ test_done
 echo "=== TEST 7 ==="
 xfs_db -r -c 'ring' $TEST_DEV
 test_done
+
+_success
diff --git a/tests/xfs/004 b/tests/xfs/004
index bf03583d7382..040133efc195 100755
--- a/tests/xfs/004
+++ b/tests/xfs/004
@@ -6,21 +6,19 @@
 #
 # exercise xfs_db bug #789674 and other freesp functionality
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=0
+# test exit cleanup goes here
+cleanup() { :; }
 
-_cleanup()
-{
-	_scratch_unmount
-	rm -f $tmp.*
-	exit $status
-}
-trap "_cleanup" 0 1 2 3 15
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_no_large_scratch_dev
 
 _populate_scratch()
 {
@@ -36,19 +34,6 @@ _populate_scratch()
 	_scratch_mount				# and then remount
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs xfs
-_supported_os Linux
-
-_require_scratch
-_require_no_large_scratch_dev
-
-rm -f $seqres.full
-
 _populate_scratch
 
 eval `$DF_PROG -P --block-size=512 $SCRATCH_MNT 2>&1 \
@@ -84,7 +69,7 @@ then
 	echo "Error: $SCRATCH_DEV: freesp mismatch: $ans"
 	echo "xfs_db output ..."
 	cat $tmp.xfs_db
-	status=1
+	exit
 fi
 
 # check the 'pct' field from freesp command is good
@@ -103,7 +88,7 @@ then
 	echo "Error: $SCRATCH_DEV: pct mismatch: $ans (expected 100)"
 	echo "xfs_db output ..."
 	cat $tmp.xfs_db
-	status=1
+	exit
 fi
 
-exit
+_success
diff --git a/tests/xfs/005 b/tests/xfs/005
index ab7712232933..3f4a608a4e62 100755
--- a/tests/xfs/005
+++ b/tests/xfs/005
@@ -10,34 +10,20 @@
 # inadvertently caused primary SB CRC failures to not error out, this
 # is a regression test for that fix.
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
 
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs xfs
 _supported_os Linux
-
 _require_scratch_nocheck
 _require_xfs_mkfs_crc
 
-rm -f $seqres.full
-
 _scratch_mkfs_xfs -m crc=1 >> $seqres.full 2>&1 || _fail "mkfs failed"
 
 # Zap the crc.  xfs_db updates the CRC post-write, so poke it directly
@@ -46,6 +32,4 @@ $XFS_IO_PROG -c "pwrite 224 4" -c fsync $SCRATCH_DEV | _filter_xfs_io
 # should FAIL, the crc is bad; golden output contains mount failure
 _try_scratch_mount 2>&1 | _filter_error_mount
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/xfs/006 b/tests/xfs/006
index 2ee066200e20..57c3898caa37 100755
--- a/tests/xfs/006
+++ b/tests/xfs/006
@@ -7,31 +7,18 @@
 # Test xfs' "fail at unmount" error handling configuration. Stop
 # XFS from retrying to writeback forever at unmount.
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
 	_dmerror_cleanup
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/dmerror
-
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-# real QA test starts here
+# include test specific environments here
+. ./common/dmerror
 _supported_fs xfs
 _supported_os Linux
 _require_scratch
@@ -83,6 +70,4 @@ _dmerror_load_working_table
 _dmerror_mount
 _dmerror_unmount
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/xfs/007 b/tests/xfs/007
index 7e965a642be5..59808e219efa 100755
--- a/tests/xfs/007
+++ b/tests/xfs/007
@@ -6,35 +6,21 @@
 #
 # Test to verify Q_XQUOTARM functionality.
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# include test specific environments here
 . ./common/quota
-
-# Modify as appropriate.
 _supported_fs xfs
 _supported_os Linux
-
 _require_scratch
 _require_xfs_quota
 
-rm -f $seqres.full
-
 _scratch_mkfs_xfs | _filter_mkfs > /dev/null 2> $tmp.mkfs
 . $tmp.mkfs
 
@@ -83,6 +69,4 @@ _qmount
 _require_prjquota $SCRATCH_DEV
 do_test uquotino $PQUOTINO up
 
-# success, all done
-status=0
-exit
+_success
diff --git a/tests/xfs/008 b/tests/xfs/008
index 968a80528eec..51d5e5c50d96 100755
--- a/tests/xfs/008
+++ b/tests/xfs/008
@@ -6,32 +6,29 @@
 #
 # randholes test
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
+. common/setup_test
 
-here=`pwd`
-tmp=/tmp/$$
-status=0	# success is the default!
-pgsize=`$here/src/feature -s`
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-    rm -f $tmp.*
-    rm -rf $TEST_DIR/randholes.$$.*
+# test exit cleanup goes here
+cleanup() {
+	rm -rf $TEST_DIR/randholes.$$.*
 }
 
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs xfs
+_supported_os Linux
+_require_test
+
+pgsize=`$here/src/feature -s`
+
 _filter()
 {
     sed -e "s/-b $pgsize/-b PGSIZE/g" \
 	-e "s/-l .* -c/-l FSIZE -c/g"
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
 _do_test()
 {
     _n="$1"
@@ -64,17 +61,9 @@ _do_test()
         echo "$_n - output from bmap:"                      >>$seqres.full
         echo "--------------------------------------"       >>$seqres.full
         xfs_bmap -vvv $out                                  >>$seqres.full
-        status=1
     fi
 }
 
-# real QA test starts here
-_supported_fs xfs
-_supported_os Linux
-_require_test
-
-rm -f $seqres.full
-
 # Note on special numbers here.
 #
 # We are trying to create roughly 50 or 100 holes in a file
@@ -95,5 +84,4 @@ _do_test 5 100 "-d -l `expr 400 \* $pgsize` -c 100 -b $pgsize"
 
 # todo: realtime.
 
-# success, all done
-exit
+_success
diff --git a/tests/xfs/009 b/tests/xfs/009
index 68f63798cee3..6225d602d5f7 100755
--- a/tests/xfs/009
+++ b/tests/xfs/009
@@ -6,24 +6,25 @@
 #
 # XFS allocator test (preallocation - allocp, resvsp ,etc)
 #
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
+. common/setup_test
+
+# test exit cleanup goes here
+cleanup() { :; }
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# include test specific environments here
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+
+_supported_fs generic
+_supported_os Linux
+
 # This isn't really related to fs block size, it's just what
 # alloc uses for the "block" unit in it's input parameters...
 bsize=4096
-
-_cleanup()
-{
-    echo "*** unmount"
-    _scratch_unmount
-}
-
 _block_filter()
 {
    sed \
@@ -54,16 +55,6 @@ _filesize()
     ls -l $1 | $AWK_PROG '{print "filesize = " $5}'
 }
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs xfs
-_supported_os Linux
-
-_require_scratch
-
 _init
 out=$SCRATCH_MNT/$$.tmp
 
@@ -167,5 +158,6 @@ EOF
 
 _filesize $out
 
-status=0
-exit
+echo "*** unmount"
+_scratch_unmount
+_success
-- 
2.17.0

