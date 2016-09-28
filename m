Received: from mx1.redhat.com ([209.132.183.28]:41400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbcI1Do0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Sep 2016 23:44:26 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66AECC04D2E2
        for <fstests@vger.kernel.org>; Wed, 28 Sep 2016 03:44:26 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/2] generic/052: use _check_scratch_fs not _xfs_check
Date: Wed, 28 Sep 2016 11:44:09 +0800
Message-Id: <1475034250-6909-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

generic/052 was made generic from an xfs test, and generic functions
should be used not the xfs-specific ones.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/052 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/052 b/tests/generic/052
index a81885b..74cf5b6 100755
--- a/tests/generic/052
+++ b/tests/generic/052
@@ -72,7 +72,7 @@ _print_logstate
 
 # curious if FS consistent at start
 if false; then
-    if _xfs_check $SCRATCH_DEV; then
+    if _check_scratch_fs; then
        echo "*** checked ok ***"
     fi
 fi
-- 
2.7.4

