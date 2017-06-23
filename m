Received: from mx1.redhat.com ([209.132.183.28]:59508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753772AbdFWALU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Jun 2017 20:11:20 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic/441: Another SEEK_HOLE/SEEK_DATA sanity test
Date: Fri, 23 Jun 2017 02:11:16 +0200
Message-Id: <1498176676-30021-2-git-send-email-agruenba@redhat.com>
In-Reply-To: <1498176676-30021-1-git-send-email-agruenba@redhat.com>
References: <1498176676-30021-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Both ext4 and xfs have a bug in the page cache scanning code for
SEEK_HOLE / SEEK_DATA in unwritten extents: the start offset isn't taken
into account when scanning a page, so seeking can fail on filesystems
with a block size less than half of the page size.  For example, the
following command fails on a filesystem with a block size of 1k:

  xfs_io -f -c "falloc 0 4k" \
            -c "pwrite 1k 1k" \
            -c "pwrite 3k 1k" \
            -c "seek -a -r 0" foo

Like with generic/436, the actual tests are added to seek_sanity_test.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/seek_sanity_test.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/441      | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/441.out  |  2 ++
 tests/generic/group    |  1 +
 4 files changed, 140 insertions(+)
 create mode 100755 tests/generic/441
 create mode 100644 tests/generic/441.out

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index c9e9366..bf323f2 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -277,6 +277,78 @@ out:
 	return ret;
 }
 
+static int test17(int fd, int testnum)
+{
+	char *buf = NULL;
+	int pagesz = sysconf(_SC_PAGE_SIZE);
+	int bufsz, filsz;
+	int ret = 0;
+
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped\n");
+		goto out;
+	}
+
+	if (pagesz < 4 * alloc_size) {
+		fprintf(stdout, "Test skipped as page size (%d) is less than "
+			"four times allocation size (%d).\n",
+			pagesz, (int)alloc_size);
+		goto out;
+	}
+	bufsz = alloc_size;
+	filsz = 3 * bufsz;
+
+	buf = do_malloc(bufsz);
+	if (!buf) {
+		ret = -1;
+		goto out;
+	}
+	memset(buf, 'a', bufsz);
+
+	ret = do_fallocate(fd, 0, filsz, 0);
+	if (ret < 0) {
+		/* Report success if fs doesn't support fallocate */
+		if (errno == EOPNOTSUPP) {
+			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
+			ret = 0;
+		}
+		goto out;
+	}
+
+	ret = do_pwrite(fd, buf, bufsz, 0);
+	if (ret)
+		goto out;
+
+	ret = do_pwrite(fd, buf, bufsz, 2 * bufsz);
+	if (ret)
+		goto out;
+
+	ret += do_lseek(testnum,  1, fd, filsz, SEEK_DATA, 0, 0);
+	ret += do_lseek(testnum,  2, fd, filsz, SEEK_HOLE, 0, bufsz);
+	ret += do_lseek(testnum,  3, fd, filsz, SEEK_DATA, 1, 1);
+	ret += do_lseek(testnum,  4, fd, filsz, SEEK_HOLE, 1, bufsz);
+	ret += do_lseek(testnum,  5, fd, filsz, SEEK_DATA, bufsz, 2 * bufsz);
+	ret += do_lseek(testnum,  6, fd, filsz, SEEK_HOLE, bufsz, bufsz);
+	ret += do_lseek(testnum,  7, fd, filsz, SEEK_DATA, bufsz + 1, 2 * bufsz);
+	ret += do_lseek(testnum,  8, fd, filsz, SEEK_HOLE, bufsz + 1, bufsz + 1);
+	ret += do_lseek(testnum,  9, fd, filsz, SEEK_DATA, 2 * bufsz, 2 * bufsz);
+	ret += do_lseek(testnum, 10, fd, filsz, SEEK_HOLE, 2 * bufsz, 3 * bufsz);
+	ret += do_lseek(testnum, 11, fd, filsz, SEEK_DATA, 2 * bufsz + 1, 2 * bufsz + 1);
+	ret += do_lseek(testnum, 12, fd, filsz, SEEK_HOLE, 2 * bufsz + 1, 3 * bufsz);
+
+	filsz += bufsz;
+	ret += do_fallocate(fd, 0, filsz, 0);
+
+	ret += do_lseek(testnum, 13, fd, filsz, SEEK_DATA, 3 * bufsz, -1);
+	ret += do_lseek(testnum, 14, fd, filsz, SEEK_HOLE, 3 * bufsz, 3 * bufsz);
+	ret += do_lseek(testnum, 15, fd, filsz, SEEK_DATA, 3 * bufsz + 1, -1);
+	ret += do_lseek(testnum, 16, fd, filsz, SEEK_HOLE, 3 * bufsz + 1, 3 * bufsz + 1);
+
+out:
+	do_free(buf);
+	return ret;
+}
+
 /*
  * test file with unwritten extents, having non-contiguous dirty pages in
  * the unwritten extent.
@@ -912,6 +984,7 @@ struct testrec seek_tests[] = {
        { 14, test14, "Test file with unwritten extents, small hole after pagevec dirty pages" },
        { 15, test15, "Test file with unwritten extents, page after unwritten extent" },
        { 16, test16, "Test file with unwritten extents, non-contiguous dirty pages" },
+       { 17, test17, "Test file with unwritten extents, data-hole-data inside page" },
 };
 
 static int run_test(struct testrec *tr)
diff --git a/tests/generic/441 b/tests/generic/441
new file mode 100755
index 0000000..295ccf4
--- /dev/null
+++ b/tests/generic/441
@@ -0,0 +1,64 @@
+#! /bin/bash
+# FS QA Test 441
+#
+# Another SEEK_DATA/SEEK_HOLE sanity test.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
+tmp=$$
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
+# Disable extent zeroing for ext4 as that change where holes are created
+if [ "$FSTYP" = "ext4" ]; then
+	DEV=`_short_dev $TEST_DEV`
+	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
+fi
+
+_cleanup()
+{
+	rm -f $tmp.* $BASE_TEST_FILE.*
+}
+
+$here/src/seek_sanity_test -s 17 -e 17 $BASE_TEST_FILE > $seqres.full 2>&1 ||
+	_fail "seek sanity check failed!"
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/441.out b/tests/generic/441.out
new file mode 100644
index 0000000..842f9c4
--- /dev/null
+++ b/tests/generic/441.out
@@ -0,0 +1,2 @@
+QA output created by 441
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index ab1e9d3..5046c97 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -443,3 +443,4 @@
 438 auto
 439 auto quick punch
 440 auto quick encrypt
+441 auto quick rw
-- 
2.7.5

