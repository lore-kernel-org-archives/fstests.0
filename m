Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbfDSS3S (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:18 -0400
From: fdmanana@kernel.org
Subject: [PATCH v4 2/7] fsstress: allow afsync on directories too
Date: Fri, 19 Apr 2019 11:53:58 +0100
Message-Id: <20190419105358.11833-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Currently the afsync function can only be performed against regular files.
Allow it to operate on directories too, to increase test coverage and
allow for chances of finding bugs in a filesystem's implementation of
fsync against directories.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Use the helper functions for opening and closing files or directories,
    introduced in the previous patch.
V3: Use the new simplified helper for opening a file or directory.
V4: No changes.

 ltp/fsstress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 72c574da..3ec19143 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -1395,8 +1395,8 @@ open_file_or_dir(pathname_t *name, int flags)
 		return fd;
 	if (fd == -1 && errno != EISDIR)
 		return fd;
-	/* Directories can not be opened in write mode. */
-	flags &= ~O_WRONLY;
+	/* Directories can not be opened in write mode nor direct mode. */
+	flags &= ~(O_WRONLY | O_DIRECT);
 	flags |= O_RDONLY | O_DIRECTORY;
 	return open_path(name, flags);
 }
@@ -1774,13 +1774,13 @@ afsync_f(int opno, long r)
 	struct io_event	event;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, NULL, &v)) {
 		if (v)
 			printf("%d/%d: afsync - no filename\n", procid, opno);
 		free_pathname(&f);
 		return;
 	}
-	fd = open_path(&f, O_WRONLY | O_DIRECT);
+	fd = open_file_or_dir(&f, O_WRONLY | O_DIRECT);
 	e = fd < 0 ? errno : 0;
 	check_cwd();
 	if (fd < 0) {
-- 
2.11.0
