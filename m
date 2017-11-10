Received: from mx1.redhat.com ([209.132.183.28]:60036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755546AbdKJD5y (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Nov 2017 22:57:54 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] fstests: do not call _scratch_mkfs_sized in a pipe
Date: Fri, 10 Nov 2017 11:57:49 +0800
Message-Id: <20171110035749.8304-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

_scratch_mkfs_sized will create a filesystem of the given size, and
call _notrun and exit if current $FSTYP doesn't support sized mkfs.
But when it's called in a pipe, the exit in _notrun only exits from
the subshell created by the pipe not the test itself, and test
continues to run unnecessarily, though the test is still reported as
[notrun] due to existence of $seqres.notrun file.

Fix it by not calling _scratch_mkfs_sized in a pipe, but dumping the
output to a tmp file, which will be fed to _filter_mkfs later.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- fix xfs/015 as well
- update commit log a bit

 tests/generic/204 | 4 ++--
 tests/xfs/015     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/generic/204 b/tests/generic/204
index 4c203a213f5b..ebc9c0fa001b 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -58,8 +58,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
 
 SIZE=`expr 115 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null \
-		| _filter_mkfs 2> $tmp.mkfs > /dev/null
+_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
+cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
 _scratch_mount
 
 # Source $tmp.mkfs to get geometry
diff --git a/tests/xfs/015 b/tests/xfs/015
index 55666a8e3473..2c57f7882308 100755
--- a/tests/xfs/015
+++ b/tests/xfs/015
@@ -74,7 +74,8 @@ _scratch_unmount
 
 rm -f $seqres.full
 
-_scratch_mkfs_sized $((16 * 1024 * 1024)) | _filter_mkfs >$seqres.full 2>$tmp.mkfs
+_scratch_mkfs_sized $((16 * 1024 * 1024)) > $tmp.mkfs.raw
+cat $tmp.mkfs.raw | _filter_mkfs >$seqres.full 2>$tmp.mkfs
 # get original data blocks number and agcount
 . $tmp.mkfs
 _scratch_mount
-- 
2.13.6

