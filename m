Received: from mx2.suse.de ([195.135.220.15]:48259 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968532AbdEWQT6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 May 2017 12:19:58 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v2] src/seek_sanity_test: fix test15 SEEK_HOLE expected results
Date: Tue, 23 May 2017 17:19:55 +0100
Message-Id: <20170523161955.28394-1-lhenriques@suse.com>
In-Reply-To: <20170523155654.GG7250@eguan.usersys.redhat.com>
References: <20170523155654.GG7250@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, Jan Kara <jack@suse.cz>, Luis Henriques <lhenriques@suse.com>
List-ID: <fstests@vger.kernel.org>

Filesystesm with the "default behaviour" will always return the offset of
the end of the file when lseek'ing with SEEK_HOLE.  This test does the
following:

 - fallocate 4 << 20 bytes
 - write PAGE_SIZE bytes at offset 0
 - writes PAGE_SIZE bytes at offset 4 << 20

Thus, using lseek in an FS with the "default behaviour" will set the
position at 4 << 20 + PAGE_SIZE.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
- Changes since v1
  Updated with Eryu suggestions (thanks for reviewing!): update filsz
  after the last write and set the expected result for the 5th test to
  'filsz - bufsz'.

 src/seek_sanity_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index d52e2b6dab79..064a8fa5822f 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -334,12 +334,15 @@ static int test15(int fd, int testnum)
 	if (ret)
 		goto out;
 
+	/* update file size */
+	filsz += bufsz;
+
 	/* offset at the beginning */
 	ret += do_lseek(testnum,  1, fd, filsz, SEEK_HOLE, 0, bufsz);
 	ret += do_lseek(testnum,  2, fd, filsz, SEEK_HOLE, 1, bufsz);
 	ret += do_lseek(testnum,  3, fd, filsz, SEEK_DATA, 0, 0);
 	ret += do_lseek(testnum,  4, fd, filsz, SEEK_DATA, 1, 1);
-	ret += do_lseek(testnum,  5, fd, filsz, SEEK_DATA, bufsz, filsz);
+	ret += do_lseek(testnum,  5, fd, filsz, SEEK_DATA, bufsz, filsz - bufsz);
 
 out:
 	do_free(buf);
