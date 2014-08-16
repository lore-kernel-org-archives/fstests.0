Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:15222 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbaHPNNd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Aug 2014 09:13:33 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 4/6] src/e4compact: handle various block_size correctly
Date: Sat, 16 Aug 2014 17:13:09 +0400
Message-Id: <1408194791-1797-4-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

EXT4_IOC_MOVE_EXT requires both files has same offset inside page

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 src/e4compact.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/e4compact.c b/src/e4compact.c
index ecc6906..314c329 100644
--- a/src/e4compact.c
+++ b/src/e4compact.c
@@ -50,6 +50,8 @@ struct donor_info
 
 static int ignore_error = 0;
 static int verbose = 0;
+static unsigned blk_per_pg;
+static unsigned blk_sz;
 
 
 static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor_info *donor)
@@ -60,6 +62,9 @@ static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor
 	int i = 0;
 
 	assert(donor->length >= len);
+	/* EXT4_IOC_MOVE_EXT requires both files has same offset inside page */
+	donor->offset += (blk_per_pg - (donor->offset  & (blk_per_pg -1)) +
+			 (start  & (blk_per_pg -1))) & (blk_per_pg -1);
 
 	mv_ioc.donor_fd = donor->fd;
 	mv_ioc.orig_start = start;
@@ -133,6 +138,7 @@ int main(int argc, char **argv)
 	extern int optind;
 	int c;
 	char * donor_name = NULL;
+
 	donor.offset = 0;
 	while ((c = getopt(argc, argv, "f:o:iv")) != -1) {
 		switch (c) {
@@ -170,10 +176,13 @@ int main(int argc, char **argv)
 	donor.length = st.st_size / st.st_blksize;
 	if (donor.offset)
 		donor.offset /= st.st_blksize;
+	blk_sz = st.st_blksize;
+	blk_per_pg = sysconf(_SC_PAGESIZE) / blk_sz;
 
 	if (verbose)
-		printf("Init donor :%s off:%lld len:%lld\n",
-		       donor_name, donor.offset, donor.length);
+		printf("Init donor %s off:%lld len:%lld bsz:%lu\n",
+		       donor_name, donor.offset, donor.length, st.st_blksize);
+
 	while ((read = getline(&line, &len, stdin)) != -1) {
 
 		if (line[read -1] == '\n')
@@ -200,8 +209,8 @@ int main(int argc, char **argv)
 		}
 		if (st.st_size && st.st_blocks) {
 			ret = do_defrag_one(fd, line, 0,
-					    (st.st_size  + st.st_blksize-1)/
-					    st.st_blksize, &donor);
+					    (st.st_size  + blk_sz-1)/ blk_sz,
+					    &donor);
 			if (ret && !ignore_error)
 				break;
 		}
-- 
1.7.1

