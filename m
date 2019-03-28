Received: from mail.kernel.org ([198.145.29.99]:45504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1SzO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 14:55:14 -0400
From: fdmanana@kernel.org
Subject: [PATCH 6/7] fsstress: allow fsync on directories too
Date: Thu, 28 Mar 2019 18:55:09 +0000
Message-Id: <20190328185509.29086-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Currently the fsync function can only be performed against regular files.
Allow it to operate on directories too, to increase test coverage and allow
for chances of finding bugs in a filesystem's implementation of fsync
against directories.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsstress.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 0fb9e399..bd058c04 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -3460,15 +3460,21 @@ fsync_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	int		v;
+	DIR             *dir = NULL;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, NULL, &v)) {
 		if (v)
 			printf("%d/%d: fsync - no filename\n", procid, opno);
 		free_pathname(&f);
 		return;
 	}
 	fd = open_path(&f, O_WRONLY);
+	if (fd < 0 && errno == EISDIR) {
+		dir = opendir_path(&f);
+		if (dir)
+			fd = dirfd(dir);
+	}
 	e = fd < 0 ? errno : 0;
 	check_cwd();
 	if (fd < 0) {
@@ -3476,13 +3482,18 @@ fsync_f(int opno, long r)
 			printf("%d/%d: fsync - open %s failed %d\n",
 				procid, opno, f.path, e);
 		free_pathname(&f);
+		if (dir)
+			closedir(dir);
 		return;
 	}
 	e = fsync(fd) < 0 ? errno : 0;
 	if (v)
 		printf("%d/%d: fsync %s %d\n", procid, opno, f.path, e);
 	free_pathname(&f);
-	close(fd);
+	if (dir)
+		closedir(dir);
+	else
+		close(fd);
 }
 
 void
-- 
2.11.0
