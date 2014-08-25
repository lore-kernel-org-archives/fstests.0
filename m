Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:58570 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755323AbaHYWec (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 Aug 2014 18:34:32 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XM2q1-0008PZ-NS
	for fstests@vger.kernel.org; Tue, 26 Aug 2014 08:34:09 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XM2q1-0008Cj-MU
	for fstests@vger.kernel.org; Tue, 26 Aug 2014 08:34:09 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/2] common: don't check scratch dev on all tests
Date: Tue, 26 Aug 2014 08:34:02 +1000
Message-Id: <1409006043-31495-2-git-send-email-david@fromorbit.com>
In-Reply-To: <1409006043-31495-1-git-send-email-david@fromorbit.com>
References: <1409006043-31495-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Some tests deliberately corrupt  scratch devices and so will fail
the post-test check. Add a "_require_scratch_nocheck" helper
function for such tests to avoid false test failure detection.

Also, ensure that _notrun cleans up the trigger for the post-test
checks. Otherwise the next test to run may try to validate the
scratch/test devices even though they are not used by the test.

Further, _check_xfs_filesystem() causes check to exit if it finds a
corruption. This is extremely annoying as it terminates the entire
test run rather than just reporting that the test fails. Hence add
an "iam != check" test before exiting so that calls from tests will
cause the test to fail, but calls from check won't cause the harness
to exit.

There are still some tests that fail the scratch check, these are
not obvious test failures and so need further investigation to
determine the cause of the failures.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc         | 24 +++++++++++++++++++-----
 tests/generic/311 |  2 +-
 tests/generic/321 |  2 +-
 tests/generic/322 |  2 +-
 tests/xfs/001     |  2 +-
 tests/xfs/002     |  2 +-
 tests/xfs/005     |  2 +-
 tests/xfs/045     |  2 +-
 tests/xfs/049     |  3 +--
 tests/xfs/202     |  4 +++-
 tests/xfs/205     |  3 ++-
 11 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/common/rc b/common/rc
index 16da898..95abfe3 100644
--- a/common/rc
+++ b/common/rc
@@ -908,12 +908,15 @@ _do()
     return $ret
 }
 
-# bail out, setting up .notrun file
+# bail out, setting up .notrun file. Need to kill the filesystem check files
+# here, otherwise they are set incorrectly for the next test.
 #
 _notrun()
 {
     echo "$*" > $seqres.notrun
     echo "$seq not run: $*"
+    rm -f ${RESULT_DIR}/require_test
+    rm -f ${RESULT_DIR}/require_scratch
     status=0
     exit
 }
@@ -960,8 +963,9 @@ _supported_os()
 }
 
 # this test needs a scratch partition - check we're ok & unmount it
-#
-_require_scratch()
+# No post-test check of the device is required. e.g. the test intentionally
+# finishes the test with the filesystem in a corrupt state
+_require_scratch_nocheck()
 {
     case "$FSTYP" in
 	nfs*)
@@ -1005,9 +1009,17 @@ _require_scratch()
             exit 1
         fi
     fi
-    touch ${RESULT_DIR}/require_scratch
+    rm -f ${RESULT_DIR}/require_scratch
+}
+
+# we need the scratch device and it should be checked post test.
+_require_scratch()
+{
+	_require_scratch_nocheck
+	touch ${RESULT_DIR}/require_scratch
 }
 
+
 # this test needs a test partition - check we're ok & unmount it
 #
 _require_test()
@@ -1681,7 +1693,9 @@ _check_xfs_filesystem()
 
     if [ $ok -eq 0 ]; then
 	status=1
-	exit 1
+	if [ "$iam" != "check" ]; then
+		exit 1
+	fi
     fi
 
     return 0
diff --git a/tests/generic/311 b/tests/generic/311
index e389049..85e52e8 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -54,7 +54,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
-_require_scratch
+_require_scratch_nocheck
 _require_dm_flakey
 
 # xfs_io is not required for this test, but it's the best way to verify
diff --git a/tests/generic/321 b/tests/generic/321
index 8410d40..3bd6b12 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -43,7 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
-_require_scratch
+_require_scratch_nocheck
 _require_dm_flakey
 
 rm -f $seqres.full
diff --git a/tests/generic/322 b/tests/generic/322
index fe1a4d5..3ec2387 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -43,7 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _need_to_be_root
-_require_scratch
+_require_scratch_nocheck
 _require_dm_flakey
 
 rm -f $seqres.full
diff --git a/tests/xfs/001 b/tests/xfs/001
index e72e6fd..c33adae 100755
--- a/tests/xfs/001
+++ b/tests/xfs/001
@@ -63,7 +63,7 @@ _do_bit_test()
 # Modify as appropriate.
 _supported_fs xfs
 _supported_os Linux
-_require_scratch
+_require_scratch_nocheck
 _require_xfs_mkfs_crc
 
 _scratch_mkfs -m crc=0 >/dev/null 2>&1
diff --git a/tests/xfs/002 b/tests/xfs/002
index d461d37..6dfdd6c 100755
--- a/tests/xfs/002
+++ b/tests/xfs/002
@@ -50,8 +50,8 @@ _cleanup()
 # Modify as appropriate.
 _supported_fs xfs
 _supported_os Linux
+_require_scratch_nocheck
 
-_require_scratch
 # So we can explicitly turn it _off_:
 _require_xfs_mkfs_crc
 
diff --git a/tests/xfs/005 b/tests/xfs/005
index 509ac61..5d4534b 100755
--- a/tests/xfs/005
+++ b/tests/xfs/005
@@ -53,7 +53,7 @@ filter_mount()
 _supported_fs xfs
 _supported_os Linux
 
-_require_scratch
+_require_scratch_nocheck
 _require_xfs_mkfs_crc
 
 rm -f $seqres.full
diff --git a/tests/xfs/045 b/tests/xfs/045
index 31516b3..7d8a4a1 100755
--- a/tests/xfs/045
+++ b/tests/xfs/045
@@ -45,7 +45,7 @@ _supported_fs xfs
 _supported_os Linux
 
 _require_test
-_require_scratch
+_require_scratch_nocheck
 
 echo "*** get uuid"
 uuid=`_get_existing_uuid`
diff --git a/tests/xfs/049 b/tests/xfs/049
index dc76baa..04c2c75 100755
--- a/tests/xfs/049
+++ b/tests/xfs/049
@@ -60,7 +60,7 @@ _log()
 }
 
 _require_nonexternal
-_require_scratch
+_require_scratch_nocheck
 _require_no_large_scratch_dev
 _require_loop
 _require_ext2
@@ -133,7 +133,6 @@ umount -d $SCRATCH_MNT/test >> $seqres.full 2>&1 \
 echo "--- mounts at end (before cleanup)" >> $seqres.full
 mount >> $seqres.full
 
-rm -f $seqres.full
 # success, all done
 status=0
 exit
diff --git a/tests/xfs/202 b/tests/xfs/202
index 15c6603..b9827a7 100755
--- a/tests/xfs/202
+++ b/tests/xfs/202
@@ -38,7 +38,9 @@ status=1	# failure is the default!
 _supported_fs xfs
 _supported_os Linux
 
-_require_scratch
+# single AG will cause default xfs_repair to fail. This test is actually
+# testing the special corner case option needed to repair a single AG fs.
+_require_scratch_nocheck
 
 #
 # The AG size is limited to 1TB (or even less with historic xfsprogs),
diff --git a/tests/xfs/205 b/tests/xfs/205
index 0c071ca..debdc2a 100755
--- a/tests/xfs/205
+++ b/tests/xfs/205
@@ -37,7 +37,8 @@ status=1	# failure is the default!
 _supported_fs xfs
 _supported_os Linux
 
-_require_scratch
+# single AG will cause xfs_repair to fail checks.
+_require_scratch_nocheck
 
 rm -f $seqres.full
 
-- 
2.0.0

