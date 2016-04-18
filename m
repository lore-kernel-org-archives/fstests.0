Received: from mx2.suse.de ([195.135.220.15]:54915 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbcDRTcp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Apr 2016 15:32:45 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id DBDB8AD42
	for <fstests@vger.kernel.org>; Mon, 18 Apr 2016 19:32:41 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 4/5] generic/345: Test races between processes doing mmap writes
Date: Mon, 18 Apr 2016 21:32:34 +0200
Message-Id: <1461007955-7921-5-git-send-email-jack@suse.cz>
In-Reply-To: <1461007955-7921-1-git-send-email-jack@suse.cz>
References: <1461007955-7921-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Add test which spawns two processes both writing one file via mmap.
Then to the test when processes first prefault the file by reading it
via mmap. This is mainly interesting to uncover races in DAX fault
handling.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/holetest.c        | 90 +++++++++++++++++++++++++++++++++++++++------------
 tests/generic/345     | 59 +++++++++++++++++++++++++++++++++
 tests/generic/345.out | 73 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |  1 +
 4 files changed, 203 insertions(+), 20 deletions(-)
 create mode 100644 tests/generic/345
 create mode 100644 tests/generic/345.out

diff --git a/src/holetest.c b/src/holetest.c
index 252fe734523e..03c03604ab18 100644
--- a/src/holetest.c
+++ b/src/holetest.c
@@ -61,6 +61,7 @@
 #include <pthread.h>
 #include <string.h>
 #include <getopt.h>
+#include <sys/wait.h>
 
 #define THREADS 2
 
@@ -68,6 +69,26 @@ long page_size;
 long page_offs[THREADS];
 int use_wr[THREADS];
 int prefault = 0;
+int use_fork = 0;
+
+uint64_t get_id(void)
+{
+	if (!use_fork)
+		return (uint64_t) pthread_self();
+	return getpid();
+}
+
+void prefault_mapping(char *addr, long npages)
+{
+	long i;
+
+	for (i = 0; i < npages; i++) {
+		if (addr[i * page_size] != 0) {
+			fprintf(stderr, "Prefaulting found non-zero value in "
+				"page %ld: %d\n", i, (int)addr[i * page_size]);
+		}
+	}
+}
 
 void *pt_page_marker(void *args)
 {
@@ -75,7 +96,10 @@ void *pt_page_marker(void *args)
 	char *va = (char *)a[1];
 	long npages = (long)a[2];
 	long pgoff = (long)a[3];
-	uint64_t tid = (uint64_t)pthread_self();
+	uint64_t tid = get_id();
+
+	if (prefault && use_fork)
+		prefault_mapping(va, npages);
 
 	va += pgoff;
 
@@ -92,7 +116,7 @@ void *pt_write_marker(void *args)
 	int fd = (long)a[0];
 	long npages = (long)a[2];
 	long pgoff = (long)a[3];
-	uint64_t tid = (uint64_t)pthread_self();
+	uint64_t tid = get_id();
 	long i;
 
 	/* mark pages */
@@ -123,15 +147,8 @@ int test_this(int fd, loff_t sz)
 		exit(20);
 	}
 
-	if (prefault) {
-		for (i = 0; i < npages; i++) {
-			if (vastart[i * page_size] != 0) {
-				fprintf(stderr, "Prefaulting found non-zero "
-					"value in page %d: %d\n", i,
-					vastart[i * page_size]);
-			}
-		}
-	}
+	if (prefault && !use_fork)
+		prefault_mapping(vastart, npages);
 
 	/* prepare the thread args */
 	for (i = 0; i < THREADS; i++) {
@@ -142,20 +159,49 @@ int test_this(int fd, loff_t sz)
 	}
 
 	for (i = 0; i < THREADS; i++) {
-		/* start two threads */
-		if (pthread_create(&t[i], NULL,
+		if (!use_fork) {
+			/* start two threads */
+			if (pthread_create(&t[i], NULL,
 				   use_wr[i] ? pt_write_marker : pt_page_marker,
 				   &targs[i])) {
-			perror("pthread_create");
-			exit(21);
+				perror("pthread_create");
+				exit(21);
+			}
+			tid[i] = (uint64_t)t[i];
+			printf("INFO: thread %d created\n", i);
+		} else {
+			/*
+			 * Flush stdout before fork, otherwise some lines get
+			 * duplicated... ?!?!?
+			 */
+			fflush(stdout);
+			tid[i] = fork();
+			if (tid[i] < 0) {
+				int j;
+
+				perror("fork");
+				for (j = 0; j < i; j++)
+					waitpid(tid[j], NULL, 0);
+				exit(21);
+			}
+			/* Child? */
+			if (!tid[i]) {
+				if (use_wr[i])
+					pt_write_marker(&targs[i]);
+				else
+					pt_page_marker(&targs[i]);
+				exit(0);
+			}
+			printf("INFO: process %d created\n", i);
 		}
-		tid[i] = (uint64_t)t[i];
-		printf("INFO: thread %d created\n", i);
 	}
 
 	/* wait for them to finish */
 	for (i = 0; i < THREADS; i++)
-		pthread_join(t[i], NULL);
+		if (!use_fork)
+			pthread_join(t[i], NULL);
+		else
+			waitpid(tid[i], NULL, 0);
 
 	/* check markers on each page */
 	errcnt = 0;
@@ -196,7 +242,7 @@ int main(int argc, char **argv)
 	for (i = 1; i < THREADS; i++)
 		page_offs[i] = page_offs[i-1] + step;
 
-	while ((opt = getopt(argc, argv, "fwr")) > 0) {
+	while ((opt = getopt(argc, argv, "fwrF")) > 0) {
 		switch (opt) {
 		case 'f':
 			/* ignore errors */
@@ -210,6 +256,10 @@ int main(int argc, char **argv)
 			/* prefault mmapped area by reading it */
 			prefault = 1;
 			break;
+		case 'F':
+			/* create processes instead of threads */
+			use_fork = 1;
+			break;
 		default:
 			fprintf(stderr, "ERROR: Unknown option character.\n");
 			exit(1);
@@ -217,7 +267,7 @@ int main(int argc, char **argv)
 	}
 
 	if (optind != argc - 2) {
-		fprintf(stderr, "ERROR: usage: holetest [-fwr] "
+		fprintf(stderr, "ERROR: usage: holetest [-fwrF] "
 			"FILENAME FILESIZEinMB\n");
 		exit(1);
 	}
diff --git a/tests/generic/345 b/tests/generic/345
new file mode 100644
index 000000000000..780cf7c37a67
--- /dev/null
+++ b/tests/generic/345
@@ -0,0 +1,59 @@
+#! /bin/bash
+# FSQA Test No. 345
+#
+# Test races between mmap from racing processes with and without prefaulting.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2016 SUSE Linux Products GmbH. All Rights Reserved.
+# Author: Jan Kara <jack@suse.cz>
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
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment and checks
+. ./common/rc
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_test_program "holetest"
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+src/holetest -f -F $SCRATCH_MNT/testfile 16
+src/holetest -f -F $SCRATCH_MNT/testfile 256
+src/holetest -f -F -r $SCRATCH_MNT/testfile 16
+src/holetest -f -F -r $SCRATCH_MNT/testfile 256
+
+status=0
+exit
diff --git a/tests/generic/345.out b/tests/generic/345.out
new file mode 100644
index 000000000000..39a4ac6a8b32
--- /dev/null
+++ b/tests/generic/345.out
@@ -0,0 +1,73 @@
+QA output created by 345
+
+INFO: zero-filled test...
+INFO: sz = 16777216
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: posix_fallocate test...
+INFO: sz = 16777216
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: ftruncate test...
+INFO: sz = 16777216
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: zero-filled test...
+INFO: sz = 268435456
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: posix_fallocate test...
+INFO: sz = 268435456
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: ftruncate test...
+INFO: sz = 268435456
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: zero-filled test...
+INFO: sz = 16777216
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: posix_fallocate test...
+INFO: sz = 16777216
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: ftruncate test...
+INFO: sz = 16777216
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: zero-filled test...
+INFO: sz = 268435456
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: posix_fallocate test...
+INFO: sz = 268435456
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
+
+INFO: ftruncate test...
+INFO: sz = 268435456
+INFO: process 0 created
+INFO: process 1 created
+INFO: 0 error(s) detected
diff --git a/tests/generic/group b/tests/generic/group
index e58d36085585..caf4483313e7 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -347,3 +347,4 @@
 342 auto quick metadata
 343 auto
 344 auto
+345 auto
-- 
2.6.6

