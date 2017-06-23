Received: from mx1.redhat.com ([209.132.183.28]:44724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753772AbdFWALT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Jun 2017 20:11:19 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] seek_sanity_test: Report the actual allocation size
Date: Fri, 23 Jun 2017 02:11:15 +0200
Message-Id: <1498176676-30021-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Instead of reporting the preferred block size for I/O as returned by
stat(2) as the allocation size, report the actual allocation size.
Clean things up a little in the process.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/seek_sanity_test.c | 84 ++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 064a8fa..c9e9366 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -51,19 +51,51 @@ static void get_file_system(int fd)
 
 static int get_io_sizes(int fd)
 {
-       struct stat buf;
-       int ret;
+	off_t pos = 0, offset = 1;
+	struct stat buf;
+	int shift, ret;
 
-       ret = fstat(fd, &buf);
-       if (ret)
-               fprintf(stderr, "  ERROR %d: Failed to find io blocksize\n",
-                       errno);
+	ret = fstat(fd, &buf);
+	if (ret) {
+		fprintf(stderr, "  ERROR %d: Failed to find io blocksize\n",
+			errno);
+		return ret;
+	}
 
-       /* st_blksize is typically also the allocation size */
-       alloc_size = buf.st_blksize;
-       fprintf(stdout, "Allocation size: %ld\n", alloc_size);
+	/* st_blksize is typically also the allocation size */
+	alloc_size = buf.st_blksize;
 
-       return ret;
+	/* try to discover the actual alloc size */
+	while (pos == 0 && offset < alloc_size) {
+		offset <<= 1;
+		ftruncate(fd, 0);
+		pwrite(fd, "a", 1, offset);
+		pos = lseek(fd, 0, SEEK_DATA);
+		if (pos == -1)
+			goto fail;
+	}
+
+	/* bisect */
+	shift = offset >> 2;
+	while (shift && offset < alloc_size) {
+		ftruncate(fd, 0);
+		pwrite(fd, "a", 1, offset);
+		pos = lseek(fd, 0, SEEK_DATA);
+		if (pos == -1)
+			goto fail;
+		offset += pos ? -shift : shift;
+		shift >>= 1;
+	}
+	if (!shift)
+		offset += pos ? 0 : 1;
+	alloc_size = offset;
+	fprintf(stdout, "Allocation size: %ld\n", alloc_size);
+	return 0;
+
+fail:
+	fprintf(stderr, "Kernel does not support llseek(2) extension "
+		"SEEK_DATA. Aborting.\n");
+	return -1;
 }
 
 #define do_free(x)     do { if(x) free(x); } while(0);
@@ -902,8 +934,8 @@ static int run_test(struct testrec *tr)
 
 static int test_basic_support(void)
 {
-	int ret = -1, fd, shift;
-	off_t pos = 0, offset = 1;
+	int ret = -1, fd;
+	off_t pos;
 	char *buf = NULL;
 	int bufsz, filsz;
 
@@ -917,34 +949,6 @@ static int test_basic_support(void)
 	if (ret)
 		goto out;
 
-	/* try to discover the actual alloc size */
-	while (pos == 0 && offset < alloc_size) {
-		offset <<= 1;
-		ftruncate(fd, 0);
-		pwrite(fd, "a", 1, offset);
-		pos = lseek(fd, 0, SEEK_DATA);
-	}
-
-	/* bisect */
-	shift = offset >> 2;
-	while (shift && offset < alloc_size) {
-		ftruncate(fd, 0);
-		pwrite(fd, "a", 1, offset);
-		pos = lseek(fd, 0, SEEK_DATA);
-		offset += pos ? -shift : shift;
-		shift >>= 1;
-	}
-	if (!shift)
-		offset += pos ? 0 : 1;
-	alloc_size = offset;
-
-	if (pos == -1) {
-		fprintf(stderr, "Kernel does not support llseek(2) extension "
-			"SEEK_DATA. Aborting.\n");
-		ret = -1;
-		goto out;
-	}
-
 	ftruncate(fd, 0);
 	bufsz = alloc_size * 2;
 	filsz = bufsz * 2;
-- 
2.7.5

