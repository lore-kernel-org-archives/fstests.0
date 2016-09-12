Received: from cn.fujitsu.com ([59.151.112.132]:31641 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756600AbcILFTg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Sep 2016 01:19:36 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3] xfs/098: fix xfs_repair on newer xfsprogs
Date: Mon, 12 Sep 2016 13:13:57 +0800
Message-ID: <1473657237-13148-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160909122831.GD12847@dhcp12-143.nay.redhat.com>
References: <20160909122831.GD12847@dhcp12-143.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, darrick.wong@oracle.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

The obsolete xfs_repair always cleared the log regardless of whether it
is corrupted.   However current xfs_repair only cleared the log when -L
option is specified, so xfs_repair without any options failed to clear log
on newer xfsprogs.  If xfs_repair failed to clear log, xfs_repair -L option
should be used to clear it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc     | 10 ++++++----
 tests/xfs/098 |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index 04039a4..fda108c 100644
--- a/common/rc
+++ b/common/rc
@@ -1134,16 +1134,18 @@ _scratch_xfs_repair()
     $XFS_REPAIR_PROG $SCRATCH_OPTIONS $* $SCRATCH_DEV
 }
 
-# Repair scratch filesystem.  Returns 0 if the FS is good to go (either no
-# errors found or errors were fixed) and nonzero otherwise; also spits out
-# a complaint on stderr if fsck didn't tell us that the FS is good to go.
+# Repair scratch filesystem.  Return 2 if the filesystem has valuable
+# metadata changes in log which needs to be replayed, 1 if there's
+# corruption left to be fixed or can't find log head and tail or some
+# other errors happened, and 0 if nothing wrong or all the corruptions
+# were fixed.
 _repair_scratch_fs()
 {
     case $FSTYP in
     xfs)
         _scratch_xfs_repair "$@" 2>&1
 	res=$?
-	if [ "$res" -eq 2 ]; then
+	if [ "$res" -ne 0 ]; then
 		echo "xfs_repair returns $res; replay log?"
 		_scratch_mount
 		res=$?
diff --git a/tests/xfs/098 b/tests/xfs/098
index d91d617..3743e78 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -93,7 +93,7 @@ echo "+ mount image"
 _scratch_mount 2>/dev/null && _fail "mount should not succeed"
 
 echo "+ repair fs"
-_scratch_xfs_repair >> $seqres.full 2>&1
+_repair_scratch_fs >> $seqres.full 2>&1
 
 echo "+ mount image (2)"
 _scratch_mount
-- 
1.8.3.1



