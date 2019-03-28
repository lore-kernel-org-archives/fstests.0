Received: from mail.cn.fujitsu.com ([183.91.158.132]:5090 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725875AbfC1HtY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Mar 2019 03:49:24 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id A79314CD5D2E
        for <fstests@vger.kernel.org>; Thu, 28 Mar 2019 15:49:18 +0800 (CST)
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] common/populate: decrease the step of rm file
Date: Thu, 28 Mar 2019 15:48:59 +0800
Message-ID: <1553759339-2206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

 Now that we have allocated 2*4096*64/16(32768) inodes after "Inode btree",
 but the step of rm file is too large to create enough free inodes in agi.
 So the freecount is not enough large to make free_level gt 1 and call
 _scratch__populate on xfs will report the following failure(such as xfs/083):

Failed to create fino of sufficient height!

By decreasing the step of rm file, xfs/083 will pass.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 common/populate | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/populate b/common/populate
index 4fa118f0..7403dec3 100644
--- a/common/populate
+++ b/common/populate
@@ -271,7 +271,7 @@ _scratch_xfs_populate() {
 		touch "${dir}/${f}"
 	done
 
-	seq 0 "$((ino_per_rec + 1))" "${nr}" | while read f; do
+	seq 0 2 "${nr}" | while read f; do
 		rm -f "${dir}/${f}"
 	done
 
-- 
2.18.1
