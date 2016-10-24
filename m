Received: from mx1.redhat.com ([209.132.183.28]:40786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934306AbcJXNwn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Oct 2016 09:52:43 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2F7565F64
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2016 13:52:42 +0000 (UTC)
Received: from bcodding.csb (vpn-62-144.rdu2.redhat.com [10.10.62.144])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9ODqgYX005599
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2016 09:52:42 -0400
From: Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v2] generic/285: discover allocation size
Date: Mon, 24 Oct 2016 09:52:41 -0400
Message-Id: <74439b6f5a0393358803629c6f4dc15da08d0c02.1477314151.git.bcodding@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Try to discover the allocation size.  For NFS, the st_blksize is optimized
for the network, and will usually be much larger than the allocation size
of the exported filesystem, which may trigger preallocation strategies in
the exported filesystem causing the seek tests here to fail.

Change from v1:  do not limit behavior to NFS only

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 src/seek_sanity_test.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 18262c2b0493..a6dd48cc257b 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -700,8 +700,8 @@ static int run_test(struct testrec *tr)
 
 static int test_basic_support(void)
 {
-	int ret = -1, fd;
-	off_t pos;
+	int ret = -1, fd, shift;
+	off_t pos = 0, offset = 1;
 	char *buf = NULL;
 	int bufsz, filsz;
 
@@ -715,6 +715,35 @@ static int test_basic_support(void)
 	if (ret)
 		goto out;
 
+	/* try to discover the actual alloc size */
+	while (pos == 0 && offset < alloc_size) {
+		offset <<= 1;
+		ftruncate(fd, 0);
+		pwrite(fd, "a", 1, offset);
+		pos = lseek(fd, 0, SEEK_DATA);
+	}
+
+	/* bisect */
+	shift = offset >> 2;
+	while (shift && offset < alloc_size) {
+		ftruncate(fd, 0);
+		pwrite(fd, "a", 1, offset);
+		pos = lseek(fd, 0, SEEK_DATA);
+		offset += pos ? -shift : shift;
+		shift >>= 1;
+	}
+	if (!shift)
+		offset += pos ? 0 : 1;
+	alloc_size = offset;
+
+	if (pos == -1) {
+		fprintf(stderr, "Kernel does not support llseek(2) extension "
+			"SEEK_DATA. Aborting.\n");
+		ret = -1;
+		goto out;
+	}
+
+	ftruncate(fd, 0);
 	bufsz = alloc_size * 2;
 	filsz = bufsz * 2;
 
@@ -734,12 +763,10 @@ static int test_basic_support(void)
 		goto out;
 
 	/* Is SEEK_DATA and SEEK_HOLE supported in the kernel? */
-	pos = lseek(fd, 0, SEEK_DATA);
-	if (pos != -1)
-		pos = lseek(fd, 0, SEEK_HOLE);
+	pos = lseek(fd, 0, SEEK_HOLE);
 	if (pos == -1) {
-		fprintf(stderr, "Kernel does not support llseek(2) extensions "
-			"SEEK_HOLE and/or SEEK_DATA. Aborting.\n");
+		fprintf(stderr, "Kernel does not support llseek(2) extension "
+			"SEEK_HOLE. Aborting.\n");
 		ret = -1;
 		goto out;
 	}
-- 
2.5.5

