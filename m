Received: from mga03.intel.com ([134.134.136.65]:6571 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389763AbfIWRwS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:52:18 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 08/16] generic/131: Save stderr for debugging
Date: Mon, 23 Sep 2019 10:51:56 -0700
Message-Id: <20190923175204.2139-9-ira.weiny@intel.com>
In-Reply-To: <20190923175204.2139-1-ira.weiny@intel.com>
References: <20190923175204.2139-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Details of which internal step failed within a test are lost without
additional debugging output.  Save that output by separating stdout and
stderr.

This allows the server port to be written solely to stdout for
consumption by the script.  Then all error output can be sent to the
seqres.full file in the event of a failure.  Then, depend on the return
code of the server _and_ the client to detect failure and save the error
output for inspection.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tests/generic/131 | 63 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/tests/generic/131 b/tests/generic/131
index c333e676e8f9..4d90411d4a19 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -14,11 +14,15 @@ here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
+debug="-d"
+
+TESTFILE=$TEST_DIR/lock_file
 
 _cleanup()
 {
 	kill $client_pid > /dev/null 2>&1
 	kill $server_pid > /dev/null 2>&1
+	rm -f $TESTFILE
 }
 
 # get standard environment, filters and checks
@@ -31,48 +35,71 @@ _supported_os Linux
 _require_test
 _require_test_fcntl_advisory_locks
 
-TESTFILE=$TEST_DIR/lock_file
+# set up log files
+SERVER_LOG=$TEST_DIR/server.out
+rm -f $SERVER_LOG
+touch $SERVER_LOG
+SERVER_PORT=$TEST_DIR/server.port
+rm -f $SERVER_PORT
+touch $SERVER_PORT
+CLIENT_LOG=$TEST_DIR/client.out
+rm -f $CLIENT_LOG
+touch $CLIENT_LOG
+
+touch $TESTFILE
+
+function dump_logs_fail()
+{
+	fail_str=$1
 
-rm -f $TEST_DIR/server.out
-touch $TEST_DIR/server.out
+	echo "     ***** Client log *****" >> $seqres.full
+	cat $CLIENT_LOG >> $seqres.full
+	echo "     ***** Server log *****" >> $seqres.full
+	cat $SERVER_LOG >> $seqres.full
+	echo "     ***** End file details *****" >> $seqres.full
+	ls -la $TESTFILE >> $seqres.full
+	_fail $fail_str
+	exit 1
+}
 
 # Start the server
-src/locktest $TESTFILE 2>&1 > $TEST_DIR/server.out &
+src/locktest $debug $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
 server_pid=$!
 
 timeout=30
 while [ $timeout -gt 0 ]; do
 	sleep 1
 
-	PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
+	PORT=$(cat $SERVER_PORT | grep "^server port: " | awk '{print $3}')
 	if [ -n "$PORT" ]; then
 		break
 	fi
 
 	# check the existence of server process
 	if ! kill -s 0 $server_pid >/dev/null 2>&1; then
-		echo "Server died abnormally"
-		exit 1
+		dump_logs_fail "Server died abnormally"
 	fi
 
 	let timeout=timeout-1
 done
 
 if [ -z "$PORT" ]; then
-	echo "Could not get server port"
-	exit 1
+	dump_logs_fail "Could not get server port"
 fi
 
 # Start the client
-src/locktest -p $PORT -h localhost $TESTFILE 2>&1 > $TEST_DIR/client.out
+
+src/locktest $debug -p $PORT -h localhost $TESTFILE 2> $CLIENT_LOG
+client_result=$?
 client_pid=$!
-result=$?
-if [ $result -eq 0 ]; then
-	echo success!
-	status=0
-else
-	echo "Client reported failure ($result)"
-	cat $TEST_DIR/*.out
+if [ $client_result -ne 0 ]; then
+	dump_logs_fail "Client reported failure ($client_result)"
 fi
-
+wait $server_pid
+server_result=$?
+if [ $server_result -ne 0 ]; then
+	dump_logs_fail "Server reported failure ($server_result)"
+fi
+echo success!
+status=0
 exit
-- 
2.20.1
