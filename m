Received: from mx1.redhat.com ([209.132.183.28]:41068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034537AbcIZMqo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Sep 2016 08:46:44 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32C3AA14FA
        for <fstests@vger.kernel.org>; Mon, 26 Sep 2016 12:46:44 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/349,350,351: remove from quick group
Date: Mon, 26 Sep 2016 20:46:32 +0800
Message-Id: <1474893992-32630-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

These tests are meant to test block devices, so they're not in auto
group. And quick group is a subset of auto group, so remove quick as
well.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/group | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index 879b1ef..dc8e70d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -352,9 +352,9 @@
 346 auto quick rw
 347 auto quick rw thin
 348 auto quick metadata
-349 blockdev quick rw zero
-350 blockdev quick rw punch
-351 blockdev quick rw punch collapse insert zero
+349 blockdev rw zero
+350 blockdev rw punch
+351 blockdev rw punch collapse insert zero
 352 auto clone
 353 auto quick clone
 354 auto
-- 
2.7.4

