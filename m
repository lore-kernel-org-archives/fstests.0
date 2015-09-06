Received: from mx1.redhat.com ([209.132.183.28]:32844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbbIFCoQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 5 Sep 2015 22:44:16 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 769F7461C2
	for <fstests@vger.kernel.org>; Sun,  6 Sep 2015 02:44:16 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] src/t_truncate_cmtime: test truncate up too
Date: Sun,  6 Sep 2015 10:43:25 +0800
Message-Id: <1441507405-15789-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Currently src/t_truncate_cmtime only tests the truncate down case,
truncate up case should be tested too. A recent ext4 bug shows that we
missed that coverage.

See kernel commit 911af577de4e ("ext4: update c/mtime on truncate up")

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 src/t_truncate_cmtime.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/src/t_truncate_cmtime.c b/src/t_truncate_cmtime.c
index b08ca44..4b28c2b 100644
--- a/src/t_truncate_cmtime.c
+++ b/src/t_truncate_cmtime.c
@@ -53,17 +53,18 @@ int do_test(const char *file, int is_ftrunc)
 		exit(EXIT_FAILURE);
 	}
 
+	/* Test [f]truncate(2) down */
 	sleep(1);
 	if (is_ftrunc) {
 		ret = ftruncate(fd, 0);
 		if (ret == -1) {
-			perror("ftruncate(2) failed");
+			perror("ftruncate(2) down failed");
 			exit(EXIT_FAILURE);
 		}
 	} else {
 		ret = truncate(file, 0);
 		if (ret == -1) {
-			perror("truncate(2) failed");
+			perror("truncate(2) down failed");
 			exit(EXIT_FAILURE);
 		}
 	}
@@ -75,15 +76,47 @@ int do_test(const char *file, int is_ftrunc)
 		exit(EXIT_FAILURE);
 	}
 
-	/* Check whether timestamps got updated */
+	/* Check whether timestamps got updated on [f]truncate(2) down */
 	if (statbuf1.st_ctime == statbuf2.st_ctime) {
 		fprintf(stderr, "ctime not updated after %s\n",
-			is_ftrunc ? "ftruncate" : "truncate");
+			is_ftrunc ? "ftruncate" : "truncate" " down");
 		ret++;
 	}
 	if (statbuf1.st_mtime == statbuf2.st_mtime) {
 		fprintf(stderr, "mtime not updated after %s\n",
-			is_ftrunc ? "ftruncate" : "truncate");
+			is_ftrunc ? "ftruncate" : "truncate" " down");
+		ret++;
+	}
+
+	/* Test [f]truncate(2) up */
+	sleep(1);
+	if (is_ftrunc) {
+		ret = ftruncate(fd, 123);
+		if (ret == -1) {
+			perror("ftruncate(2) up failed");
+			exit(EXIT_FAILURE);
+		}
+	} else {
+		ret = truncate(file, 123);
+		if (ret == -1) {
+			perror("truncate(2) up failed");
+			exit(EXIT_FAILURE);
+		}
+	}
+	ret = fstat(fd, &statbuf1);
+	if (ret == -1) {
+		perror("fstat(2) failed");
+		exit(EXIT_FAILURE);
+	}
+	/* Check whether timestamps got updated on [f]truncate(2) up */
+	if (statbuf1.st_ctime == statbuf2.st_ctime) {
+		fprintf(stderr, "ctime not updated after %s\n",
+			is_ftrunc ? "ftruncate" : "truncate" " up");
+		ret++;
+	}
+	if (statbuf1.st_mtime == statbuf2.st_mtime) {
+		fprintf(stderr, "mtime not updated after %s\n",
+			is_ftrunc ? "ftruncate" : "truncate" " up");
 		ret++;
 	}
 
-- 
2.4.3

