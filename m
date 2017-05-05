Received: from mx2.suse.de ([195.135.220.15]:33274 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752898AbdEEO51 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 May 2017 10:57:27 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] src/seek_sanity_test: ensure file size is big enough
Date: Fri,  5 May 2017 15:57:23 +0100
Message-Id: <20170505145723.13582-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Yan, Zheng" <ukernel@gmail.com>, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Tests test07, test08, and test09 preallocate a file and assume the file
size used is bigger than 10xbufsz (100xbufsz for test09).  This patch
adjusts the file size so this assumption is always true.

As an example, here's test06 output for cephfs, where the allocation size
is set to 4194304, and the output is (4194304 * 10 + 4194304)

  07. Test file with unwritten extents, only have dirty pages
  07.01 SEEK_HOLE expected 0 or 4194304, got 46137344.              FAIL
  07.02 SEEK_HOLE expected 1 or 4194304, got 46137344.              FAIL

(Note: The test will be skipped if an integer overflow occurs.)

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 src/seek_sanity_test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index a6dd48cc257b..41da59801212 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -282,6 +282,13 @@ static int test09(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 8 << 20;
 
+	while ((filsz < (bufsz * 100 + bufsz)) && (filsz > 0))
+		filsz <<= 1;
+	if (filsz <= 0) {
+		fprintf(stdout, "Test skipped due to int overflow.\n");
+		return ret;
+	}
+
 	/*
 	 * HOLE - unwritten DATA in dirty page - HOLE -
 	 * unwritten DATA in writeback page
@@ -338,6 +345,13 @@ static int test08(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 4 << 20;
 
+	while ((filsz < (bufsz * 10 + bufsz)) && (filsz > 0))
+		filsz <<= 1;
+	if (filsz <= 0) {
+		fprintf(stdout, "Test skipped due to int overflow.\n");
+		return ret;
+	}
+
 	/* HOLE - unwritten DATA in writeback page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
@@ -387,6 +401,13 @@ static int test07(int fd, int testnum)
 	int bufsz = alloc_size;
 	int filsz = 4 << 20;
 
+	while ((filsz < (bufsz * 10 + bufsz)) && (filsz > 0))
+		filsz <<= 1;
+	if (filsz <= 0) {
+		fprintf(stdout, "Test skipped due to int overflow.\n");
+		return ret;
+	}
+
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
 	buf = do_malloc(bufsz);
