Received: from mx1.redhat.com ([209.132.183.28]:60554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfCaMbf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 31 Mar 2019 08:31:35 -0400
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH v2] common/rc: add global mounted option for _scratch_remount
Date: Sun, 31 Mar 2019 20:31:30 +0800
Message-Id: <20190331123130.14922-1-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: smfrench@gmail.com, Xiaoli Feng <xifeng@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Xiaoli Feng <xifeng@redhat.com>

When call _scratch_remount for cifs , it always requires to input
password. This will make generic/306 generic/452 failed because
cifs remount failed.
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 1c42515f..ea1eaf6a 100644
--- a/common/rc
+++ b/common/rc
@@ -357,7 +357,7 @@ _scratch_remount()
     local opts="$1"
 
     if test -n "$opts"; then
-	mount -o "remount,$opts" $SCRATCH_MNT
+	mount $MOUNT_OPTIONS -o "remount,$opts" $SCRATCH_MNT
     fi
 }
 
-- 
2.18.1
