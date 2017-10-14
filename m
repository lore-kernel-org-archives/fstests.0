Received: from mx1.redhat.com ([209.132.183.28]:42534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750772AbdJNHHg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Oct 2017 03:07:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A71E23680C
        for <fstests@vger.kernel.org>; Sat, 14 Oct 2017 07:07:36 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH] ltp/fsstress: check mkdir(2) return value
Date: Sat, 14 Oct 2017 15:07:17 +0800
Message-Id: <1507964837-10820-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

If mkdir(2) fails, the following chdir(2) would fail either.
Although dirname and error message are printed, we don't know
which operation has failed.

Like this:
+/test2/fsstress.1582: No such file or directory

This trivial fix will check the return value and print detail
error info if fail.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 ltp/fsstress.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 96f48b1..1962d14 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -493,7 +493,11 @@ int main(int argc, char **argv)
             exit(1);
         }
 
-	(void)mkdir(dirname, 0777);
+	if (mkdir((const char *)dirname, 0777) < 0) {
+		fprintf(stderr, "mkdir %s failed: %s\n", dirname,
+			strerror(errno));
+		exit(1);
+	}
 	if (logname && logname[0] != '/') {
 		if (getcwd(rpath, sizeof(rpath)) < 0){
 			perror("getcwd failed");
@@ -503,7 +507,8 @@ int main(int argc, char **argv)
 		rpath[0] = '\0';
 	}
 	if (chdir(dirname) < 0) {
-		perror(dirname);
+		fprintf(stderr, "chdir %s failed: %s\n", dirname,
+			strerror(errno));
 		exit(1);
 	}
 	if (logname) {
@@ -959,7 +964,11 @@ doproc(void)
 
 	dividend = (operations + execute_freq) / (execute_freq + 1);
 	sprintf(buf, "p%x", procid);
-	(void)mkdir(buf, 0777);
+	if (mkdir((const char *)buf, 0777) < 0) {
+		fprintf(stderr, "mkdir %s failed: %s\n", buf,
+			strerror(errno));
+		exit(1);
+	}
 	if (chdir(buf) < 0 || stat64(".", &statbuf) < 0) {
 		perror(buf);
 		_exit(1);
-- 
1.8.3.1

