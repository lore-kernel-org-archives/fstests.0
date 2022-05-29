Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DF5C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 10:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiE2KzV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 06:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiE2KzS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 06:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEED762BFF
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 03:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C40360C1C
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C065C34119
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653821713;
        bh=zOD6XWNFjRVu38KkNBrtFeOCpFel1z50yCXExS70/3I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mMQEfarVr0gRyK33+NXNz/TA/7CiR3Az6GijSf0gNRTDyBss1Z03i3fm4rxztsuE7
         nVNKVNzlzU+GUh5Oy1EJv7WjyGUOFhBPBJFfjEgfh80PZuP2svdAtinHEHD+ooIiLa
         fsHIVVuvXG64iB/JRP8SFUCy7v9Hp0Tfw22OjhbVgle4WcHMW8Y01+nurPi7g2IPVg
         2wRJR7bBC/KGJRH7ykILCXU/dT2mNeAGfu1ca6LWOKYOv3yafbWlO3QsiQNrxoTzgr
         D3gHRNYd2ZPCfrWI8jxRoexvhsE+OwNctSIbE8mdpGuZy+f3KXSh7CsccW3IaYCtWc
         CifoDKDPjlQOw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 4/5] generic/591: use proper sector size
Date:   Sun, 29 May 2022 18:55:04 +0800
Message-Id: <20220529105505.667891-5-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220529105505.667891-1-zlang@kernel.org>
References: <20220529105505.667891-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The generic/591 fails if the sector size of TEST_DEV isn't 512:

  splice-test: write: /mnt/test/a: Invalid argument

To fix this issue, this patch help src/splice-test.c to get a specify
sector size from the test case. Then let g/591 give it a proper
sector size which dio aligned.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 src/dmiperf        | Bin 0 -> 31288 bytes
 src/splice-test.c  |  37 +++++++++++++++++++++++++------------
 src/t_locks_execve | Bin 0 -> 25904 bytes
 tests/generic/591  |   6 ++++--
 4 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100755 src/dmiperf
 create mode 100755 src/t_locks_execve

diff --git a/src/dmiperf b/src/dmiperf
new file mode 100755
index 0000000000000000000000000000000000000000..da9aa46bbc7dd5bed88e6bdcadaa5923a34ea1b3
GIT binary patch
literal 31288
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

literal 0
HcmV?d00001

diff --git a/src/splice-test.c b/src/splice-test.c
index e6ae6fca..3e08f1c0 100644
--- a/src/splice-test.c
+++ b/src/splice-test.c
@@ -19,19 +19,20 @@
 #include <errno.h>
 #include <malloc.h>
 
-#define SECTOR_SIZE 512
-#define BUFFER_SIZE (150 * SECTOR_SIZE)
+unsigned int sector_size;
+unsigned int buffer_size;
 
 void read_from_pipe(int fd, const char *filename, size_t size)
 {
-	char buffer[SECTOR_SIZE];
+	char *buffer;
 	size_t sz;
 	ssize_t ret;
+	buffer = malloc(buffer_size);
 
 	while (size) {
 		sz = size;
-		if (sz > sizeof buffer)
-			sz = sizeof buffer;
+		if (sz > buffer_size)
+			sz = buffer_size;
 		ret = read(fd, buffer, sz);
 		if (ret < 0)
 			err(1, "read: %s", filename);
@@ -41,6 +42,7 @@ void read_from_pipe(int fd, const char *filename, size_t size)
 		}
 		size -= sz;
 	}
+	free(buffer);
 }
 
 void do_splice1(int fd, const char *filename, size_t size)
@@ -108,7 +110,7 @@ void do_splice2(int fd, const char *filename, size_t size)
 
 void usage(const char *argv0)
 {
-	fprintf(stderr, "USAGE: %s [-rd] {filename}\n", basename(argv0));
+	fprintf(stderr, "USAGE: %s [-rd] [-s sectorsize] {filename}\n", basename(argv0));
 	exit(2);
 }
 
@@ -120,11 +122,22 @@ int main(int argc, char *argv[])
 	int opt, open_flags, fd;
 	ssize_t ret;
 
+	/*
+	 * init default sector_size and buffer_size, might be changed if the -s
+	 * option is specified
+	 */
+	sector_size = 512;
+	buffer_size = 150 * sector_size;
+
 	do_splice = do_splice1;
 	open_flags = O_CREAT | O_TRUNC | O_RDWR | O_DIRECT;
 
-	while ((opt = getopt(argc, argv, "rd")) != -1) {
+	while ((opt = getopt(argc, argv, "rds:")) != -1) {
 		switch(opt) {
+		case 's':
+			sector_size = strtol(optarg, NULL, 0);
+			buffer_size = 150 * sector_size;
+			break;
 		case 'r':
 			do_splice = do_splice2;
 			break;
@@ -145,7 +158,7 @@ int main(int argc, char *argv[])
 		   (open_flags & O_DIRECT) ? "with" : "without");
 	fflush(stdout);
 
-	buffer = memalign(SECTOR_SIZE, BUFFER_SIZE);
+	buffer = memalign(sector_size, buffer_size);
 	if (buffer == NULL)
 		err(1, "memalign");
 
@@ -153,11 +166,11 @@ int main(int argc, char *argv[])
 	if (fd == -1)
 		err(1, "open: %s", filename);
 
-	memset(buffer, 'x', BUFFER_SIZE);
-	ret = write(fd, buffer, BUFFER_SIZE);
+	memset(buffer, 'x', buffer_size);
+	ret = write(fd, buffer, buffer_size);
 	if (ret < 0)
 		err(1, "write: %s", filename);
-	if (ret != BUFFER_SIZE) {
+	if (ret != buffer_size) {
 		fprintf(stderr, "%s: short write\n", filename);
 		exit(1);
 	}
@@ -166,7 +179,7 @@ int main(int argc, char *argv[])
 	if (ret != 0)
 		err(1, "lseek: %s", filename);
 
-	do_splice(fd, filename, BUFFER_SIZE);
+	do_splice(fd, filename, buffer_size);
 
 	if (unlink(filename) == -1)
 		err(1, "unlink: %s", filename);
diff --git a/src/t_locks_execve b/src/t_locks_execve
new file mode 100755
index 0000000000000000000000000000000000000000..5f0d77f903da5e85ddcab7fb095f6be2ea34b499
GIT binary patch
literal 25904
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
Ba=-up

literal 0
HcmV?d00001

diff --git a/tests/generic/591 b/tests/generic/591
index 5efc5136..4de50e2a 100755
--- a/tests/generic/591
+++ b/tests/generic/591
@@ -24,9 +24,11 @@ _require_test
 _require_odirect
 _require_test_program "splice-test"
 
-$here/src/splice-test -r $TEST_DIR/a
+diosize=`_min_dio_alignment $TEST_DEV`
+
+$here/src/splice-test -s $diosize -r $TEST_DIR/a
 $here/src/splice-test -rd $TEST_DIR/a
-$here/src/splice-test $TEST_DIR/a
+$here/src/splice-test -s $diosize $TEST_DIR/a
 $here/src/splice-test -d $TEST_DIR/a
 
 # success, all done
-- 
2.31.1

