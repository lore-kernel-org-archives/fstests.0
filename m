Received: from cn.fujitsu.com ([59.151.112.132]:16856 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755924AbbIUDsq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 20 Sep 2015 23:48:46 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t8L3mRmS009079
	for <fstests@vger.kernel.org>; Mon, 21 Sep 2015 11:48:27 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH] fstests: Fix wrong ret value in log
Date: Mon, 21 Sep 2015 11:47:05 +0800
Message-ID: <2747ef92dbd3d3b64a7b7e397155af9b57630312.1442807209.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

Current code always output "truncfile returned 0" because $? was
modified by previous command.

This patch fixed above bug.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 tests/generic/014 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/014 b/tests/generic/014
index 7961961..a775f8b 100755
--- a/tests/generic/014
+++ b/tests/generic/014
@@ -61,10 +61,12 @@ echo "brevity is wit..."
 echo "------"
 echo "test 1"
 echo "------"
-if ! src/truncfile -c 10000 $TEST_DIR/truncfile.$$.0 >$tmp.out 2>&1
+src/truncfile -c 10000 $TEST_DIR/truncfile.$$.0 >$tmp.out 2>&1
+ret=$?
+if [ "$ret" -ne 0 ]
 then
     out=`cat $tmp.out`
-    echo "truncfile returned $? : \"$out\""
+    echo "truncfile returned $ret : \"$out\""
 else
     echo "OK"
 fi
-- 
1.8.5.1

