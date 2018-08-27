Received: from mx2.suse.de ([195.135.220.15]:36802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbeH0Q5x (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 27 Aug 2018 12:57:53 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDD55AFC7
        for <fstests@vger.kernel.org>; Mon, 27 Aug 2018 13:11:16 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] src/seek_sanity_test: skip test20 if file's too big
Date: Mon, 27 Aug 2018 14:12:11 +0100
Message-Id: <20180827131211.5887-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Since the allocation size can be quite big for some filesystems (4194304
for cephfs), the pwrite operation in test20 may fail with EFBIG.  Skip
this test if that's the case.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 src/seek_sanity_test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index e5aab239771d..e9938d1b1a23 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -280,8 +280,17 @@ static int test20(int fd, int testnum)
 	/* Magic size in the middle of ext[23] triple indirect tree */
 	filsz = (12 + bufsz / 4 + 8 * bufsz / 4 * bufsz / 4 + 2 * bufsz / 4 + 5) * bufsz;
 	ret = do_pwrite(fd, buf, bufsz, filsz - bufsz);
-	if (ret)
+	if (ret) {
+		/*
+		 * Report success. Filesystem just cannot handle so large
+		 * offsets and correctly reports it.
+		 */
+		if (errno == EFBIG) {
+			fprintf(stdout, "Test skipped as fs doesn't support so large files.\n");
+			ret = 0;
+		}
 		goto out;
+	}
 
 	/* Offset inside ext[23] indirect block */
 	ret += do_lseek(testnum, 1, fd, filsz, SEEK_DATA, 14 * bufsz, filsz - bufsz);
