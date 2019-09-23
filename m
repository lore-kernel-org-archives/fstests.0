Received: from mga05.intel.com ([192.55.52.43]:53828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389763AbfIWRwJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:52:09 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 01/16] src/locktest: Remove unnecessary sleep
Date: Mon, 23 Sep 2019 10:51:49 -0700
Message-Id: <20190923175204.2139-2-ira.weiny@intel.com>
In-Reply-To: <20190923175204.2139-1-ira.weiny@intel.com>
References: <20190923175204.2139-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

There is no need to sleep because we asked for debugging.  Remove extra
sleep code.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 8e27e922668e..29e914febdf9 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -69,7 +69,6 @@ extern int h_errno;
 
 #define RAND()              (rand())
 #define SRAND(s)            (srand(s))
-#define SLEEP(s)            (sleep(s))
 
 #define MIN(A,B)            (((A)<(B))?(A):(B))
 #define MAX(A,B)            (((A)>(B))?(A):(B))
@@ -1037,10 +1036,6 @@ main(int argc, char *argv[])
 		    }
 		}
 	    }
-	    if (debug > 1) {
-		fprintf(stderr, "server sleeping ...\n");
-		SLEEP(1);
-	    }
 	    if(tests[index][TEST_NUM] != 0) {
 		if(last_test != tests[index][TEST_NUM]) {
 		    test_count++;
-- 
2.20.1
