Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:44280 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbaHPNNe (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Aug 2014 09:13:34 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 5/6] src/e4compact: add sparse file optimization
Date: Sat, 16 Aug 2014 17:13:10 +0400
Message-Id: <1408194791-1797-5-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>


Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 src/e4compact.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/src/e4compact.c b/src/e4compact.c
index 314c329..a0f216b 100644
--- a/src/e4compact.c
+++ b/src/e4compact.c
@@ -16,6 +16,8 @@
 #include <ctype.h>
 #include <limits.h>
 #include <errno.h>
+#include <linux/fs.h>
+#include <linux/fiemap.h>
 #include <linux/types.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
@@ -40,6 +42,7 @@ struct move_extent {
 
 #define EXT4_IOC_MOVE_EXT      _IOWR('f', 15, struct move_extent)
 #endif
+#define EXTENT_MAX_COUNT        512
 
 struct donor_info
 {
@@ -50,11 +53,12 @@ struct donor_info
 
 static int ignore_error = 0;
 static int verbose = 0;
+static int do_sparse = 0;
 static unsigned blk_per_pg;
 static unsigned blk_sz;
 
-
-static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor_info *donor)
+static int do_defrag_range(int fd, char *name,__u64 start, __u64 len,
+			   struct donor_info *donor)
 {
 	int ret, retry;
 	struct move_extent mv_ioc;
@@ -119,10 +123,64 @@ static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor
 	return ret;
 }
 
+static int do_defrag_sparse(int fd, char *name,__u64 start, __u64 len,
+			    struct donor_info *donor)
+{
+	int i, ret = 0;
+	struct fiemap	*fiemap_buf = NULL;
+	struct fiemap_extent	*ext_buf = NULL;
+
+	fiemap_buf = malloc(EXTENT_MAX_COUNT * sizeof(struct fiemap_extent)
+			    + sizeof(struct fiemap));
+	if (fiemap_buf == NULL) {
+		fprintf(stderr, "%s Can not allocate memory\n", __func__);
+		return -1;
+	}
+	ext_buf = fiemap_buf->fm_extents;
+	memset(fiemap_buf, 0, sizeof(struct fiemap));
+	fiemap_buf->fm_flags |= FIEMAP_FLAG_SYNC;
+	fiemap_buf->fm_extent_count = EXTENT_MAX_COUNT;
+
+	do {
+		__u64 next;
+
+		fiemap_buf->fm_start = start * blk_sz;
+		fiemap_buf->fm_length = len * blk_sz;
+		ret = ioctl(fd, FS_IOC_FIEMAP, fiemap_buf);
+		if (ret < 0 || fiemap_buf->fm_mapped_extents == 0) {
+			fprintf(stderr, "%s Can get extent info for %s ret:%d mapped:%d",
+				__func__, name, ret, fiemap_buf->fm_mapped_extents);
+			goto out;
+		}
+		for (i = 0; i < fiemap_buf->fm_mapped_extents; i++) {
+			ret = do_defrag_range(fd, name,
+					      ext_buf[i].fe_logical / blk_sz,
+					      ext_buf[i].fe_length / blk_sz,
+					      donor);
+			if (ret)
+				goto out;
+		}
+		next = (ext_buf[fiemap_buf->fm_mapped_extents -1].fe_logical +
+			   ext_buf[fiemap_buf->fm_mapped_extents -1].fe_length) /
+			blk_sz;
+		if (next <  start + len) {
+			len -= next  - start;
+			start = next;
+		} else
+			break;
+
+	} while (fiemap_buf->fm_mapped_extents == EXTENT_MAX_COUNT &&
+		 !(ext_buf[EXTENT_MAX_COUNT-1].fe_flags & FIEMAP_EXTENT_LAST));
+out:
+	free(fiemap_buf);
+	return ret;
+}
+
 void usage()
 {
 	printf("Usage: -f donor_file [-o donor_offset] [-v] [-i]\n"
 	       "\t\t -v: verbose\n"
+	       "\t\t -s: enable sparse file optimization\n"
 	       "\t\t -i: ignore errors\n");
 }
 
@@ -138,9 +196,10 @@ int main(int argc, char **argv)
 	extern int optind;
 	int c;
 	char * donor_name = NULL;
+	__u64 eof_blk;
 
 	donor.offset = 0;
-	while ((c = getopt(argc, argv, "f:o:iv")) != -1) {
+	while ((c = getopt(argc, argv, "f:o:isv")) != -1) {
 		switch (c) {
 		case 'o':
 			donor.offset = atol(optarg);
@@ -151,6 +210,9 @@ int main(int argc, char **argv)
 		case 'v':
 			verbose = 1;
 			break;
+		case 's':
+			do_sparse = 1;
+			break;
 		case 'f':
 			donor_name = (optarg);
 			break;
@@ -207,13 +269,17 @@ int main(int argc, char **argv)
 				break;
 
 		}
-		if (st.st_size && st.st_blocks) {
-			ret = do_defrag_one(fd, line, 0,
-					    (st.st_size  + blk_sz-1)/ blk_sz,
-					    &donor);
-			if (ret && !ignore_error)
-				break;
-		}
+		if (!(st.st_size && st.st_blocks))
+			continue;
+
+		eof_blk = (st.st_size + blk_sz-1) / blk_sz;
+		if (do_sparse)
+			ret = do_defrag_sparse(fd, line, 0, eof_blk, &donor);
+		else
+			ret = do_defrag_range(fd, line, 0, eof_blk, &donor);
+		if (ret && !ignore_error)
+			break;
+
 	}
 	free(line);
 	return ret;
-- 
1.7.1

