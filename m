Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1SzD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 14:55:03 -0400
From: fdmanana@kernel.org
Subject: [PATCH 5/7] fsstress: allow afsync on directories too
Date: Thu, 28 Mar 2019 18:54:58 +0000
Message-Id: <20190328185458.29033-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Currently the afsync function can only be performed against regular files.
Allow it to operate on directories too, to increase test coverage and allow
for chances of finding bugs in the filesystem implementation of fsync
against directories.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsstress.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index ffe78ef7..0fb9e399 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -1767,15 +1767,21 @@ afsync_f(int opno, long r)
 	struct iocb	iocb;
 	struct iocb	*iocbs[] = { &iocb };
 	struct io_event	event;
+	DIR             *dir = NULL;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, NULL, &v)) {
 		if (v)
 			printf("%d/%d: afsync - no filename\n", procid, opno);
 		free_pathname(&f);
 		return;
 	}
 	fd = open_path(&f, O_WRONLY | O_DIRECT);
+	if (fd < 0 && errno == EISDIR) {
+		dir = opendir_path(&f);
+		if (dir)
+			fd = dirfd(dir);
+	}
 	e = fd < 0 ? errno : 0;
 	check_cwd();
 	if (fd < 0) {
@@ -1783,6 +1789,8 @@ afsync_f(int opno, long r)
 			printf("%d/%d: afsync - open %s failed %d\n",
 			       procid, opno, f.path, e);
 		free_pathname(&f);
+		if (dir)
+			closedir(dir);
 		return;
 	}
 
@@ -1791,24 +1799,24 @@ afsync_f(int opno, long r)
 		if (v)
 			printf("%d/%d: afsync - io_submit %s %d\n",
 			       procid, opno, f.path, e);
-		free_pathname(&f);
-		close(fd);
-		return;
+		goto out;
 	}
 	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
 		if (v)
 			printf("%d/%d: afsync - io_getevents failed %d\n",
 			       procid, opno, e);
-		free_pathname(&f);
-		close(fd);
-		return;
+		goto out;
 	}
 
 	e = event.res2;
 	if (v)
 		printf("%d/%d: afsync %s %d\n", procid, opno, f.path, e);
+out:
 	free_pathname(&f);
-	close(fd);
+	if (dir)
+		closedir(dir);
+	else
+		close(fd);
 #endif
 }
 
-- 
2.11.0
