Received: from mail.cn.fujitsu.com ([183.91.158.132]:64581 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727428AbfBLLNO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Feb 2019 06:13:14 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0E07A4C4BB93
        for <fstests@vger.kernel.org>; Tue, 12 Feb 2019 19:13:12 +0800 (CST)
From: Cui Yue <cuiyue-fnst@cn.fujitsu.com>
Subject: [PATCH] generic/089: Add error check for unlock_mtab()
Date: Tue, 12 Feb 2019 19:12:30 +0800
Message-ID: <1549969950-4886-1-git-send-email-cuiyue-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When unlink() fails, that is, when the lock file is not deleted
successfully, variable we_created_lockfile is still set to 0.

On the next iteration, the 3 processes will not be able to
successfully create the lock file.

Signed-off-by: Cui Yue <cuiyue-fnst@cn.fujitsu.com>
---
 src/t_mtab.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/t_mtab.c b/src/t_mtab.c
index fd85c6b..6a17fbd 100644
--- a/src/t_mtab.c
+++ b/src/t_mtab.c
@@ -184,9 +184,15 @@ lock_mtab (void) {
 /* Remove lock file.  */
 void
 unlock_mtab (void) {
+        int ret;
 	if (we_created_lockfile) {
-		unlink (mounted_lock);
-		we_created_lockfile = 0;
+		ret = unlink (mounted_lock);
+		if (ret) {
+			fprintf(stderr, "Cannot remove lock file: %s\n", strerror(errno));
+			exit(1);
+		} else {
+			we_created_lockfile = 0;
+		}
 	}
 }
 
-- 
1.8.3.1
