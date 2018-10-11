Received: from mail-wr1-f68.google.com ([209.85.221.68]:38018 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKTMW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Oct 2018 15:12:22 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] src/fiemap-tester: check for illegal block size
Date: Thu, 11 Oct 2018 14:45:22 +0300
Message-Id: <20181011114522.7537-1-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

There was a regression in v4.19-rc1 that caused FIGETBSZ ioctl
to return 0 on an overlayfs file.

That regression went unnoticed because the xfstests that run
fiemap-tester program terminated in success status after not doing
much instead of failing.

Check for invalid value of block size returned by FIGETBSZ ioctl,
so these tests can detect the regression.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 src/fiemap-tester.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/fiemap-tester.c b/src/fiemap-tester.c
index 97ac5ad0..5b0af478 100644
--- a/src/fiemap-tester.c
+++ b/src/fiemap-tester.c
@@ -561,6 +561,12 @@ main(int argc, char **argv)
 		exit(1);
 	}
 
+	if (blocksize <= 0) {
+		printf("Illegal filesystem block size\n");
+		close(fd);
+		exit(1);
+	}
+
 #ifdef HAVE_FALLOCATE
 	/* if fallocate passes, then we can do preallocation, else not */
 	if (prealloc) {
-- 
2.17.1
