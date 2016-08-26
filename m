Received: from cn.fujitsu.com ([59.151.112.132]:46090 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752847AbcHZDkI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 23:40:08 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] xfs/098: fix xfs_repair on newer xfsprogs
Date: Fri, 26 Aug 2016 11:36:52 +0800
Message-ID: <1472182612-10218-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160825154052.GD20705@birch.djwong.org>
References: <20160825154052.GD20705@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: darrick.wong@oracle.com, fstests@vger.kernel.org
Cc: zlang@redhat.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Make sure xfs_repair can't clear the log by default when it is corrupted.
xfs_repair always and only clear the log when the -L parameter is specified.
This has updated by:
Commit f2053bc ("xfs_repair: don't clear the log by default")

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc     | 4 ++--
 tests/xfs/098 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 3fb0600..c693a31 100644
--- a/common/rc
+++ b/common/rc
@@ -1143,9 +1143,9 @@ _repair_scratch_fs()
     xfs)
         _scratch_xfs_repair "$@" 2>&1
 	res=$?
-	if [ "$res" -eq 2 ]; then
+	if [ "$res" -ne 0 ]; then
 		echo "xfs_repair returns $res; replay log?"
-		_scratch_mount
+		_scratch_mount 2>&1
 		res=$?
 		if [ "$res" -gt 0 ]; then
 			echo "mount returns $res; zap log?"
diff --git a/tests/xfs/098 b/tests/xfs/098
index d91d617..eb33bb1 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -93,7 +93,7 @@ echo "+ mount image"
 _scratch_mount 2>/dev/null && _fail "mount should not succeed"
 
 echo "+ repair fs"
-_scratch_xfs_repair >> $seqres.full 2>&1
+_repair_scratch_fs >> $seqres.full
 
 echo "+ mount image (2)"
 _scratch_mount
-- 
1.8.3.1



