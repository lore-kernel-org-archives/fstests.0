Received: from mail-pf0-f170.google.com ([209.85.192.170]:34262 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbdBCXcl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2017 18:32:41 -0500
Received: by mail-pf0-f170.google.com with SMTP id e4so9049352pfg.1
        for <fstests@vger.kernel.org>; Fri, 03 Feb 2017 15:32:40 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] xfs/014: fix typo in xfs_quota command
Date: Fri,  3 Feb 2017 15:32:03 -0800
Message-Id: <f5be7cb3f0d910b97e7ad1bdb5c76d24fdb9df04.1486164662.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

This meant to say "$qa_group", not "$qa_grup".

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/xfs/014 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/014 b/tests/xfs/014
index 22ac4a81..875ab400 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -145,7 +145,7 @@ _test_edquot()
 	blks=`$XFS_QUOTA_PROG -xc "quota -u $qa_user" $dir | \
 		tail -n 1 | awk '{ print $2 }'`
 	$XFS_QUOTA_PROG -xc "limit -u bhard=${blks}k $qa_user" $dir
-	blks=`$XFS_QUOTA_PROG -xc "quota -g $qa_grup" $dir | \
+	blks=`$XFS_QUOTA_PROG -xc "quota -g $qa_group" $dir | \
 		tail -n 1 | awk '{ print $2 }'`
 	$XFS_QUOTA_PROG -xc "limit -g bhard=${blks}k $qa_group" $dir
 
-- 
2.11.0

