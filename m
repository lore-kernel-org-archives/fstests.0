Received: from szxga06-in.huawei.com ([45.249.212.32]:44278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfADIQC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jan 2019 03:16:02 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 35CB0A5A6A956
        for <fstests@vger.kernel.org>; Fri,  4 Jan 2019 16:15:59 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH v2 1/2] generic/131: wait until the server is ready or timeout
Date: Fri, 4 Jan 2019 16:19:26 +0800
Message-ID: <20190104081927.112622-2-houtao1@huawei.com>
In-Reply-To: <20190104081927.112622-1-houtao1@huawei.com>
References: <20190104081927.112622-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

When running xfstests under KVM VM and the load of host is high,
only delaying 1s and checking the readiness of server are not
enough, and the test case will fail early.

Fix it by repeatedly checking the readiness signal until it's found,
or timeout is triggered.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
v2:
    * add a timeout for the check of server readiness, else
      the test case may loop forever.
---
 tests/generic/131 | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/generic/131 b/tests/generic/131
index d7c146ae..80929c23 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -37,10 +37,19 @@ TESTFILE=$TEST_DIR/lock_file
 src/locktest $TESTFILE 2>&1 > $TEST_DIR/server.out &
 locktest_pid1=$!
 
-sleep 1
+timeout=30
+while [ $timeout -gt 0 ]; do
+	sleep 1
 
-PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
-if [ -z $PORT ]; then
+	PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
+	if [ -n "$PORT" ]; then
+		break
+	fi
+
+	let timeout=timeout-1
+done
+
+if [ -z "$PORT" ]; then
 	echo "Could not get server port"
 	exit 1
 fi
-- 
2.16.2.dirty
