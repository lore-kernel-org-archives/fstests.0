Received: from mail-bl2on0124.outbound.protection.outlook.com ([65.55.169.124]:6933
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750886AbcCWVrk convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 23 Mar 2016 17:47:40 -0400
From: "Boylston, Brian" <brian.boylston@hpe.com>
Subject: RE: [PATCH] generic/338: Add mmap race test
Date: Wed, 23 Mar 2016 21:33:14 +0000
Message-ID: <AT5PR84MB002088291386F87A62B2399A8E810@AT5PR84MB0020.NAMPRD84.PROD.OUTLOOK.COM>
References: <1458740555-3512-1-git-send-email-jack@suse.cz>
In-Reply-To: <1458740555-3512-1-git-send-email-jack@suse.cz>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>
List-ID: <fstests@vger.kernel.org>

It might be good to run with larger file sizes if possible.  In my notes,
I had recorded that "a file size of 1000 (MB) is enough to see errors almost
every test run.  A size of 500 will occasionally pass without error".

Otherwise, it looks good.  With that:
Acked-by: Brian Boylston <brian.boylston@hpe.com>

-----Original Message-----
From: Jan Kara [mailto:jack@suse.cz] 
Sent: Wednesday, March 23, 2016 9:43 AM
To: fstests@vger.kernel.org
Cc: Kani, Toshimitsu <toshi.kani@hpe.com>; Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/338: Add mmap race test

Add test which spawns two threads racing to write to file via mmap and
checks the result. This is mainly interesting to uncover races in DAX
fault handling.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/Makefile          |   5 +-
 src/holetest.c        | 342 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/338     |  57 +++++++++
 tests/generic/338.out |  73 +++++++++++
 tests/generic/group   |   1 +
 5 files changed, 476 insertions(+), 2 deletions(-)
 create mode 100644 src/holetest.c
 create mode 100755 tests/generic/338
 create mode 100644 tests/generic/338.out

diff --git a/src/Makefile b/src/Makefile
index 31102086a5f6..1bf318bd068b 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -11,7 +11,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	devzero feature alloc fault fstest t_access_root \
 	godown resvtest writemod makeextents itrash rename \
 	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
-	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite
+	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
+	holetest
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
@@ -23,7 +24,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 
 SUBDIRS =
 
-LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL)
+LLDLIBS = $(LIBATTR) $(LIBHANDLE) $(LIBACL) -lpthread
 
 ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
 LINUX_TARGETS += loggen
diff --git a/src/holetest.c b/src/holetest.c
new file mode 100644
index 000000000000..c0a2c67798a3
--- /dev/null
+++ b/src/holetest.c
@@ -0,0 +1,342 @@
+/*
+ * holetest -- test simultaneous page faults on hole-backed pages
+ * Copyright (C) 2015  Hewlett Packard Enterprise Development LP
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+
+/*
+ * holetest
+ *
+ * gcc -Wall -pthread -o holetest holetest.c
+ *
+ * This test tool exercises page faults on hole-y portions of an mmapped
+ * file.  The file is created, sized using various methods, mmapped, and
+ * then two threads race to write a marker to different offsets within
+ * each mapped page.  Once the threads have finished marking each page,
+ * the pages are checked for the presence of the markers.
+ *
+ * The file is sized four different ways: explicitly zero-filled by the
+ * test, posix_fallocate(), fallocate(), and ftruncate().  The explicit
+ * zero-fill does not really test simultaneous page faults on hole-backed
+ * pages, but rather serves as control of sorts.
+ *
+ * Usage:
+ *
+ *   holetest [-f] FILENAME FILESIZEinMB
+ *
+ * Where:
+ *
+ *   FILENAME is the name of a non-existent test file to create
+ *
+ *   FILESIZEinMB is the desired size of the test file in MiB
+ *
+ * If the test is successful, FILENAME will be unlinked.  By default,
+ * if the test detects an error in the page markers, then the test exits
+ * immediately and FILENAME is left.  If -f is given, then the test
+ * continues after a marker error and FILENAME is unlinked, but will
+ * still exit with a non-0 status.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <string.h>
+
+#define THREADS 2
+
+long page_size;
+long page_offs[THREADS];
+
+void *pt_page_marker(void *args)
+{
+	void **a = args;
+	char *va = (char *)a[0];
+	long npages = (long)a[1];
+	long pgoff = (long)a[2];
+	uint64_t tid = (uint64_t)pthread_self();
+
+	va += pgoff;
+
+	/* mark pages */
+	for (; npages > 0; va += page_size, npages--)
+		*(uint64_t *)(va) = tid;
+
+	return NULL;
+}  /* pt_page_marker() */
+
+
+int test_this(int fd, loff_t sz)
+{
+	long npages;
+	char *vastart;
+	char *va;
+	void *targs[THREADS][3];
+	pthread_t t[THREADS];
+	uint64_t tid[THREADS];
+	int errcnt;
+	int i;
+
+	npages = sz / page_size;
+	printf("INFO: sz = %llu\n", (unsigned long long)sz);
+
+	/* mmap it */
+	vastart = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (MAP_FAILED == vastart) {
+		perror("mmap()");
+		exit(20);
+	}
+
+	/* prepare the thread args */
+	for (i = 0; i < THREADS; i++) {
+		targs[i][0] = vastart;
+		targs[i][1] = (void *)npages;
+		targs[i][2] = (void *)page_offs[i];
+	}
+
+	for (i = 0; i < THREADS; i++) {
+		/* start two threads */
+		if (pthread_create(&t[i], NULL, pt_page_marker, &targs[i])) {
+			perror("pthread_create");
+			exit(21);
+		}
+		tid[i] = (uint64_t)t[i];
+		printf("INFO: thread %d created\n", i);
+	}
+
+	/* wait for them to finish */
+	for (i = 0; i < THREADS; i++)
+		pthread_join(t[i], NULL);
+
+	/* check markers on each page */
+	errcnt = 0;
+	for (va = vastart; npages > 0; va += page_size, npages--) {
+		for (i = 0; i < THREADS; i++) {
+			if (*(uint64_t*)(va + page_offs[i]) != tid[i]) {
+				printf("ERROR: thread %d, "
+				       "offset %08lx, %08lx != %08lx\n", i,
+				       (va + page_offs[i] - vastart),
+				       *(uint64_t*)(va + page_offs[i]), tid[i]);
+				errcnt += 1;
+			}
+		}
+	}
+
+	printf("INFO: %d error(s) detected\n", errcnt);
+
+	munmap(vastart, sz);
+
+	return errcnt;
+}
+
+int main(int argc, char **argv)
+{
+	int stoponerror = 1;
+	char *path;
+	loff_t sz;
+	int fd;
+	int errcnt;
+	int toterr = 0;
+	int i, step;
+	char *endch;
+
+	page_size = getpagesize();
+	step = page_size / THREADS;
+	page_offs[0] = step / 2;
+	for (i = 1; i < THREADS; i++)
+		page_offs[i] = page_offs[i-1] + step;
+
+	/* process command line */
+	argc--; argv++;
+	/* ignore errors? */
+	if ((argc == 3) && !strcmp(argv[0], "-f")) {
+		stoponerror = 0;
+		argc--;
+		argv++;
+	}
+	/* file name and size */
+	if (argc != 2 || argv[0][0] == '-') {
+		fprintf(stderr, "ERROR: usage: holetest [-f] "
+			"FILENAME FILESIZEinMB\n");
+		exit(1);
+	}
+	path = argv[0];
+	sz = strtol(argv[1], &endch, 10);
+	if (*endch || sz < 1) {
+		fprintf(stderr, "ERROR: bad FILESIZEinMB\n");
+		exit(1);
+	}
+	sz <<= 20;
+
+	/*
+	 * we're going to run our test in several different ways:
+	 *
+	 * 1. explictly zero-filled
+	 * 2. posix_fallocated
+	 * 3. fallocated
+	 * 4. ftruncated
+	 */
+
+
+	/*
+	 * explicitly zero-filled
+	 */
+	printf("\nINFO: zero-filled test...\n");
+
+	/* create the file */
+	fd = open(path, O_RDWR | O_EXCL | O_CREAT, 0644);
+	if (fd < 0) {
+		perror(path);
+		exit(2);
+	}
+
+	/* truncate it to size */
+	if (ftruncate(fd, sz)) {
+		perror("ftruncate()");
+		exit(3);
+	}
+
+	/* explicitly zero-fill */
+	{
+		char*   va = mmap(NULL, sz, PROT_READ | PROT_WRITE,
+				  MAP_SHARED, fd, 0);
+		if (MAP_FAILED == va) {
+			perror("mmap()");
+			exit(4);
+		}
+		memset(va, 0, sz);
+		munmap(va, sz);
+	}
+
+	/* test it */
+	errcnt = test_this(fd, sz);
+	toterr += errcnt;
+	close(fd);
+	if (stoponerror && errcnt > 0)
+		exit(5);
+
+	/* cleanup */
+	if (unlink(path)) {
+		perror("unlink()");
+		exit(6);
+	}
+
+
+	/*
+	 * posix_fallocated
+	 */
+	printf("\nINFO: posix_fallocate test...\n");
+
+	/* create the file */
+	fd = open(path, O_RDWR | O_EXCL | O_CREAT, 0644);
+	if (fd < 0) {
+		perror(path);
+		exit(7);
+	}
+
+	/* fill it to size */
+	if (posix_fallocate(fd, 0, sz)) {
+		perror("posix_fallocate()");
+		exit(8);
+	}
+
+	/* test it */
+	errcnt = test_this(fd, sz);
+	toterr += errcnt;
+	close(fd);
+	if (stoponerror && errcnt > 0)
+		exit(9);
+
+	/* cleanup */
+	if (unlink(path)) {
+		perror("unlink()");
+		exit(10);
+	}
+
+	/*
+	 * fallocated
+	 */
+	printf("\nINFO: fallocate test...\n");
+
+#ifdef HAVE_FALLOCATE
+	/* create the file */
+	fd = open(path, O_RDWR | O_EXCL | O_CREAT, 0644);
+	if (fd < 0) {
+		perror(path);
+		exit(11);
+	}
+
+	/* fill it to size */
+	if (fallocate(fd, 0, 0, sz)) {
+		perror("fallocate()");
+		exit(12);
+	}
+
+	/* test it */
+	errcnt = test_this(fd, sz);
+	toterr += errcnt;
+	close(fd);
+	if (stoponerror && errcnt > 0)
+		exit(13);
+
+	/* cleanup */
+	if (unlink(path)) {
+		perror("unlink()");
+		exit(14);
+	}
+#endif
+
+	/*
+	 * ftruncated
+	 */
+	printf("\nINFO: ftruncate test...\n");
+
+	/* create the file */
+	fd = open(path, O_RDWR | O_EXCL | O_CREAT, 0644);
+	if (fd < 0) {
+		perror(path);
+		exit(15);
+	}
+
+	/* truncate it to size */
+	if (ftruncate(fd, sz)) {
+		perror("ftruncate()");
+		exit(16);
+	}
+
+	/* test it */
+	errcnt = test_this(fd, sz);
+	toterr += errcnt;
+	close(fd);
+	if (stoponerror && errcnt > 0)
+		exit(17);
+
+	/* cleanup */
+	if (unlink(path)) {
+		perror("unlink()");
+		exit(18);
+	}
+
+	/* done */
+	if (toterr > 0)
+		exit(19);
+	return 0;
+}
diff --git a/tests/generic/338 b/tests/generic/338
new file mode 100755
index 000000000000..06d787773015
--- /dev/null
+++ b/tests/generic/338
@@ -0,0 +1,57 @@
+#! /bin/bash
+# FSQA Test No. 338
+#
+# Test mmap writing races from racing threads
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
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+src/holetest -f $SCRATCH_MNT/testfile 1
+src/holetest -f $SCRATCH_MNT/testfile 16
+src/holetest -f $SCRATCH_MNT/testfile 256
+
+status=0
+exit
diff --git a/tests/generic/338.out b/tests/generic/338.out
new file mode 100644
index 000000000000..110203e33d01
--- /dev/null
+++ b/tests/generic/338.out
@@ -0,0 +1,73 @@
+QA output created by 338
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
+INFO: fallocate test...
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
+INFO: fallocate test...
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
+INFO: fallocate test...
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
index 727648c68785..4f41631f8adc 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -340,3 +340,4 @@
 335 auto quick metadata
 336 auto quick metadata
 337 auto quick metadata
+338 auto
-- 
2.6.2

