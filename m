Received: from mga05.intel.com ([192.55.52.43]:53958 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394221AbfIWRxo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:53:44 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 06/16] src/locktest.c: Fix return code if last test fails
Date: Mon, 23 Sep 2019 10:53:26 -0700
Message-Id: <20190923175336.2287-7-ira.weiny@intel.com>
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

If anything but the first step of the last test fails, the exit code
(fail_count) was not properly set.  Fix this such that follow on patches
will be able to save error output and correctly inform the script that a
failure has occurred rather than just expecting random output to fail
the diff check.

The issue is last_test is not properly tracking which test the loop is
currently on.  Therefore fail_count would not be incremented correctly.

Remove the special case of checking for the end of the steps array and
track last_test properly.  Then adjust test_count to be correct for the
new code.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 3abb91120144..241e7c451724 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -963,7 +963,7 @@ main(int argc, char *argv[])
     int end = 0;
     int result = 0;
     int last_test = 0;
-    int test_count = 0;
+    int test_count = -1;
     int fail_flag = 0;
     while(!end) {
 	if (server) {
@@ -1058,15 +1058,13 @@ main(int argc, char *argv[])
 		    }
 		}
 	    }
-	    if(tests[index][TEST_NUM] != 0) {
-		if(last_test != tests[index][TEST_NUM]) {
-		    test_count++;
-		    if(fail_flag)
-			fail_count++;
-		    fail_flag = 0;
 
-		}
-		last_test = tests[index][TEST_NUM];
+	    if(last_test != tests[index][TEST_NUM]) {
+	        test_count++;
+	        if(fail_flag)
+		    fail_count++;
+	        fail_flag = 0;
+	        last_test = tests[index][TEST_NUM];
 	    }
 		
 	    index++;
@@ -1126,9 +1124,8 @@ main(int argc, char *argv[])
 		fprintf(stderr,"client: sending result to server (%d)\n", ctl.index);
 	    /* Send result to the server */
 	    send_ctl();
-	    if(tests[index][TEST_NUM] != 0) {
-		if(last_test != tests[index][TEST_NUM])
-		    test_count++;
+	    if(last_test != tests[index][TEST_NUM]) {
+		test_count++;
 		last_test = tests[index][TEST_NUM];
 	    }
 	}
-- 
2.20.1
