Received: from mga06.intel.com ([134.134.136.31]:32026 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfICVIU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 3 Sep 2019 17:08:20 -0400
From: ira.weiny@intel.com
Subject: [PATCH 1/3] src/locktest: Remove D_flag
Date: Tue,  3 Sep 2019 14:08:13 -0700
Message-Id: <20190903210815.29545-2-ira.weiny@intel.com>
In-Reply-To: <20190903210815.29545-1-ira.weiny@intel.com>
References: <20190903210815.29545-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

This flag is never set.  Furthermore, there does not seem to be any need
to set O_DIRECT for lock testing.

Remove the D_flag

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index b23a1a99cc76..089951e2d992 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -61,8 +61,7 @@ extern int h_errno;
        
 #define HANDLE              int
 #define INVALID_HANDLE      -1
-#define OPEN(N,F)           (open(N, F|O_CREAT|O_BINARY| \
-                            (D_flag ? O_DIRECT : 0), 0644))
+#define OPEN(N,F)           (open(N, F|O_CREAT|O_BINARY, 0644))
 #define SEEK(H, O)          (lseek(H, O, SEEK_SET))
 #define READ(H, B, L)       (read(H, B, L))
 #define WRITE(H, B, L)      (write(H, B, L))
@@ -91,7 +90,6 @@ static SOCKET	s_fd = -1;              /* listen socket    */
 static SOCKET	c_fd = -1;	        /* IPC socket       */
 static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 static char	*buf;		        /* I/O buffer       */
-static int	D_flag = 0;
 
 #define 	WRLOCK	0
 #define 	RDLOCK	1
@@ -579,12 +577,7 @@ initialize(HANDLE fd)
     int 	offset = 0;
     int 	togo = FILE_SIZE;
 
-    if (D_flag) {
-        ibuf = (char *)ALLOC_ALIGNED(INIT_BUFSZ);
-    }
-    else {
-        ibuf = (char*)malloc(INIT_BUFSZ);
-    }
+    ibuf = (char*)malloc(INIT_BUFSZ);
     memset(ibuf, ':', INIT_BUFSZ);
 
     SEEK(fd, 0L);
@@ -614,15 +607,6 @@ int do_open(int flag)
 	/*NOTREACHED*/
     }
 
-#ifdef __sun
-    if (D_flag) {
-        directio(f_fd, DIRECTIO_ON);
-    }
-#elif defined(__APPLE__)
-    if (D_flag) {
-	fcntl(f_fd, F_NOCACHE, 1);
-    }
-#endif
     return PASS;
 }
 
@@ -826,18 +810,10 @@ main(int argc, char *argv[])
      * +10 is slop for the iteration number if do_write() ... never
      * needed unless maxio is very small
      */
-    if (D_flag) {
-        if ((buf = (char *)ALLOC_ALIGNED(maxio + 10)) == NULL) {
-	    perror("aligned alloc buf");
-	    exit(1);
-	    /*NOTREACHED*/
-        }
-    } else {
-        if ((buf = (char *)malloc(maxio + 10)) == NULL) {
-	    perror("malloc buf");
-	    exit(1);
-	    /*NOTREACHED*/
-        }
+    if ((buf = (char *)malloc(maxio + 10)) == NULL) {
+        perror("malloc buf");
+        exit(1);
+        /*NOTREACHED*/
     }
 
     setbuf(stderr, NULL);
@@ -1159,10 +1135,7 @@ main(int argc, char *argv[])
 	printf("%d tests run, %d failed\n", test_count, fail_count);
 }   
     if (buf) {
-        if (D_flag)
-            FREE_ALIGNED(buf);
-        else
-            free(buf);
+        free(buf);
     }
 
     
-- 
2.20.1
