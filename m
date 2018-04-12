Received: from mail-pf0-f193.google.com ([209.85.192.193]:37327 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeDLFHi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Apr 2018 01:07:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id p6so2638790pfn.4
        for <fstests@vger.kernel.org>; Wed, 11 Apr 2018 22:07:37 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 1/2] aio-dio-eof-race: handle aio pwrite errors and short reads
Date: Wed, 11 Apr 2018 22:07:28 -0700
Message-Id: <d928f86c748db034ca4efd849e01c5c2bf805199.1523509644.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

generic/427 fails on Btrfs with a cryptic "pread: Success" message. This
is because an aio pwrite fails with ENOSPC, so the file isn't as long as
we expect it to be. Make sure we check the result of the aio writes and
also print a more explicit message for short reads (which are
technically valid but in practice shouldn't happen for this test case).
Now the test fails with a much more informative "pwrite: No space left
on device".

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 src/aio-dio-regress/aio-dio-eof-race.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/aio-dio-regress/aio-dio-eof-race.c b/src/aio-dio-regress/aio-dio-eof-race.c
index bb1890b5..04479035 100644
--- a/src/aio-dio-regress/aio-dio-eof-race.c
+++ b/src/aio-dio-regress/aio-dio-eof-race.c
@@ -154,6 +154,9 @@ int main(int argc, char *argv[])
 
 	/* Keep extending until size_MB */
 	while (eof < size_MB * 1024 * 1024) {
+		ssize_t sret;
+		int i;
+
 		memset(buf, IO_PATTERN, buf_size);
 		fstat(fd, &statbuf);
 		eof = statbuf.st_size;
@@ -186,15 +189,32 @@ int main(int argc, char *argv[])
 			return 1;
 		}
 
+		for (i = 0; i < err; i++) {
+			/*
+			 * res is unsigned for some reason, so this is the best
+			 * way to detect that it contains a negative errno.
+			 */
+			if (evs[i].res > buf_size / 4) {
+				fprintf(stderr, "pwrite: %s\n",
+					strerror(-evs[i].res));
+				return 1;
+			}
+		}
+
 		/*
 		 * And then read it back.
 		 *
 		 * Using pread to keep it simple, but AIO has the same effect.
 		 * eof is the prior eof; we just wrote buf_size more.
 		 */
-		if (pread(fd, buf, buf_size, eof) != buf_size) {
+		sret = pread(fd, buf, buf_size, eof);
+		if (sret == -1) {
 			perror("pread");
 			return 1;
+		} else if (sret != buf_size) {
+			fprintf(stderr, "short read %zd was less than %zu\n",
+				sret, buf_size);
+			return 1;
 		}
 
 		/*
-- 
2.17.0

