Received: from mga11.intel.com ([192.55.52.93]:18673 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfIREQS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 00:16:18 -0400
From: ira.weiny@intel.com
Subject: [PATCH 12/13] src/locktest: Clean up error output
Date: Tue, 17 Sep 2019 21:15:57 -0700
Message-Id: <20190918041558.2621-13-ira.weiny@intel.com>
In-Reply-To: <20190918041558.2621-1-ira.weiny@intel.com>
References: <20190918041558.2621-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Add some debugging
Make sure all errors go to stderr
Clean up formatting and make failures stand out
Report test results for the client not just the server

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index b469a2270f82..debae04f7753 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -1057,6 +1057,8 @@ main(int argc, char *argv[])
     }
 
     filename=argv[optind];
+    if (debug)
+	fprintf(stderr, "Working on file : %s\n", filename);
     if (do_open(O_RDWR) == FAIL)
 	exit(1);
 
@@ -1135,10 +1137,10 @@ main(int argc, char *argv[])
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
@@ -1256,16 +1258,14 @@ main(int argc, char *argv[])
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
@@ -1292,14 +1292,13 @@ main(int argc, char *argv[])
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
@@ -1371,9 +1370,10 @@ main(int argc, char *argv[])
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
@@ -1391,8 +1391,7 @@ main(int argc, char *argv[])
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
