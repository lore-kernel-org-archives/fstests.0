Received: from mx1.redhat.com ([209.132.183.28]:54547 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755309AbbJHJzZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 8 Oct 2015 05:55:25 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 8C5D58CF55
	for <fstests@vger.kernel.org>; Thu,  8 Oct 2015 09:55:25 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/167: wait for fsstress to exit
Date: Thu,  8 Oct 2015 17:55:01 +0800
Message-Id: <1444298101-7646-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

sync doesn't guarantee all fsstress processes died, and sometimes it
ends up running fsck on a mounted fs.

Use wait to wait for fsstress to exit.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/167 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/167 b/tests/xfs/167
index 875bd31..e6c65d2 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _cleanup()
 {
 	$KILLALL_PROG -r -q -TERM fsstress 2> /dev/null
-	sync	# ensures all fsstress processes died
+	wait	# ensures all fsstress processes died
 }
 
 workout()
-- 
2.4.3

