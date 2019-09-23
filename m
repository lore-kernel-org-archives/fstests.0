Received: from mga02.intel.com ([134.134.136.20]:33973 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394221AbfIWRxr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:53:47 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 11/16] src/locktest: Add run() function
Date: Mon, 23 Sep 2019 10:53:31 -0700
Message-Id: <20190923175336.2287-12-ira.weiny@intel.com>
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Separate the functionality of main() into socket set up and run().  Pass
the test information to run() rather than have it be gloabal.  This is
in preparation for adding a separate lease test array.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	New patch for this series

 src/locktest.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 3dc74947f100..076781badaa1 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -146,7 +146,7 @@ static char *get_cmd_str(int cmd)
  * (or vice versa)
  */
 
-char *descriptions[] = {
+char *lock_descriptions[] = {
     /* 1 */"Add a lock to an empty lock list",
     /* 2 */"Add a lock to the start and end of a list - no overlaps",
     /* 3 */"Add a lock to the middle of a list - no overlap",
@@ -183,7 +183,7 @@ char *descriptions[] = {
     #endif
 };
 
-static int64_t tests[][6] =
+static int64_t lock_tests[][6] =
 	/*	test #	Action	[offset|flags]	length		expected	server/client */
 	{ 	
 	/* Various simple tests exercising the list */
@@ -673,7 +673,7 @@ int do_close(void)
     return PASS;
 }
 
-static void init_ctl(int32_t index)
+static void init_ctl(int64_t tests[][6], int32_t index)
 {
     ctl.test= (int32_t)tests[index][TEST_NUM];
     ctl.command = (int32_t)tests[index][COMMAND];
@@ -765,6 +765,9 @@ cleanup(void)
     PLATFORM_CLEANUP();
 }
 
+int
+run(int64_t tests[][6], char *descriptions[]);
+
 int
 main(int argc, char *argv[])
 {
@@ -778,7 +781,7 @@ main(int argc, char *argv[])
     char	*p;
     extern char	*optarg;
     extern int	optind;
-    int fail_count = 0;; 
+    int fail_count = 0;
     
     atexit(cleanup);
     
@@ -962,7 +965,13 @@ main(int argc, char *argv[])
      *
      * real work is in here ...
      */
-    i = 0;
+    fail_count = run(lock_tests, lock_descriptions);
+
+    exit(fail_count);
+    /*NOTREACHED*/
+}
+
+int run(int64_t tests[][6], char *descriptions[])
 {
     int index = 0;
     int end = 0;
@@ -970,6 +979,7 @@ main(int argc, char *argv[])
     int last_test = 0;
     int test_count = -1;
     int fail_flag = 0;
+    int fail_count = 0;
     while(!end) {
 	if (server) {
 	    if(testnumber > 0) {
@@ -1033,7 +1043,7 @@ main(int argc, char *argv[])
 		    end=1;
 		} 
 		/* get the client to do something */
-		init_ctl(index);
+		init_ctl(tests, index);
 		if(debug)
 		    fprintf(stderr, "Sending command to client (%d) - %s - %lld:%lld\n", 
 					index,
@@ -1134,10 +1144,6 @@ main(int argc, char *argv[])
 	}
     }
     fprintf(stderr, "%d tests run, %d failed\n", test_count, fail_count);
-}   
-    
-    exit(fail_count);
-    /*NOTREACHED*/
-}
-
 
+    return fail_count;
+}
-- 
2.20.1
