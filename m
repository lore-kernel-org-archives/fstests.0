Received: from cn.fujitsu.com ([59.151.112.132]:34428 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752141AbbLIBRu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 8 Dec 2015 20:17:50 -0500
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
	by cn.fujitsu.com (Postfix) with ESMTP id 9A6CE40427C8
	for <fstests@vger.kernel.org>; Wed,  9 Dec 2015 09:16:56 +0800 (CST)
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] fstests: add generic/275 to the 'enospc' group
Date: Wed, 9 Dec 2015 09:00:19 +0800
Message-ID: <1449622819-12764-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Currently we're developing a new in-band deduplication feature for btrfs,
when enabing this feature, it will take much long time to hit the enospc
condition which 275 tries to create. I think 275 is also certain enospc
test and we should add it to 'enospc' group, then we can skip it easily by
excluding 'enospc' group when running fstests.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 355603f..3af390d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -228,7 +228,7 @@
 270 auto quota rw prealloc ioctl enospc stress
 273 auto rw
 274 auto rw prealloc
-275 auto rw
+275 auto rw enospc
 277 auto ioctl quick metadata
 280 auto quota freeze dangerous
 285 auto rw
-- 
1.8.2.1



