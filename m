Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:14683 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752883AbbBZKkK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 05:40:10 -0500
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t1QAdHbo026253
	for <fstests@vger.kernel.org>; Thu, 26 Feb 2015 18:39:17 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH v3 2/2] Fix warning of "Usage: _is_block_dev dev"
Date: Thu, 26 Feb 2015 18:38:59 +0800
Message-ID: <477b0e94819bea20d920822f0b88099ce19532a8.1424946979.git.zhaolei@cn.fujitsu.com>
In-Reply-To: <196cc72cb39e1a338339fa09c73f6334af63a2d6.1424946979.git.zhaolei@cn.fujitsu.com>
References: <196cc72cb39e1a338339fa09c73f6334af63a2d6.1424946979.git.zhaolei@cn.fujitsu.com>
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

Changelog v2->v3:
 Separate __same_block_dev() from _is_block_dev() to make code
 self documenting.
 Suggested by: Dave Chinner <david@fromorbit.com>

Changelog v1->v2:
 Rewrite _is_block_dev() to make caller code simple.
 Suggested by: Dave Chinner <david@fromorbit.com>

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/rc | 101 +++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/common/rc b/common/rc
index 5a8c74d..f528c25 100644
--- a/common/rc
+++ b/common/rc
@@ -945,24 +945,51 @@ _fs_options()
     ' </proc/mounts
 }
 
-# returns device number if a file is a block device
+# Returns:
+# 0: if filename is a block device
+# 1: if filename is not a block device
+# -1 if argument wrong
 #
 _is_block_dev()
 {
-    if [ $# -ne 1 ]
-    then
-	echo "Usage: _is_block_dev dev" 1>&2
-	exit 1
-    fi
+	if [ $# -ne 1 ]; then
+		return -1
+	fi
+	if [ -b "$1" ]; then
+		return 0
+	fi
+	return 1;
+}
 
-    _dev=$1
-    if [ -L "${_dev}" ]; then
-        _dev=`readlink -f ${_dev}`
-    fi
+# Returns:
+# 0: if the devices are same
+# 1: if the devices are not same
+#
+__same_block_dev()
+{
+	if [ $# -ne 2 ]; then
+		return 1
+	fi
 
-    if [ -b "${_dev}" ]; then
-        src/lstat64 ${_dev} | $AWK_PROG '/Device type:/ { print $9 }'
-    fi
+	_dev1="$1"
+	_dev2="$2"
+
+	if [ ! -b "$_dev1" -o ! -b "$_dev2" ]; then
+		return 1
+	fi
+
+	if [ -L "${_dev1}" ]; then
+		_dev1=`readlink -f "$_dev1"`
+	fi
+	if [ -L "${_dev2}" ]; then
+		_dev2=`readlink -f "$_dev2"`
+	fi
+
+	if [ `stat -c %t,%T "$_dev1"` != `stat -c %t,%T "$_dev2"` ]; then
+		return 1
+	fi
+
+	return 0;
 }
 
 # Do a command, log it to $seqres.full, optionally test return status
@@ -1095,19 +1122,16 @@ _require_scratch_nocheck()
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
-		if [ ! -d "$SCRATCH_MNT" ]
-		then
-		     _notrun "this test requires a valid \$SCRATCH_MNT"
+		if ! _is_block_dev "$SCRATCH_DEV"; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if __same_block_dev "$SCRATCH_DEV" "$TEST_DEV"; then
+			_notrun "\$SCRATCH_DEV and \$TEST_DEV are same device"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
-		 ;;
+		;;
     esac
 
     # mounted?
@@ -1167,19 +1191,16 @@ _require_test()
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
-		if [ ! -d "$TEST_DIR" ]
-		then
-		     _notrun "this test requires a valid \$TEST_DIR"
+		if ! _is_block_dev "$TEST_DEV"; then
+			_notrun "this test requires a valid \$TEST_DEV"
+		fi
+		if __same_block_dev "$TEST_DEV" "$SCRATCH_DEV"; then
+			_notrun "\$TEST_DEV and \$SCRATCH_DEV are same device"
 		fi
-		 ;;
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
     esac
 
     # mounted?
@@ -1288,7 +1309,7 @@ _require_block_device()
 		echo "Usage: _require_block_device <dev>" 1>&2
 		exit 1
 	fi
-	if [ "`_is_block_dev $1`" == "" ]; then
+	if ! _is_block_dev "$1"; then
 		_notrun "require $1 to be valid block disk"
 	fi
 }
@@ -2236,10 +2257,10 @@ _require_scratch_dev_pool()
 	esac
 
 	for i in $SCRATCH_DEV_POOL; do
-		if [ "`_is_block_dev $i`" = "" ]; then
+		if ! _is_block_dev "$i"; then
 			_notrun "this test requires valid block disk $i"
 		fi
-		if [ "`_is_block_dev $i`" = "`_is_block_dev $TEST_DEV`" ]; then
+		if __same_block_dev "$i" "$TEST_DEV"; then
 			_notrun "$i is part of TEST_DEV, this test requires unique disks"
 		fi
 		if _mount | grep -q $i; then
-- 
1.8.5.1

