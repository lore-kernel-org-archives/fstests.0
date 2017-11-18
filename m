Received: from mx1.redhat.com ([209.132.183.28]:42590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161737AbdKRGTL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 18 Nov 2017 01:19:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1EE89883AB
        for <fstests@vger.kernel.org>; Sat, 18 Nov 2017 06:19:11 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] ltp/fsx: really skip fallocate keep_size calls when replaying ops
Date: Sat, 18 Nov 2017 14:19:06 +0800
Message-Id: <20171118061906.11227-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On start up, fsx checks for various fallocate(2) operation support
status and disables unsupported operations. But when replaying
operations from a log, fsx failed to skip KEEP_SIZE fallocate(2)
calls if underlying filesystem doesn't support it. For example,
NFSv4.2 supports fallocate(2) but not KEEP_SIZE, and this causes
generic/469 fails on NFSv4.2.

Fix it by taking 'keep_size_calls' into consideration when replaying
ops from log file.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

Note that generic/469 hasn't been pushed to upstream yet. Will do in
this week's update.

 ltp/fsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 9c358f27bd92..fc1381e60f09 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1469,7 +1469,7 @@ test(void)
 			offset = log_entry.args[0];
 			size = log_entry.args[1];
 			closeopen = !!(log_entry.flags & FL_CLOSE_OPEN);
-			keep_size = !!(log_entry.flags & FL_KEEP_SIZE);
+			keep_size = !!((log_entry.flags & FL_KEEP_SIZE) && keep_size_calls);
 			goto have_op;
 		}
 		return 0;
-- 
2.14.3

