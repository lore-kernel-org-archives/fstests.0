Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:61071 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752933AbbC3JNE (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 30 Mar 2015 05:13:04 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2U9Bwwo005487
	for <fstests@vger.kernel.org>; Mon, 30 Mar 2015 17:11:58 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH] Fix caller's argument for _require_command()
Date: Mon, 30 Mar 2015 17:11:27 +0800
Message-ID: <9a1c40cb9eceb72543647cb4209269bc4aba86f0.1427706679.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

_require_command() only accept 2 arguments but some caller
misused this function, and caused "not_run" after we limit
calling way.

This patch fixed above caller.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/defrag | 13 +++++++++----
 tests/xfs/094 |  2 +-
 tests/xfs/103 |  2 +-
 tests/xfs/195 |  2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

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
 
diff --git a/tests/xfs/094 b/tests/xfs/094
index cee42d6..5c6e98d 100755
--- a/tests/xfs/094
+++ b/tests/xfs/094
@@ -46,7 +46,7 @@ _supported_fs xfs
 _supported_os IRIX Linux
 _require_realtime
 _require_scratch
-_require_command "$XFS_IO_PROG" xfs_io
+[ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
 
 _filter_realtime_flag()
 {
diff --git a/tests/xfs/103 b/tests/xfs/103
index cbe884f..d80dbf2 100755
--- a/tests/xfs/103
+++ b/tests/xfs/103
@@ -66,7 +66,7 @@ _filter_noymlinks_flag()
 # real QA test starts here
 _supported_os Linux IRIX
 _supported_fs xfs
-_require_command "$XFS_IO_PROG" xfs_io
+[ -n "$XFS_IO_PROG" ] || _notrun "xfs_io executable not found"
 _require_scratch
 
 _create_scratch
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

