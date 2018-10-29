Received: from mail.kernel.org ([198.145.29.99]:50202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbeJ2Sbi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Oct 2018 14:31:38 -0400
From: fdmanana@kernel.org
Subject: [PATCH] fstests: fix fssum to actually ignore file holes when supposed to
Date: Mon, 29 Oct 2018 09:43:40 +0000
Message-Id: <20181029094340.18154-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Unless the '-s' option is passed to fssum, it should not detect file holes
and have their existence influence the computed checksum for a file. This
tool was added to test btrfs' send/receive feature, so that it checks for
any metadata and data differences between the original filesystem and the
filesystem that receives send streams.

For a long time the test btrfs/007, which tests btrfs' send/receive with
fsstress, fails sporadically reporting data differences between files.
However the md5sum/sha1sum from the reported files in the original and
new filesystems are the same. The reason why fssum fails is because even
in normal mode it still accounts for number of holes that exist in the
file and their respective lengths. This is done using the SEEK_DATA mode
of lseek. The btrfs send feature does not preserve holes nor prealloc
extents (not supported by the current protocol), so whenever a hole or
prealloc (unwritten) extent is detected in the source filesystem, it
issues a write command full of zeroes, which will translate to a regular
(written) extent in the destination filesystem. This is why fssum reports
a different checksum. A prealloc extent also counts as hole when using
lseek.

For example when passing a seed of 1540592967 to fsstress in btrfs/007,
the test fails, as file p0/d0/f7 has a prealloc extent in the original
filesystem (in the incr snapshot).

Fix this by making fssum just read the hole file and feed its data to the
digest calculation function when option '-s' is not given. If we ever get
btrfs' send/receive to support holes and fallocate, we can just change
the test and pass the '-s' option to all fssum calls.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 src/fssum.c | 65 +++++--------------------------------------------------------
 1 file changed, 5 insertions(+), 60 deletions(-)

diff --git a/src/fssum.c b/src/fssum.c
index 5da39abf..f1da72fb 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -224,71 +224,16 @@ int
 sum_file_data_permissive(int fd, sum_t *dst)
 {
 	int ret;
-	off_t pos;
-	off_t old;
-	int i;
-	uint64_t zeros = 0;
-
-	pos = lseek(fd, 0, SEEK_CUR);
-	if (pos == (off_t)-1)
-		return errno == ENXIO ? 0 : -2;
 
 	while (1) {
-		old = pos;
-		pos = lseek(fd, pos, SEEK_DATA);
-		if (pos == (off_t)-1) {
-			if (errno == ENXIO) {
-				ret = 0;
-				pos = lseek(fd, 0, SEEK_END);
-				if (pos != (off_t)-1)
-					zeros += pos - old;
-			} else {
-				ret = -2;
-			}
-			break;
-		}
 		ret = read(fd, buf, sizeof(buf));
-		assert(ret); /* eof found by lseek */
-		if (ret <= 0)
+		if (ret < 0)
+			return -errno;
+		sum_add(dst, buf, ret);
+		if (ret < sizeof(buf))
 			break;
-		if (old < pos) /* hole */
-			zeros += pos - old;
-		for (i = 0; i < ret; ++i) {
-			for (old = i; buf[i] == 0 && i < ret; ++i)
-				;
-			if (old < i) /* code like a hole */
-				zeros += i - old;
-			if (i == ret)
-				break;
-			if (zeros) {
-				if (verbose >= 2)
-					fprintf(stderr,
-						"adding %llu zeros to sum\n",
-						(unsigned long long)zeros);
-				sum_add_u64(dst, 0);
-				sum_add_u64(dst, zeros);
-				zeros = 0;
-			}
-			for (old = i; buf[i] != 0 && i < ret; ++i)
-				;
-			if (verbose >= 2)
-				fprintf(stderr, "adding %u non-zeros to sum\n",
-					i - (int)old);
-			sum_add(dst, buf + old, i - old);
-		}
-		pos += ret;
 	}
-
-	if (zeros) {
-		if (verbose >= 2)
-			fprintf(stderr,
-				"adding %llu zeros to sum (finishing)\n",
-				(unsigned long long)zeros);
-		sum_add_u64(dst, 0);
-		sum_add_u64(dst, zeros);
-	}
-
-	return ret;
+	return 0;
 }
 
 int
-- 
2.11.0
