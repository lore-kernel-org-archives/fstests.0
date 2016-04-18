Received: from mx2.suse.de ([195.135.220.15]:54916 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbcDRTcp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Apr 2016 15:32:45 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id DBC31AD35
	for <fstests@vger.kernel.org>; Mon, 18 Apr 2016 19:32:41 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] generic/344: Test races between mmap and normal write for prefaulted ranges
Date: Mon, 18 Apr 2016 21:32:33 +0200
Message-Id: <1461007955-7921-4-git-send-email-jack@suse.cz>
In-Reply-To: <1461007955-7921-1-git-send-email-jack@suse.cz>
References: <1461007955-7921-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Add test which spawns two threads both writing one file via mmap which
has been previously prefaulted by reading. Do the same test when one
thread accesses the file via mmap and the other one via normal write.
This is mainly interesting to uncover races in DAX fault handling and
between DAX fault handling and write path.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/holetest.c        | 19 ++++++++++++--
 tests/generic/344     | 60 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/344.out | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |  1 +
 4 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 tests/generic/344
 create mode 100644 tests/generic/344.out

diff --git a/src/holetest.c b/src/holetest.c
index 6f23110b3769..252fe734523e 100644
--- a/src/holetest.c
+++ b/src/holetest.c
@@ -67,6 +67,7 @@
 long page_size;
 long page_offs[THREADS];
 int use_wr[THREADS];
+int prefault = 0;
 
 void *pt_page_marker(void *args)
 {
@@ -122,6 +123,16 @@ int test_this(int fd, loff_t sz)
 		exit(20);
 	}
 
+	if (prefault) {
+		for (i = 0; i < npages; i++) {
+			if (vastart[i * page_size] != 0) {
+				fprintf(stderr, "Prefaulting found non-zero "
+					"value in page %d: %d\n", i,
+					vastart[i * page_size]);
+			}
+		}
+	}
+
 	/* prepare the thread args */
 	for (i = 0; i < THREADS; i++) {
 		targs[i][0] = (void *)(long)fd;
@@ -185,7 +196,7 @@ int main(int argc, char **argv)
 	for (i = 1; i < THREADS; i++)
 		page_offs[i] = page_offs[i-1] + step;
 
-	while ((opt = getopt(argc, argv, "fw")) > 0) {
+	while ((opt = getopt(argc, argv, "fwr")) > 0) {
 		switch (opt) {
 		case 'f':
 			/* ignore errors */
@@ -195,6 +206,10 @@ int main(int argc, char **argv)
 			/* use writes instead of mmap for one thread */
 			use_wr[0] = 1;
 			break;
+		case 'r':
+			/* prefault mmapped area by reading it */
+			prefault = 1;
+			break;
 		default:
 			fprintf(stderr, "ERROR: Unknown option character.\n");
 			exit(1);
@@ -202,7 +217,7 @@ int main(int argc, char **argv)
 	}
 
 	if (optind != argc - 2) {
-		fprintf(stderr, "ERROR: usage: holetest [-fw] "
+		fprintf(stderr, "ERROR: usage: holetest [-fwr] "
 			"FILENAME FILESIZEinMB\n");
 		exit(1);
 	}
diff --git a/tests/generic/344 b/tests/generic/344
new file mode 100644
index 000000000000..1c10a955c8e6
--- /dev/null
+++ b/tests/generic/344
@@ -0,0 +1,60 @@
+#! /bin/bash
+# FSQA Test No. 344
+#
+# Test races between mmap from racing threads when pages are prefaulted,
+# Test races between mmap and buffered writes when pages are prefaulted.
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
+src/holetest -f -r $SCRATCH_MNT/testfile 16
+src/holetest -f -r $SCRATCH_MNT/testfile 256
+src/holetest -f -r -w $SCRATCH_MNT/testfile 16
+src/holetest -f -r -w $SCRATCH_MNT/testfile 256
+
+status=0
+exit
diff --git a/tests/generic/344.out b/tests/generic/344.out
new file mode 100644
index 000000000000..3ae5e5b373d9
--- /dev/null
+++ b/tests/generic/344.out
@@ -0,0 +1,73 @@
+QA output created by 344
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
index 05b0448d64f4..e58d36085585 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -346,3 +346,4 @@
 341 auto quick metadata
 342 auto quick metadata
 343 auto
+344 auto
-- 
2.6.6

