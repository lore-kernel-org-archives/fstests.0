Received: from mx1.redhat.com ([209.132.183.28]:13726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbfHGLZS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Aug 2019 07:25:18 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] seek_sanity_test: Repair check for unwritten extent support
Date: Wed,  7 Aug 2019 13:25:14 +0200
Message-Id: <20190807112514.1903-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

In test_basic_support, commit f3c1bca7fb25 ("generic: Test that
SEEK_HOLE can find a punched hole") cleverly punched a hole in the test
file in the middle of the check for unwritten extent support, making
sure we would never detect when unwritten extent support is missing.
Fix that.

While at it, explicitly check for SEEK_DATA support as well:  so far, we
were assuming that SEEK_HOLE support implies SEEK_DATA support, but it
won't hurt to actually check.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 src/seek_sanity_test.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 30e996e2..080ca7eb 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -1156,7 +1156,16 @@ static int test_basic_support(void)
 	if (ret)
 		goto out;
 
-	/* Is SEEK_DATA and SEEK_HOLE supported in the kernel? */
+	/* Is SEEK_DATA supported in the kernel? */
+	pos = lseek(fd, 0, SEEK_DATA);
+	if (pos == -1) {
+		fprintf(stderr, "Kernel does not support llseek(2) extension "
+			"SEEK_DATA. Aborting.\n");
+		ret = -1;
+		goto out;
+	}
+
+	/* Is SEEK_HOLE supported in the kernel? */
 	pos = lseek(fd, 0, SEEK_HOLE);
 	if (pos == -1) {
 		fprintf(stderr, "Kernel does not support llseek(2) extension "
@@ -1186,19 +1195,21 @@ static int test_basic_support(void)
 			ret = -1;
 		}
 		goto out;
-	} else if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-			     0, alloc_size) == -1) {
-		fprintf(stderr, "File system does not support punch hole.\n");
-	} else {
-		punch_hole = 1;
 	}
 
 	pos = lseek(fd, 0, SEEK_DATA);
 	if (pos == 0) {
 		fprintf(stderr, "File system does not support unwritten extents.\n");
-		goto out;
+	} else {
+		unwritten_extents = 1;
+	}
+
+	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			     0, alloc_size) == -1) {
+		fprintf(stderr, "File system does not support punch hole.\n");
+	} else {
+		punch_hole = 1;
 	}
-	unwritten_extents = 1;
 
 	printf("\n");
 
-- 
2.20.1
