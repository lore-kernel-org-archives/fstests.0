Received: from mx1.redhat.com ([209.132.183.28]:37544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbdEJLqH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 10 May 2017 07:46:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEB72C05974D
        for <fstests@vger.kernel.org>; Wed, 10 May 2017 11:46:06 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] src/seek_sanity_test: Fix for filesystems without delayed allocation
Date: Wed, 10 May 2017 13:46:04 +0200
Message-Id: <1494416764-22528-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

src/seek_sanity_test (test generic/285) assumes that after fallocating
space in a file, fseek SEEK_HOLE / SEEK_DATA will still report the
allocated space as a hole.  This isn't true on filesystems that don't
support delayed allocation, so skip the affected tests in that case.

Tested on xfs and gfs2 + patches for fseek SEEK_HOLE / SEEK_DATA.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/seek_sanity_test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index a6dd48c..86ddf1c 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -37,6 +37,7 @@
 
 static blksize_t alloc_size;
 int default_behavior = 0;
+int delayed_allocation = 1;
 char *base_file_path;
 
 static void get_file_system(int fd)
@@ -282,6 +283,12 @@ static int test09(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 8 << 20;
 
+	if (!delayed_allocation) {
+		/* Report success if fs doesn't support delayed allocation */
+		fprintf(stdout, "Test skipped as fs doesn't support delayed allocation\n");
+		goto out;
+	}
+
 	/*
 	 * HOLE - unwritten DATA in dirty page - HOLE -
 	 * unwritten DATA in writeback page
@@ -338,6 +345,12 @@ static int test08(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 4 << 20;
 
+	if (!delayed_allocation) {
+		/* Report success if fs doesn't support delayed allocation */
+		fprintf(stdout, "Test skipped as fs doesn't support delayed allocation\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in writeback page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -387,6 +400,12 @@ static int test07(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 4 << 20;
 
+	if (!delayed_allocation) {
+		/* Report success if fs doesn't support delayed allocation */
+		fprintf(stdout, "Test skipped as fs doesn't support delayed allocation\n");
+		goto out;
+	}
+
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -776,6 +795,14 @@ static int test_basic_support(void)
 		fprintf(stderr, "File system supports the default behavior.\n");
 	}
 
+	ftruncate(fd, 0);
+	fallocate(fd, 0, 0, 1 << 20);
+	pos = lseek(fd, 0, SEEK_DATA);
+	if (pos == 0) {
+		fprintf(stderr, "File system does not support delayed allocation.\n");
+		delayed_allocation = 0;
+	}
+
 	printf("\n");
 
 out:
-- 
2.7.4

