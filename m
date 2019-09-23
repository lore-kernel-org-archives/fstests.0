Received: from mga06.intel.com ([134.134.136.31]:32885 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394221AbfIWRxk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:53:40 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 02/16] src/locktest: Remove OPEN macro
Date: Mon, 23 Sep 2019 10:53:22 -0700
Message-Id: <20190923175336.2287-3-ira.weiny@intel.com>
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

The code is much cleaner without this macro.  While here add extra debug
output as well.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 29e914febdf9..b5e1cf7669d8 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -61,7 +61,6 @@ extern int h_errno;
        
 #define HANDLE              int
 #define INVALID_HANDLE      -1
-#define OPEN(N,F)           (open(N, F|O_CREAT|O_BINARY, 0644))
 #define SEEK(H, O)          (lseek(H, O, SEEK_SET))
 #define READ(H, B, L)       (read(H, B, L))
 #define WRITE(H, B, L)      (write(H, B, L))
@@ -598,12 +597,16 @@ initialize(HANDLE fd)
 
 int do_open(int flag)
 {
-    if ((f_fd = OPEN(filename, flag)) == INVALID_HANDLE) {
+    int flags = flag|O_CREAT|O_BINARY;
+
+    if(debug > 1)
+	fprintf(stderr, "do_open %s 0x%x\n", filename, flags);
+
+    if ((f_fd = open(filename, flags, 0666)) == INVALID_HANDLE) {
 	perror("shared file create");
 	return FAIL;
 	/*NOTREACHED*/
     }
-
     return PASS;
 }
 
-- 
2.20.1
