Received: from mx2.suse.de ([195.135.220.15]:52062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751059AbdI0TKL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Sep 2017 15:10:11 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25BFDAE7B
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2017 19:10:10 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH 1/2] generic/461: Test RWF_NOWAIT
Date: Wed, 27 Sep 2017 14:10:02 -0500
Message-Id: <20170927191003.10099-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Tests the RWF_NOWAIT flag so the I/O returns immediately on
a new file, without any block allocations.

A new program which includes the pwritev2() call is used. This allows
passing flags for the I/O to be performed.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 src/Makefile          |   2 +-
 src/pwritev2.c        | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/461     |  80 +++++++++++++++++++++++++
 tests/generic/461.out |   9 +++
 tests/generic/group   |   1 +
 5 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 src/pwritev2.c
 create mode 100755 tests/generic/461
 create mode 100644 tests/generic/461.out

diff --git a/src/Makefile b/src/Makefile
index 7d1306bc..427c561e 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -23,7 +23,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
 	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
-	dio-invalidate-cache stat_test t_encrypted_d_revalidate
+	dio-invalidate-cache stat_test t_encrypted_d_revalidate pwritev2
 
 SUBDIRS = log-writes
 
diff --git a/src/pwritev2.c b/src/pwritev2.c
new file mode 100644
index 00000000..28413910
--- /dev/null
+++ b/src/pwritev2.c
@@ -0,0 +1,161 @@
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/uio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <linux/fs.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/time.h>
+
+int openflag = O_RDWR | O_LARGEFILE;
+long datasz = 4096;
+long iovcnt = 1;
+long offset = 0;
+int readfile = 0;
+int measure_time = 0;
+int flags = 0;
+char *filename = "pwrite-file";
+unsigned int seed = 0xcdcdcdcd;
+
+int usage()
+{
+	fprintf(stderr, "Usage: pwritev2 \n");
+	fprintf(stderr,	"\t-b [buffer size]: Size of each buffer\n");
+	fprintf(stderr, "\t-d: Direct write\n");
+	fprintf(stderr,	"\t-f: create file if not exists\n");
+	fprintf(stderr,	"\t-s [data size]: Size of each iovec data buffer\n");
+	fprintf(stderr,	"\t-S [seed]: seed for the data buffer\n");
+	fprintf(stderr,	"\t-t: measure time\n");
+	fprintf(stderr,	"\t-o [offset]: Offset where to perform the pwritev2\n");
+	fprintf(stderr,	"\t-V [num of iovecs]: Number of vectors\n");
+	fprintf(stderr,	"\t-W: perform I/O with RWF_NOWAIT\n");
+	fprintf(stderr,	"\t filename: The filename to perform pwritev2\n");
+	exit(1);
+}
+
+/*
+ * Scale value by kilo, mega, or giga.
+ */
+long long scale_by_kmg(long long value, char scale)
+{
+	switch (scale) {
+		case 'g':
+		case 'G':
+			value *= 1024;
+		case 'm':
+		case 'M':
+			value *= 1024;
+		case 'k':
+		case 'K':
+			value *= 1024;
+			break;
+		case '\0':
+			break;
+		default:
+			usage();
+			break;
+	}
+	return value;
+}
+
+
+int parse_args(int argc, char *argv[])
+{
+	int c;
+	extern int optind;
+	while ((c = getopt(argc, argv, "b:dfo:V:S:tW")) != -1) {
+		char *endp;
+		switch (c) {
+			case 'b':
+				datasz = strtol(optarg, &endp, 0);
+				datasz = (long)scale_by_kmg((long long)datasz,
+						*endp);
+				break;
+			case 'd':
+				openflag |= O_DIRECT;
+				break;
+			case 'f':
+				openflag |= O_CREAT;
+				break;
+			case 'o':
+				offset = strtol(optarg, &endp, 0);
+				break;
+			case 't':
+				measure_time = 1;
+				break;
+			case 'S':
+				seed = strtoul(optarg, &endp, 0);
+				break;
+			case 'V':
+				iovcnt = strtol(optarg, &endp, 0);
+				break;
+			case 'W':
+				flags |= RWF_NOWAIT;
+				break;
+			default:
+				usage();
+		}
+	}
+	filename = argv[optind];
+}
+
+
+
+int main(int argc, char *argv[])
+{
+	int i, fd;
+	size_t ret = 0;
+	struct iovec *iovec;
+	char *data;
+	struct timeval before, after;
+	struct timezone tz;
+
+	parse_args(argc, argv);
+
+	iovec = (struct iovec *)malloc(sizeof(struct iovec) * iovcnt);
+	if (!iovec) {
+		fprintf(stderr, "Could not allocate iovec\n");
+		exit(1);
+	}
+	data = aligned_alloc(datasz, datasz);
+	if (!data) {
+		fprintf(stderr, "Could not allocate data\n");
+		exit(1);
+	}
+
+	memset(data, seed, datasz);
+
+	for (i=0; i<iovcnt; i++) {
+		iovec[i].iov_base = data;
+		iovec[i].iov_len = datasz;
+	}
+
+	fd = open(filename, openflag, S_IRUSR | S_IWUSR);
+
+	gettimeofday(&before, &tz);
+	ret = pwritev2(fd, iovec, iovcnt, offset, flags);
+	gettimeofday(&after, &tz);
+	printf("pwritev2() ret = %ld %s(%d)\n", ret, strerror(errno), errno);
+
+	if (measure_time) {
+		unsigned long seconds, ms;
+		seconds = after.tv_sec - before.tv_sec;
+		if (after.tv_usec < before.tv_usec) {
+			seconds -= 1;
+			ms = 1000000 + after.tv_usec - before.tv_usec;
+		} else
+			ms = after.tv_usec - before.tv_usec;
+		printf("Time: %lu seconds %lu microseconds\n", seconds, ms);
+	}
+
+	close(fd);
+	return 0;
+
+}
+
+
diff --git a/tests/generic/461 b/tests/generic/461
new file mode 100755
index 00000000..7bbedd5d
--- /dev/null
+++ b/tests/generic/461
@@ -0,0 +1,80 @@
+#! /bin/bash
+# FS QA Test No. 461
+#
+# write() to a file opened with O_DIRECT with count > remaining
+# bytes. Result should be remaining bytes (to aligned bytes) instead
+# of ENOSPC error
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015, Oracle and/or its affiliates.  All Rights Reserved.
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
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -rf $tmp.* $testdir1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/populate
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_os Linux
+_require_odirect
+
+rm -f $seqres.full
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+# Create a file with pwrite nowait (will fail with EAGAIN)
+out=`src/pwritev2 -f -W -d -V 1 -b 128M -t $testdir/f1 | grep Time`
+microsecs=`echo $out | cut -f 4 -d " "`
+secs=`echo $out | cut -f 2 -d " "`
+if [ $microsecs -lt 50 -a $secs -eq 0 ]; then
+	echo "RWF_NOWAIT time is within limits."
+else
+	echo "RWF_NOWAIT took $secs seconds and $microsecs microsecs"
+fi
+
+# Write the file without nowait
+src/pwritev2 -S 0xaa -d -V 1 -b 128M $testdir/f1 
+
+# Write the file with nowait
+src/pwritev2 -W -d -V 1 -b 128M $testdir/f1
+
+# Read the file to check if data is correct
+$XFS_IO_PROG -d -c "pread 0 4k -v" $testdir/f1 | _filter_xfs_io_unique 
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/461.out b/tests/generic/461.out
new file mode 100644
index 00000000..1c331d5b
--- /dev/null
+++ b/tests/generic/461.out
@@ -0,0 +1,9 @@
+QA output created by 461
+Format and mount
+RWF_NOWAIT time is within limits.
+pwritev2() ret = 134217728 Success(0)
+pwritev2() ret = 134217728 Success(0)
+00000000:  cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  ................
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index f922b496..6352064a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -463,3 +463,4 @@
 458 auto quick clone
 459 auto dangerous
 460 auto quick rw
+461 auto quick rw
-- 
2.14.1

