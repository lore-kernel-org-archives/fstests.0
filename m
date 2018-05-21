Received: from mail.cn.fujitsu.com ([183.91.158.132]:48663 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750962AbeEUFxf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 May 2018 01:53:35 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/484: Need another process to check record locks
Date: Mon, 21 May 2018 13:42:00 +0800
Message-ID: <1526881320-10983-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, xzhou@redhat.com, jlayton@poochiereds.net, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) According to fcntl(2) manpage, A single process always gets F_UNLCK in
   the l_type field when using fcntl(F_GETLK) to acquire the existing lock
   set by itself because it could convert the existing lock to a new lock
   unconditionally.  So we need another process to check if the lock exists.

2) Remove redundant exit(0).

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 src/t_locks_execve.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/src/t_locks_execve.c b/src/t_locks_execve.c
index 9ad2dc3..d99d7de 100644
--- a/src/t_locks_execve.c
+++ b/src/t_locks_execve.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <pthread.h>
 #include <unistd.h>
+#include <sys/types.h>
 #include <sys/wait.h>
 
 static void err_exit(char *op, int errn)
@@ -32,12 +33,24 @@ struct flock fl = {
 
 static void checklock(int fd)
 {
-	if (fcntl(fd, F_GETLK, &fl) < 0)
-		err_exit("getlk", errno);
-	if (fl.l_type == F_UNLCK) {
-		printf("record lock is not preserved across execve(2)\n");
-		exit(1);
+	pid_t pid;
+
+	pid = fork();
+	if (pid < 0)
+		err_exit("fork", errno);
+
+	if (!pid) {
+		if (fcntl(fd, F_GETLK, &fl) < 0)
+			err_exit("getlk", errno);
+		if (fl.l_type == F_UNLCK) {
+			printf("record lock is not preserved across execve(2)\n");
+			exit(1);
+		}
+		exit(0);
 	}
+
+	waitpid(pid, NULL, 0);
+
 	exit(0);
 }
 
@@ -52,7 +65,6 @@ int main(int argc, char **argv)
 	if (argc == 3) {
 		fd = atoi(argv[2]);
 		checklock(fd);
-		exit(0);
 	}
 
 	fd = open(argv[1], O_WRONLY|O_CREAT, 0755);
-- 
1.8.3.1



