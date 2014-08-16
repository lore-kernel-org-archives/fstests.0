Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:32237 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbaHPNNc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 16 Aug 2014 09:13:32 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 3/6] src/e4compact cleanup
Date: Sat, 16 Aug 2014 17:13:08 +0400
Message-Id: <1408194791-1797-3-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

- fix incorrect donor offset initialization.
- fix donor name logging.
- handle EOPNOTSUPP correctly

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 src/e4compact.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/e4compact.c b/src/e4compact.c
index de0aeb6..ecc6906 100644
--- a/src/e4compact.c
+++ b/src/e4compact.c
@@ -64,7 +64,6 @@ static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor
 	mv_ioc.donor_fd = donor->fd;
 	mv_ioc.orig_start = start;
 	mv_ioc.donor_start = donor->offset;
-	mv_ioc.moved_len = 0;
 	mv_ioc.len = len;
 
 	if (verbose)
@@ -77,6 +76,7 @@ static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor
 	do {
 		i++;
 		errno = 0;
+		mv_ioc.moved_len = 0;
 		ret = ioctl(fd, EXT4_IOC_MOVE_EXT, &mv_ioc);
 		if (verbose)
 			printf("process %s  it:%d start:%lld len:%lld donor:%lld,"
@@ -102,12 +102,12 @@ static int do_defrag_one(int fd, char *name,__u64 start, __u64 len, struct donor
 		assert(mv_ioc.len >= mv_ioc.moved_len);
 		mv_ioc.len -= mv_ioc.moved_len;
 		mv_ioc.orig_start += mv_ioc.moved_len;
-		mv_ioc.donor_start = mv_ioc.orig_start;
+		mv_ioc.donor_start += mv_ioc.moved_len;
 		moved += mv_ioc.moved_len;
-
 	} while (mv_ioc.len);
 
-	if (ret && (errno == EBUSY || errno == ENODATA))
+	if (ret && ignore_error &&
+	    (errno == EBUSY || errno == ENODATA || errno == EOPNOTSUPP))
 		ret = 0;
 	donor->length -= moved;
 	donor->offset += moved;
@@ -154,6 +154,10 @@ int main(int argc, char **argv)
 			exit(1);
 		}
 	}
+	if (!donor_name) {
+		usage();
+		exit(1);
+	}
 	donor.fd = open(donor_name, O_RDWR);
 	if (donor.fd < 0) {
 		perror("can not open donor file");
@@ -168,7 +172,8 @@ int main(int argc, char **argv)
 		donor.offset /= st.st_blksize;
 
 	if (verbose)
-		printf("Init donor :%s off:%lld len:%lld\n", argv[1], donor.offset, donor.length);
+		printf("Init donor :%s off:%lld len:%lld\n",
+		       donor_name, donor.offset, donor.length);
 	while ((read = getline(&line, &len, stdin)) != -1) {
 
 		if (line[read -1] == '\n')
@@ -197,7 +202,7 @@ int main(int argc, char **argv)
 			ret = do_defrag_one(fd, line, 0,
 					    (st.st_size  + st.st_blksize-1)/
 					    st.st_blksize, &donor);
-			if (ret && ignore_error)
+			if (ret && !ignore_error)
 				break;
 		}
 	}
-- 
1.7.1

