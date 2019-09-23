Received: from mga11.intel.com ([192.55.52.93]:51636 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440202AbfIWRwR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:52:17 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 07/16] generic/131: Clean up pid variables
Date: Mon, 23 Sep 2019 10:51:55 -0700
Message-Id: <20190923175204.2139-8-ira.weiny@intel.com>
In-Reply-To: <20190923175204.2139-1-ira.weiny@intel.com>
References: <20190923175204.2139-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Change the name of the variables to reflect the client vs server.  This
will help in future patches.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tests/generic/131 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/generic/131 b/tests/generic/131
index e8cdd48e8667..c333e676e8f9 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -17,8 +17,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
-    kill $locktest_pid2 > /dev/null 2>&1
-    kill $locktest_pid1 > /dev/null 2>&1
+	kill $client_pid > /dev/null 2>&1
+	kill $server_pid > /dev/null 2>&1
 }
 
 # get standard environment, filters and checks
@@ -38,7 +38,7 @@ touch $TEST_DIR/server.out
 
 # Start the server
 src/locktest $TESTFILE 2>&1 > $TEST_DIR/server.out &
-locktest_pid1=$!
+server_pid=$!
 
 timeout=30
 while [ $timeout -gt 0 ]; do
@@ -50,7 +50,7 @@ while [ $timeout -gt 0 ]; do
 	fi
 
 	# check the existence of server process
-	if ! kill -s 0 $locktest_pid1 >/dev/null 2>&1; then
+	if ! kill -s 0 $server_pid >/dev/null 2>&1; then
 		echo "Server died abnormally"
 		exit 1
 	fi
@@ -65,7 +65,7 @@ fi
 
 # Start the client
 src/locktest -p $PORT -h localhost $TESTFILE 2>&1 > $TEST_DIR/client.out
-locktest_pid2=$!
+client_pid=$!
 result=$?
 if [ $result -eq 0 ]; then
 	echo success!
-- 
2.20.1
