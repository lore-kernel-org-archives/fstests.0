Received: from szxga06-in.huawei.com ([45.249.212.32]:38772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfCSGXq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Mar 2019 02:23:46 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B8C6E5C56AE73709B25B
        for <fstests@vger.kernel.org>; Tue, 19 Mar 2019 14:23:44 +0800 (CST)
From: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Subject: [PATCH] generic/131: Create server.out manually.
Date: Tue, 19 Mar 2019 14:27:55 +0800
Message-ID: <1552976875-39608-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, guaneryu@gmail.com
Cc: zhangxiaoxu5@huawei.com
List-ID: <fstests@vger.kernel.org>

From: zhangxiaoxu 00467499 <zhangxiaoxu5@huawei.com>

When test generic/131 on nfs, the 'server.out' maybe create
later than expect. Because the server is running on background,
we should ensure the 'server.out' is exist before 'cat' it.

So, let's create the server.out manually.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
---
 tests/generic/131 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/131 b/tests/generic/131
index c7bac3b..e78a64c 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -33,6 +33,9 @@ _require_test_fcntl_advisory_locks
 
 TESTFILE=$TEST_DIR/lock_file
 
+rm -rf $TEST_DIR/server.out
+touch $TEST_DIR/server.out
+
 # Start the server
 src/locktest $TESTFILE 2>&1 > $TEST_DIR/server.out &
 locktest_pid1=$!
-- 
2.7.4
