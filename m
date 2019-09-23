Received: from mga14.intel.com ([192.55.52.115]:39222 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440204AbfIWRwS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:52:18 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 09/16] src/locktest: Clean up error output
Date: Mon, 23 Sep 2019 10:51:57 -0700
Message-Id: <20190923175204.2139-10-ira.weiny@intel.com>
In-Reply-To: <20190923175204.2139-1-ira.weiny@intel.com>
References: <20190923175204.2139-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Add some debugging
Make sure all errors go to stderr
Clean up formatting and make failures stand out
Report test results for the client not just the server

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
	Moved earlier in the series

 src/locktest.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 241e7c451724..159d13291f79 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -827,6 +827,8 @@ main(int argc, char *argv[])
     }
 
     filename=argv[optind];
+    if (debug)
+	fprintf(stderr, "Working on file : %s\n", filename);
     if (do_open(O_RDWR) == FAIL)
 	exit(1);
 
@@ -905,10 +907,10 @@ main(int argc, char *argv[])
         struct hostent  *servInfo;
 
         if ((servInfo = gethostbyname(host)) == NULL) {
-	    printf("Couldn't get hostbyname for %s", host);
+	    fprintf(stderr, "Couldn't get hostbyname for %s", host);
 	    if (h_errno == HOST_NOT_FOUND)
-		printf(": host not found");
-	    printf("\n");
+		fprintf(stderr, ": host not found");
+	    fprintf(stderr, "\n");
             exit(1);
             /*NOTREACHED*/
         }
@@ -1011,16 +1013,14 @@ main(int argc, char *argv[])
 		    if( result != tests[index][RESULT]) {
 			fail_flag++;
 			/* We have a failure */
-			if(debug)
-			    fprintf(stderr, "Server failure in test %d, while %sing using offset %lld, length %lld - err = %d:%s\n", 
-					ctl.test,
-					get_cmd_str(tests[index][COMMAND]),
-						(long long)tests[index][OFFSET],
-						(long long)tests[index][LENGTH],
-						saved_errno, strerror(saved_errno));
-			fprintf(stderr, "Server failure in %lld:%s\n",
-					(long long)tests[index][TEST_NUM],
-					descriptions[tests[index][TEST_NUM] - 1]);
+			fprintf(stderr, "     ***** Server failure *****\n");
+			fprintf(stderr, "     in test %d, while %sing using offset %lld, length %lld - err = %d:%s\n", 
+				ctl.test, get_cmd_str(tests[index][COMMAND]),
+				(long long)tests[index][OFFSET],
+				(long long)tests[index][LENGTH],
+				saved_errno, strerror(saved_errno));
+			fprintf(stderr, "     %d:%s\n",
+					ctl.test, descriptions[ctl.test - 1]);
 		    }
 		}
 	    /* else send it off to the client */
@@ -1047,14 +1047,13 @@ main(int argc, char *argv[])
 		     * not what the command returned */
 		    if( ctl.result == FAIL ) {
 			fail_flag++;
-			if(debug)
-			    fprintf(stderr, "Client failure in test %d, while %sing using offset %lld, length %lld - err = %d:%s\n",
+			fprintf(stderr, "     ***** Client failure *****\n");
+			fprintf(stderr, "     in test %d, while %sing using offset %lld, length %lld - err = %d:%s\n",
 					ctl.test, get_cmd_str(ctl.command),
 					(long long)ctl.offset, (long long)ctl.length,
 					ctl.error, strerror(ctl.error));
-			fprintf(stderr, "Client failure in %lld:%s\n",
-					(long long)tests[index][TEST_NUM],
-					descriptions[tests[index][TEST_NUM] - 1]);
+			fprintf(stderr, "     %d:%s\n",
+					ctl.test, descriptions[ctl.test - 1]);
 		    }
 		}
 	    }
@@ -1110,9 +1109,10 @@ main(int argc, char *argv[])
 		    break;
 	    }
 	    if( result != ctl.result ) {
-		if(debug)
-		    fprintf(stderr,"Got %d, wanted %d\n",
-				result, ctl.result);
+		fprintf(stderr,"Failure in %d:%s\n",
+			ctl.test, descriptions[ctl.test - 1]);
+		fprintf(stderr,"     Got %d, wanted %d\n",
+			result, ctl.result);
 		ctl.result = FAIL;
 		ctl.error = saved_errno;
 		fail_count++;
@@ -1130,8 +1130,7 @@ main(int argc, char *argv[])
 	    }
 	}
     }
-    if(server)
-	printf("%d tests run, %d failed\n", test_count, fail_count);
+    fprintf(stderr, "%d tests run, %d failed\n", test_count, fail_count);
 }   
     
     exit(fail_count);
-- 
2.20.1
