Received: from mx2.suse.de ([195.135.220.15]:57751 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750765AbdEPJuW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 May 2017 05:50:22 -0400
From: Jan Kara <jack@suse.cz>
Subject: [PATCH v3] generic/435: Add more SEEK_HOLE tests
Date: Mon, 15 May 2017 18:08:16 +0200
Message-Id: <20170515160816.21750-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Add tests for bugs found in ext4 & xfs SEEK_HOLE implementations
fixed by following patches:

xfs: Fix missed holes in SEEK_HOLE implementation
ext4: Fix SEEK_HOLE

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/seek_sanity_test.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++--
 tests/generic/435      |  63 ++++++++++++++++++
 tests/generic/435.out  |   1 +
 tests/generic/group    |   1 +
 4 files changed, 237 insertions(+), 5 deletions(-)
 create mode 100755 tests/generic/435
 create mode 100644 tests/generic/435.out

Added one more buggy case found by Brian.

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index a6dd48cc257b..7d63590e9ca3 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -246,6 +246,150 @@ out:
 }
 
 /*
+ * test file with unwritten extents, having page just after end of unwritten
+ * extent.
+ */
+static int test15(int fd, int testnum)
+{
+	int ret = 0;
+	char *buf = NULL;
+	int bufsz = sysconf(_SC_PAGE_SIZE);
+	int filsz = 4 << 20;
+
+	/* HOLE - unwritten DATA in dirty page */
+	/* Each unit is bufsz */
+	buf = do_malloc(bufsz);
+	if (!buf)
+		goto out;
+	memset(buf, 'a', bufsz);
+
+	/* preallocate 4M space to file */
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
+	/* One page written just after end of unwritten extent... */
+	ret = do_pwrite(fd, buf, bufsz, filsz);
+	if (ret)
+		goto out;
+
+	/* offset at the beginning */
+	ret += do_lseek(testnum,  1, fd, filsz, SEEK_HOLE, 0, bufsz);
+	ret += do_lseek(testnum,  2, fd, filsz, SEEK_HOLE, 1, bufsz);
+	ret += do_lseek(testnum,  3, fd, filsz, SEEK_DATA, 0, 0);
+	ret += do_lseek(testnum,  4, fd, filsz, SEEK_DATA, 1, 1);
+	ret += do_lseek(testnum,  5, fd, filsz, SEEK_DATA, bufsz, filsz);
+
+out:
+	do_free(buf);
+	return ret;
+}
+
+/*
+ * test file with unwritten extents, only have pagevec worth of dirty pages
+ * in page cache, a hole and then another page.
+ */
+static int test14(int fd, int testnum)
+{
+	int ret = 0;
+	char *buf = NULL;
+	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
+	int filsz = 4 << 20;
+
+	/* HOLE - unwritten DATA in dirty page */
+	/* Each unit is bufsz */
+	buf = do_malloc(bufsz);
+	if (!buf)
+		goto out;
+	memset(buf, 'a', bufsz);
+
+	/* preallocate 4M space to file */
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
+	ret = do_pwrite(fd, buf, bufsz, 3 * bufsz);
+	if (ret)
+		goto out;
+
+	/* offset at the beginning */
+	ret += do_lseek(testnum,  1, fd, filsz, SEEK_HOLE, 0, bufsz);
+	ret += do_lseek(testnum,  2, fd, filsz, SEEK_HOLE, 1, bufsz);
+	ret += do_lseek(testnum,  3, fd, filsz, SEEK_HOLE, 3 * bufsz, 4 * bufsz);
+	ret += do_lseek(testnum,  4, fd, filsz, SEEK_DATA, 0, 0);
+	ret += do_lseek(testnum,  5, fd, filsz, SEEK_DATA, 1, 1);
+	ret += do_lseek(testnum,  6, fd, filsz, SEEK_DATA, bufsz, 3 * bufsz);
+
+out:
+	do_free(buf);
+	return ret;
+}
+
+/*
+ * test file with unwritten extents, only have pagevec worth of dirty pages
+ * in page cache.
+ */
+static int test13(int fd, int testnum)
+{
+	int ret = 0;
+	char *buf = NULL;
+	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
+	int filsz = 4 << 20;
+
+	/* HOLE - unwritten DATA in dirty page */
+	/* Each unit is bufsz */
+	buf = do_malloc(bufsz);
+	if (!buf)
+		goto out;
+	memset(buf, 'a', bufsz);
+
+	/* preallocate 4M space to file */
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
+	/* offset at the beginning */
+	ret += do_lseek(testnum,  1, fd, filsz, SEEK_HOLE, 0, bufsz);
+	ret += do_lseek(testnum,  2, fd, filsz, SEEK_HOLE, 1, bufsz);
+	ret += do_lseek(testnum,  3, fd, filsz, SEEK_DATA, 0, 0);
+	ret += do_lseek(testnum,  4, fd, filsz, SEEK_DATA, 1, 1);
+
+out:
+	do_free(buf);
+	return ret;
+}
+
+/*
  * Test huge file to check for overflows of block counts due to usage of
  * 32-bit types.
  */
@@ -678,6 +822,9 @@ struct testrec seek_tests[] = {
        { 10, test10, "Test a huge file for offset overflow" },
        { 11, test11, "Test a huge file for block number signed" },
        { 12, test12, "Test a huge file for block number overflow" },
+       { 13, test13, "Test file with unwritten extents, only have pagevec dirty pages" },
+       { 14, test14, "Test file with unwritten extents, small hole after pagevec dirty pages" },
+       { 15, test15, "Test file with unwritten extents, page after unwritten extent" },
 };
 
 static int run_test(struct testrec *tr)
@@ -786,7 +933,7 @@ out:
 
 void usage(char *cmd)
 {
-	fprintf(stdout, "Usage: %s [-t] base_file_path\n", cmd);
+	fprintf(stdout, "Usage: %s [-t] [-s <starttest>] [-e <endtest>] base_file_path\n", cmd);
 	exit(1);
 }
 
@@ -797,12 +944,29 @@ int main(int argc, char **argv)
 	int opt;
 	int check_support = 0;
 	int numtests = sizeof(seek_tests) / sizeof(struct testrec);
+	int teststart = 1, testend = 12;
 
-	while ((opt = getopt(argc, argv, "t")) != -1) {
+	while ((opt = getopt(argc, argv, "ts:e:")) != -1) {
 		switch (opt) {
 		case 't':
 			check_support++;
 			break;
+		case 's':
+			teststart = strtol(optarg, NULL, 10);
+			if (teststart <= 0) {
+				fprintf(stdout, "Invalid starting test: %s\n",
+					optarg);
+				usage(argv[0]);
+			}
+			break;
+		case 'e':
+			testend = strtol(optarg, NULL, 10);
+			if (testend <= 0) {
+				fprintf(stdout, "Invalid final test: %s\n",
+					optarg);
+				usage(argv[0]);
+			}
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -819,9 +983,12 @@ int main(int argc, char **argv)
 		goto out;
 
 	for (i = 0; i < numtests; ++i) {
-		ret = run_test(&seek_tests[i]);
-		if (ret)
-			break;
+		if (seek_tests[i].test_num >= teststart &&
+		    seek_tests[i].test_num <= testend) {
+			ret = run_test(&seek_tests[i]);
+			if (ret)
+				break;
+		}
 	}
 
 out:
diff --git a/tests/generic/435 b/tests/generic/435
new file mode 100755
index 000000000000..2654768c838d
--- /dev/null
+++ b/tests/generic/435
@@ -0,0 +1,63 @@
+#! /bin/bash
+# FS QA Test No. 435
+#
+# More SEEK_DATA/SEEK_HOLE sanity tests.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2011 Oracle Inc.  All Rights Reserved.
+# Copyright (c) 2011 Red Hat.  All Rights Reserved.
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
+# Disable extent zeroing for ext4 as that change where holes are created
+if [ "$FSTYP" = "ext4" ]; then
+	DEV=`_short_dev $TEST_DEV`
+	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
+fi
+
+_cleanup()
+{
+	eval "rm -f $BASE_TEST_FILE.*"
+}
+
+$here/src/seek_sanity_test -s 13 -e 15 $BASE_TEST_FILE > $seqres.full 2>&1 ||
+	_fail "seek sanity check failed!"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/435.out b/tests/generic/435.out
new file mode 100644
index 000000000000..e10caa0f0b5f
--- /dev/null
+++ b/tests/generic/435.out
@@ -0,0 +1 @@
+QA output created by 435
diff --git a/tests/generic/group b/tests/generic/group
index 9fc7f9d419a8..c6628d97af76 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -432,3 +432,4 @@
 427 auto quick aio rw
 428 auto quick
 429 auto encrypt
+435 auto quick rw
-- 
2.12.0

