Received: from mx2.mpynet.fi ([82.197.21.85]:44730 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdJEM7L (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Oct 2017 08:59:11 -0400
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH 4/4] bulkstat_unlink_test_modified: Remove extraneous if statement
Date: Thu, 5 Oct 2017 12:50:00 +0000
Message-ID: <1507207800-5688-4-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
References: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Fixes the following compiler warning:

bulkstat_unlink_test_modified.c:171:26: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
                    if ((ret[i].bs_ino == inodelist[j])) {
                         ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
---
 src/bulkstat_unlink_test_modified.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/bulkstat_unlink_test_modified.c b/src/bulkstat_unlink_test_modified.c
index 6604992..eee7fd6 100644
--- a/src/bulkstat_unlink_test_modified.c
+++ b/src/bulkstat_unlink_test_modified.c
@@ -168,13 +168,12 @@ main(int argc, char *argv[])
 				 genlist[j]);
 			exit(1);
 		    }
-		    if ((ret[i].bs_ino == inodelist[j])) {
-			if ((genlist[j] + 1) != ret[i].bs_gen) {
-				/* oops, the new gen number is not 1 bigger than the old */
-				printf("Inode with old generation %d, new generation %d\n",
-				genlist[j], ret[i].bs_gen);
-				exit(1);
-			}
+		    if ((ret[i].bs_ino == inodelist[j]) &&
+			((genlist[j] + 1) != ret[i].bs_gen)) {
+			/* oops, the new gen number is not 1 bigger than the old */
+			printf("Inode with old generation %d, new generation %d\n",
+			genlist[j], ret[i].bs_gen);
+			exit(1);
 		    }
 		}
 	    }
-- 
2.1.4

