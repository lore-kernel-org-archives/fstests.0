Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39491 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbaJQJvU (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 17 Oct 2014 05:51:20 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id E1732AC8E
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2014 09:51:18 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH v2] xfs/195: Use XFSDUMP_PROG instead of xfsdump directly
Date: Fri, 17 Oct 2014 11:51:15 +0200
Message-Id: <1413539475-8365-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Use appropriate environment variable (XFSDUMP_PROG) instead of
hardcoding 'xfsdump' name. Also make the test fail graciously when
xfsdump isn't installed.

We also make XFSDUMP_PROG be equal to empty string instead of -e when
xfsdump isn't installed. The changes require some tweaking to output
filtering since full command path now appears in the output.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/config | 6 +++++-
 tests/xfs/195 | 7 ++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/common/config b/common/config
index 64506a23ac6b..1cb08c0ee441 100644
--- a/common/config
+++ b/common/config
@@ -163,7 +163,11 @@ export XFS_IO_PROG="`set_prog_path xfs_io`"
 export XFS_PARALLEL_REPAIR_PROG="`set_prog_path xfs_prepair`"
 export XFS_PARALLEL_REPAIR64_PROG="`set_prog_path xfs_prepair64`"
 export __XFSDUMP_PROG="`set_prog_path xfsdump`"
-export XFSDUMP_PROG="$__XFSDUMP_PROG -e"
+if [ -n "$__XFSDUMP_PROG" ]; then
+	export XFSDUMP_PROG="$__XFSDUMP_PROG -e"
+else
+	export XFSDUMP_PROG=""
+fi
 export XFSRESTORE_PROG="`set_prog_path xfsrestore`"
 export XFSINVUTIL_PROG="`set_prog_path xfsinvutil`"
 export GETFATTR_PROG="`set_prog_path getfattr`"
diff --git a/tests/xfs/195 b/tests/xfs/195
index c7bc7b815a2c..76f130ebdf66 100755
--- a/tests/xfs/195
+++ b/tests/xfs/195
@@ -48,11 +48,11 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 #
 _do_dump()
 {
-	xfsdump -l 0 -s d -F  \
+	$XFSDUMP_PROG -l 0 -s d -F  \
 		-L prova -M prova \
-		-f $TEST_DIR/dumpfile -e -v excluded_files=debug $TEST_DIR \
+		-f $TEST_DIR/dumpfile -v excluded_files=debug $TEST_DIR \
 		| grep "ino $inum" \
-		| sed -e 's/xfsdump: pruned ino [0-9]*, owner 0, estimated size 0: skip flag set/xfsdump: pruned ino NNN, owner 0, estimated size 0: skip flag set/'
+		| sed -e 's/.*xfsdump: pruned ino [0-9]*, owner 0, estimated size 0: skip flag set/xfsdump: pruned ino NNN, owner 0, estimated size 0: skip flag set/'
 }
 
 # get standard environment, filters and checks
@@ -65,6 +65,7 @@ _supported_os Linux
 
 _require_test
 _require_user
+_require_command $XFSDUMP_PROG xfsdump
 
 echo "Preparing subtree"
 mkdir $TEST_DIR/d
-- 
1.8.1.4

