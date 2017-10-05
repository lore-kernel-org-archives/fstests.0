Received: from mx2.mpynet.fi ([82.197.21.85]:31287 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbdJEM7L (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Oct 2017 08:59:11 -0400
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH 3/4] holetest: Fix comparison of unsigned integer with 0
Date: Thu, 5 Oct 2017 12:49:59 +0000
Message-ID: <1507207800-5688-3-git-send-email-rostislav@tuxera.com>
In-Reply-To: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
References: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

---
 src/holetest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/holetest.c b/src/holetest.c
index 1939b35..e7ba123 100644
--- a/src/holetest.c
+++ b/src/holetest.c
@@ -205,7 +205,7 @@ int test_this(int fd, loff_t sz)
 			 */
 			fflush(stdout);
 			tid[i] = fork();
-			if (tid[i] < 0) {
+			if ((int64_t)tid[i] < 0) {
 				int j;
 
 				perror("fork");
-- 
2.1.4

