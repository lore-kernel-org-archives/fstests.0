Received: from mga05.intel.com ([192.55.52.43]:53958 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394221AbfIWRxq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:53:46 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 10/16] src/locktest: Audit all debug output
Date: Mon, 23 Sep 2019 10:53:30 -0700
Message-Id: <20190923175336.2287-11-ira.weiny@intel.com>
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Audit all the debug output to be clear on what failed so that we can
remove the debug flag from the script.

Specifically, remove the need for a debug flag on system call error
output.  This helps to indicate what happened when an individual test
step fails.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Moved earlier in the series

 src/locktest.c    | 19 +++++++++++--------
 tests/generic/131 |  5 ++---
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 159d13291f79..3dc74947f100 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -647,7 +647,7 @@ static int do_lock(int cmd, int type, int start, int length)
     ret = fcntl(filedes, cmd, &fl);
     saved_errno = errno;	    
 
-    if(debug > 1 && ret)
+    if(ret)
 	fprintf(stderr, "do_lock: ret = %d, errno = %d (%s)\n", ret, errno, strerror(errno));
 
     return(ret==0?PASS:FAIL);
@@ -665,8 +665,11 @@ int do_close(void)
 
     saved_errno = errno;	    
 	
-    if (errno)
+    if (errno) {
+	fprintf(stderr, "%s errno = %d (%s)\n",
+		__FILE__, errno, strerror(errno));
 	return FAIL;
+    }
     return PASS;
 }
 
@@ -686,7 +689,7 @@ send_ctl(void)
 {
     int         nwrite;
 
-    if (debug > 1) {
+    if (debug) {
 	fprintf(stderr, "send_ctl: test=%d, command=%d offset=%"LL"d, length=%"LL"d, result=%d, error=%d\n", 
                 ctl.test, ctl.command, (long long)ctl.offset, (long long)ctl.length,ctl.result, ctl.error);
     }
@@ -741,7 +744,7 @@ void recv_ctl(void)
     ctl.index= bswap_uint32(ctl.index);
     ctl.error= bswap_uint32(ctl.error);
 
-    if (debug > 1) {
+    if (debug) {
 	fprintf(stderr, "recv_ctl: test=%d, command=%d offset=%"LL"d, length=%"LL"d, result=%d, error=%d\n", 
                 ctl.test, ctl.command, (long long)ctl.offset, (long long)ctl.length, ctl.result, ctl.error);
     }
@@ -977,7 +980,7 @@ main(int argc, char *argv[])
 	    }
 	    /* If we have a server command, deal with it */
 	    if(tests[index][WHO] == SERVER) {
-		if(debug>1)
+		if(debug)
 		    fprintf(stderr, "Got a server command (%d)\n", index);
 		if(tests[index][TEST_NUM] == 0) {
 		    index++;
@@ -1031,7 +1034,7 @@ main(int argc, char *argv[])
 		} 
 		/* get the client to do something */
 		init_ctl(index);
-		if(debug > 1)
+		if(debug)
 		    fprintf(stderr, "Sending command to client (%d) - %s - %lld:%lld\n", 
 					index,
 					get_cmd_str(ctl.command),
@@ -1068,7 +1071,7 @@ main(int argc, char *argv[])
 		
 	    index++;
 	} else { /* CLIENT */
-	    if(debug > 2)
+	    if(debug)
 		fprintf(stderr,"client: waiting...\n");
 	    /* wait for the server to do something */
 	    recv_ctl();
@@ -1120,7 +1123,7 @@ main(int argc, char *argv[])
 		ctl.result = PASS;
 		ctl.error = 0;
 	    }
-	    if(debug > 2)
+	    if(debug)
 		fprintf(stderr,"client: sending result to server (%d)\n", ctl.index);
 	    /* Send result to the server */
 	    send_ctl();
diff --git a/tests/generic/131 b/tests/generic/131
index 4d90411d4a19..9990f38b26a3 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -14,7 +14,6 @@ here=`pwd`
 tmp=/tmp/$$
 status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
-debug="-d"
 
 TESTFILE=$TEST_DIR/lock_file
 
@@ -63,7 +62,7 @@ function dump_logs_fail()
 }
 
 # Start the server
-src/locktest $debug $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
+src/locktest $TESTFILE 2> $SERVER_LOG 1> $SERVER_PORT &
 server_pid=$!
 
 timeout=30
@@ -89,7 +88,7 @@ fi
 
 # Start the client
 
-src/locktest $debug -p $PORT -h localhost $TESTFILE 2> $CLIENT_LOG
+src/locktest -p $PORT -h localhost $TESTFILE 2> $CLIENT_LOG
 client_result=$?
 client_pid=$!
 if [ $client_result -ne 0 ]; then
-- 
2.20.1
