Received: from mx1.redhat.com ([209.132.183.28]:48104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbdFWNcR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Jun 2017 09:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 994641E33C
        for <fstests@vger.kernel.org>; Fri, 23 Jun 2017 13:32:16 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] src/seek_sanity_test: Fix for filesystems without unwritten extent support
Date: Fri, 23 Jun 2017 15:32:14 +0200
Message-Id: <1498224734-32621-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, 'Eryu Guan ' <eguan@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

src/seek_sanity_test assumes that after preallocating space in a file
with fallocate, fseek SEEK_HOLE / SEEK_DATA will still report the
allocated space as a hole.  On filesystems without unwritten extent
support, that space will be reported as data, though.  On such
filesystems, skip the unwritten extent tests.

Tested on ext4, xfs, and gfs2 + patches for fseek SEEK_HOLE / SEEK_DATA
support.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/seek_sanity_test.c | 130 ++++++++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 95984b6..a58ec36 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -37,6 +37,7 @@
 
 static blksize_t alloc_size;
 int default_behavior = 0;
+int unwritten_extents = 0;
 char *base_file_path;
 
 static void get_file_system(int fd)
@@ -128,13 +129,9 @@ static int do_fallocate(int fd, off_t offset, off_t length, int mode)
 	int ret;
 
 	ret = fallocate(fd, mode, offset, length);
-	if (ret) {
-		/* Don't warn about a filesystem w/o fallocate support */
-		if (errno == EOPNOTSUPP)
-			return ret;
+	if (ret)
 		fprintf(stderr, "  ERROR %d: Failed to preallocate "
 			"space to %ld bytes\n", errno, (long) length);
-	}
 
 	return ret;
 }
@@ -284,6 +281,11 @@ static int test17(int fd, int testnum)
 	int bufsz, filsz;
 	int ret = 0;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped as fs doesn't support unwritten extents.\n");
+		goto out;
+	}
+
 	if (pagesz < 4 * alloc_size) {
 		fprintf(stdout, "Test skipped as page size (%d) is less than "
 			"four times allocation size (%d).\n",
@@ -301,14 +303,8 @@ static int test17(int fd, int testnum)
 	memset(buf, 'a', bufsz);
 
 	ret = do_fallocate(fd, 0, filsz, 0);
-	if (ret < 0) {
-		/* Report success if fs doesn't support fallocate */
-		if (errno == EOPNOTSUPP) {
-			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
-			ret = 0;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = do_pwrite(fd, buf, bufsz, 0);
 	if (ret)
@@ -355,6 +351,11 @@ static int test16(int fd, int testnum)
 	int bufsz = sysconf(_SC_PAGE_SIZE);
 	int filsz = 4 << 20;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped as fs doesn't support unwritten extents.\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -364,14 +365,8 @@ static int test16(int fd, int testnum)
 
 	/* preallocate 4M space to file */
 	ret = do_fallocate(fd, 0, filsz, 0);
-	if (ret < 0) {
-		/* Report success if fs doesn't support fallocate */
-		if (errno == EOPNOTSUPP) {
-			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
-			ret = 0;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = do_pwrite(fd, buf, bufsz, 0);
 	if (ret)
@@ -406,6 +401,11 @@ static int test15(int fd, int testnum)
 	int bufsz = sysconf(_SC_PAGE_SIZE);
 	int filsz = 4 << 20;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped as fs doesn't support unwritten extents.\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -415,14 +415,8 @@ static int test15(int fd, int testnum)
 
 	/* preallocate 4M space to file */
 	ret = do_fallocate(fd, 0, filsz, 0);
-	if (ret < 0) {
-		/* Report success if fs doesn't support fallocate */
-		if (errno == EOPNOTSUPP) {
-			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
-			ret = 0;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = do_pwrite(fd, buf, bufsz, 0);
 	if (ret)
@@ -459,6 +453,11 @@ static int test14(int fd, int testnum)
 	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
 	int filsz = 4 << 20;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped as fs doesn't support unwritten extents.\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -468,14 +467,8 @@ static int test14(int fd, int testnum)
 
 	/* preallocate 4M space to file */
 	ret = do_fallocate(fd, 0, filsz, 0);
-	if (ret < 0) {
-		/* Report success if fs doesn't support fallocate */
-		if (errno == EOPNOTSUPP) {
-			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
-			ret = 0;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = do_pwrite(fd, buf, bufsz, 0);
 	if (ret)
@@ -509,6 +502,11 @@ static int test13(int fd, int testnum)
 	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
 	int filsz = 4 << 20;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped as fs doesn't support unwritten extents.\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -518,14 +516,8 @@ static int test13(int fd, int testnum)
 
 	/* preallocate 4M space to file */
 	ret = do_fallocate(fd, 0, filsz, 0);
-	if (ret < 0) {
-		/* Report success if fs doesn't support fallocate */
-		if (errno == EOPNOTSUPP) {
-			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
-			ret = 0;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = do_pwrite(fd, buf, bufsz, 0);
 	if (ret)
@@ -579,6 +571,11 @@ static int test09(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = bufsz * 100 + bufsz;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped as fs doesn't support unwritten extents.\n");
+		goto out;
+	}
+
 	/*
 	 * HOLE - unwritten DATA in dirty page - HOLE -
 	 * unwritten DATA in writeback page
@@ -592,14 +589,8 @@ static int test09(int fd, int testnum)
 
 	/* preallocate 8M space to file */
 	ret = do_fallocate(fd, 0, filsz, 0);
-	if (ret < 0) {
-		/* Report success if fs doesn't support fallocate */
-		if (errno == EOPNOTSUPP) {
-			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
-			ret = 0;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = do_pwrite(fd, buf, bufsz, bufsz * 10);
 	if (!ret) {
@@ -635,6 +626,11 @@ static int test08(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = bufsz * 10 + bufsz;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped as fs doesn't support unwritten extents.\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in writeback page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -644,14 +640,8 @@ static int test08(int fd, int testnum)
 
 	/* preallocate 4M space to file */
 	ret = do_fallocate(fd, 0, filsz, 0);
-	if (ret < 0) {
-		/* Report success if fs doesn't support fallocate */
-		if (errno == EOPNOTSUPP) {
-			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
-			ret = 0;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = do_pwrite(fd, buf, bufsz, bufsz * 10);
 	if (ret)
@@ -684,6 +674,11 @@ static int test07(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = bufsz * 10 + bufsz;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped as fs doesn't support unwritten extents.\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -693,14 +688,8 @@ static int test07(int fd, int testnum)
 
 	/* preallocate 4M space to file */
 	ret = do_fallocate(fd, 0, filsz, 0);
-	if (ret < 0) {
-		/* Report success if fs doesn't support fallocate */
-		if (errno == EOPNOTSUPP) {
-			fprintf(stdout, "Test skipped as fs doesn't support fallocate.\n");
-			ret = 0;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = do_pwrite(fd, buf, bufsz, bufsz * 10);
 	if (ret)
@@ -1050,6 +1039,25 @@ static int test_basic_support(void)
 		fprintf(stderr, "File system supports the default behavior.\n");
 	}
 
+	ftruncate(fd, 0);
+	if (fallocate(fd, 0, 0, alloc_size) == -1) {
+		if (errno == EOPNOTSUPP)
+			fprintf(stderr, "File system does not support fallocate.");
+		else {
+			fprintf(stderr, "ERROR %d: Failed to preallocate "
+				"space to %ld bytes. Aborting.\n", errno, (long) alloc_size);
+			ret = -1;
+		}
+		goto out;
+	}
+
+	pos = lseek(fd, 0, SEEK_DATA);
+	if (pos == 0) {
+		fprintf(stderr, "File system does not support unwritten extents.\n");
+		goto out;
+	}
+	unwritten_extents = 1;
+
 	printf("\n");
 
 out:
-- 
2.7.5

