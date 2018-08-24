Received: from mail-wr1-f42.google.com ([209.85.221.42]:33428 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeHXH65 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Aug 2018 03:58:57 -0400
Received: by mail-wr1-f42.google.com with SMTP id v90-v6so6334739wrc.0
        for <fstests@vger.kernel.org>; Thu, 23 Aug 2018 21:26:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] open_by_handle: fix name of directory in error messages
Date: Fri, 24 Aug 2018 07:27:55 +0300
Message-Id: <1535084875-22879-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

dirname() modifies the string in dname, but we use that string
in error messages later on to print the test dir name.
Make another copy of test_dir for passing to dirname().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 src/open_by_handle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index 36f2b07..4fdfacd 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -123,6 +123,7 @@ int main(int argc, char **argv)
 	int	fd;
 	int	ret = 0;
 	int	failed = 0;
+	char	mname[PATH_MAX];
 	char	dname[PATH_MAX];
 	char	fname[PATH_MAX];
 	char	fname2[PATH_MAX];
@@ -240,9 +241,10 @@ int main(int argc, char **argv)
 	 *    the dentry cache and the use of -ip flag combination would not
 	 *    allow testing decode of dir file handle in cold dcache scenario.
 	 */
+	strcpy(dname, test_dir);
 	if (parent && !in_fd) {
-		strcpy(dname, test_dir);
-		mount_dir = dirname(dname);
+		strcpy(mname, test_dir);
+		mount_dir = dirname(mname);
 		if (create)
 			ret = mkdir(test_dir, 0700);
 		if (ret < 0 && errno != EEXIST) {
-- 
2.7.4
