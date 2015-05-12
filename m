Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38794 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933539AbbELShW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 12 May 2015 14:37:22 -0400
Received: by wicnf17 with SMTP id nf17so27277897wic.1
        for <fstests@vger.kernel.org>; Tue, 12 May 2015 11:37:21 -0700 (PDT)
From: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: [PATCH] generic/126: Test the permission to set file times
Date: Tue, 12 May 2015 20:37:11 +0200
Message-Id: <1431455831-13345-1-git-send-email-andreas.gruenbacher@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

Check if setting the file access and modification times to the current time
and to a specific timestamp is allowed when expected.

Signed-off-by: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
---
 src/fs_perms.c        | 14 +++++++++++++-
 tests/generic/126     | 22 ++++++++++++++++++++++
 tests/generic/126.out |  6 ++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/src/fs_perms.c b/src/fs_perms.c
index ea188c4..519db5b 100644
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
@@ -57,7 +59,7 @@ int main( int argc, char *argv[]) {
               exresult = atoi(argv[7]);
 	      break;
       default:
-	      printf("Usage: %s <mode of file> <UID of file> <GID of file> <UID of tester> <GID of tester> <permission to test r|w|x> <expected result as 0|1>\n",argv[0]); 
+	      printf("Usage: %s <mode of file> <UID of file> <GID of file> <UID of tester> <GID of tester> <permission to test r|w|x|t|T> <expected result as 0|1>\n",argv[0]);
 	      exit(0);
    }
 
@@ -113,6 +115,16 @@ int testfperm(int userId, int groupId, char* fperm) {
           seteuid(0);
           setegid(0);
 	  return(nuthertmpi);
+    } else if (!strcmp("t", fperm)) {
+	return utime("test.file", NULL) ? 0 : 1;
+    } else if (!strcmp("T", fperm)) {
+	time_t now = time(NULL);
+	struct utimbuf times = {
+		.actime = now - 1,
+		.modtime = now - 1
+	};
+
+	return utime("test.file", &times) ? 0 : 1;
     } else {
           if((testfile=fopen("test.file",fperm))){
             fclose(testfile);
diff --git a/tests/generic/126 b/tests/generic/126
index a22d587..45500af 100755
--- a/tests/generic/126
+++ b/tests/generic/126
@@ -70,5 +70,27 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
 $QA_FS_PERMS 040 99 99 99 500 r 1
 $QA_FS_PERMS 400 99 99 200 99 r 1
 
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
 status=0
 exit
diff --git a/tests/generic/126.out b/tests/generic/126.out
index 3347930..ad0e592 100644
--- a/tests/generic/126.out
+++ b/tests/generic/126.out
@@ -17,3 +17,9 @@ w a 020 file owned by (99/99) as user/group(99/500)  FAIL
 w a 200 file owned by (99/99) as user/group(200/99)  FAIL
 r a 040 file owned by (99/99) as user/group(99/500)  FAIL
 r a 400 file owned by (99/99) as user/group(200/99)  FAIL
+t a 600 file owned by (99/99) as user/group(99/99)  PASS
+T a 600 file owned by (99/99) as user/group(99/99)  PASS
+t a 600 file owned by (99/99) as user/group(100/99)  PASS
+T a 600 file owned by (99/99) as user/group(100/99)  PASS
+t a 660 file owned by (99/99) as user/group(100/99)  PASS
+T a 660 file owned by (99/99) as user/group(100/99)  PASS
-- 
2.4.0

