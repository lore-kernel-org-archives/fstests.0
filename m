Received: from mx1.redhat.com ([209.132.183.28]:50742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbdDJGGI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Apr 2017 02:06:08 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v2 3/3] DAX: mmap write readonly file
Date: Mon, 10 Apr 2017 14:05:53 +0800
Message-Id: <1491804353-1326-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1491804353-1326-1-git-send-email-xzhou@redhat.com>
References: <20170407171600.GA29489@linux.intel.com>
 <1491804353-1326-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Regression case that one can write to read-only
file in a DAX mountpoint.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

v2:
  compile test programme manually in this test because default
cc option -O2 prevents this issue reproduction;
  use md5sum instead of seq numbers to check file consistence;
  umount/check scratch fs after test
  restore SCRATCH_DEV mode in cleanup
  fix variable names

 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/t_mmap_write_ro.c |  56 +++++++++++++++++++++++++
 tests/generic/422     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/422.out |   2 +
 tests/generic/group   |   1 +
 6 files changed, 172 insertions(+), 1 deletion(-)
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
index 0000000..cce6e0d
--- /dev/null
+++ b/src/t_mmap_write_ro.c
@@ -0,0 +1,56 @@
+#define _GNU_SOURCE
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
index 0000000..93e10fe
--- /dev/null
+++ b/tests/generic/422
@@ -0,0 +1,111 @@
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
+	rm -rf $tmp.*
+	rm -f src/t_mmap_write_ro_no_optim
+	# restore SCRATCH_DEV to original mode
+	$NDCTL_PROG create-namespace -f -e $scratch_dev_namespace \
+	  -m $scratch_dev_mode > /dev/null 2>&1
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
+# corrupt the fs on it. fsck manually after tests.
+_require_scratch_nocheck
+_require_ndctl
+_require_jq
+_require_test_program "t_mmap_write_ro"
+_require_user
+
+# real QA test starts here
+
+# config SCRATCH_DEV to memory mode.
+
+# save original mode
+scratch_dev_mode=$(_ndctl_get_pmem_key_value $SCRATCH_DEV mode)
+
+# get its namespace
+scratch_dev_namespace=$(_ndctl_get_pmem_key_value $SCRATCH_DEV dev)
+
+# notrun if config fails.
+$NDCTL_PROG create-namespace -f -e $scratch_dev_namespace \
+  -m memory > /dev/null 2>&1 || \
+  _notrun "config $SCRATCH_DEV fail"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o dax"
+
+# write a 4k read-only file, save its md5sum
+$XFS_IO_PROG -f -c "pwrite -S 0xFFFF 0 4096" \
+  $SCRATCH_MNT/readonlyfile >> $seqres.full 2>&1
+chmod 0644  $SCRATCH_MNT/readonlyfile
+rofile_md5_1="$(_md5_checksum $SCRATCH_MNT/readonlyfile)"
+
+# can't reproduce this issue if cc with -O2 option
+cc src/t_mmap_write_ro.c -o  src/t_mmap_write_ro_no_optim \
+  >> $seqres.full 2>&1
+
+# run test programme, read another larger file writing into
+# the read-only file with mmap.
+_user_do "$XFS_IO_PROG -f -c \"pwrite -S 0x0000 0 40960\" \
+  ${tmp}.largefile > /dev/null 2>&1"
+
+# read/write should fail.
+_user_do "src/t_mmap_write_ro_no_optim ${tmp}.largefile \
+  $SCRATCH_MNT/readonlyfile"
+
+# read-only file should not get updated, md5sum again.
+rofile_md5_2="$(_md5_checksum $SCRATCH_MNT/readonlyfile)"
+
+[ $rofile_md5_1 != $rofile_md5_2 ] && echo "read only file changed"
+
+_scratch_unmount
+_check_scratch_fs
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/422.out b/tests/generic/422.out
new file mode 100644
index 0000000..dc5bca6
--- /dev/null
+++ b/tests/generic/422.out
@@ -0,0 +1,2 @@
+QA output created by 422
+read: Bad address
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

