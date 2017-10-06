Received: from mx1.mpynet.fi ([82.197.21.84]:39758 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbdJFI1N (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Oct 2017 04:27:13 -0400
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH v2] bulkstat_unlink_test_modified: Remove extraneous if statement
Date: Fri, 6 Oct 2017 08:25:19 +0000
Message-ID: <1507278319-17380-1-git-send-email-rostislav@tuxera.com>
In-Reply-To: <20171005194629.GA21115@infradead.org>
References: <20171005194629.GA21115@infradead.org>
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
Updated according to your suggestion, removed extra parentheses.

 src/bulkstat_unlink_test_modified.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/bulkstat_unlink_test_modified.c b/src/bulkstat_unlink_test_modified.c
index 6604992..981d80c 100644
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
+		    if (ret[i].bs_ino == inodelist[j] &&
+			ret[i].bs_gen != genlist[j] + 1) {
+			/* oops, the new gen number is not 1 bigger than the old */
+			printf("Inode with old generation %d, new generation %d\n",
+			genlist[j], ret[i].bs_gen);
+			exit(1);
 		    }
 		}
 	    }
-- 
2.1.4

