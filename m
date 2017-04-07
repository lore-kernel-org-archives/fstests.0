Received: from mx1.redhat.com ([209.132.183.28]:56178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbdDGH4Z (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Apr 2017 03:56:25 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 3/3] DAX: mmap write readonly file
Date: Fri,  7 Apr 2017 15:56:04 +0800
Message-Id: <1491551764-18779-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1491551764-18779-1-git-send-email-xzhou@redhat.com>
References: <1491551764-18779-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/t_mmap_write_ro.c | 55 +++++++++++++++++++++++++++++
 tests/generic/422     | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/422.out |  3 ++
 tests/generic/group   |  1 +
 6 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_write_ro.c
 create mode 100755 tests/generic/422
 create mode 100644 tests/generic/422.out

diff --git a/.gitignore b/.gitignore
index 1ed2a92..ee9329f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -131,6 +131,7 @@
 /src/renameat2
 /src/t_rename_overwrite
 /src/t_mmap_dio
+/src/t_mmap_write_ro
 
 # dmapi/ binaries
 /dmapi/src/common/cmd/read_invis
diff --git a/src/Makefile b/src/Makefile
index a7f27f0..2604f52 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -12,7 +12,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	godown resvtest writemod makeextents itrash rename \
 	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
 	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
-	holetest t_truncate_self t_mmap_dio
+	holetest t_truncate_self t_mmap_dio t_mmap_write_ro
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_mmap_write_ro.c b/src/t_mmap_write_ro.c
new file mode 100644
index 0000000..cd13f00
--- /dev/null
+++ b/src/t_mmap_write_ro.c
@@ -0,0 +1,55 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <libgen.h>
+#include <sys/mman.h>
+
+int
+main(int argc, char **argv)
+{
+	int fd, pfd, ret;
+	char *buf, foo;
+	int pagesize = getpagesize();
+
+	if (argc < 2) {
+		printf("Usage: %s <file> <pmem file>\n", basename(argv[0]));
+		exit(0);
+	}
+
+	fd = open(argv[1], O_RDONLY|O_DIRECT);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	pfd = open(argv[2], O_RDONLY);
+	if (pfd < 0) {
+		perror("pmem open");
+		exit(1);
+	}
+
+	buf = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, pfd, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* fault in the page */
+	foo = *buf;
+
+	ret = read(fd, buf, pagesize);
+	if (ret != pagesize) {
+		perror("read");
+		exit(1);
+	}
+
+	ret = msync(buf, pagesize, MS_SYNC);
+	if (ret != 0) {
+		perror("msync");
+		exit(1);
+	}
+
+	exit(0);
+}
diff --git a/tests/generic/422 b/tests/generic/422
new file mode 100755
index 0000000..8c75f10
--- /dev/null
+++ b/tests/generic/422
@@ -0,0 +1,98 @@
+#! /bin/bash
+# FS QA Test 422
+#
+# This is a regression test for kernel commit
+#  ef947b2 x86, mm: fix gup_pte_range() vs DAX mappings
+# created by Jeffrey Moyer <jmoyer@redhat.com>
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat.  All Rights Reserved.
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
+	rm -rf $tmp
+	_check_scratch_fs
+	# umount and restore SCRATCH_DEV to original mode
+	_scratch_unmount
+	$NDCTL_PROG create-namespace -f -e $scns -m $scmode \
+	  > /dev/null 2>&1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch_dax
+# We need reconfig SCRATCH_DEV in cleanup, which will
+# corrupt the fs on it. fsck manually in cleanup.
+_require_scratch_nocheck
+_require_ndctl
+_require_jq
+_require_test_program "t_mmap_write_ro"
+_require_xfs_io_command "w"
+_require_user
+
+# real QA test starts here
+mkdir -p $tmp
+chown $qa_user $tmp
+
+# config SCRATCH_DEV to memory mode.
+
+# save original mode
+scmode=$(_ndctl_get_pmem_key_value $SCRATCH_DEV mode)
+
+# get its namespace
+scns=$(_ndctl_get_pmem_key_value $SCRATCH_DEV dev)
+
+# notrun if config fails.
+$NDCTL_PROG create-namespace -f -e $scns -m memory \
+  > /dev/null 2>&1 || _notrun "config $SCRATCH_DEV fail"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o dax"
+
+seq -w 0 1023 > $tmp/input 2>&1
+$XFS_IO_PROG -f -c "w -i $tmp/input 0 4096" \
+  $SCRATCH_MNT/rofile >> $seqres.full 2>&1
+chmod 0644  $SCRATCH_MNT/rofile
+
+_user_do "seq -w 9000 100000 > $tmp/lf 2>&1"
+# read/write should fail.
+_user_do "src/t_mmap_write_ro $tmp/lf $SCRATCH_MNT/rofile"
+# read-only file should not get updated.
+head -1 $SCRATCH_MNT/rofile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/422.out b/tests/generic/422.out
new file mode 100644
index 0000000..68c6db4
--- /dev/null
+++ b/tests/generic/422.out
@@ -0,0 +1,3 @@
+QA output created by 422
+read: Bad address
+0000
diff --git a/tests/generic/group b/tests/generic/group
index 3c7c5e4..d747385 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -424,3 +424,4 @@
 419 auto quick encrypt
 420 auto quick punch
 421 auto quick encrypt dangerous
+422 auto quick
-- 
1.8.3.1

