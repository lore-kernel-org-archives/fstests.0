Received: from cn.fujitsu.com ([59.151.112.132]:12822 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752142AbcHYJWm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 05:22:42 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/098: fix xfs_repair on newer xfsprogs
Date: Thu, 25 Aug 2016 17:22:31 +0800
Message-ID: <1472116951-3317-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Make sure xfs_repair can't clear the log by default when it is corrupted.
xfs_repair always and only clear the log when the -L parameter is specified.
This has updated by:
Commit f2053bc ("xfs_repair: don't clear the log by default")

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/098 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/098 b/tests/xfs/098
index d91d617..0fe8d93 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -93,7 +93,9 @@ echo "+ mount image"
 _scratch_mount 2>/dev/null && _fail "mount should not succeed"
 
 echo "+ repair fs"
-_scratch_xfs_repair >> $seqres.full 2>&1
+_scratch_xfs_repair >> $seqres.full 2>&1 && _fail "xfs_repair should not succeed without -L option"
+
+_scratch_xfs_repair -L >> $seqres.full 2>&1
 
 echo "+ mount image (2)"
 _scratch_mount
-- 
1.8.3.1



