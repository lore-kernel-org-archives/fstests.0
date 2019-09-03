Received: from mga14.intel.com ([192.55.52.115]:54692 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfICVIW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 3 Sep 2019 17:08:22 -0400
From: ira.weiny@intel.com
Subject: [PATCH 3/3] src/locktest: Remove unused buf allocation
Date: Tue,  3 Sep 2019 14:08:15 -0700
Message-Id: <20190903210815.29545-4-ira.weiny@intel.com>
In-Reply-To: <20190903210815.29545-1-ira.weiny@intel.com>
References: <20190903210815.29545-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 6030c7a8a909..8e27e922668e 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -81,7 +81,6 @@ static char	*prog;
 static char	*filename = 0;
 static int	debug = 0;
 static int	server = 1;
-static int	maxio = 8192;
 static int	port = 0;
 static int 	testnumber = -1;
 static int	saved_errno = 0;
@@ -89,7 +88,6 @@ static int	saved_errno = 0;
 static SOCKET	s_fd = -1;              /* listen socket    */
 static SOCKET	c_fd = -1;	        /* IPC socket       */
 static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
-static char	*buf;		        /* I/O buffer       */
 
 #define 	WRLOCK	0
 #define 	RDLOCK	1
@@ -806,16 +804,6 @@ main(int argc, char *argv[])
     if (do_open(O_RDWR) == FAIL)
 	exit(1);
 
-    /*
-     * +10 is slop for the iteration number if do_write() ... never
-     * needed unless maxio is very small
-     */
-    if ((buf = (char *)malloc(maxio + 10)) == NULL) {
-        perror("malloc buf");
-        exit(1);
-        /*NOTREACHED*/
-    }
-
     setbuf(stderr, NULL);
 
     if (server) {
@@ -1134,10 +1122,6 @@ main(int argc, char *argv[])
     if(server)
 	printf("%d tests run, %d failed\n", test_count, fail_count);
 }   
-    if (buf) {
-        free(buf);
-    }
-
     
     exit(fail_count);
     /*NOTREACHED*/
-- 
2.20.1
