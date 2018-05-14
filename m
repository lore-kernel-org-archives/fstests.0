Received: from mx2.suse.de ([195.135.220.15]:33632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeENJrU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 May 2018 05:47:20 -0400
From: Jan Kara <jack@suse.cz>
Subject: [PATCH v2] generic/488: Add SEEK_DATA tests for offsets in the middle of holes
Date: Mon, 14 May 2018 11:47:07 +0200
Message-Id: <20180514094707.1360-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

ext4 had a bug for files with indirect extents where it wrongly reported
a size of a hole in some cases and thus SEEK_DATA implementation could
skip some data in a file. Test for that. The problem is fixed by patch
"ext4: Fix hole length detection in ext4_ind_map_blocks()".

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/seek_sanity_test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/488      | 59 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/488.out  |  1 +
 tests/generic/group    |  1 +
 4 files changed, 132 insertions(+)
 create mode 100755 tests/generic/488
 create mode 100644 tests/generic/488.out

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index e82cb1f78671..9245464400e8 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -274,6 +274,75 @@ out:
 	return ret;
 }
 
+/*
+ * Make sure hole size is properly reported when starting in the middle of a
+ * hole in ext? doubly indirect tree
+ */
+static int test20(int fd, int testnum)
+{
+	int ret = -1;
+	char *buf = NULL;
+	loff_t bufsz, filsz;
+
+	bufsz = alloc_size;
+	buf = do_malloc(bufsz);
+	if (!buf)
+		goto out;
+	memset(buf, 'a', bufsz);
+
+	/* Magic size in the middle of ext[23] triple indirect tree */
+	filsz = (12 + bufsz / 4 + 8 * bufsz / 4 * bufsz / 4 + 2 * bufsz / 4 + 5) * bufsz;
+	ret = do_pwrite(fd, buf, bufsz, filsz - bufsz);
+	if (ret)
+		goto out;
+
+	/* Offset inside ext[23] indirect block */
+	ret += do_lseek(testnum, 1, fd, filsz, SEEK_DATA, 14 * bufsz, filsz - bufsz);
+	/* Offset inside ext[23] doubly indirect block */
+	ret += do_lseek(testnum, 2, fd, filsz, SEEK_DATA, (12 + 2 * bufsz / 4) * bufsz, filsz - bufsz);
+	/* Offsets inside ext[23] triply indirect block */
+	ret += do_lseek(testnum, 3, fd, filsz, SEEK_DATA,
+		(12 + bufsz / 4 + bufsz / 4 * bufsz / 4 + 3 * bufsz / 4 + 5) * bufsz, filsz - bufsz);
+	ret += do_lseek(testnum, 3, fd, filsz, SEEK_DATA,
+		(12 + bufsz / 4 + 7 * bufsz / 4 * bufsz / 4 + 5 * bufsz / 4) * bufsz, filsz - bufsz);
+	ret += do_lseek(testnum, 3, fd, filsz, SEEK_DATA,
+		(12 + bufsz / 4 + 8 * bufsz / 4 * bufsz / 4 + bufsz / 4 + 11) * bufsz, filsz - bufsz);
+out:
+	if (buf)
+		free(buf);
+	return ret;
+}
+/*
+ * Make sure hole size is properly reported when starting in the middle of a
+ * hole in ext? indirect tree
+ */
+static int test19(int fd, int testnum)
+{
+	int ret = -1;
+	char *buf = NULL;
+	int bufsz, filsz;
+
+	bufsz = alloc_size;
+	buf = do_malloc(bufsz);
+	if (!buf)
+		goto out;
+	memset(buf, 'a', bufsz);
+
+	/* Magic size just beyond ext[23] indirect tree size */
+	filsz = (12 + bufsz / 4 + 1) * bufsz;
+	ret = do_pwrite(fd, buf, bufsz, filsz - bufsz);
+	if (ret)
+		goto out;
+
+	ret += do_lseek(testnum, 1, fd, filsz, SEEK_DATA, bufsz, filsz - bufsz);
+	ret += do_lseek(testnum, 2, fd, filsz, SEEK_DATA, 12*bufsz, filsz - bufsz);
+	ret += do_lseek(testnum, 3, fd, filsz, SEEK_DATA, (12 + bufsz / 4 - 8)*bufsz, filsz - bufsz);
+out:
+	if (buf)
+		free(buf);
+	return ret;
+}
+
 /* Make sure we get ENXIO if we pass in a negative offset. */
 static int test18(int fd, int testnum)
 {
@@ -982,6 +1051,8 @@ struct testrec seek_tests[] = {
        { 16, test16, "Test file with unwritten extents, non-contiguous dirty pages" },
        { 17, test17, "Test file with unwritten extents, data-hole-data inside page" },
        { 18, test18, "Test file with negative SEEK_{HOLE,DATA} offsets" },
+       { 19, test19, "Test file SEEK_DATA from middle of a large hole" },
+       { 20, test20, "Test file SEEK_DATA from middle of a huge hole" },
 };
 
 static int run_test(struct testrec *tr)
diff --git a/tests/generic/488 b/tests/generic/488
new file mode 100755
index 000000000000..561ccbbc2558
--- /dev/null
+++ b/tests/generic/488
@@ -0,0 +1,59 @@
+#! /bin/bash
+# FS QA Test No. 488
+#
+# Check that SEEK_DATA works properly for offsets in the middle of large holes.
+# This was broken for ext4 with indirect-block based files and this test checks
+# for that. The problem has been fixed by commit 2ee3ee06a8fd79 "ext4: fix hole
+# length detection in ext4_ind_map_blocks()"
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 SUSE.  All Rights Reserved.
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
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+_supported_fs generic
+_supported_os Linux
+
+_require_test
+_require_seek_data_hole
+
+BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
+
+_require_test_program "seek_sanity_test"
+
+_cleanup()
+{
+	eval "rm -f $BASE_TEST_FILE.*"
+}
+
+$here/src/seek_sanity_test -s 19 -e 20 $BASE_TEST_FILE > $seqres.full 2>&1 ||
+	_fail "seek sanity check failed!"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/488.out b/tests/generic/488.out
new file mode 100644
index 000000000000..f7697357b4f5
--- /dev/null
+++ b/tests/generic/488.out
@@ -0,0 +1 @@
+QA output created by 488
diff --git a/tests/generic/group b/tests/generic/group
index dc637c96c264..99c0143ca64b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -490,3 +490,4 @@
 485 auto quick insert
 486 auto quick attr
 487 auto quick
+488 auto quick rw
-- 
2.13.6

