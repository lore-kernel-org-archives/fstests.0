Received: from mx1.redhat.com ([209.132.183.28]:49856 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbcHILQ5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Aug 2016 07:16:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 858F74E32F
	for <fstests@vger.kernel.org>; Tue,  9 Aug 2016 11:16:56 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] src/t_immutable: allow EPERM on immutable inode
Date: Tue,  9 Aug 2016 19:16:48 +0800
Message-Id: <1470741408-32689-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Starting from kernel commit 337684a1746f ("fs: return EPERM on
immutable inode"), EPERM is returned instead of EACCES. Update
src/t_immutable.c to accept EPERM as a PASS.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 src/t_immutable.c | 108 +++++++++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/src/t_immutable.c b/src/t_immutable.c
index 7fd9e5d..8a12d2c 100644
--- a/src/t_immutable.c
+++ b/src/t_immutable.c
@@ -165,8 +165,8 @@ static int test_immutable(const char *dir)
 	  fprintf(stderr, "open(%s, O_RDWR) did not fail\n", path);
 	  fail++;
 	  close(fd);
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "open(%s, O_RDWR) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "open(%s, O_RDWR) did not set errno == EACCES or EPERM\n", path);
 	  fail++;
      }
 
@@ -175,8 +175,8 @@ static int test_immutable(const char *dir)
 	  fprintf(stderr, "open(%s, O_WRONLY) did not fail\n", path);
 	  fail++;
 	  close(fd);
-     } else if (errno != EACCES) {
-          fprintf(stderr, "open(%s, O_WRONLY) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "open(%s, O_WRONLY) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -185,8 +185,8 @@ static int test_immutable(const char *dir)
           fprintf(stderr, "open(%s, O_RDWR|O_TRUNC) did not fail\n", path);
           fail++;
           close(fd);
-     } else if (errno != EACCES) {
-          fprintf(stderr, "open(%s, O_RDWR|O_TRUNC) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "open(%s, O_RDWR|O_TRUNC) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -195,8 +195,8 @@ static int test_immutable(const char *dir)
           fprintf(stderr, "open(%s, O_WRONLY|O_TRUNC) did not fail\n", path);
           fail++;
           close(fd);
-     } else if (errno != EACCES) {
-          fprintf(stderr, "open(%s, O_WRONLY|O_TRUNC did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "open(%s, O_WRONLY|O_TRUNC did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -205,8 +205,8 @@ static int test_immutable(const char *dir)
           fprintf(stderr, "open(%s, O_RDWR|O_APPEND) did not fail\n", path);
           fail++;
           close(fd);
-     } else if (errno != EACCES) {
-          fprintf(stderr, "open(%s, O_RDWR|O_APPEND) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "open(%s, O_RDWR|O_APPEND) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -215,8 +215,8 @@ static int test_immutable(const char *dir)
           fprintf(stderr, "open(%s, O_WRONLY|O_APPEND) did not fail\n", path);
           fail++;
           close(fd);
-     } else if (errno != EACCES) {
-          fprintf(stderr, "open(%s, O_WRONLY|O_APPEND) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "open(%s, O_WRONLY|O_APPEND) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -225,8 +225,8 @@ static int test_immutable(const char *dir)
           fprintf(stderr, "open(%s, O_RDWR|O_APPEND|O_TRUNC) did not fail\n", path);
           fail++;
           close(fd);
-     } else if (errno != EACCES) {
-          fprintf(stderr, "open(%s, O_RDWR|O_APPEND|O_TRUNC) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "open(%s, O_RDWR|O_APPEND|O_TRUNC) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -235,8 +235,8 @@ static int test_immutable(const char *dir)
           fprintf(stderr, "open(%s, O_WRONLY|O_APPEND|O_TRUNC) did not fail\n", path);
           fail++;
           close(fd);
-     } else if (errno != EACCES) {
-          fprintf(stderr, "open(%s, O_WRONLY|O_APPEND|O_TRUNC) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "open(%s, O_WRONLY|O_APPEND|O_TRUNC) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -283,9 +283,9 @@ static int test_immutable(const char *dir)
 	       fprintf(stderr, "jdm_open(%s, O_RDWR) did not fail\n", path);
 	       fail++;
 	       close(fd);
-	  } else if (errno != EACCES) {
+	  } else if (errno != EACCES && errno != EPERM) {
 	       perror("jdm_open");
-	       fprintf(stderr, "jdm_open(%s, O_RDWR) did not set errno == EACCES\n", path);
+	       fprintf(stderr, "jdm_open(%s, O_RDWR) did not set errno == EACCES or EPERM\n", path);
 	       fail++;
 	  }
 
@@ -294,8 +294,8 @@ static int test_immutable(const char *dir)
 	       fprintf(stderr, "jdm_open(%s, O_WRONLY) did not fail\n", path);
 	       fail++;
 	       close(fd);
-	  } else if (errno != EACCES) {
-	       fprintf(stderr, "jdm_open(%s, O_WRONLY) did not set errno == EACCES\n", path);
+	  } else if (errno != EACCES && errno != EPERM) {
+	       fprintf(stderr, "jdm_open(%s, O_WRONLY) did not set errno == EACCES or EPERM\n", path);
 	       fail++;
 	  }
 
@@ -304,8 +304,8 @@ static int test_immutable(const char *dir)
 	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_TRUNC) did not fail\n", path);
 	       fail++;
 	       close(fd);
-	  } else if (errno != EACCES) {
-	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_TRUNC) did not set errno == EACCES\n", path);
+	  } else if (errno != EACCES && errno != EPERM) {
+	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_TRUNC) did not set errno == EACCES or EPERM\n", path);
 	       fail++;
 	  }
 
@@ -314,8 +314,8 @@ static int test_immutable(const char *dir)
 	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_TRUNC) did not fail\n", path);
 	       fail++;
 	       close(fd);
-	  } else if (errno != EACCES) {
-	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_TRUNC did not set errno == EACCES\n", path);
+	  } else if (errno != EACCES && errno != EPERM) {
+	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_TRUNC did not set errno == EACCES or EPERM\n", path);
 	       fail++;
 	  }
 
@@ -324,8 +324,8 @@ static int test_immutable(const char *dir)
 	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_APPEND) did not fail\n", path);
 	       fail++;
 	       close(fd);
-	  } else if (errno != EACCES) {
-	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_APPEND) did not set errno == EACCES\n", path);
+	  } else if (errno != EACCES && errno != EPERM) {
+	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_APPEND) did not set errno == EACCES or EPERM\n", path);
 	       fail++;
 	  }
 
@@ -334,8 +334,8 @@ static int test_immutable(const char *dir)
 	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_APPEND) did not fail\n", path);
 	       fail++;
 	       close(fd);
-	  } else if (errno != EACCES) {
-	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_APPEND) did not set errno == EACCES\n", path);
+	  } else if (errno != EACCES && errno != EPERM) {
+	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_APPEND) did not set errno == EACCES or EPERM\n", path);
 	       fail++;
 	  }
 
@@ -344,8 +344,8 @@ static int test_immutable(const char *dir)
 	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_APPEND|O_TRUNC) did not fail\n", path);
 	       fail++;
 	       close(fd);
-	  } else if (errno != EACCES) {
-	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_APPEND|O_TRUNC) did not set errno == EACCES\n", path);
+	  } else if (errno != EACCES && errno != EPERM) {
+	       fprintf(stderr, "jdm_open(%s, O_RDWR|O_APPEND|O_TRUNC) did not set errno == EACCES or EPERM\n", path);
 	       fail++;
 	  }
 
@@ -354,8 +354,8 @@ static int test_immutable(const char *dir)
 	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_APPEND|O_TRUNC) did not fail\n", path);
 	       fail++;
 	       close(fd);
-	  } else if (errno != EACCES) {
-	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_APPEND|O_TRUNC) did not set errno == EACCES\n", path);
+	  } else if (errno != EACCES && errno != EPERM) {
+	       fprintf(stderr, "jdm_open(%s, O_WRONLY|O_APPEND|O_TRUNC) did not set errno == EACCES or EPERM\n", path);
 	       fail++;
 	  }
      }
@@ -364,8 +364,8 @@ static int test_immutable(const char *dir)
      if (truncate(path, 0) != -1) {
 	  fprintf(stderr, "truncate(%s, 0) did not fail\n", path);
 	  fail++;
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "truncate(%s, 0) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "truncate(%s, 0) did not set errno == EACCES or EPERM\n", path);
 	  fail++;
      }
 
@@ -383,8 +383,8 @@ static int test_immutable(const char *dir)
      if (utime(path, NULL) != -1) {
           fprintf(stderr, "utime(%s, NULL) did not fail\n", path);
           fail++;
-     } else if (errno != EACCES) {
-          fprintf(stderr, "utime(%s, NULL) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "utime(%s, NULL) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 #endif /* TEST_UTIME */
@@ -570,16 +570,16 @@ static int test_immutable(const char *dir)
 	  fprintf(stderr, "link(%s, %s) did not fail\n", path, linkpath);
 	  fail++;
 	  unlink(linkpath);
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "link(%s, %s) did not set errno == EACCES\n", path, linkpath);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "link(%s, %s) did not set errno == EACCES or EPERM\n", path, linkpath);
 	  fail++;
      }
      if (symlink(path, linkpath) != -1) {
 	  fprintf(stderr, "symlink(%s, %s) did not fail\n", path, linkpath);
 	  fail++;
 	  unlink(linkpath);
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "symlink(%s, %s) did not set errno == EACCES\n", path, linkpath);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "symlink(%s, %s) did not set errno == EACCES or EPERM\n", path, linkpath);
           fail++;
      }
      free(linkpath);
@@ -588,8 +588,8 @@ static int test_immutable(const char *dir)
 	  fprintf(stderr, "rename(%s, %s) did not fail\n", path, linkpath);
 	  fail++;
 	  rename(linkpath, path);
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "rename(%s, %s) did not set errno == EACCES\n", path, linkpath);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "rename(%s, %s) did not set errno == EACCES or EPERM\n", path, linkpath);
           fail++;
      }
      free(linkpath);
@@ -597,8 +597,8 @@ static int test_immutable(const char *dir)
      if (unlink(path) != -1) {
 	  fprintf(stderr, "unlink(%s) did not fail\n", path);
 	  fail++;
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "unlink(%s) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "unlink(%s) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -609,8 +609,8 @@ static int test_immutable(const char *dir)
 	  fprintf(stderr, "open(%s, O_RDWR|O_CREAT, 0666) did not fail\n", path);
 	  fail++;
 	  unlink(path);
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "open(%s, O_RDWR|O_CREAT, 0666) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "open(%s, O_RDWR|O_CREAT, 0666) did not set errno == EACCES or EPERM\n", path);
 	  fail++;
      }
      if (!getuid()) {
@@ -619,8 +619,8 @@ static int test_immutable(const char *dir)
 		    fprintf(stderr, "mknod(%s, S_IFCHR|0666, %lld) did not fail\n", path, (long long int)st.st_rdev);
 		    fail++;
 		    unlink(path);
-	       } else if (errno != EACCES) {
-		    fprintf(stderr, "mknod(%s, S_IFCHR|0666, %lld) did not set errno == EACCESS\n", path, (long long int)st.st_rdev);
+	       } else if (errno != EACCES && errno != EPERM) {
+		    fprintf(stderr, "mknod(%s, S_IFCHR|0666, %lld) did not set errno == EACCES or EPERM\n", path, (long long int)st.st_rdev);
 		    fail++;
 	       }
 	  }
@@ -633,8 +633,8 @@ static int test_immutable(const char *dir)
 	  fprintf(stderr, "mkdir(%s, 0777) did not fail\n", path);
 	  fail++;
 	  rmdir(path);
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "mkdir(%s, 0777) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "mkdir(%s, 0777) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 
@@ -670,8 +670,8 @@ static int test_immutable(const char *dir)
      if (rmdir(path) != -1) {
 	  fprintf(stderr, "rmdir(%s) did not fail\n", path);
 	  fail++;
-     } else if (errno != EACCES) {
-	  fprintf(stderr, "rmdir(%s) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+	  fprintf(stderr, "rmdir(%s) did not set errno == EACCES or EPERM\n", path);
 	  fail++;
      }
 
@@ -692,8 +692,8 @@ static int test_immutable(const char *dir)
      if (utime(path, NULL) != -1) {
           fprintf(stderr, "utime(%s, NULL) did not fail\n", path);
           fail++;
-     } else if (errno != EACCES) {
-          fprintf(stderr, "utime(%s, NULL) did not set errno == EACCES\n", path);
+     } else if (errno != EACCES && errno != EPERM) {
+          fprintf(stderr, "utime(%s, NULL) did not set errno == EACCES or EPERM\n", path);
           fail++;
      }
 #endif /* TEST_UTIME */
-- 
2.7.4

