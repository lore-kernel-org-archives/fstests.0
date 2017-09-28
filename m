Received: from mx1.redhat.com ([209.132.183.28]:33290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbdI1HmA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Sep 2017 03:42:00 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v6 3/4] generic: mmap write readonly DAX file
Date: Thu, 28 Sep 2017 15:41:39 +0800
Message-Id: <1506584500-867-4-git-send-email-xzhou@redhat.com>
In-Reply-To: <1506584500-867-1-git-send-email-xzhou@redhat.com>
References: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
 <1506584500-867-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Regression case that one can write to read-only
file in a DAX mountpoint.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/t_mmap_write_ro.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/461     | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/461.out |  2 ++
 tests/generic/group   |  1 +
 6 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_write_ro.c
 create mode 100755 tests/generic/461
 create mode 100644 tests/generic/461.out

diff --git a/.gitignore b/.gitignore
index 73ab533..cf5d91e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -137,6 +137,7 @@
 /src/t_mmap_dio
 /src/t_mmap_fallocate
 /src/t_mmap_stale_pmd
+/src/t_mmap_write_ro
 /src/t_mmap_writev
 /src/t_mtab
 /src/t_readdir_1
diff --git a/src/Makefile b/src/Makefile
index 7d1306b..3eb25b1 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,7 +13,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
 	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
-	t_mmap_cow_race t_mmap_fallocate fsync-err
+	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_mmap_write_ro.c b/src/t_mmap_write_ro.c
new file mode 100644
index 0000000..1a0ee71
--- /dev/null
+++ b/src/t_mmap_write_ro.c
@@ -0,0 +1,81 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <libgen.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+void
+err_exit(char *op)
+{
+	fprintf(stderr, "%s: %s\n", op, strerror(errno));
+	exit(1);
+}
+
+int
+main(int argc, char **argv)
+{
+	int fd, pfd, ret;
+	char *buf;
+	/*
+	 * gcc -O2 will optimize foo's storage, prevent reproducing
+	 * this issue.
+	 * foo is never actually used after fault in value stored.
+	 */
+	volatile char foo __attribute__((__unused__));
+	int pagesize = getpagesize();
+
+	if (argc < 3) {
+		printf("Usage: %s <file> <pmem file>\n", basename(argv[0]));
+		exit(0);
+	}
+
+	/*
+	 * This O_DIRECT is necessary for reproduce this bug.
+	 */
+	fd = open(argv[1], O_RDONLY|O_DIRECT);
+	if (fd < 0)
+		err_exit("open");
+
+	pfd = open(argv[2], O_RDONLY);
+	if (pfd < 0)
+		err_exit("pmem open");
+
+	buf = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, pfd, 0);
+	if (buf == MAP_FAILED)
+		err_exit("mmap");
+
+	/*
+	 * Read from the DAX mmap to populate the first page in the
+	 * address_space with a read-only mapping.
+	 */
+	foo = *buf;
+
+	/*
+	 * Now write to the DAX mmap.  This *should* fail, but if the bug is
+	 * present in __get_user_pages_fast(), it will succeed.
+	 */
+	ret = read(fd, buf, pagesize);
+	if (ret != pagesize)
+		err_exit("read");
+
+	ret = msync(buf, pagesize, MS_SYNC);
+	if (ret != 0)
+		err_exit("msync");
+
+	ret = munmap(buf, pagesize);
+	if (ret < 0)
+		err_exit("munmap");
+
+	ret = close(fd);
+	if (ret < 0)
+		err_exit("clsoe fd");
+
+	ret = close(pfd);
+	if (ret < 0)
+		err_exit("close pfd");
+
+	exit(0);
+}
diff --git a/tests/generic/461 b/tests/generic/461
new file mode 100755
index 0000000..b988135
--- /dev/null
+++ b/tests/generic/461
@@ -0,0 +1,95 @@
+#! /bin/bash
+# FS QA Test 461
+#
+# This is a regression test for kernel commit
+#  ef947b2 x86, mm: fix gup_pte_range() vs DAX mappings
+# created by Jeffrey Moyer <jmoyer@redhat.com>
+#
+# This is reproducible only when testing on pmem device
+# which is configured in "memory mode", not in "raw mode".
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
+_require_test
+_require_scratch_dax
+_require_test_program "t_mmap_write_ro"
+# running by unpriviliged user is not necessary to reproduce
+# this bug, just trying to test more.
+_require_user
+
+# real QA test starts here
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o dax"
+
+# remount TEST_DEV wo/ dax
+export TEST_FS_MOUNT_OPTS=""
+_test_cycle_mount
+
+# prepare a 4k read-only DAX file, save its md5sum
+$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
+	$SCRATCH_MNT/readonlyfile >> $seqres.full 2>&1
+chmod 0644  $SCRATCH_MNT/readonlyfile
+md5_1="$(_md5_checksum $SCRATCH_MNT/readonlyfile)"
+
+# prepare another 4k non-DAX file
+$XFS_IO_PROG -f -c "pwrite -S 0x00 0 4096" \
+	$TEST_DIR/${seq}.file >> $seqres.full 2>&1
+
+# allow qa_user access
+chown $qa_user $TEST_DIR/${seq}.file
+
+# run test programme, read another file writing into
+# the read-only file with mmap, which should fail.
+_user_do "src/t_mmap_write_ro $TEST_DIR/${seq}.file \
+	$SCRATCH_MNT/readonlyfile"
+
+# read-only file should not get updated, md5sum again.
+md5_2="$(_md5_checksum $SCRATCH_MNT/readonlyfile)"
+
+[ "$md5_1" != "$md5_2" ] && echo "read only file changed"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/461.out b/tests/generic/461.out
new file mode 100644
index 0000000..8b1e29c
--- /dev/null
+++ b/tests/generic/461.out
@@ -0,0 +1,2 @@
+QA output created by 461
+read: Bad address
diff --git a/tests/generic/group b/tests/generic/group
index 0d42d54..28df131 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -463,3 +463,4 @@
 458 auto quick clone
 459 auto dangerous
 460 auto quick rw
+461 auto quick dax
-- 
1.8.3.1

