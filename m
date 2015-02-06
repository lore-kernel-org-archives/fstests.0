Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52938 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbbBFGhp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 6 Feb 2015 01:37:45 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/9 v5] xfs/086,087: remove specific testing options in output
Date: Thu,  5 Feb 2015 22:37:10 -0800
Message-Id: <1423204633-66673-7-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
References: <1423204633-66673-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch removes the mkfs and mount options specified in output files in
xfs/086 and xfs/087.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/xfs/086     |  2 +-
 tests/xfs/086.out | 20 --------------------
 tests/xfs/087     |  2 +-
 tests/xfs/087.out |  9 ---------
 4 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/tests/xfs/086 b/tests/xfs/086
index 02977aa..1f81c1b 100755
--- a/tests/xfs/086
+++ b/tests/xfs/086
@@ -80,7 +80,7 @@ for s in sync nosync ; do
 	    continue
 	fi
 
-	echo "--- mkfs=$mkfs, mnt=$mnt, sync=$s ---"
+	echo "--- mkfs=$mkfs, mnt=$mnt, sync=$s ---" >>$seqres.full
 	export MKFS_OPTIONS="-l $mkfs"
 	export MOUNT_OPTIONS="-o $mnt"
 
diff --git a/tests/xfs/086.out b/tests/xfs/086.out
index ac56cc2..40326ee 100644
--- a/tests/xfs/086.out
+++ b/tests/xfs/086.out
@@ -1,6 +1,5 @@
 QA output created by 086
 *** init FS
---- mkfs=version=2, mnt=logbsize=32k, sync=sync ---
 
 *** mkfs ***
 
@@ -236,7 +235,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=4096, mnt=logbsize=32k, sync=sync ---
 
 *** mkfs ***
 
@@ -472,7 +470,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=32768, mnt=logbsize=32k, sync=sync ---
 
 *** mkfs ***
 
@@ -708,7 +705,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=32768, mnt=logbsize=64k, sync=sync ---
 
 *** mkfs ***
 
@@ -944,7 +940,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=64k, sync=sync ---
 
 *** mkfs ***
 
@@ -1180,7 +1175,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=64k, mnt=logbsize=64k, sync=sync ---
 
 *** mkfs ***
 
@@ -1416,7 +1410,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=128k, sync=sync ---
 
 *** mkfs ***
 
@@ -1652,7 +1645,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=128k, mnt=logbsize=128k, sync=sync ---
 
 *** mkfs ***
 
@@ -1888,7 +1880,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=256k, sync=sync ---
 
 *** mkfs ***
 
@@ -2124,7 +2115,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=256k, mnt=logbsize=256k, sync=sync ---
 
 *** mkfs ***
 
@@ -2360,7 +2350,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=32k, sync=nosync ---
 
 *** mkfs ***
 
@@ -2596,7 +2585,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=4096, mnt=logbsize=32k, sync=nosync ---
 
 *** mkfs ***
 
@@ -2832,7 +2820,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=32768, mnt=logbsize=32k, sync=nosync ---
 
 *** mkfs ***
 
@@ -3068,7 +3055,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=32768, mnt=logbsize=64k, sync=nosync ---
 
 *** mkfs ***
 
@@ -3304,7 +3290,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=64k, sync=nosync ---
 
 *** mkfs ***
 
@@ -3540,7 +3525,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=64k, mnt=logbsize=64k, sync=nosync ---
 
 *** mkfs ***
 
@@ -3776,7 +3760,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=128k, sync=nosync ---
 
 *** mkfs ***
 
@@ -4012,7 +3995,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=128k, mnt=logbsize=128k, sync=nosync ---
 
 *** mkfs ***
 
@@ -4248,7 +4230,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=256k, sync=nosync ---
 
 *** mkfs ***
 
@@ -4484,7 +4465,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=256k, mnt=logbsize=256k, sync=nosync ---
 
 *** mkfs ***
 
diff --git a/tests/xfs/087 b/tests/xfs/087
index 17a999c..8986f67 100755
--- a/tests/xfs/087
+++ b/tests/xfs/087
@@ -88,7 +88,7 @@ do
 	continue
     fi
 
-    echo "--- mkfs=$mkfs, mnt=$mnt ---"
+    echo "--- mkfs=$mkfs, mnt=$mnt ---" >> $seqres.full
     export MKFS_OPTIONS="-l $mkfs"
     export MOUNT_OPTIONS="-o $mnt"
 
diff --git a/tests/xfs/087.out b/tests/xfs/087.out
index 9f009c0..181774e 100644
--- a/tests/xfs/087.out
+++ b/tests/xfs/087.out
@@ -1,6 +1,5 @@
 QA output created by 087
 *** init FS
---- mkfs=version=2, mnt=logbsize=32k ---
 
 *** mkfs ***
 
@@ -43,7 +42,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=4096, mnt=logbsize=32k ---
 
 *** mkfs ***
 
@@ -86,7 +84,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=32768, mnt=logbsize=32k ---
 
 *** mkfs ***
 
@@ -129,7 +126,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=64k ---
 
 *** mkfs ***
 
@@ -172,7 +168,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=64k, mnt=logbsize=64k ---
 
 *** mkfs ***
 
@@ -215,7 +210,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=128k ---
 
 *** mkfs ***
 
@@ -258,7 +252,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=128k, mnt=logbsize=128k ---
 
 *** mkfs ***
 
@@ -301,7 +294,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2, mnt=logbsize=256k ---
 
 *** mkfs ***
 
@@ -344,7 +336,6 @@ clean log
 
 *** filesystem is checked ok ***
 
---- mkfs=version=2,su=256k, mnt=logbsize=256k ---
 
 *** mkfs ***
 
-- 
2.1.1

