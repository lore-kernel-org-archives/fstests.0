Received: from mail.kernel.org ([198.145.29.99]:53556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758277AbeD0Qig (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Apr 2018 12:38:36 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] generic: test for seeing unseen fsync errors on newly open files
Date: Fri, 27 Apr 2018 12:38:33 -0400
Message-Id: <20180427163833.21882-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, eguan@redhat.com
Cc: willy@infradead.org, andres@anarazel.de, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

This adds a regression test for the following kernel patch:

    errseq: Always report a writeback error once

This is motivated by some rather odd behavior done by the PostgreSQL
project. The main database writers will offload the fsync calls to a
separate process, which can open files after a writeback error has
already occurred.

This used to work with older kernels that reported the error to only
one fd, but with the errseq_t changes we lost the ability to see
errors that occurred before the open. The above patch restores that
behavior.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---

This patch currently fails on mainline kernels, but I'll be sending
a pull request to Linus in the near future for the above patch.

 src/Makefile               |   2 +-
 src/fsync-open-after-err.c | 167 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999          |  95 ++++++++++++++++++++++++++
 tests/generic/999.out      |   3 +
 tests/generic/group        |   1 +
 5 files changed, 267 insertions(+), 1 deletion(-)
 create mode 100644 src/fsync-open-after-err.c
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/src/Makefile b/src/Makefile
index 0d3feae1eeb2..3dc9b0da9c3a 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -15,7 +15,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
-	t_ofd_locks
+	t_ofd_locks fsync-open-after-err
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/fsync-open-after-err.c b/src/fsync-open-after-err.c
new file mode 100644
index 000000000000..3dcf936eb94a
--- /dev/null
+++ b/src/fsync-open-after-err.c
@@ -0,0 +1,167 @@
+/*
+ * fsync-err.c: test whether writeback errors are reported to all open fds
+ * 		and properly cleared as expected after being seen once on each
+ *
+ * Copyright (c) 2017: Jeff Layton <jlayton@redhat.com>
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <stdbool.h>
+
+/*
+ * btrfs has a fixed stripewidth of 64k, so we need to write enough data to
+ * ensure that we hit both stripes by default.
+ */
+#define DEFAULT_BUFSIZE (65 * 1024)
+
+/* default number of fds to open */
+#define DEFAULT_NUM_FDS	10
+
+bool use_sync_file_range;
+
+static void usage()
+{
+	printf("Usage: fsync-open-after-err [ -b bufsize ] -d dmerror path <filename>\n");
+}
+
+int main(int argc, char **argv)
+{
+	int ret, i, fd1, fd2;
+	char *fname, *buf;
+	char *dmerror_path = NULL;
+	char *cmdbuf;
+	size_t cmdsize, bufsize = DEFAULT_BUFSIZE;
+
+	while ((i = getopt(argc, argv, "b:d:n:sS")) != -1) {
+		switch (i) {
+		case 'b':
+			bufsize = strtol(optarg, &buf, 0);
+			if (*buf != '\0') {
+				printf("bad string conversion: %s\n", optarg);
+				return 1;
+			}
+			break;
+		case 'd':
+			dmerror_path = optarg;
+			break;
+		}
+	}
+
+	if (argc < 1) {
+		usage();
+		return 1;
+	}
+
+	if (!dmerror_path) {
+		printf("Must specify dmerror path with -d option!\n");
+		return 1;
+	}
+
+	/* Remaining argument is filename */
+	fname = argv[optind];
+
+	fd1 = open(fname, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (fd1 < 0) {
+		printf("open of fd1 failed: %m\n");
+		return 1;
+	}
+
+	buf = malloc(bufsize);
+	if (!buf) {
+		printf("malloc failed: %m\n");
+		return 1;
+	}
+
+	/* fill it with some junk */
+	memset(buf, 0x7c, bufsize);
+
+	ret = pwrite(fd1, buf, bufsize, 0);
+	if (ret < 0) {
+		printf("First write on fd1 failed: %m\n");
+		return 1;
+	}
+
+	ret = fsync(fd1);
+	if (ret < 0) {
+		printf("First fsync on fd1 failed: %m\n");
+		return 1;
+	}
+
+	/* enough for path + dmerror command string  (and then some) */
+	cmdsize = strlen(dmerror_path) + 64;
+
+	cmdbuf = malloc(cmdsize);
+	if (!cmdbuf) {
+		printf("malloc failed: %m\n");
+		return 1;
+	}
+
+	ret = snprintf(cmdbuf, cmdsize, "%s load_error_table", dmerror_path);
+	if (ret < 0 || ret >= cmdsize) {
+		printf("sprintf failure: %d\n", ret);
+		return 1;
+	}
+
+	/* flip the device to non-working mode */
+	ret = system(cmdbuf);
+	if (ret) {
+		if (WIFEXITED(ret))
+			printf("system: program exited: %d\n",
+					WEXITSTATUS(ret));
+		else
+			printf("system: 0x%x\n", (int)ret);
+
+		return 1;
+	}
+
+	ret = pwrite(fd1, buf, bufsize, 0);
+	if (ret < 0) {
+		printf("Second write on fd1 failed: %m\n");
+		return 1;
+	}
+
+	/* Ensure writeback occurs, but don't scrape the error */
+	sync();
+
+	/* flip the device to working mode */
+	ret = snprintf(cmdbuf, cmdsize, "%s load_working_table", dmerror_path);
+	if (ret < 0 || ret >= cmdsize) {
+		printf("sprintf failure: %d\n", ret);
+		return 1;
+	}
+
+	ret = system(cmdbuf);
+	if (ret) {
+		if (WIFEXITED(ret))
+			printf("system: program exited: %d\n",
+					WEXITSTATUS(ret));
+		else
+			printf("system: 0x%x\n", (int)ret);
+
+		return 1;
+	}
+
+
+	fd2 = open(fname, O_WRONLY, 0644);
+	if (fd2 < 0) {
+		printf("Open of fd2 failed: %m\n");
+		return 1;
+	}
+
+	/* We now expect an error */
+	ret = fsync(fd2);
+	if (ret >= 0) {
+		printf("Success on fsync on fd2!\n");
+		return 1;
+	}
+
+	printf("Test passed!\n");
+	return 0;
+}
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 000000000000..c46ac4bf3517
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,95 @@
+#! /bin/bash
+# FS QA Test No. XXX
+#
+# Open a file several times, write to it, fsync on all fds and make sure that
+# they all return 0. Change the device to start throwing errors. Write again
+# on all fds and fsync on all fds. Ensure that we get errors on all of them.
+# Then fsync on all one last time and verify that all return 0.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018, Jeff Layton <jlayton@redhat.com>
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
+	cd /
+	rm -rf $tmp.* $testdir
+	_dmerror_cleanup
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmerror
+
+# real QA test starts here
+_supported_os Linux
+_require_scratch
+# This test uses "dm" without taking into account the data could be on
+# realtime subvolume, thus the test will fail with rtinherit=1
+_require_no_rtinherit
+
+# Generally, we want to avoid journal errors on the extended testcase. Only
+# unset the -s flag if we have a logdev
+# case $FSTYP in
+# 	btrfs)
+# 		_notrun "btrfs has a specialized test for this"
+# 		;;
+# 	ext3|ext4|gfs2|xfs)
+# 		# Do the more thorough test if we have a logdev
+# 		_has_logdev && sflag=''
+# 		;;
+# 	*)
+# 		;;
+# esac
+
+_require_dm_target error
+_require_test_program fsync-open-after-err
+_require_test_program dmerror
+
+rm -f $seqres.full
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_dmerror_init
+_dmerror_mount
+
+_require_fs_space $SCRATCH_MNT 65536
+
+testfile=$SCRATCH_MNT/fsync-open-after-err
+
+echo "$here/src/fsync-open-after-err -d $here/src/dmerror $testfile" >> $seqres.full
+$here/src/fsync-open-after-err -d $here/src/dmerror $testfile
+
+# success, all done
+_dmerror_load_working_table
+_dmerror_unmount
+_dmerror_cleanup
+
+# fs may be corrupt after this -- attempt to repair it
+_repair_scratch_fs >> $seqres.full
+
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 000000000000..2e48492ff6d1
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,3 @@
+QA output created by 999
+Format and mount
+Test passed!
diff --git a/tests/generic/group b/tests/generic/group
index ea8e51b35e79..48f491a5c32b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -486,3 +486,4 @@
 481 auto quick log metadata
 482 auto metadata replay
 483 auto quick log metadata
+999 auto quick
-- 
2.14.3

