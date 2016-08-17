Received: from mail-pf0-f170.google.com ([209.85.192.170]:33552 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbcHQASe (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2016 20:18:34 -0400
Received: by mail-pf0-f170.google.com with SMTP id y134so32220824pfg.0
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2016 17:18:34 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] test-nextquota: fix build failure with glibc 2.24
Date: Tue, 16 Aug 2016 17:18:28 -0700
Message-Id: <89c2bd786fc4be75edb99132a1e404bc3923079a.1471392905.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

glibc 2.24 defines Q_GETNEXTQUOTA but not `struct nextdqblk`. We need to
define it ourselves, but let's give it a hacky name that won't cause
another build error when the definition is added to glibc.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
This is kind of ugly, but it's future-proof. The definition should
probably be added to glibc, I'm guessing that was an oversight.

 src/test-nextquota.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/test-nextquota.c b/src/test-nextquota.c
index 3baa296..ba4de27 100644
--- a/src/test-nextquota.c
+++ b/src/test-nextquota.c
@@ -40,8 +40,10 @@
 
 #ifndef Q_GETNEXTQUOTA
 #define Q_GETNEXTQUOTA 0x800009        /* get disk limits and usage >= ID */
+#endif
 
-struct nextdqblk
+/* glibc 2.24 defines Q_GETNEXTQUOTA but not struct nextdqblk. */
+struct test_nextdqblk
   {
     u_int64_t dqb_bhardlimit;	/* absolute limit on disk quota blocks alloc */
     u_int64_t dqb_bsoftlimit;	/* preferred limit on disk quota blocks */
@@ -54,7 +56,6 @@ struct nextdqblk
     u_int32_t dqb_valid;	/* bitmask of QIF_* constants */
     u_int32_t dqb_id;		/* id for this quota info*/
   };
-#endif
 
 #ifndef Q_XGETNEXTQUOTA
 #define Q_XGETNEXTQUOTA XQM_CMD(9)
@@ -75,7 +76,7 @@ int main(int argc, char *argv[])
 	uint id = 0, idflag = 0;
 	char *device = NULL;
 	char *tmp;
-	struct nextdqblk dqb;
+	struct test_nextdqblk dqb;
 	struct fs_disk_quota xqb;
 
 	while ((c = getopt(argc,argv,"ugpi:d:v")) != EOF) {
@@ -131,7 +132,7 @@ int main(int argc, char *argv[])
 	if (verbose)
 		printf("asking for quota type %d for id %u on %s\n", type, id, device);
 
-	memset(&dqb, 0, sizeof(struct nextdqblk));
+	memset(&dqb, 0, sizeof(struct test_nextdqblk));
 	memset(&xqb, 0, sizeof(struct fs_disk_quota));
 
 	if (verbose)
-- 
2.9.3

