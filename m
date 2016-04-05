Received: from mx2.suse.de ([195.135.220.15]:54540 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757709AbcDEKPp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 5 Apr 2016 06:15:45 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 93BFFAC01
	for <fstests@vger.kernel.org>; Tue,  5 Apr 2016 10:15:42 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] generic/341: Test races between mmap and normal writes
Date: Tue,  5 Apr 2016 12:16:16 +0200
Message-Id: <1459851376-16387-2-git-send-email-jack@suse.cz>
In-Reply-To: <1459851376-16387-1-git-send-email-jack@suse.cz>
References: <1459851376-16387-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Add test which spawns two threads one writing to file via normal write
and one via mmap and checks the result. This is mainly interesting to
uncover races between DAX fault handling and write path.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/holetest.c        | 68 ++++++++++++++++++++++++++++++++++++---------------
 tests/generic/341     | 58 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/341.out | 55 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |  1 +
 4 files changed, 162 insertions(+), 20 deletions(-)
 create mode 100755 tests/generic/341
 create mode 100644 tests/generic/341.out

diff --git a/src/holetest.c b/src/holetest.c
index 661599954e4f..e78d1956a004 100644
--- a/src/holetest.c
+++ b/src/holetest.c
@@ -60,18 +60,20 @@
 #include <unistd.h>
 #include <pthread.h>
 #include <string.h>
+#include <getopt.h>
 
 #define THREADS 2
 
 long page_size;
 long page_offs[THREADS];
+int use_wr[THREADS];
 
 void *pt_page_marker(void *args)
 {
 	void **a = args;
-	char *va = (char *)a[0];
-	long npages = (long)a[1];
-	long pgoff = (long)a[2];
+	char *va = (char *)a[1];
+	long npages = (long)a[2];
+	long pgoff = (long)a[3];
 	uint64_t tid = (uint64_t)pthread_self();
 
 	va += pgoff;
@@ -83,13 +85,28 @@ void *pt_page_marker(void *args)
 	return NULL;
 }  /* pt_page_marker() */
 
+void *pt_write_marker(void *args)
+{
+	void **a = args;
+	int fd = (long)a[0];
+	long npages = (long)a[2];
+	long pgoff = (long)a[3];
+	uint64_t tid = (uint64_t)pthread_self();
+	long i;
+
+	/* mark pages */
+	for (i = 0; i < npages; i++)
+		pwrite(fd, &tid, sizeof(tid), i * page_size + pgoff);
+
+	return NULL;
+}
 
 int test_this(int fd, loff_t sz)
 {
 	long npages;
 	char *vastart;
 	char *va;
-	void *targs[THREADS][3];
+	void *targs[THREADS][4];
 	pthread_t t[THREADS];
 	uint64_t tid[THREADS];
 	int errcnt;
@@ -107,14 +124,17 @@ int test_this(int fd, loff_t sz)
 
 	/* prepare the thread args */
 	for (i = 0; i < THREADS; i++) {
-		targs[i][0] = vastart;
-		targs[i][1] = (void *)npages;
-		targs[i][2] = (void *)page_offs[i];
+		targs[i][0] = (void *)(long)fd;
+		targs[i][1] = vastart;
+		targs[i][2] = (void *)npages;
+		targs[i][3] = (void *)page_offs[i];
 	}
 
 	for (i = 0; i < THREADS; i++) {
 		/* start two threads */
-		if (pthread_create(&t[i], NULL, pt_page_marker, &targs[i])) {
+		if (pthread_create(&t[i], NULL,
+				   use_wr[i] ? pt_write_marker : pt_page_marker,
+				   &targs[i])) {
 			perror("pthread_create");
 			exit(21);
 		}
@@ -157,6 +177,7 @@ int main(int argc, char **argv)
 	int toterr = 0;
 	int i, step;
 	char *endch;
+	int opt;
 
 	page_size = getpagesize();
 	step = page_size / THREADS;
@@ -164,22 +185,29 @@ int main(int argc, char **argv)
 	for (i = 1; i < THREADS; i++)
 		page_offs[i] = page_offs[i-1] + step;
 
-	/* process command line */
-	argc--; argv++;
-	/* ignore errors? */
-	if ((argc == 3) && !strcmp(argv[0], "-f")) {
-		stoponerror = 0;
-		argc--;
-		argv++;
+	while ((opt = getopt(argc, argv, "fw")) > 0) {
+		switch (opt) {
+		case 'f':
+			/* ignore errors */
+			stoponerror = 0;
+			break;
+		case 'w':
+			/* use writes instead of mmap for one thread */
+			use_wr[0] = 1;
+			break;
+		default:
+			fprintf(stderr, "ERROR: Unknown option character.\n");
+			exit(1);
+		}
 	}
-	/* file name and size */
-	if (argc != 2 || argv[0][0] == '-') {
-		fprintf(stderr, "ERROR: usage: holetest [-f] "
+
+	if (optind != argc - 2) {
+		fprintf(stderr, "ERROR: usage: holetest [-fw] "
 			"FILENAME FILESIZEinMB\n");
 		exit(1);
 	}
-	path = argv[0];
-	sz = strtol(argv[1], &endch, 10);
+	path = argv[optind];
+	sz = strtol(argv[optind + 1], &endch, 10);
 	if (*endch || sz < 1) {
 		fprintf(stderr, "ERROR: bad FILESIZEinMB\n");
 		exit(1);
diff --git a/tests/generic/341 b/tests/generic/341
new file mode 100755
index 000000000000..1f8b58e930f5
--- /dev/null
+++ b/tests/generic/341
@@ -0,0 +1,58 @@
+#! /bin/bash
+# FSQA Test No. 341
+#
+# Test races between mmap and normal writes from racing threads
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
+src/holetest -f -w $SCRATCH_MNT/testfile 1
+src/holetest -f -w $SCRATCH_MNT/testfile 16
+src/holetest -f -w $SCRATCH_MNT/testfile 256
+
+status=0
+exit
diff --git a/tests/generic/341.out b/tests/generic/341.out
new file mode 100644
index 000000000000..675a29eece0a
--- /dev/null
+++ b/tests/generic/341.out
@@ -0,0 +1,55 @@
+QA output created by 341
+
+INFO: zero-filled test...
+INFO: sz = 1048576
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
+
+INFO: posix_fallocate test...
+INFO: sz = 1048576
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
+
+INFO: ftruncate test...
+INFO: sz = 1048576
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
+
+INFO: zero-filled test...
+INFO: sz = 16777216
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
+
+INFO: posix_fallocate test...
+INFO: sz = 16777216
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
+
+INFO: ftruncate test...
+INFO: sz = 16777216
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
+
+INFO: zero-filled test...
+INFO: sz = 268435456
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
+
+INFO: posix_fallocate test...
+INFO: sz = 268435456
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
+
+INFO: ftruncate test...
+INFO: sz = 268435456
+INFO: thread 0 created
+INFO: thread 1 created
+INFO: 0 error(s) detected
diff --git a/tests/generic/group b/tests/generic/group
index d0ca807b3695..c1686f8ac03c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -341,3 +341,4 @@
 336 auto quick metadata
 337 auto quick metadata
 340 auto
+341 auto
-- 
2.6.2

