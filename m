Received: from mx2.suse.de ([195.135.220.15]:54906 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715AbcDRTco (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 18 Apr 2016 15:32:44 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 10B08AC54
	for <fstests@vger.kernel.org>; Mon, 18 Apr 2016 19:32:41 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/5] generic/340: Remove second fallocate test
Date: Mon, 18 Apr 2016 21:32:31 +0200
Message-Id: <1461007955-7921-2-git-send-email-jack@suse.cz>
In-Reply-To: <1461007955-7921-1-git-send-email-jack@suse.cz>
References: <1461007955-7921-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Currently holetest program uses both posix_fallocate(3) and fallocate(3)
to setup the file. However this unnecessarily prolongs the test run and
doesn't really bring any additional code coverage. So remove the
fallocate(3) pass as using posix_fallocate(3) allows us to make the test
easily runnable even for filesystems not supporting that (such as ext2).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 src/holetest.c        | 36 +-----------------------------------
 tests/generic/340     |  1 -
 tests/generic/340.out | 18 ------------------
 3 files changed, 1 insertion(+), 54 deletions(-)

diff --git a/src/holetest.c b/src/holetest.c
index c0a2c67798a3..c5a4fd5c043a 100644
--- a/src/holetest.c
+++ b/src/holetest.c
@@ -191,8 +191,7 @@ int main(int argc, char **argv)
 	 *
 	 * 1. explictly zero-filled
 	 * 2. posix_fallocated
-	 * 3. fallocated
-	 * 4. ftruncated
+	 * 3. ftruncated
 	 */
 
 
@@ -272,39 +271,6 @@ int main(int argc, char **argv)
 	}
 
 	/*
-	 * fallocated
-	 */
-	printf("\nINFO: fallocate test...\n");
-
-#ifdef HAVE_FALLOCATE
-	/* create the file */
-	fd = open(path, O_RDWR | O_EXCL | O_CREAT, 0644);
-	if (fd < 0) {
-		perror(path);
-		exit(11);
-	}
-
-	/* fill it to size */
-	if (fallocate(fd, 0, 0, sz)) {
-		perror("fallocate()");
-		exit(12);
-	}
-
-	/* test it */
-	errcnt = test_this(fd, sz);
-	toterr += errcnt;
-	close(fd);
-	if (stoponerror && errcnt > 0)
-		exit(13);
-
-	/* cleanup */
-	if (unlink(path)) {
-		perror("unlink()");
-		exit(14);
-	}
-#endif
-
-	/*
 	 * ftruncated
 	 */
 	printf("\nINFO: ftruncate test...\n");
diff --git a/tests/generic/340 b/tests/generic/340
index 69794ae417a4..2ba34eb59724 100644
--- a/tests/generic/340
+++ b/tests/generic/340
@@ -44,7 +44,6 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_test_program "holetest"
-_require_xfs_io_command "falloc"
 
 rm -f $seqres.full
 
diff --git a/tests/generic/340.out b/tests/generic/340.out
index 2bfc722edbe4..0eac9ed654dc 100644
--- a/tests/generic/340.out
+++ b/tests/generic/340.out
@@ -12,12 +12,6 @@ INFO: thread 0 created
 INFO: thread 1 created
 INFO: 0 error(s) detected
 
-INFO: fallocate test...
-INFO: sz = 1048576
-INFO: thread 0 created
-INFO: thread 1 created
-INFO: 0 error(s) detected
-
 INFO: ftruncate test...
 INFO: sz = 1048576
 INFO: thread 0 created
@@ -36,12 +30,6 @@ INFO: thread 0 created
 INFO: thread 1 created
 INFO: 0 error(s) detected
 
-INFO: fallocate test...
-INFO: sz = 16777216
-INFO: thread 0 created
-INFO: thread 1 created
-INFO: 0 error(s) detected
-
 INFO: ftruncate test...
 INFO: sz = 16777216
 INFO: thread 0 created
@@ -60,12 +48,6 @@ INFO: thread 0 created
 INFO: thread 1 created
 INFO: 0 error(s) detected
 
-INFO: fallocate test...
-INFO: sz = 268435456
-INFO: thread 0 created
-INFO: thread 1 created
-INFO: 0 error(s) detected
-
 INFO: ftruncate test...
 INFO: sz = 268435456
 INFO: thread 0 created
-- 
2.6.6

