Received: from mga14.intel.com ([192.55.52.115]:39785 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393421AbfIWSAH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 14:00:07 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 15/16] common/locktest: Add common locktest functions
Date: Mon, 23 Sep 2019 10:59:58 -0700
Message-Id: <20190923175959.2802-1-ira.weiny@intel.com>
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Move common test functions to common directory and call them from the
lock test.  This is in preparation for adding a separate lease test.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	New patch for this series

 common/locktest   | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/131 | 80 +++--------------------------------------
 2 files changed, 95 insertions(+), 76 deletions(-)
 create mode 100644 common/locktest

diff --git a/common/locktest b/common/locktest
new file mode 100644
index 000000000000..c41f5054c523
--- /dev/null
+++ b/common/locktest
@@ -0,0 +1,91 @@
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2019 Intel Corp, All Rights Reserved
+
+SERVER_LOG=$TEST_DIR/server.out
+SERVER_PORT=$TEST_DIR/server.port
+CLIENT_LOG=$TEST_DIR/client.out
+TESTFILE=$TEST_DIR/lock_file
+client_pid=""
+server_pid=""
+
+_cleanup()
+{
+	kill $client_pid > /dev/null 2>&1
+	kill $server_pid > /dev/null 2>&1
+	rm -f $TESTFILE
+}
+
+_dump_logs_fail()
+{
+	fail_str=$1
+
+	echo "     ***** Client log *****" >> $seqres.full
+	cat $CLIENT_LOG >> $seqres.full
+	echo "     ***** Server log *****" >> $seqres.full
+	cat $SERVER_LOG >> $seqres.full
+	echo "     ***** End file details *****" >> $seqres.full
+	ls -la $TESTFILE >> $seqres.full
+	_fail $fail_str
+	exit 1
+}
+
+
+_run_generic() {
+	mode=$1
+
+	# set up log files
+	rm -f $SERVER_LOG
+	touch $SERVER_LOG
+	rm -f $SERVER_PORT
+	touch $SERVER_PORT
+	rm -f $CLIENT_LOG
+	touch $CLIENT_LOG
+
+	touch $TESTFILE
+
+	# Start the server
+	src/locktest $mode $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
+	server_pid=$!
+
+	timeout=30
+	while [ $timeout -gt 0 ]; do
+		sleep 1
+
+		PORT=$(cat $SERVER_PORT | grep "^server port: " | awk '{print $3}')
+		if [ -n "$PORT" ]; then
+			break
+		fi
+
+		# check the existence of server process
+		if ! kill -s 0 $server_pid >/dev/null 2>&1; then
+			_dump_logs_fail "Server died abnormally"
+		fi
+
+		let timeout=timeout-1
+	done
+
+	if [ -z "$PORT" ]; then
+		_dump_logs_fail "Could not get server port"
+	fi
+
+	# Start the client
+
+	src/locktest $mode -p $PORT -h localhost $TESTFILE 2> $CLIENT_LOG
+	client_result=$?
+	client_pid=$!
+	if [ $client_result -ne 0 ]; then
+		_dump_logs_fail "Client reported failure ($client_result)"
+	fi
+	wait $server_pid
+	server_result=$?
+	if [ $server_result -ne 0 ]; then
+		_dump_logs_fail "Server reported failure ($server_result)"
+	fi
+	echo success!
+	status=0
+}
+
+_run_locktest() {
+	_run_generic ""
+}
diff --git a/tests/generic/131 b/tests/generic/131
index 9990f38b26a3..f086bc9840c1 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -13,20 +13,13 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-TESTFILE=$TEST_DIR/lock_file
-
-_cleanup()
-{
-	kill $client_pid > /dev/null 2>&1
-	kill $server_pid > /dev/null 2>&1
-	rm -f $TESTFILE
-}
 
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
+. ./common/locktest
+
+trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # real QA test starts here
 _supported_fs generic
@@ -34,71 +27,6 @@ _supported_os Linux
 _require_test
 _require_test_fcntl_advisory_locks
 
-# set up log files
-SERVER_LOG=$TEST_DIR/server.out
-rm -f $SERVER_LOG
-touch $SERVER_LOG
-SERVER_PORT=$TEST_DIR/server.port
-rm -f $SERVER_PORT
-touch $SERVER_PORT
-CLIENT_LOG=$TEST_DIR/client.out
-rm -f $CLIENT_LOG
-touch $CLIENT_LOG
-
-touch $TESTFILE
-
-function dump_logs_fail()
-{
-	fail_str=$1
-
-	echo "     ***** Client log *****" >> $seqres.full
-	cat $CLIENT_LOG >> $seqres.full
-	echo "     ***** Server log *****" >> $seqres.full
-	cat $SERVER_LOG >> $seqres.full
-	echo "     ***** End file details *****" >> $seqres.full
-	ls -la $TESTFILE >> $seqres.full
-	_fail $fail_str
-	exit 1
-}
-
-# Start the server
-src/locktest $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
-server_pid=$!
-
-timeout=30
-while [ $timeout -gt 0 ]; do
-	sleep 1
-
-	PORT=$(cat $SERVER_PORT | grep "^server port: " | awk '{print $3}')
-	if [ -n "$PORT" ]; then
-		break
-	fi
-
-	# check the existence of server process
-	if ! kill -s 0 $server_pid >/dev/null 2>&1; then
-		dump_logs_fail "Server died abnormally"
-	fi
-
-	let timeout=timeout-1
-done
-
-if [ -z "$PORT" ]; then
-	dump_logs_fail "Could not get server port"
-fi
-
-# Start the client
+_run_locktest
 
-src/locktest -p $PORT -h localhost $TESTFILE 2> $CLIENT_LOG
-client_result=$?
-client_pid=$!
-if [ $client_result -ne 0 ]; then
-	dump_logs_fail "Client reported failure ($client_result)"
-fi
-wait $server_pid
-server_result=$?
-if [ $server_result -ne 0 ]; then
-	dump_logs_fail "Server reported failure ($server_result)"
-fi
-echo success!
-status=0
 exit
-- 
2.20.1
