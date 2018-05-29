Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17207 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755808AbeE2Ar7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 20:47:59 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fNSns-0007pc-Rw
        for fstests@vger.kernel.org; Tue, 29 May 2018 10:47:56 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fNSns-0002Uw-Qu
        for fstests@vger.kernel.org; Tue, 29 May 2018 10:47:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/2] fstests: generic test setup preamble
Date: Tue, 29 May 2018 10:47:51 +1000
Message-Id: <20180529004752.8243-2-david@fromorbit.com>
In-Reply-To: <20180529004752.8243-1-david@fromorbit.com>
References: <20180529004752.8243-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

So many tests chop random bits out of the mandaotry test setup
preamble which leads to subtle problems and stray files being dumped
all over the place. Create a common test preamble with hooks for
local cleanup functions so we can prevent this in future.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/setup_test     | 23 +++++++++++++++++++++++
 new                   | 24 ++++--------------------
 soak                  | 19 +++++++------------
 tests/generic/001     | 42 ++++++++----------------------------------
 tests/generic/001.out |  2 --
 tests/xfs/001         | 41 +++++++----------------------------------
 6 files changed, 49 insertions(+), 102 deletions(-)
 create mode 100644 common/setup_test

diff --git a/common/setup_test b/common/setup_test
new file mode 100644
index 000000000000..0e22452b4f6e
--- /dev/null
+++ b/common/setup_test
@@ -0,0 +1,23 @@
+# common test setup preamble
+# test specific cleanup is done via the cleanup() function now.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup_test; exit \$status" 0 1 2 3 15
+
+_cleanup_test()
+{
+	# call local test cleanup function first, then cleanup tmp files
+	cleanup
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
diff --git a/new b/new
index 4eacccd3bf8b..5e7f6a3c4198 100755
--- a/new
+++ b/new
@@ -181,31 +181,15 @@ cat <<End-of-File >$tdir/$id
 #-----------------------------------------------------------------------
 #
 
-seq=\`basename \$0\`
-seqres=\$RESULT_DIR/\$seq
-echo "QA output created by \$seq"
+. common/setup_test
 
-here=\`pwd\`
-tmp=/tmp/\$\$
-status=1	# failure is the default!
-trap "_cleanup; exit \\\$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f \$tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+local_cleanup() { true }
 
 # remove previous \$seqres.full before test
 rm -f \$seqres.full
 
-# real QA test starts here
-
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
 _require_test
diff --git a/soak b/soak
index 26b345a3e4a9..8fd0b9043329 100755
--- a/soak
+++ b/soak
@@ -18,21 +18,16 @@
 #-----------------------------------------------------------------------
 #
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+. common/setup_test
 
-tmp=/tmp/$$
-seq=soak
-status=1	# failure is the default!
-
-_cleanup()
-{
-    echo "        *** umount"
-    _scratch_unmount >/dev/null 2>&1
+# test exit cleanup goes here
+cleanup() {
+	echo "        *** umount"
+	_scratch_unmount >/dev/null 2>&1
 }
 
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
 ROOT="."
 LOG="$ROOT/soak.log"
diff --git a/tests/generic/001 b/tests/generic/001
index 0edd41f1e2cc..f86dc5a85d5d 100755
--- a/tests/generic/001
+++ b/tests/generic/001
@@ -31,21 +31,17 @@
 #-----------------------------------------------------------------------
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
+	rm -rf $TEST_DIR/$$
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
@@ -276,28 +272,6 @@ _check()
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
-rm -f $seqres.full
-status=0
-_cleanup
-status=1
-done_cleanup=false
-
 _setup
 
 # do the test
diff --git a/tests/generic/001.out b/tests/generic/001.out
index e843a586cac2..4df5c4ca419b 100644
--- a/tests/generic/001.out
+++ b/tests/generic/001.out
@@ -1,9 +1,7 @@
 QA output created by 001
-cleanup
 setup ....................................
 iter 1 chain ... check ....................................
 iter 2 chain ... check ....................................
 iter 3 chain ... check ....................................
 iter 4 chain ... check ....................................
 iter 5 chain ... check ....................................
-cleanup
diff --git a/tests/xfs/001 b/tests/xfs/001
index 2c205f064e2e..1b5a1020e173 100755
--- a/tests/xfs/001
+++ b/tests/xfs/001
@@ -23,44 +23,17 @@
 #-----------------------------------------------------------------------
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
-    cd /
-    rm -f $tmp.*
+# test exit cleanup goes here
+cleanup() {
+	rm -rf $TEST_DIR/$$
 }
 
-_do_bit_test()
-{
-	field="$1"
-	bits="$2"
-
-	echo "testing $field with $bits bits"
-	_scratch_xfs_db -x -c "inode $FILE_INO" -c "write $field 0"
-	num=1
-	for n in `seq 0 1 $bits`; do
-		_scratch_xfs_db -x -c "inode $FILE_INO" \
-			  -c "write $field $num"
-		let num=$num*2
-	done
-	echo
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs xfs
 _supported_os Linux
 _require_scratch_nocheck
-- 
2.17.0

