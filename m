Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:5383 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751339AbbDMEeV convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 13 Apr 2015 00:34:21 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3D4XA0F001095
	for <fstests@vger.kernel.org>; Mon, 13 Apr 2015 12:33:10 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH v2] Fix caller's argument for _require_command()
Date: Mon, 13 Apr 2015 12:32:43 +0800
Message-ID: <188af9eed150e2f7efb04b5d634a14ca50fdd694.1428899527.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

_require_command() only accept 2 arguments, first one is pure command,
and second one is name for error message.

But some caller misused this function, for example,
  DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
  _require_command $DEFRAG_PROG defragment
In above code, _require_command get 4 arguments, the caller's
second argument is never used, and the second field of first
argument is treat as "error message" in _require_command.

We fixed above case by adding quotes to _require_command()'s
arguments, it fixed most test case, but introduced a new bug,
in above case, "btrfs filesystem defragment" is not a command,
and always failed in _require_command(), it caused some testcase
not work, as btrfs/005.

This patch fixed above caller.

Changelog v1->v2:
1: Add detail description, suggested by:
   Lukáš Czerner <lczerner@redhat.com>
2: Add missed Reported-by.
3: Make $XFSDUMP_PROG always be a pure command, to avoid special
   handling for it.

Reported-by: Filipe David Manana <fdmanana@gmail.com>
Suggested-by: Lukáš Czerner <lczerner@redhat.com>
Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/defrag | 13 +++++++++----
 common/rc     |  3 ---
 tests/xfs/195 |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/common/defrag b/common/defrag
index f923dc0..b44ef98 100644
--- a/common/defrag
+++ b/common/defrag
@@ -22,22 +22,27 @@
 
 _require_defrag()
 {
+    local defrag_cmd
+
     case "$FSTYP" in
     xfs)
-        DEFRAG_PROG="$XFS_FSR_PROG"
+        defrag_cmd="$XFS_FSR_PROG"
+        DEFRAG_PROG="$defrag_cmd"
 	;;
     ext4|ext4dev)
-        DEFRAG_PROG="$E4DEFRAG_PROG"
+        defrag_cmd="$E4DEFRAG_PROG"
+        DEFRAG_PROG="$defrag_cmd"
 	;;
     btrfs)
-	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
+        defrag_cmd="$BTRFS_UTIL_PROG"
+        DEFRAG_PROG="defrag_cmd filesystem defragment"
 	;;
     *)
         _notrun "defragmentation not supported for fstype \"$FSTYP\""
 	;;
     esac
 
-    _require_command "$DEFRAG_PROG" defragment
+    _require_command "$defrag_cmd" defragment
     _require_xfs_io_command "fiemap"
 }
 
diff --git a/common/rc b/common/rc
index c1a50f2..02ac02a 100644
--- a/common/rc
+++ b/common/rc
@@ -2923,9 +2923,6 @@ init_rc()
 		$DF_PROG $TEST_DEV
 		exit 1
 	fi
-	# Figure out if we need to add -F ("foreign", deprecated) option to xfs_io
-	xfs_io -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
-	export XFS_IO_PROG="$XFS_IO_PROG -F"
 }
 
 # get real device path name by following link
diff --git a/tests/xfs/195 b/tests/xfs/195
index 21fcb00..075022d 100755
--- a/tests/xfs/195
+++ b/tests/xfs/195
@@ -65,7 +65,7 @@ _supported_os Linux
 
 _require_test
 _require_user
-_require_command "$XFSDUMP_PROG" xfsdump
+[ "$XFSDUMP_PROG" = "" ] && _notrun "xfsdump not found"
 
 echo "Preparing subtree"
 mkdir $TEST_DIR/d
-- 
1.8.5.1

