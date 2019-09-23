Received: from mga18.intel.com ([134.134.136.126]:15071 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394221AbfIWRxn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:53:43 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 05/16] src/locktest.c: Clean up client command passing
Date: Mon, 23 Sep 2019 10:53:25 -0700
Message-Id: <20190923175336.2287-6-ira.weiny@intel.com>
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

The client was using the test index rather than the values being passed
to it for a command.  While this technically worked it is cleaner to
fully initialize the command message and use the values in that message.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 825d9df3ddf8..3abb91120144 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -670,6 +670,17 @@ int do_close(void)
     return PASS;
 }
 
+static void init_ctl(int32_t index)
+{
+    ctl.test= (int32_t)tests[index][TEST_NUM];
+    ctl.command = (int32_t)tests[index][COMMAND];
+    ctl.offset = tests[index][OFFSET];
+    ctl.length = tests[index][LENGTH];
+    ctl.index = index;
+    ctl.result = (int32_t)tests[index][RESULT];
+    ctl.error = 0;
+}
+
 void
 send_ctl(void)
 {
@@ -1018,6 +1029,8 @@ main(int argc, char *argv[])
 		    ctl.test = 0;
 		    end=1;
 		} 
+		/* get the client to do something */
+		init_ctl(index);
 		if(debug > 1)
 		    fprintf(stderr, "Sending command to client (%d) - %s - %lld:%lld\n", 
 					index,
@@ -1074,20 +1087,16 @@ main(int argc, char *argv[])
 		end = 1;
 		break;
 	    }
-		
 
-	    ctl.command = tests[index][COMMAND];
-	    ctl.offset = tests[index][OFFSET];
-	    ctl.length = tests[index][LENGTH];
-	    switch(tests[index][COMMAND]) {
+	    switch(ctl.command) {
 		case CMD_WRLOCK:
-		    result = do_lock(F_SETLK, F_WRLCK, tests[index][OFFSET], tests[index][LENGTH]);
+		    result = do_lock(F_SETLK, F_WRLCK, ctl.offset, ctl.length);
 		    break;
 		case CMD_RDLOCK:
-		    result = do_lock(F_SETLK, F_RDLCK, tests[index][OFFSET], tests[index][LENGTH]);
+		    result = do_lock(F_SETLK, F_RDLCK, ctl.offset, ctl.length);
 		    break;
 		case CMD_UNLOCK:
-		    result = do_lock(F_SETLK, F_UNLCK, tests[index][OFFSET], tests[index][LENGTH]);
+		    result = do_lock(F_SETLK, F_UNLCK, ctl.offset, ctl.length);
 		    break;
 		case CMD_CLOSE:
 		    result = do_close();
@@ -1096,21 +1105,22 @@ main(int argc, char *argv[])
 		    result = do_open(tests[index][FLAGS]);
 		    break;
 		case CMD_WRTEST:
-		    result = do_lock(F_GETLK, F_WRLCK, tests[index][OFFSET], tests[index][LENGTH]);
+		    result = do_lock(F_GETLK, F_WRLCK, ctl.offset, ctl.length);
 		    break;
 		case CMD_RDTEST:
-		    result = do_lock(F_GETLK, F_RDLCK, tests[index][OFFSET], tests[index][LENGTH]);
+		    result = do_lock(F_GETLK, F_RDLCK, ctl.offset, ctl.length);
 		    break;
 	    }
-	    if( result != tests[index][RESULT] ) {
+	    if( result != ctl.result ) {
 		if(debug)
-		    fprintf(stderr,"Got %d, wanted %lld\n", result,
-					(long long)tests[index][RESULT]);
+		    fprintf(stderr,"Got %d, wanted %d\n",
+				result, ctl.result);
 		ctl.result = FAIL;
 		ctl.error = saved_errno;
 		fail_count++;
 	    } else {
 		ctl.result = PASS;
+		ctl.error = 0;
 	    }
 	    if(debug > 2)
 		fprintf(stderr,"client: sending result to server (%d)\n", ctl.index);
-- 
2.20.1
