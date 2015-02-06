Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52997 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbbBFGhu (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:50 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 9/9 v5] tests/generic: relocate xfs's tests into tests/generic/
Date: Thu,  5 Feb 2015 22:37:13 -0800
Message-Id: <1423204633-66673-10-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch moves the generic testcases defined in xfs into tests/generic/.
  xfs/085 -> generic/052
  xfs/086 -> generic/054
  xfs/087 -> generic/055

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/{xfs/085 => generic/052}         |  6 +++---
 tests/{xfs/085.out => generic/052.out} |  2 +-
 tests/{xfs/086 => generic/054}         | 17 ++++++++---------
 tests/{xfs/086.out => generic/054.out} |  2 +-
 tests/{xfs/087 => generic/055}         | 15 +++++++--------
 tests/{xfs/087.out => generic/055.out} |  2 +-
 tests/generic/group                    |  3 +++
 tests/xfs/group                        |  3 ---
 8 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/tests/xfs/085 b/tests/generic/052
similarity index 96%
rename from tests/xfs/085
rename to tests/generic/052
index 1b6f424..3430b65 100755
--- a/tests/xfs/085
+++ b/tests/generic/052
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test No. 085
+# FS QA Test No. 052
 #
 # To test log replay by shutdown of file system
 # This is the first simple initial test to ensure that
@@ -40,7 +40,7 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 . ./common/log
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os IRIX Linux
 
 rm -f $seqres.full
@@ -51,7 +51,7 @@ _require_scratch_shutdown
 _require_logstate
 
 echo "mkfs"
-_scratch_mkfs_xfs >>$seqres.full 2>&1 \
+_scratch_mkfs >>$seqres.full 2>&1 \
     || _fail "mkfs scratch failed"
 
 echo "mount"
diff --git a/tests/xfs/085.out b/tests/generic/052.out
similarity index 94%
rename from tests/xfs/085.out
rename to tests/generic/052.out
index d2d99a1..df7a66a 100644
--- a/tests/xfs/085.out
+++ b/tests/generic/052.out
@@ -1,4 +1,4 @@
-QA output created by 085
+QA output created by 052
 mkfs
 mount
 touch files
diff --git a/tests/xfs/086 b/tests/generic/054
similarity index 92%
rename from tests/xfs/086
rename to tests/generic/054
index 0cc5008..6cb0122 100755
--- a/tests/xfs/086
+++ b/tests/generic/054
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test No. 086
+# FS QA Test No. 054
 #
 # To test log replay with version 2 logs
 # Initially keep this simple with just creates.
@@ -39,14 +39,13 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 . ./common/log
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os IRIX Linux
 
 rm -f $seqres.full $tmp.*
 _require_scratch
 _require_scratch_shutdown
 _require_logstate
-_require_v2log
 
 echo "*** init FS"
 umount $SCRATCH_DEV >/dev/null 2>&1
@@ -56,14 +55,14 @@ _get_log_configs > $tmp.seq.params
 # Do the work for various log params which
 # should not effect the data content of the log
 # Try with and without sync'ing - sync'ing will mean that
-# the log will be written out unfilled and thus the log 
+# the log will be written out unfilled and thus the log
 # stripe can have an effect.
 #
 for s in sync nosync ; do
     cat $tmp.seq.params \
     | while read mkfs mnt restofline
     do
-	if [ "$mkfs" = "#" ]; then 
+	if [ "$mkfs" = "#" ]; then
 	    continue
 	fi
 
@@ -73,8 +72,8 @@ for s in sync nosync ; do
 
 	# mkfs the FS
 	_echofull "mkfs"
-	_scratch_mkfs_xfs >>$seqres.full 2>&1
-	if [ $? -ne 0 ] ; then 
+	_scratch_mkfs >>$seqres.full 2>&1
+	if [ $? -ne 0 ] ; then
 	    _echofull "mkfs failed: $MKFS_OPTIONS"
 	    continue
 	fi
@@ -89,7 +88,7 @@ for s in sync nosync ; do
 	# create the metadata
 	if [ $s = "sync" ]; then
 	    # generate some log traffic - but not too much
-	    # add some syncs to get the log flushed to disk 
+	    # add some syncs to get the log flushed to disk
 	    for file in $SCRATCH_MNT/{0,1,2,3,4,5,6,7,8,9}{0,1,2,3,4,5,6,7,8,9}; do
 		touch $file
 		sync
@@ -137,5 +136,5 @@ for s in sync nosync ; do
     done
 done
 
-status=0 
+status=0
 exit
diff --git a/tests/xfs/086.out b/tests/generic/054.out
similarity index 99%
rename from tests/xfs/086.out
rename to tests/generic/054.out
index 40326ee..4654bde 100644
--- a/tests/xfs/086.out
+++ b/tests/generic/054.out
@@ -1,4 +1,4 @@
-QA output created by 086
+QA output created by 054
 *** init FS
 
 *** mkfs ***
diff --git a/tests/xfs/087 b/tests/generic/055
similarity index 93%
rename from tests/xfs/087
rename to tests/generic/055
index 2fd6f1a..068f0c3 100755
--- a/tests/xfs/087
+++ b/tests/generic/055
@@ -1,7 +1,7 @@
 #! /bin/bash
-# FS QA Test No. 087
+# FS QA Test No. 055
 #
-# * like 086 but want to create more/different kinds of metadata
+# * like 054 but want to create more/different kinds of metadata
 #   and so will use fsstress
 # * also can interrupt metadata with godown
 #
@@ -54,14 +54,13 @@ _do_meta()
 }
 
 # real QA test starts here
-_supported_fs xfs
+_supported_fs generic
 _supported_os IRIX Linux
 
 rm -f $seqres.full $tmp.*
 _require_scratch
 _require_scratch_shutdown
 _require_logstate
-_require_v2log 
 
 QUOTA_OPTION=`_get_quota_option`
 
@@ -73,7 +72,7 @@ _get_log_configs > $tmp.seq.params
 cat $tmp.seq.params \
 | while read mkfs mnt restofline
 do
-    if [ "$mkfs" = "#" ]; then 
+    if [ "$mkfs" = "#" ]; then
 	continue
     fi
 
@@ -83,8 +82,8 @@ do
 
     # mkfs the FS
     _echofull "mkfs"
-    _scratch_mkfs_xfs >>$seqres.full 2>&1
-    if [ $? -ne 0 ] ; then 
+    _scratch_mkfs >>$seqres.full 2>&1
+    if [ $? -ne 0 ] ; then
 	_echofull "mkfs failed: $MKFS_OPTIONS"
 	continue
     fi
@@ -140,5 +139,5 @@ do
     fi
 done
 
-status=0 
+status=0
 exit
diff --git a/tests/xfs/087.out b/tests/generic/055.out
similarity index 99%
rename from tests/xfs/087.out
rename to tests/generic/055.out
index 9f6f80a..048ef1e 100644
--- a/tests/xfs/087.out
+++ b/tests/generic/055.out
@@ -1,4 +1,4 @@
-QA output created by 087
+QA output created by 055
 *** init FS
 
 *** mkfs ***
diff --git a/tests/generic/group b/tests/generic/group
index d38240e..441d5a1 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -54,7 +54,10 @@
 049 metadata rw auto
 050 mount auto quick
 051 auto stress log metadata repair
+052 log auto quick
 053 acl repair auto quick
+054 log v2log auto
+055 log v2log auto quota stress
 062 attr udf auto quick
 068 other auto freeze dangerous stress
 069 rw udf auto quick
diff --git a/tests/xfs/group b/tests/xfs/group
index 4099793..3e1cffb 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -73,9 +73,6 @@
 081 deprecated # log logprint quota
 082 deprecated # log logprint v2log
 084 ioctl rw auto
-085 log auto quick
-086 log v2log auto
-087 log v2log auto quota stress
 090 rw auto
 092 other auto quick
 094 metadata dir ioctl auto
-- 
2.1.1

