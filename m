Received: from mga03.intel.com ([134.134.136.65]:23930 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfIREQU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 00:16:20 -0400
From: ira.weiny@intel.com
Subject: [PATCH 13/13] src/locktest: Audit all debug output
Date: Tue, 17 Sep 2019 21:15:58 -0700
Message-Id: <20190918041558.2621-14-ira.weiny@intel.com>
In-Reply-To: <20190918041558.2621-1-ira.weiny@intel.com>
References: <20190918041558.2621-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Audit all the debug output to be more clear on what failed.

Remove the debug flag from around prints for system call errors and
remove the debug flag from the script.  This helps to indicate what
happened when an individual test step fails.

Also, clean up the debug output to be a single level of test
infrastructure prints.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c    | 42 ++++++++++++++++++++++++------------------
 tests/generic/131 |  5 ++---
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index debae04f7753..d470533fbe03 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -730,7 +730,7 @@ static int do_truncate(size_t length)
 {
     int rc;
 
-    if (debug > 1)
+    if (debug)
 	fprintf(stderr, "truncating to %ld\n", length);
 
 again:
@@ -740,7 +740,7 @@ again:
 
     saved_errno = errno;
 
-    if (debug && rc)
+    if (rc)
 	fprintf(stderr, "%s %d : %s\n",
 		__FILE__, errno, strerror(errno));
 
@@ -752,14 +752,14 @@ void release_lease(int fd)
 	int rc;
 
 	rc = fcntl(fd, F_SETLEASE, F_UNLCK);
-	if (debug && rc != 0)
+	if (rc != 0)
 		fprintf(stderr, "%s Failed to remove lease %d : %d %s\n",
 			__FILE__, rc, errno, strerror(errno));
 }
 
 void lease_break(int sig, siginfo_t *info, void *p)
 {
-    if (debug > 1)
+    if (debug)
 	fprintf(stderr, "lease break %d %p fd %d\n",
 		sig, info, info->si_fd);
     got_sigio = 1;
@@ -778,17 +778,20 @@ int do_setup_sigio(int fd)
 	got_sigio = 0;
 
 	rc = sigaction(SIGIO, &lease_break_action, NULL);
-	if (rc != 0)
+	if (rc != 0) {
+		fprintf(stderr, "%s Set '%s' sigaction failed %d\n",
+			__FILE__, strsignal(SIGIO), rc);
 		return FAIL;
+	}
 
-	if (debug > 1)
+	if (debug)
 		fprintf(stderr, "Set '%s' sigaction on %d\n",
 			strsignal(SIGIO), fd);
 
 	rc = fcntl(fd, F_SETSIG, SIGIO);
-	if (debug && rc)
-		fprintf(stderr, "%s Set '%s' sigaction on %d\n",
-			__FILE__, strsignal(SIGIO), fd);
+	if (rc)
+		fprintf(stderr, "%s Set '%s' sigaction failed %d\n",
+			__FILE__, strsignal(SIGIO), rc);
 
 	return (rc == 0 ? PASS : FAIL);
 }
@@ -848,7 +851,7 @@ static int do_lock(int cmd, int type, int start, int length)
     ret = fcntl(filedes, cmd, &fl);
     saved_errno = errno;	    
 
-    if(debug > 1 && ret)
+    if(ret)
 	fprintf(stderr, "do_lock: ret = %d, errno = %d (%s)\n", ret, errno, strerror(errno));
 
     return(ret==0?PASS:FAIL);
@@ -873,7 +876,7 @@ static int do_lease(int cmd, int arg, int expected)
     if (expected && (expected == ret))
 	ret = 0;
 
-    if(debug > 1 && ret)
+    if(ret)
 	fprintf(stderr, "%s do_lease: ret = %d, errno = %d (%s)\n",
 		__FILE__, ret, errno, strerror(errno));
 
@@ -892,8 +895,11 @@ int do_close(void)
 
     saved_errno = errno;	    
 	
-    if (errno)
+    if (errno) {
+	fprintf(stderr, "%s errno = %d (%s)\n",
+		__FILE__, errno, strerror(errno));
 	return FAIL;
+    }
     return PASS;
 }
 
@@ -913,7 +919,7 @@ send_ctl(void)
 {
     int         nwrite;
 
-    if (debug > 1) {
+    if (debug) {
 	fprintf(stderr, "send_ctl: test=%d, command=%d offset=%"LL"d, length=%"LL"d, result=%d, error=%d\n", 
                 ctl.test, ctl.command, (long long)ctl.offset, (long long)ctl.length,ctl.result, ctl.error);
     }
@@ -971,7 +977,7 @@ again:
     ctl.index= bswap_uint32(ctl.index);
     ctl.error= bswap_uint32(ctl.error);
 
-    if (debug > 1) {
+    if (debug) {
 	fprintf(stderr, "recv_ctl: test=%d, command=%d offset=%"LL"d, length=%"LL"d, result=%d, error=%d\n", 
                 ctl.test, ctl.command, (long long)ctl.offset, (long long)ctl.length, ctl.result, ctl.error);
     }
@@ -1207,7 +1213,7 @@ main(int argc, char *argv[])
 	    }
 	    /* If we have a server command, deal with it */
 	    if(tests[index][WHO] == SERVER) {
-		if(debug>1)
+		if(debug)
 		    fprintf(stderr, "Got a server command (%d)\n", index);
 		if(tests[index][TEST_NUM] == 0) {
 		    index++;
@@ -1276,7 +1282,7 @@ main(int argc, char *argv[])
 		} 
 		/* get the client to do something */
 		init_ctl(index);
-		if(debug > 1)
+		if(debug)
 		    fprintf(stderr, "Sending command to client (%d) - %s - %lld:%lld\n", 
 					index,
 					get_cmd_str(ctl.command),
@@ -1313,7 +1319,7 @@ main(int argc, char *argv[])
 		
 	    index++;
 	} else { /* CLIENT */
-	    if(debug > 2)
+	    if(debug)
 		fprintf(stderr,"client: waiting...\n");
 	    /* wait for the server to do something */
 	    recv_ctl();
@@ -1381,7 +1387,7 @@ main(int argc, char *argv[])
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
