Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:42777 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753777AbaIQBmO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Sep 2014 21:42:14 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XU4Fo-0003kX-8F
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XU4Fo-0006O9-7V
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/5] generic: more tests should clean up TESTDIR on success
Date: Wed, 17 Sep 2014 11:41:49 +1000
Message-Id: <1410918113-23516-2-git-send-email-david@fromorbit.com>
In-Reply-To: <1410918113-23516-1-git-send-email-david@fromorbit.com>
References: <1410918113-23516-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

I'm getting enospc errors on a 4GB test device after a while of
running. Part of the issue is that many tests can't or don't clean
up previous failed runs when they start or if the run to success.
Hence while we want to slowly age the test filesystem, we don't
really want that aging to unintentionally run the filesystem out of
space. To that end:

$ sudo du -s /mnt/test/* | sort -nr |head -10
1929160 /mnt/test/fsfile
512000  /mnt/test/247.8133
512000  /mnt/test/247.4713
512000  /mnt/test/247.4488
466752  /mnt/test/fstest.9850.2
40000   /mnt/test/resv
29804   /mnt/test/fsstress.12144.1
26208   /mnt/test/populate_root
26208   /mnt/test/mnt
23216   /mnt/test/fsstress.4491.1

We can see that there are a few tests that using most of the space.
These are often left behind due to kernel failures during tests or
reboots while tests are in progress, so make sure that they at least
clean up such mess the next time they run.

Test generic/247, xfs/020 (fsfile) and generic/074 (fstest.$$.n)
are the worst offenders, so just target these to being with.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/074 | 21 ++++++++++-----------
 tests/generic/247 |  7 ++++++-
 tests/xfs/020     |  9 ++++++---
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/tests/generic/074 b/tests/generic/074
index df85d66..55264bd 100755
--- a/tests/generic/074
+++ b/tests/generic/074
@@ -33,20 +33,26 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    cd /
-    rm -rf $TEST_DIR/fstest.$$.* $tmp.*
+    rm -rf $fstest_dir.* $tmp.*
 }
 
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
 
+_supported_fs generic
+_supported_os IRIX Linux
+_require_test
+
+rm -f $seqres.full
+fstest_dir=$TEST_DIR/fstest
+
 _do_test()
 {
     _n="$1"
     _param="$2"
 
-    out=$TEST_DIR/fstest.$$.$_n
+    out=$fstest_dir.$_n
     rm -rf $out
     if ! mkdir $out
     then
@@ -59,7 +65,7 @@ _do_test()
 	-e 's/-n [0-9][0-9]*/-n children/' \
 	-e 's/-l [0-9][0-9]*/-l loops/' \
 	-e 's/-f [0-9][0-9]*/-f files/'`
-    
+
     echo ""
     echo "-----------------------------------------------"
     echo "fstest.$_n : $_filter_param"
@@ -105,13 +111,6 @@ _process_args()
     done
 }
 
-# real QA test starts here
-rm -f $seqres.full
-
-_supported_fs generic
-_supported_os IRIX Linux
-_require_test
-
 #
 # set params
 # These params can take a while on different CPUs/OSs
diff --git a/tests/generic/247 b/tests/generic/247
index c8648a2..832ade1 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -48,7 +48,12 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 
-testfile=$TEST_DIR/$seq.$$
+# this test leaves a 512MB file around if we abort the test during the run via a
+# reboot or kernel panic. Hence just name the file $seq so that we can always
+# clean up on the next run and not leave large stale files around on the testdir
+# that can lead to ENOSPC issues over time.
+testfile=$TEST_DIR/$seq
+rm -f $testfile
 
 loops=500
 iosize=1048576
diff --git a/tests/xfs/020 b/tests/xfs/020
index 957f3c4..dc305c1 100755
--- a/tests/xfs/020
+++ b/tests/xfs/020
@@ -37,7 +37,7 @@ _cleanup()
 {
     cd /
     rm -f $tmp.*
-    rm -f $TEST_DIR/fsfile
+    rm -f $fsfile
 }
 
 # get standard environment, filters and checks
@@ -51,8 +51,11 @@ _require_test
 
 echo "Silence is golden"
 
-$MKFS_PROG -t xfs -d size=60t,file,name=$TEST_DIR/fsfile >/dev/null
-$XFS_REPAIR_PROG -o ag_stride=32 -t 1 $TEST_DIR/fsfile >/dev/null 2>&1
+fsfile=$TEST_DIR/fsfile.$seq
+rm -f $fsfile
+
+$MKFS_PROG -t xfs -d size=60t,file,name=$fsfile >/dev/null
+$XFS_REPAIR_PROG -o ag_stride=32 -t 1 $fsfile >/dev/null 2>&1
 
 status=$?
 exit
-- 
2.0.0

