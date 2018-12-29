Received: from szxga04-in.huawei.com ([45.249.212.190]:17068 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728312AbeL2Cbg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Dec 2018 21:31:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 02EAA282A53F0
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 10:31:31 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH 3/5] generic/131: wait until the server is ready
Date: Sat, 29 Dec 2018 10:34:50 +0800
Message-ID: <20181229023452.28074-4-houtao1@huawei.com>
In-Reply-To: <20181229023452.28074-1-houtao1@huawei.com>
References: <20181229023452.28074-1-houtao1@huawei.com>
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
or the server exits.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tests/generic/131 | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/generic/131 b/tests/generic/131
index d7c146ae..1af86e77 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -37,13 +37,20 @@ TESTFILE=$TEST_DIR/lock_file
 src/locktest $TESTFILE 2>&1 > $TEST_DIR/server.out &
 locktest_pid1=$!
 
-sleep 1
+while true; do
+	sleep 1
 
-PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
-if [ -z $PORT ]; then
-	echo "Could not get server port"
-	exit 1
-fi
+	PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
+	if [ -n "$PORT" ]; then
+		break
+	fi
+
+	# check the existence of server process
+	if ! kill -s 0 $locktest_pid1 >/dev/null 2>&1; then
+		echo "Could not get server port"
+		exit 1
+	fi
+done
 
 # Start the client
 src/locktest -p $PORT -h localhost $TESTFILE 2>&1 > $TEST_DIR/client.out
-- 
2.16.2.dirty
