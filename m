Received: from mx1.redhat.com ([209.132.183.28]:44568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbdI2CUS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Sep 2017 22:20:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21DB0859FA
        for <fstests@vger.kernel.org>; Fri, 29 Sep 2017 02:20:18 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 1/2] tests: add new group dax
Date: Fri, 29 Sep 2017 10:20:02 +0800
Message-Id: <1506651603-21876-2-git-send-email-xzhou@redhat.com>
In-Reply-To: <1506651603-21876-1-git-send-email-xzhou@redhat.com>
References: <1506651603-21876-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/generic/group | 8 ++++----
 tests/xfs/group     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index f922b49..0d42d54 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -415,7 +415,7 @@
 410 auto quick mount
 411 auto quick mount
 412 auto quick metadata
-413 auto quick
+413 auto quick dax
 414 auto quick clone
 415 auto clone
 416 auto enospc
@@ -430,7 +430,7 @@
 425 auto quick attr
 426 auto quick exportfs
 427 auto quick aio rw
-428 auto quick
+428 auto quick dax
 429 auto encrypt
 430 auto quick copy
 431 auto quick copy
@@ -439,7 +439,7 @@
 434 auto quick copy
 435 auto encrypt
 436 auto quick rw
-437 auto quick
+437 auto quick dax
 438 auto
 439 auto quick punch
 440 auto quick encrypt
@@ -454,7 +454,7 @@
 449 auto quick acl enospc
 450 auto quick rw
 451 auto quick rw aio
-452 auto quick
+452 auto quick dax
 453 auto quick dir
 454 auto quick attr
 455 auto log replay
diff --git a/tests/xfs/group b/tests/xfs/group
index d352fe0..42e928b 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -257,7 +257,7 @@
 257 auto quick clone
 258 auto quick clone
 259 auto quick
-260 auto attr quick
+260 auto attr quick dax
 261 auto quick quota
 262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 263 auto quick quota
-- 
1.8.3.1

