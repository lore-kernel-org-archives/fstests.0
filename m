Received: from mx2.suse.de ([195.135.220.15]:53254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751153AbdFBOu7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 2 Jun 2017 10:50:59 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] common: Fix wrong word in _require_group
Date: Fri,  2 Jun 2017 17:50:46 +0300
Message-Id: <1496415046-23940-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

Make _require_group yield the correct error message when the requested 
group is not found. 

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 743df427..87e6ff08 100644
--- a/common/rc
+++ b/common/rc
@@ -2027,7 +2027,7 @@ _require_group()
         qa_group=$1
     fi
     _cat_group | grep -q $qa_group
-    [ "$?" == "0" ] || _notrun "$qa_group user not defined."
+    [ "$?" == "0" ] || _notrun "$qa_group group not defined."
 }
 
 _filter_user_do()
-- 
2.12.3

