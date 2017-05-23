Received: from mx2.suse.de ([195.135.220.15]:33152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966427AbdEWOG1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 May 2017 10:06:27 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E6BAABCA
        for <fstests@vger.kernel.org>; Tue, 23 May 2017 14:06:25 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] src/seek_sanity_test: fix test15 SEEK_HOLE expected results
Date: Tue, 23 May 2017 15:06:18 +0100
Message-Id: <20170523140618.24387-1-lhenriques@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Luis Henriques <lhenriques@suse.com>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Filesystesm with the "default behaviour" will always return the offset of
the end of the file when lseek'ing with SEEK_HOLE.  This test does the
following:

 - fallocate 4 << 20 bytes
 - write PAGE_SIZE bytes at offset 0
 - writes PAGE_SIZE bytes at offset 4 << 20

Thus, using lseek in an FS with the "default behaviour" will set the
position at 4 << 20 + PAGE_SIZE.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 src/seek_sanity_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index d52e2b6dab79..b35a324c749c 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -335,8 +335,8 @@ static int test15(int fd, int testnum)
 		goto out;
 
 	/* offset at the beginning */
-	ret += do_lseek(testnum,  1, fd, filsz, SEEK_HOLE, 0, bufsz);
-	ret += do_lseek(testnum,  2, fd, filsz, SEEK_HOLE, 1, bufsz);
+	ret += do_lseek(testnum,  1, fd, filsz + bufsz, SEEK_HOLE, 0, bufsz);
+	ret += do_lseek(testnum,  2, fd, filsz + bufsz, SEEK_HOLE, 1, bufsz);
 	ret += do_lseek(testnum,  3, fd, filsz, SEEK_DATA, 0, 0);
 	ret += do_lseek(testnum,  4, fd, filsz, SEEK_DATA, 1, 1);
 	ret += do_lseek(testnum,  5, fd, filsz, SEEK_DATA, bufsz, filsz);
