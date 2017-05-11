Received: from mx1.redhat.com ([209.132.183.28]:52254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754977AbdEKLfK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 May 2017 07:35:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7F1C8553D
        for <fstests@vger.kernel.org>; Thu, 11 May 2017 11:35:09 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] src/seek_sanity_test: Fix for filesystems without unwritten extent support
Date: Thu, 11 May 2017 13:35:07 +0200
Message-Id: <1494502507-27742-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

src/seek_sanity_test (test generic/285) assumes that after preallocating
space in a file with fallocate, fseek SEEK_HOLE / SEEK_DATA will still
report the allocated space as a hole.  On filesystems without unwritten
extent support, that space will be reported as data, though.

Tested on ext4, xfs, and gfs2 + patches for fseek SEEK_HOLE / SEEK_DATA
support.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/seek_sanity_test.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index a6dd48c..0d7fa0a 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -37,6 +37,7 @@
 
 static blksize_t alloc_size;
 int default_behavior = 0;
+int unwritten_extents = 0;
 char *base_file_path;
 
 static void get_file_system(int fd)
@@ -282,6 +283,11 @@ static int test09(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 8 << 20;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped\n");
+		goto out;
+	}
+
 	/*
 	 * HOLE - unwritten DATA in dirty page - HOLE -
 	 * unwritten DATA in writeback page
@@ -338,6 +344,11 @@ static int test08(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 4 << 20;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in writeback page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -387,6 +398,11 @@ static int test07(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 4 << 20;
 
+	if (!unwritten_extents) {
+		fprintf(stdout, "Test skipped\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -776,6 +792,25 @@ static int test_basic_support(void)
 		fprintf(stderr, "File system supports the default behavior.\n");
 	}
 
+	ftruncate(fd, 0);
+	if (fallocate(fd, 0, 0, alloc_size) == -1) {
+		if (errno == EOPNOTSUPP) {
+			fprintf(stderr, "File system does not support fallocate.");
+		} else {
+			fprintf(stderr, "ERROR %d: Failed to preallocate "
+				"space to %ld bytes.", errno, (long) alloc_size);
+		}
+		fprintf(stderr, "  Skipping unwritten extent tests.\n");
+		goto out;
+	} else {
+		pos = lseek(fd, 0, SEEK_DATA);
+		if (pos == 0) {
+			fprintf(stderr, "File system does not support unwritten extents.\n");
+			goto out;
+		}
+	}
+	unwritten_extents = 1;
+
 	printf("\n");
 
 out:
-- 
2.7.4

