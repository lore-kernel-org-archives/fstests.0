Received: from mx1.redhat.com ([209.132.183.28]:36472 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbbJKRY2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 11 Oct 2015 13:24:28 -0400
From: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: [PATCH] src/runas: Fixes and cleanups
Date: Sun, 11 Oct 2015 19:24:21 +0200
Message-Id: <1444584261-32410-1-git-send-email-andreas.gruenbacher@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

The runas helper runs a command as another user and/or with different group
memberships.  Fix the following problems:

 * Use setgid instead of setegid and setuid instead of seteuid.
   Otherwise, the command will run with the original real UID
   and/or GID; those could be made the effective IDs again.

 * When only a GID is specified, remove all supplementary
   GIDs.  Otherwise, the command would remain in the same
   supplementary groups as runas -- which often is the root
   group.

 * Use execvp instead of execv which searches the PATH when
   necessary.  The runas helper is always called either with a
   '/' in the pathname or as "runas ... `which program`", so
   we obviously want PATH lookup, anyway.

 * There is no advantage in fork'ing and waiting for the child
   over directly exec'ing the command; the test cases already
   have to deal with commands which can be killed by signals.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/runas.c       | 50 +++++++++++---------------------------------------
 tests/generic/237 |  2 +-
 tests/shared/051  |  4 ++--
 3 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/src/runas.c b/src/runas.c
index 37cae7e..1e7ea25 100644
--- a/src/runas.c
+++ b/src/runas.c
@@ -48,11 +48,9 @@ main(int argc, char **argv)
 	int c;
         uid_t uid = -1;
         gid_t gid = -1;
-        int pid;
         char **cmd;
         gid_t sgids[SUP_MAX];
         int sup_cnt = 0;
-	int status;
 	char *p;
 
 	prog = basename(argv[0]);
@@ -99,56 +97,30 @@ main(int argc, char **argv)
 	} 
 
         if (gid != -1) {
-	    if (setegid(gid) == -1) {
-		fprintf(stderr, "%s: setegid(%d) failed: %s\n",
+	    if (setgid(gid) == -1) {
+		fprintf(stderr, "%s: setgid(%d) failed: %s\n",
 			prog, (int)gid, strerror(errno));
 		exit(1);
-	    }	
+	    }
         }
 
-        if (sup_cnt > 0) {
+	if (gid != -1 || sup_cnt != 0) {
 	    if (setgroups(sup_cnt, sgids) == -1) {
 		fprintf(stderr, "%s: setgroups() failed: %s\n",
 			prog, strerror(errno));
 		exit(1);
-	    }	
+	    }
 	}
 
         if (uid != -1) {
-	    if (seteuid(uid) == -1) {
-		fprintf(stderr, "%s: seteuid(%d) failed: %s\n",
+	    if (setuid(uid) == -1) {
+		fprintf(stderr, "%s: setuid(%d) failed: %s\n",
 			prog, (int)uid, strerror(errno));
 		exit(1);
-	    }	
+	    }
         }
 
-	pid = fork();
-	if (pid == -1) {
-            fprintf(stderr, "%s: fork failed: %s\n",
-	            prog, strerror(errno));
-            exit(1);
-        }
-	if (pid == 0) {
-            execv(cmd[0], cmd);
-            fprintf(stderr, "%s: %s\n", cmd[0], strerror(errno));
-            exit(errno);
-	}
-
-        wait(&status);
-	if (WIFSIGNALED(status)) {
-	    fprintf(stderr, "%s: command terminated with signal %d\n", 
-                 prog, WTERMSIG(status));
-	    exit(1);
-	}
-	else if (WIFEXITED(status)) {
-	    exit(WEXITSTATUS(status));
-        }
-	else {
-	    fprintf(stderr, "%s: command bizarre wait status 0x%x\n", 
-               prog, status);
-	    exit(1);
-	}
-
-	exit(0);
-	/* NOTREACHED */
+	execvp(cmd[0], cmd);
+	fprintf(stderr, "%s: %s\n", cmd[0], strerror(errno));
+	exit(1);
 }
diff --git a/tests/generic/237 b/tests/generic/237
index ff11ed3..f2669cd 100755
--- a/tests/generic/237
+++ b/tests/generic/237
@@ -69,7 +69,7 @@ touch file1
 chown $acl1.$acl1 file1
 
 echo "Expect to FAIL"
-$runas -u $acl2 -g $acl2 -- `which setfacl` -m u::rwx file1 2>&1 | sed 's/^setfacl: \/.*file1: Operation not permitted$/setfacl: file1: Operation not permitted/'
+$runas -u $acl2 -g $acl2 -- setfacl -m u::rwx file1 2>&1 | sed 's/^setfacl: \/.*file1: Operation not permitted$/setfacl: file1: Operation not permitted/'
 
 echo "Test over."
 # success, all done
diff --git a/tests/shared/051 b/tests/shared/051
index 44dfd64..262cef1 100755
--- a/tests/shared/051
+++ b/tests/shared/051
@@ -294,10 +294,10 @@ done
 popd >/dev/null
 chown -R 12345.54321 root
 echo "Change #1..."
-$runas -u 12345 -g 54321 -- `which chacl` -r u::rwx,g::-w-,o::--x root
+$runas -u 12345 -g 54321 -- chacl -r u::rwx,g::-w-,o::--x root
 find root -print | xargs chacl -l
 echo "Change #2..."
-$runas -u 12345 -g 54321 -- `which chacl` -r u::---,g::---,o::--- root
+$runas -u 12345 -g 54321 -- chacl -r u::---,g::---,o::--- root
 find root -print | xargs chacl -l
 
 #-------------------------------------------------------
-- 
2.5.0

