Received: from mx1.redhat.com ([209.132.183.28]:40208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbdHJI5N (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 10 Aug 2017 04:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99455116E1F
        for <fstests@vger.kernel.org>; Thu, 10 Aug 2017 08:57:13 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic: test data integrity with mixed buffer read and aio dio write
Date: Thu, 10 Aug 2017 16:57:08 +0800
Message-Id: <20170810085708.1944-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

When mixing buffered reads and asynchronous direct writes, it is
possible to end up with the situation where we have stale data in
the page cache while the new data is already written to disk.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

This case add a new C program into src/aio-dio-regress/. I tried to
use some existent program to make some AIO load to trigger this bug,
but I found it's very hard.

For trigger this bug ASAP, I had to write a new program. And from
the my test results, it really can reproduce this bug quickly.

More details about this bug please check:
https://patchwork.kernel.org/patch/9851671/

Thanks,
Zorro

 .gitignore                                |   1 +
 src/aio-dio-regress/aio-dio-cycle-write.c | 254 ++++++++++++++++++++++++++++++
 tests/generic/999                         |  74 +++++++++
 tests/generic/999.out                     |   2 +
 tests/generic/group                       |   1 +
 5 files changed, 332 insertions(+)
 create mode 100644 src/aio-dio-regress/aio-dio-cycle-write.c
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/.gitignore b/.gitignore
index fcbc0cd4..28fe84d5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -133,6 +133,7 @@
 /src/writemod
 /src/writev_on_pagefault
 /src/xfsctl
+/src/aio-dio-regress/aio-dio-cycle-write
 /src/aio-dio-regress/aio-dio-extend-stat
 /src/aio-dio-regress/aio-dio-fcntl-race
 /src/aio-dio-regress/aio-dio-hole-filling-race
diff --git a/src/aio-dio-regress/aio-dio-cycle-write.c b/src/aio-dio-regress/aio-dio-cycle-write.c
new file mode 100644
index 00000000..6c10f9cc
--- /dev/null
+++ b/src/aio-dio-regress/aio-dio-cycle-write.c
@@ -0,0 +1,254 @@
+/*
+ * Directly AIO re-write a file with different content again and again.
+ * And check the data integrity.
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <ctype.h>
+
+#include <libaio.h>
+
+unsigned long buf_size = 0;
+unsigned long loop_count = 0;
+void *test_buf[2];
+#define IO_PATTERN1	0x55
+#define IO_PATTERN2	0xaa
+
+void usage(char *progname)
+{
+	fprintf(stderr, "usage: %s [-c loop_count] [-b bufsize] filename\n"
+	        "\t-c loopcount: specify how many times to test"
+	        "\t-b bufsize: keep writing from offset 0 to this size",
+	        progname);
+	exit(1);
+}
+
+void dump_buffer(
+	void	*buf,
+	off64_t	offset,
+	ssize_t	len)
+{
+	int	i, j;
+	char	*p;
+	int	new;
+
+	for (i = 0, p = (char *)buf; i < len; i += 16) {
+		char    *s = p;
+
+		if (i && !memcmp(p, p - 16, 16)) {
+			new = 0;
+		} else {
+			if (i)
+				printf("*\n");
+			new = 1;
+		}
+
+		if (!new) {
+			p += 16;
+			continue;
+		}
+
+		printf("%08llx  ", (unsigned long long)offset + i);
+		for (j = 0; j < 16 && i + j < len; j++, p++)
+			printf("%02x ", *p);
+		printf(" ");
+		for (j = 0; j < 16 && i + j < len; j++, s++) {
+			if (isalnum((int)*s))
+				printf("%c", *s);
+			else
+				printf(".");
+		}
+		printf("\n");
+
+	}
+	printf("%08llx\n", (unsigned long long)offset + i);
+}
+
+int init_test(char *filename)
+{
+	int fd;
+	int err = 0;
+
+	fd = open(filename, O_DIRECT | O_CREAT | O_RDWR, 0600);
+	if (fd == -1) {
+		perror("open");
+		exit(1);
+	}
+
+	ftruncate(fd, buf_size);
+
+	/* fill test_buf[0] with IO_PATTERN1 */
+	err = posix_memalign(&(test_buf[0]), getpagesize(), buf_size);
+	if (err) {
+		fprintf(stderr, "error %s during %s\n",
+			strerror(err),
+			"posix_memalign");
+		exit(1);
+	}
+	memset(test_buf[0], IO_PATTERN1, buf_size);
+
+	/* fill test_buf[1] with IO_PATTERN2 */
+	err = posix_memalign(&(test_buf[1]), getpagesize(), buf_size);
+	if (err) {
+		fprintf(stderr, "error %s during %s\n",
+			strerror(err),
+			"posix_memalign");
+		exit(1);
+	}
+	memset(test_buf[1], IO_PATTERN2, buf_size);
+
+	/* fill test file with IO_PATTERN1 */
+	if (pwrite(fd, test_buf[0], buf_size, 0) != buf_size) {
+		perror("pwrite");
+		exit(1);
+	}
+
+	fsync(fd);
+	close(fd);
+
+	return 0;
+}
+
+/*
+ * Read file content back, then compare with the 'buf' which
+ * point to the original buffer was written to file.
+ */
+int fs_check(char *filename, void *buf)
+{
+	void *cmp_buf;
+	int fd;
+
+	cmp_buf = malloc(buf_size);
+	if (!cmp_buf) {
+		perror("malloc");
+		exit(1);
+	}
+	memset(cmp_buf, 0, buf_size);
+
+	fd = open(filename, O_RDONLY, 0600);
+	if (fd == -1) {
+		perror("open");
+		exit(1);
+	}
+
+	if (pread(fd, cmp_buf, buf_size, 0) != buf_size) {
+		perror("pread");
+		exit(1);
+	}
+	close(fd);
+
+	if (memcmp(buf, cmp_buf, buf_size)) {
+		printf("corruption while extending\n");
+		dump_buffer(buf, 0, buf_size);
+		exit(1);
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct io_context *ctx = NULL;
+	struct io_event evs[1];
+	struct iocb iocb1;
+	struct iocb *iocbs[] = { &iocb1 };
+	int fd, err = 0;
+	int i;
+	int c;
+	char *filename = NULL;
+
+	while ((c = getopt(argc, argv, "c:b:")) != -1) {
+		char *endp;
+
+		switch (c) {
+		case 'c':	/* the number of testing cycles */
+			loop_count = strtol(optarg, &endp, 0);
+			break;
+		case 'b':	/* buffer size */
+			buf_size = strtol(optarg, &endp, 0);
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (loop_count == 0)
+		loop_count = 1600;
+	if (buf_size == 0)	/* default minimum buffer size is 65536 bytes */
+		buf_size = 65536;
+
+	if (optind == argc - 1)
+		filename = argv[optind];
+	else
+		usage(argv[0]);
+
+	init_test(filename);
+
+	err = io_setup(1, &ctx);
+	if (err) {
+		fprintf(stderr, "error %s during %s\n",
+		        strerror(err),
+		        "io_setup");
+		return 1;
+	}
+
+	i = 0;
+	/*
+	 * Keep running until loop_count times, fill the file with IO_PATTERN1
+	 * or IO_PATTERN2 one by one, then read the file data back to check if
+	 * there's stale data.
+	 */
+	while (loop_count--) {
+		i++;
+		i %= 2;
+		fd = open(filename, O_DIRECT | O_CREAT | O_RDWR, 0600);
+		if (fd == -1) {
+			perror("open");
+			return 1;
+		}
+
+		io_prep_pwrite(&iocb1, fd, test_buf[i], buf_size, 0);
+		err = io_submit(ctx, 1, iocbs);
+		if (err != 1) {
+			fprintf(stderr, "error %s during %s\n",
+				strerror(err),
+				"io_submit");
+			return 1;
+		}
+		err = io_getevents(ctx, 1, 1, evs, NULL);
+		if (err != 1) {
+			fprintf(stderr, "error %s during %s\n",
+				strerror(err),
+				"io_getevents");
+			return 1;
+		}
+		close(fd);
+
+		fs_check(filename, test_buf[i]);
+	}
+
+	printf("Success, all done.\n");
+	return 0;
+}
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..006a7c92
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,74 @@
+#! /bin/bash
+# FS QA Test No. 999
+#
+# Test data integrity when mixing buffered reads and asynchronous
+# direct writes a file.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
+
+here=`pwd`
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
+# get standard environment, filters and checks
+. ./common/rc
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_test_program "feature"
+_require_aiodio aio-dio-cycle-write
+
+TESTFILE=$TEST_DIR/tst-aio-dio-cycle-write.$seq
+FSIZE=655360	# bytes
+
+# buffered reads the file frequently
+while true; do
+	$XFS_IO_PROG -f -c "pread 0 $FSIZE" $TESTFILE >/dev/null 2>&1
+done &
+reader_pid=$!
+
+nr_cpu=`$here/src/feature -o`
+LOOPCOUNT=$((nr_cpu * 100))
+if [ $LOOPCOUNT -gt 1000 ]; then
+	LOOPCOUNT=1000
+fi
+# start a background aio writer, which does several writing loops
+# internally and check data integrality
+$AIO_TEST -c $LOOPCOUNT -b $FSIZE $TESTFILE
+status=$?
+
+kill $reader_pid
+wait $reader_pid
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..6362b866
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Success, all done.
diff --git a/tests/generic/group b/tests/generic/group
index e13b5683..08462eee 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -452,3 +452,4 @@
 447 auto quick clone
 448 auto quick rw
 449 auto quick acl enospc
+999 auto aio rw
-- 
2.13.4

