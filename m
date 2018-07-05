Received: from mail.cn.fujitsu.com ([183.91.158.132]:45233 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753056AbeGEBjA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Jul 2018 21:39:00 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 5B4D84B445A2
        for <fstests@vger.kernel.org>; Thu,  5 Jul 2018 09:38:52 +0800 (CST)
From: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Subject: [PATCH ] xfs/262: remove -y parameter
Date: Thu, 5 Jul 2018 09:37:03 +0800
Message-ID: <1530754623-2694-1-git-send-email-liuyd.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Since commit 66f7b4c2ce14 ("xfs_scrub: remove -y parameter") has removed parameter -y, -y is an invalid option.

Signed-off-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
---
 tests/xfs/262 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/262 b/tests/xfs/262
index 6c39268..b109f93 100755
--- a/tests/xfs/262
+++ b/tests/xfs/262
@@ -48,7 +48,7 @@ done
 LD_LIBRARY_PATH=$SCRATCH_MNT $LDD_PROG $SCRATCH_MNT/xfs_scrub >> $seqres.full
 
 echo "Force online repairs"
-XFS_SCRUB_FORCE_REPAIR=1 LD_LIBRARY_PATH=$SCRATCH_MNT $SCRATCH_MNT/xfs_scrub -dTvy $SCRATCH_MNT >> $seqres.full
+XFS_SCRUB_FORCE_REPAIR=1 LD_LIBRARY_PATH=$SCRATCH_MNT $SCRATCH_MNT/xfs_scrub -dTv $SCRATCH_MNT >> $seqres.full
 
 # success, all done
 status=0
-- 
2.7.4



