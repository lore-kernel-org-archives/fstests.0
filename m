Received: from mx1.redhat.com ([209.132.183.28]:36150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfC1Lwi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 07:52:38 -0400
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH] common/rc: use _try_scratch_mount for scratch_remount
Date: Thu, 28 Mar 2019 19:52:33 +0800
Message-Id: <20190328115233.24816-1-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: smfrench@gmail.com, Xiaoli Feng <fengxiaoli0714@gmail.com>
List-ID: <fstests@vger.kernel.org>

From: Xiaoli Feng <fengxiaoli0714@gmail.com>

When use scratch_remount, it always gives up the global mounted
options. Then will make cifs mount failed for generic/306
generic/452.

Signed-off-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 1c42515f..6c262e32 100644
--- a/common/rc
+++ b/common/rc
@@ -357,7 +357,7 @@ _scratch_remount()
     local opts="$1"
 
     if test -n "$opts"; then
-	mount -o "remount,$opts" $SCRATCH_MNT
+	_try_scratch_mount "-o remount,$opts"
     fi
 }
 
-- 
2.18.1
