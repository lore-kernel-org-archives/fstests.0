Received: from mx2.suse.de ([195.135.220.15]:56755 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1763680AbdEWLpt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 May 2017 07:45:49 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35E5AAAAD
        for <fstests@vger.kernel.org>; Tue, 23 May 2017 11:45:48 +0000 (UTC)
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] xfs: Make 'man' hard requirement for xfs/293
Date: Tue, 23 May 2017 14:45:43 +0300
Message-Id: <1495539943-9670-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

If xfs/293 is run on a system which doesn't have 'man' installed
it will hang the due to $CAT waiting for input indefinitely

Signed-off-by: Nikolay Borisov <nborisov@suse.com>

---
 tests/xfs/293 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/xfs/293 b/tests/xfs/293
index df44e98e..9556b4bb 100755
--- a/tests/xfs/293
+++ b/tests/xfs/293
@@ -40,6 +40,8 @@ _cleanup()
 . ./common/rc
 . ./common/filter
 
+_require_command man man
+
 # real QA test starts here
 
 # Modify as appropriate.
-- 
2.12.3

