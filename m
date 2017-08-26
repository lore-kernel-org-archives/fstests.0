Received: from mx1.redhat.com ([209.132.183.28]:41104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbdHZN0q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 26 Aug 2017 09:26:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FB0E883D7
        for <fstests@vger.kernel.org>; Sat, 26 Aug 2017 13:26:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EFA46E707
        for <fstests@vger.kernel.org>; Sat, 26 Aug 2017 13:26:44 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] generic: test data integrity with mixed buffer read and aio dio write
Date: Sat, 26 Aug 2017 21:26:36 +0800
Message-Id: <20170826132636.7892-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When mixing buffered reads and asynchronous direct writes, it is
possible to end up with the situation where we have stale data in
the page cache while the new data is already written to disk.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V3 follow eguan@'s suggestions, did below main changes:
1) Change fs_check() to file_check()
2) Always check on-disk data after buffered read.
3) Use TIMEOUT_PROG
4) Improve the reader loop

Thanks,
Zorro

 .gitignore                                |   1 +
 src/aio-dio-regress/aio-dio-cycle-write.c | 275 ++++++++++++++++++++++++++++++
 tests/generic/999                         |  90 ++++++++++
 tests/generic/999.out                     |   2 +
 tests/generic/group                       |   1 +
 5 files changed, 369 insertions(+)
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
index 00000000..8edfae93
--- /dev/null
+++ b/src/aio-dio-regress/aio-dio-cycle-write.c
@@ -0,0 +1,275 @@
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
+void *cmp_buf;
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
+void dump_buffer(void *buf, off64_t offset, ssize_t len)
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
+				fprintf(stderr, "*\n");
+			new = 1;
+		}
+
+		if (!new) {
+			p += 16;
+			continue;
+		}
+
+		fprintf(stderr, "%08llx  ", (unsigned long long)offset + i);
+		for (j = 0; j < 16 && i + j < len; j++, p++)
+			fprintf(stderr, "%02x ", *p);
+		fprintf(stderr, " ");
+		for (j = 0; j < 16 && i + j < len; j++, s++) {
+			if (isalnum((int)*s))
+				fprintf(stderr, "%c", *s);
+			else
+				fprintf(stderr, ".");
+		}
+		fprintf(stderr, "\n");
+
+	}
+	fprintf(stderr, "%08llx\n", (unsigned long long)offset + i);
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
+		fprintf(stderr, "error %s during posix_memalign\n",
+		        strerror(err));
+		exit(1);
+	}
+	memset(test_buf[0], IO_PATTERN1, buf_size);
+
+	/* fill test_buf[1] with IO_PATTERN2 */
+	err = posix_memalign(&(test_buf[1]), getpagesize(), buf_size);
+	if (err) {
+		fprintf(stderr, "error %s during posix_memalign\n",
+		        strerror(err));
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
+	/* cmp_buf is used to compare with test_buf */
+	err = posix_memalign(&cmp_buf, getpagesize(), buf_size);
+	if (err) {
+		fprintf(stderr, "error %s during posix_memalign\n",
+		        strerror(err));
+		exit(1);
+	}
+	memset(cmp_buf, 0, buf_size);
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
+int file_check(char *filename, void *buf)
+{
+	int fd;
+	int rc = 0;
+
+	/* check cached data with buffer read */
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
+
+	if (memcmp(buf, cmp_buf, buf_size)) {
+		fprintf(stderr, "get stale data from buffer read\n");
+		dump_buffer(cmp_buf, 0, buf_size);
+		rc++;
+	}
+
+	/*
+	 * check on-disk data with direct-IO read
+	 */
+	close(fd);
+	fd = open(filename, O_DIRECT|O_RDONLY, 0600);
+	if (fd < 0) {
+		perror("open with direct-IO");
+		exit(1);
+	}
+
+	if (pread(fd, cmp_buf, buf_size, 0) != buf_size) {
+		perror("pread");
+		exit(1);
+	}
+
+	if (memcmp(buf, cmp_buf, buf_size)) {
+		fprintf(stderr, "get stale data from DIO read\n");
+		dump_buffer(cmp_buf, 0, buf_size);
+		rc++;
+	}
+
+	close(fd);
+	return rc;
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
+		err = file_check(filename, test_buf[i]);
+		if (err != 0)
+			break;
+	}
+
+	return 0;
+}
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..1f9e09bf
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,90 @@
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
+_require_command "$TIMEOUT_PROG" timeout
+
+TESTFILE=$TEST_DIR/tst-aio-dio-cycle-write.$seq
+FSIZE=655360	# bytes
+
+# More read processes can help to reproduce the bug easier, so run
+# 2 ~ 20 readers according to the number of CPUs
+nr_cpu=`$here/src/feature -o`
+loops=$((nr_cpu / 2))
+if [ $loops -lt 2 ]; then
+	loops=2
+elif [ $loops -gt 20 ]; then
+	loops=20
+fi
+
+keep_reading=$tmp.reading
+touch $keep_reading
+# buffered reads the file frequently
+for ((i=0; i<loops; i++)); do
+	while [ -e $keep_reading ]; do
+		$XFS_IO_PROG -f -c "pread 0 $FSIZE" $TESTFILE >/dev/null 2>&1
+	done &
+	reader_pid="$reader_pid $!"
+done
+
+# start an aio writer, which does writing loops internally and check
+# data integrality.
+# For reproduce the original bug, keep testing about 30s will be better,
+# So let the AIO_TEST run as many loops as it can, then kill it in 20s.
+$TIMEOUT_PROG -s TERM 30s $AIO_TEST -c 999999 -b $FSIZE $TESTFILE >/dev/null
+
+# Remove $keep_reading file to stop the reader cycle
+rm -f $keep_reading
+wait $reader_pid
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..3b276ca8
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden
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
2.13.5

