Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32857 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964799AbbEMAIr (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 12 May 2015 20:08:47 -0400
Received: by wief7 with SMTP id f7so124085426wie.0
        for <fstests@vger.kernel.org>; Tue, 12 May 2015 17:08:46 -0700 (PDT)
From: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: [PATCH] generic/326: Test the permission to set file times
Date: Wed, 13 May 2015 02:07:34 +0200
Message-Id: <1431475654-23274-1-git-send-email-andreas.gruenbacher@gmail.com>
In-Reply-To: <20150512234005.GC4316@dastard>
References: <20150512234005.GC4316@dastard>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

Check if setting the file access and modification times to the current time
and to a specific timestamp is allowed when expected.

Signed-off-by: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
---
 src/fs_perms.c        | 14 +++++++++-
 tests/generic/326     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/326.out |  7 +++++
 tests/generic/group   |  1 +
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/326
 create mode 100644 tests/generic/326.out

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
diff --git a/tests/generic/326 b/tests/generic/326
new file mode 100755
index 0000000..16388c1
--- /dev/null
+++ b/tests/generic/326
@@ -0,0 +1,74 @@
+#! /bin/bash
+# FSQA Test No. 326
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
+status=0
+exit
diff --git a/tests/generic/326.out b/tests/generic/326.out
new file mode 100644
index 0000000..78f7543
--- /dev/null
+++ b/tests/generic/326.out
@@ -0,0 +1,7 @@
+QA output created by 326
+t a 600 file owned by (99/99) as user/group(99/99)  PASS
+T a 600 file owned by (99/99) as user/group(99/99)  PASS
+t a 600 file owned by (99/99) as user/group(100/99)  PASS
+T a 600 file owned by (99/99) as user/group(100/99)  PASS
+t a 660 file owned by (99/99) as user/group(100/99)  PASS
+T a 660 file owned by (99/99) as user/group(100/99)  PASS
diff --git a/tests/generic/group b/tests/generic/group
index b6f4b01..1f2f3d2 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -192,3 +192,4 @@
 323 auto aio stress
 324 auto fsr quick
 325 auto quick data log
+326 perms auto quick
-- 
2.4.0

