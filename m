Received: from mail-pg0-f52.google.com ([74.125.83.52]:36535 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754296AbcKQA3n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Nov 2016 19:29:43 -0500
Received: by mail-pg0-f52.google.com with SMTP id f188so84458663pgc.3
        for <fstests@vger.kernel.org>; Wed, 16 Nov 2016 16:29:43 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] generic: test concurrent non-overlapping direct I/O on the same extents
Date: Wed, 16 Nov 2016 16:29:34 -0800
Message-Id: <1edb45d8895de8fe347e800a5fd22b0f6eafb181.1479342541.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

There have been a couple of logic bugs in `btrfs_get_extent()` which
could lead to spurious -EEXIST errors from read or write. This test
exercises those conditions by having two threads race to add an extent
to the extent map.

This is fixed by Linux commit 8dff9c853410 ("Btrfs: deal with duplciates
during extent_map insertion in btrfs_get_extent") and the patch "Btrfs:
deal with existing encompassing extent map in btrfs_get_extent()"
(http://marc.info/?l=linux-btrfs&m=147873402311143&w=2).

Although the bug is Btrfs-specific, nothing about the test is.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/dio-interleaved.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/390     | 76 +++++++++++++++++++++++++++++++++++++++
 tests/generic/390.out |  2 ++
 tests/generic/group   |  1 +
 6 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 src/dio-interleaved.c
 create mode 100755 tests/generic/390
 create mode 100644 tests/generic/390.out

diff --git a/.gitignore b/.gitignore
index 915d2d8..b8d13a0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,7 @@
 /src/bulkstat_unlink_test_modified
 /src/dbtest
 /src/devzero
+/src/dio-interleaved
 /src/dirperf
 /src/dirstress
 /src/dmiperf
diff --git a/src/Makefile b/src/Makefile
index dd51216..4056496 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
-	attr-list-by-handle-cursor-test listxattr
+	attr-list-by-handle-cursor-test listxattr dio-interleaved
 
 SUBDIRS =
 
diff --git a/src/dio-interleaved.c b/src/dio-interleaved.c
new file mode 100644
index 0000000..831a191
--- /dev/null
+++ b/src/dio-interleaved.c
@@ -0,0 +1,98 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+static pthread_barrier_t barrier;
+
+static unsigned long extent_size;
+static unsigned long num_extents;
+
+struct dio_thread_data {
+	int fd;
+	int thread_id;
+};
+
+static void *dio_thread(void *arg)
+{
+	struct dio_thread_data *data = arg;
+	off_t off;
+	ssize_t ret;
+	void *buf;
+
+	if ((errno = posix_memalign(&buf, extent_size / 2, extent_size / 2))) {
+		perror("malloc");
+		return NULL;
+	}
+	memset(buf, 0, extent_size / 2);
+
+	off = (num_extents - 1) * extent_size;
+	if (data->thread_id)
+		off += extent_size / 2;
+	while (off >= 0) {
+		pthread_barrier_wait(&barrier);
+
+		ret = pread(data->fd, buf, extent_size / 2, off);
+		if (ret == -1)
+			perror("pread");
+
+		off -= extent_size;
+	}
+
+	free(buf);
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	struct dio_thread_data data[2];
+	pthread_t thread;
+	int fd;
+
+	if (argc != 4) {
+		fprintf(stderr, "usage: %s SECTORSIZE NUM_EXTENTS PATH\n",
+			argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	extent_size = strtoul(argv[1], NULL, 0);
+	num_extents = strtoul(argv[2], NULL, 0);
+
+	errno = pthread_barrier_init(&barrier, NULL, 2);
+	if (errno) {
+		perror("pthread_barrier_init");
+		return EXIT_FAILURE;
+	}
+
+	fd = open(argv[3], O_RDONLY | O_DIRECT);
+	if (fd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	data[0].fd = fd;
+	data[0].thread_id = 0;
+	errno = pthread_create(&thread, NULL, dio_thread, &data[0]);
+	if (errno) {
+		perror("pthread_create");
+		close(fd);
+		return EXIT_FAILURE;
+	}
+
+	data[1].fd = fd;
+	data[1].thread_id = 1;
+	dio_thread(&data[1]);
+
+	pthread_join(thread, NULL);
+
+	close(fd);
+	return EXIT_SUCCESS;
+}
diff --git a/tests/generic/390 b/tests/generic/390
new file mode 100755
index 0000000..0ef6537
--- /dev/null
+++ b/tests/generic/390
@@ -0,0 +1,76 @@
+#! /bin/bash
+# FS QA Test 390
+#
+# Test two threads doing non-overlapping direct I/O in the same extents.
+# Motivated by a bug in Btrfs' direct I/O get_block function which would lead
+# to spurious -EEXIST failures from direct I/O reads.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Facebook.  All Rights Reserved.
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
+	rm -f "$testfile"
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_xfs_io_command "falloc"
+_require_test_program "dio-interleaved"
+
+extent_size="$(($(stat -f -c '%S' "$TEST_DIR") * 2))"
+num_extents=1024
+testfile="$TEST_DIR/$$-testfile"
+
+truncate -s 0 "$testfile"
+for ((off = 0; off < num_extents * extent_size; off += extent_size)); do
+	xfs_io -c "falloc $off $extent_size" "$testfile"
+done
+
+# To reproduce the Btrfs bug, the extent map must not be cached in memory.
+sync
+echo 3 > /proc/sys/vm/drop_caches
+
+"$here/src/dio-interleaved" "$extent_size" "$num_extents" "$testfile"
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/390.out b/tests/generic/390.out
new file mode 100644
index 0000000..3c7b405
--- /dev/null
+++ b/tests/generic/390.out
@@ -0,0 +1,2 @@
+QA output created by 390
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 08007d7..d137d01 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -392,3 +392,4 @@
 387 auto clone
 388 auto log metadata
 389 auto quick acl
+390 auto quick rw
-- 
2.10.2

