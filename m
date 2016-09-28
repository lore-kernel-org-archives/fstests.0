Received: from mx1.redhat.com ([209.132.183.28]:36436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbcI1Do3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 27 Sep 2016 23:44:29 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDB43E0372
        for <fstests@vger.kernel.org>; Wed, 28 Sep 2016 03:44:28 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/2] xfs/287: fix wrong seq number in test
Date: Wed, 28 Sep 2016 11:44:10 +0800
Message-Id: <1475034250-6909-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1475034250-6909-1-git-send-email-eguan@redhat.com>
References: <1475034250-6909-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

It's 287 not 285.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/287 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/287 b/tests/xfs/287
index aca410a..766c91e 100755
--- a/tests/xfs/287
+++ b/tests/xfs/287
@@ -1,5 +1,5 @@
 #! /bin/bash
-# FS QA Test No. 285
+# FS QA Test No. 287
 #
 # Test to verify project quota xfs_admin, xfsdump/xfsrestore and
 # xfs_db functionality
-- 
2.7.4

