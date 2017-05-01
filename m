Received: from imap.thunk.org ([74.207.234.97]:35046 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2992521AbdEAA4o (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 30 Apr 2017 20:56:44 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] src: fix compiler warnings
Date: Sun, 30 Apr 2017 20:56:37 -0400
Message-Id: <20170501005637.32347-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Most of the fixes are printf format type warnings, but apparently GCC
6 is smart enough to realize is that if you don't do proper error
checking with posix_memalign, the resulting pointer can be undefined,
and whines about it.  So while fixing this in aio-dio-fcntl-race, I
also cleaned up the error checking and reporting.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/aio-dio-regress/aio-dio-eof-race.c   |  3 ++-
 src/aio-dio-regress/aio-dio-fcntl-race.c | 32 +++++++++++++++++++++++---------
 src/dio-invalidate-cache.c               |  6 ++++--
 src/holetest.c                           |  8 ++++----
 src/t_rename_overwrite.c                 |  3 ++-
 5 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/src/aio-dio-regress/aio-dio-eof-race.c b/src/aio-dio-regress/aio-dio-eof-race.c
index bd71b030..67c0b2de 100644
--- a/src/aio-dio-regress/aio-dio-eof-race.c
+++ b/src/aio-dio-regress/aio-dio-eof-race.c
@@ -202,7 +202,8 @@ int main(int argc, char *argv[])
 		 * a seamless buf_size worth of IO_PATTERN to the last block.
 		 */
 		if (memcmp(buf, cmp_buf, buf_size)) {
-			printf("corruption while extending from %ld\n", eof);
+			printf("corruption while extending from %lld\n",
+			       (unsigned long long) eof);
 			dump_buffer(buf, 0, buf_size);
 			return 1;
 		}
diff --git a/src/aio-dio-regress/aio-dio-fcntl-race.c b/src/aio-dio-regress/aio-dio-fcntl-race.c
index cdf97736..88a27472 100644
--- a/src/aio-dio-regress/aio-dio-fcntl-race.c
+++ b/src/aio-dio-regress/aio-dio-fcntl-race.c
@@ -92,12 +92,16 @@ int main(int argc, char **argv)
 		return 1;
 	}
 	fd = open(argv[1], O_CREAT | O_TRUNC | O_RDWR, 0600);
-	if (fd < 0)
+	if (fd < 0) {
+		perror("open");
 		return 1;
+	}
 
 	pid1 = fork();
-	if (pid1 < 0)
+	if (pid1 < 0) {
+		perror("fork");
 		return 1;
+	}
 
 	if (pid1 == 0) {
 		struct timeval start, now, delta = { 0, 0 };
@@ -108,12 +112,15 @@ int main(int argc, char **argv)
 		flags = fcntl(fd, F_GETFL);
 		while (1) {
 			ret = fcntl(fd, F_SETFL, flags | O_DIRECT);
-			if (ret)
-				return ret;
+			if (ret) {
+				perror("fcntl O_DIRECT");
+				return 1;
+			}
 			ret = fcntl(fd, F_SETFL, flags);
-			if (ret)
-				return ret;
-
+			if (ret) {
+				perror("fcntl");
+				return 1;
+			}
 			gettimeofday(&now, NULL);
 			timersub(&now, &start, &delta);
 			if (delta.tv_sec >= LOOP_SECONDS)
@@ -121,8 +128,15 @@ int main(int argc, char **argv)
 		}
 	} else {
 		/* parent: AIO */
-		void *buf;
-		posix_memalign(&buf, BUF_SIZE, BUF_SIZE);
+		void *buf = NULL;
+		int err;
+
+		err = posix_memalign(&buf, BUF_SIZE, BUF_SIZE);
+		if (err || buf == NULL) {
+			fprintf(stderr, "posix_memalign failed: %s\n",
+				strerror(err));
+			exit(1);
+		}
 		/* Two tasks which performs unaligned aio will be serialized
 		   which maks race window wider */
 		pid2 = fork();
diff --git a/src/dio-invalidate-cache.c b/src/dio-invalidate-cache.c
index 4c40c87d..004588ab 100644
--- a/src/dio-invalidate-cache.c
+++ b/src/dio-invalidate-cache.c
@@ -160,7 +160,8 @@ static int run_test(const char *filename, int n_child, int blksz, off_t offset,
 	/* seek, write, read and verify */
 	for (i = 0; i < nr_iter; i++) {
 		memset(buf_wr, i + 1, blksz);
-		log("pwrite(fd_wr, %p, %d, %lu)\n", buf_wr, blksz, seekoff);
+		log("pwrite(fd_wr, %p, %d, %llu)\n", buf_wr, blksz,
+		    (unsigned long long) seekoff);
 		if (pwrite(fd_wr, buf_wr, blksz, seekoff) != blksz) {
 			perror("direct write");
 			exit(EXIT_FAILURE);
@@ -174,7 +175,8 @@ static int run_test(const char *filename, int n_child, int blksz, off_t offset,
 			}
 		}
 
-		log("pread(fd_rd, %p, %d, %lu)\n", buf_rd, blksz, seekoff);
+		log("pread(fd_rd, %p, %d, %llu)\n", buf_rd, blksz,
+		    (unsigned long long) seekoff);
 		if (pread(fd_rd, buf_rd, blksz, seekoff) != blksz) {
 			perror("buffer read");
 			exit(EXIT_FAILURE);
diff --git a/src/holetest.c b/src/holetest.c
index edd85fe7..1939b35f 100644
--- a/src/holetest.c
+++ b/src/holetest.c
@@ -101,10 +101,10 @@ int verify_mapping(char *vastart, long npages, uint64_t *expect)
 		for (i = 0; i < THREADS; i++) {
 			if (*(uint64_t*)(va + page_offs[i]) != expect[i]) {
 				printf("ERROR: thread %d, "
-				       "offset %08lx, %08lx != %08lx\n", i,
-				       (va + page_offs[i] - vastart),
-				       *(uint64_t*)(va + page_offs[i]),
-				       expect[i]);
+				       "offset %08llx, %08llx != %08llx\n", i,
+				       (unsigned long long) (va + page_offs[i] - vastart),
+				       (unsigned long long) *(uint64_t*)(va + page_offs[i]),
+				       (unsigned long long) expect[i]);
 				errcnt++;
 			}
 		}
diff --git a/src/t_rename_overwrite.c b/src/t_rename_overwrite.c
index fe17f9d5..c5cdd1db 100644
--- a/src/t_rename_overwrite.c
+++ b/src/t_rename_overwrite.c
@@ -31,7 +31,8 @@ int main(int argc, char *argv[])
 		err(1, "fstat(%i)", fd);
 
 	if (stbuf.st_nlink != 0) {
-		fprintf(stderr, "nlink is %lu, should be 0\n", stbuf.st_nlink);
+		fprintf(stderr, "nlink is %lu, should be 0\n",
+			(unsigned long) stbuf.st_nlink);
 		return 1;
 	}
 
-- 
2.11.0.rc0.7.gbe5a750

