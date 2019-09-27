Received: from szxga07-in.huawei.com ([45.249.212.35]:57944 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfI0KIe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 06:08:34 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] generic/group: add missing dedupe tag for generic/493
Date: Fri, 27 Sep 2019 18:08:10 +0800
Message-ID: <20190927100810.9351-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

We missed to add the tag, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 7cf4f6c4..18b5a545 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -495,7 +495,7 @@
 490 auto quick rw seek
 491 auto quick freeze mount
 492 auto quick
-493 auto quick swap
+493 auto quick swap dedupe
 494 auto quick swap punch
 495 auto quick swap
 496 auto quick swap
-- 
2.18.0.rc1
