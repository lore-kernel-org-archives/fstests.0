Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36700 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933418AbbENNu4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 May 2015 09:50:56 -0400
Received: by wizk4 with SMTP id k4so242045052wiz.1
        for <fstests@vger.kernel.org>; Thu, 14 May 2015 06:50:54 -0700 (PDT)
From: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: [PATCH] generic/087,126: Test the permission to set file times
Date: Thu, 14 May 2015 15:50:09 +0200
Message-Id: <1431611409-26892-2-git-send-email-andreas.gruenbacher@gmail.com>
In-Reply-To: <1431611409-26892-1-git-send-email-andreas.gruenbacher@gmail.com>
References: <20150514103028.GR15721@dastard>
 <1431611409-26892-1-git-send-email-andreas.gruenbacher@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

Check if setting the file access and modification times to the current time
and to a specific timestamp is allowed when expected.

In generic/126, remove a left-over temporary file.

Signed-off-by: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
---
 src/fs_perms.c        | 85 +++++++++++++++++++++++++++++----------------------
 tests/generic/087     | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/087.out |  7 +++++
 tests/generic/126     |  2 ++
 tests/generic/group   |  1 +
 5 files changed, 135 insertions(+), 37 deletions(-)
 create mode 100755 tests/generic/087
 create mode 100644 tests/generic/087.out

diff --git a/src/fs_perms.c b/src/fs_perms.c
index ea188c4..5780016 100644
--- a/src/fs_perms.c
+++ b/src/fs_perms.c
@@ -37,6 +37,8 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/wait.h>
+#include <time.h>
+#include <utime.h>
 
 int testsetup(mode_t mode, int cuserId, int cgroupId);
 int testfperm(int userId, int groupId, char* fperm);
@@ -57,13 +59,13 @@ int main( int argc, char *argv[]) {
               exresult = atoi(argv[7]);
 	      break;
       default:
-	      printf("Usage: %s <mode of file> <UID of file> <GID of file> <UID of tester> <GID of tester> <permission to test r|w|x> <expected result as 0|1>\n",argv[0]); 
+	      printf("Usage: %s <mode of file> <UID of file> <GID of file> <UID of tester> <GID of tester> <permission to test r|w|x|t|T> <expected result as 0|1>\n",argv[0]);
 	      exit(0);
    }
 
    testsetup(mode,cuserId,cgroupId);
    result=testfperm(userId,groupId,fperm);
-   system("rm test.file");
+   system("rm -f test.file");
    printf("%s a %03o file owned by (%d/%d) as user/group(%d/%d)  ",fperm,mode,cuserId,cgroupId,userId,groupId);
    if (result == exresult) {
       printf("PASS\n");
@@ -84,46 +86,55 @@ int testsetup(mode_t mode, int cuserId, int cgroupId) {
 
 int testfperm(int userId, int groupId, char* fperm) {
 
-    FILE *testfile;
-    pid_t PID;
-    int tmpi,nuthertmpi;
+    int ret;
 
-/*  SET CURRENT USER/GROUP PERMISSIONS */
+    /*  SET CURRENT USER/GROUP PERMISSIONS */
+    ret = -1;
     if(setegid(groupId)) {
-        printf("could not setegid to %d.\n",groupId);
-           seteuid(0);
-           setegid(0);
-           return(-1);
-        }   
+	printf("could not setegid to %d.\n",groupId);
+	goto out;
+    }
     if(seteuid(userId)) {
-        printf("could not seteuid to %d.\n",userId);
-           seteuid(0);
-           setegid(0);
-           return(-1);
-        }
+	printf("could not seteuid to %d.\n",userId);
+	goto out;
+    }
 
     if (!strcmp("x", fperm)) {
-          PID = fork();
-	  if (PID == 0) {
-             execlp("./test.file","test.file",NULL); 
-	     exit(0);
-	  }
-	  wait(&tmpi);
-	  nuthertmpi=WEXITSTATUS(tmpi); 
-          seteuid(0);
-          setegid(0);
-	  return(nuthertmpi);
+	int status;
+	pid_t pid;
+
+	pid = fork();
+	if (pid == 0) {
+	    execlp("./test.file","test.file",NULL);
+	    exit(0);
+	}
+	wait(&status);
+	ret = WEXITSTATUS(status);
+    } else if (!strcmp("t", fperm)) {
+	ret = utime("test.file", NULL) ? 0 : 1;
+    } else if (!strcmp("T", fperm)) {
+	time_t now = time(NULL);
+	struct utimbuf times = {
+		.actime = now - 1,
+		.modtime = now - 1
+	};
+
+	ret = utime("test.file", &times) ? 0 : 1;
     } else {
-          if((testfile=fopen("test.file",fperm))){
-            fclose(testfile);
-            seteuid(0);
-            setegid(0);
-            return (1);
-	  }
-          else {
-            seteuid(0);
-            setegid(0);
-            return (0);
-	  }
+	FILE *file;
+
+	if((file = fopen("test.file",fperm))){
+	    fclose(file);
+	    ret = 1;
+	    goto out;
+	} else {
+	    ret = 0;
+	    goto out;
+	}
     }
+
+out:
+    seteuid(0);
+    setegid(0);
+    return ret;
 }
diff --git a/tests/generic/087 b/tests/generic/087
new file mode 100755
index 0000000..9653230
--- /dev/null
+++ b/tests/generic/087
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FSQA Test No. 087
+#
+# Check if setting the file access and modification times to the current time
+# (t) and to a specific timestamp (T) is allowed when expected.
+#
+# From utime(2): Changing timestamps is permitted when: either the process has
+# appropriate privileges, or the effective user ID equals the user ID of the
+# file, or [the process is trying to set the timestamps to the current time]
+# and the process has write permission for the file.
+#
+# Note that the last of these tests will always wrongly succeed over NFSv2.
+# For NFSv3+, that test will wrongly succeed until kernel commit
+# "Disable NFSv2 timestamp workaround for NFSv3+".
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat, Inc.
+# Author: Andreas Gruenbacher <agruenba@redhat.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+QA_FS_PERMS=$here/src/fs_perms
+
+cd $TEST_DIR
+cp $here/src/testx ./testx.file
+
+# The owner:
+$QA_FS_PERMS 600 99 99 99 99 t 1
+$QA_FS_PERMS 600 99 99 99 99 T 1
+
+# Other processes with and without write permission:
+$QA_FS_PERMS 600 99 99 100 99 t 0
+$QA_FS_PERMS 600 99 99 100 99 T 0
+$QA_FS_PERMS 660 99 99 100 99 t 1
+$QA_FS_PERMS 660 99 99 100 99 T 0
+
+rm -f ./testx.file
+
+status=0
+exit
diff --git a/tests/generic/087.out b/tests/generic/087.out
new file mode 100644
index 0000000..d74cc32
--- /dev/null
+++ b/tests/generic/087.out
@@ -0,0 +1,7 @@
+QA output created by 087
+t a 600 file owned by (99/99) as user/group(99/99)  PASS
+T a 600 file owned by (99/99) as user/group(99/99)  PASS
+t a 600 file owned by (99/99) as user/group(100/99)  PASS
+T a 600 file owned by (99/99) as user/group(100/99)  PASS
+t a 660 file owned by (99/99) as user/group(100/99)  PASS
+T a 660 file owned by (99/99) as user/group(100/99)  PASS
diff --git a/tests/generic/126 b/tests/generic/126
index a22d587..bb3a566 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -70,5 +70,7 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
 $QA_FS_PERMS 040 99 99 99 500 r 1
 $QA_FS_PERMS 400 99 99 200 99 r 1
 
+rm -f ./testx.file
+
 status=0
 exit
diff --git a/tests/generic/group b/tests/generic/group
index b6f4b01..5308c37 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -89,6 +89,7 @@
 084 auto metadata quick
 085 auto freeze mount
 086 auto prealloc preallocrw quick
+087 perms auto quick
 088 perms auto quick
 089 metadata auto
 091 rw auto quick
-- 
2.4.0

