Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:12381 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751224AbbBPGvz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 16 Feb 2015 01:51:55 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1G6p3Mh005679
	for <fstests@vger.kernel.org>; Mon, 16 Feb 2015 14:51:04 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH 2/2] Fix warning of "Usage: _is_block_dev dev"
Date: Mon, 16 Feb 2015 14:50:40 +0800
Message-ID: <1424069440-14957-2-git-send-email-zhaolei@cn.fujitsu.com>
In-Reply-To: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com>
References: <1424069440-14957-1-git-send-email-zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

_is_block_dev() will show above warning when "$dev" is not exist.
It happened when the program check $TEST_DEV with blank $SCRATCH_DEV
which is optional.

Changelog v1->v2:
 Rewrite _is_block_dev() to make caller code simple.
 Suggested by: Dave Chinner <david@fromorbit.com>

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/rc | 63 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/common/rc b/common/rc
index 76522d4..c5f6953 100644
--- a/common/rc
+++ b/common/rc
@@ -947,12 +947,11 @@ _fs_options()
 
 # returns device number if a file is a block device
 #
-_is_block_dev()
+_dev_type()
 {
     if [ $# -ne 1 ]
     then
-	echo "Usage: _is_block_dev dev" 1>&2
-	exit 1
+        return
     fi
 
     _dev=$1
@@ -965,6 +964,25 @@ _is_block_dev()
     fi
 }
 
+_is_block_dev()
+{
+    _dev_type=`_dev_type "$1"`
+    if [ -z "$_dev_type" ]; then
+	return 1
+    fi
+
+    _not_same_dev_type=`_dev_type "$2"`
+    if [ -z "$_not_same_dev_type" ]; then
+	return 0
+    fi
+
+    if [ "$_dev_type" = "$_not_same_dev_type" ]; then
+	return 1
+    fi
+
+    return 0
+}
+
 # Do a command, log it to $seqres.full, optionally test return status
 # and die if command fails. If called with one argument _do executes the
 # command, logs it, and returns its exit status. With two arguments _do
@@ -1095,19 +1113,14 @@ _require_scratch_nocheck()
 		fi
 		;;
 	*)
-		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev $SCRATCH_DEV`" = "" ]
-		 then
-		     _notrun "this test requires a valid \$SCRATCH_DEV"
-		 fi
-		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev $TEST_DEV`" ]
-		 then
-		     _notrun "this test requires a valid \$SCRATCH_DEV"
-		 fi
+		if ! _is_block_dev "$SCRATCH_DEV" "$TEST_DEV"; then
+		    _notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
 		if [ ! -d "$SCRATCH_MNT" ]
 		then
-		     _notrun "this test requires a valid \$SCRATCH_MNT"
+		    _notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
-		 ;;
+		;;
     esac
 
     # mounted?
@@ -1167,19 +1180,14 @@ _require_test()
 		fi
 		;;
 	*)
-		 if [ -z "$TEST_DEV" -o "`_is_block_dev $TEST_DEV`" = "" ]
-		 then
-		     _notrun "this test requires a valid \$TEST_DEV"
-		 fi
-		 if [ "`_is_block_dev $SCRATCH_DEV`" = "`_is_block_dev $TEST_DEV`" ]
-		 then
-		     _notrun "this test requires a valid \$TEST_DEV"
-		 fi
+		if ! _is_block_dev "$TEST_DEV" "$SCRATCH_DEV"; then
+		    _notrun "this test requires a valid \$TEST_DEV"
+		fi
 		if [ ! -d "$TEST_DIR" ]
 		then
-		     _notrun "this test requires a valid \$TEST_DIR"
+		    _notrun "this test requires a valid \$TEST_DIR"
 		fi
-		 ;;
+		;;
     esac
 
     # mounted?
@@ -1288,7 +1296,7 @@ _require_block_device()
 	echo "Usage: _require_block_device <dev>" 1>&2
 	exit 1
     fi
-    if [ "`_is_block_dev $1`" == "" ]; then
+    if ! _is_block_dev "$1"; then
 	_notrun "require $1 to be valid block disk"
     fi
 }
@@ -2236,11 +2244,8 @@ _require_scratch_dev_pool()
 	esac
 
 	for i in $SCRATCH_DEV_POOL; do
-		if [ "`_is_block_dev $i`" = "" ]; then
-			_notrun "this test requires valid block disk $i"
-		fi
-		if [ "`_is_block_dev $i`" = "`_is_block_dev $TEST_DEV`" ]; then
-			_notrun "$i is part of TEST_DEV, this test requires unique disks"
+		if ! _is_block_dev "$i" "$TEST_DEV"; then
+			_notrun "$i is not valid valid block disk, or part of TEST_DEV, this test requires unique valid disks"
 		fi
 		if _mount | grep -q $i; then
 			if ! $UMOUNT_PROG $i; then
-- 
1.8.5.1

