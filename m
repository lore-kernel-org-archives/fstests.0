Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57751C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 06:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349921AbiFAGhm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345648AbiFAGhm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 02:37:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2054DF43
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 23:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3136DB81828
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EADCC385B8
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654065457;
        bh=wM0HoUfxQ/MaeUKHIYmE09BoN4Tk4bhIvdTuWynmmH4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=B+i/i0pkf3a2Mh/29spCUsuXkQDjR3FLiRH4Fs4fLmW6PAPgCbmbW5vJV2cwrK9Qe
         SSa7Vf+5dGwd7I7U5yJCpfGR+BQNIqPBhVn997HgLJyw43XtlHAqEmERuuMbg2MPgG
         pO9++ZBWK2bG78LezZwQrJWja0ImWJn9II7kqMJ0alobbsoUWYDZilzdTmSDi5/Woq
         TQN6jamu68NMESRCY3DaL6CBObaNxF9xeXfofLCayiXhLSgYs39//ev5bISe3ZWXk4
         Ft4SZHnq6HXCOTbYQahRCeA//RzHeCKST98z68dh/SK0HG06mZ8IbjNRuMHnWvWYL2
         uXtzcrEwRmgXA==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 4/5] generic/591: use proper sector size
Date:   Wed,  1 Jun 2022 14:37:29 +0800
Message-Id: <20220601063730.1726879-5-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220601063730.1726879-1-zlang@kernel.org>
References: <20220601063730.1726879-1-zlang@kernel.org>
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
 src/splice-test.c | 37 +++++++++++++++++++++++++------------
 tests/generic/591 |  6 ++++--
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/src/splice-test.c b/src/splice-test.c
index dc41b0f5..eb863673 100644
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
@@ -146,7 +159,7 @@ int main(int argc, char *argv[])
 		   do_splice == do_splice1 ? "sequential" : "concurrent",
 		   (open_flags & O_DIRECT) ? "with" : "without");
 
-	buffer = memalign(SECTOR_SIZE, BUFFER_SIZE);
+	buffer = memalign(sector_size, buffer_size);
 	if (buffer == NULL)
 		err(1, "memalign");
 
@@ -154,11 +167,11 @@ int main(int argc, char *argv[])
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
@@ -167,7 +180,7 @@ int main(int argc, char *argv[])
 	if (ret != 0)
 		err(1, "lseek: %s", filename);
 
-	do_splice(fd, filename, BUFFER_SIZE);
+	do_splice(fd, filename, buffer_size);
 
 	if (unlink(filename) == -1)
 		err(1, "unlink: %s", filename);
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

