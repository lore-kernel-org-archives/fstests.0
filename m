Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfDDQaA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Apr 2019 12:30:00 -0400
From: fdmanana@kernel.org
Subject: [PATCH v3 1/7] fsstress: allow fsync on directories too
Date: Thu,  4 Apr 2019 17:29:52 +0100
Message-Id: <20190404162952.19026-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Currently the fsync function can only be performed against regular files.
Allow it to operate on directories too, to increase test coverage and
allow for chances of finding bugs in a filesystem's implementation of
fsync against directories.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Added helper functions to open and close files or directories.
V3: Simplified helper to open file or directory, removed no longer needed
    helper for closing file or directory.

 ltp/fsstress.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 41a0155e..72c574da 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -324,6 +324,7 @@ void	make_freq_table(void);
 int	mkdir_path(pathname_t *, mode_t);
 int	mknod_path(pathname_t *, mode_t, dev_t);
 void	namerandpad(int, char *, int);
+int	open_file_or_dir(pathname_t *, int);
 int	open_path(pathname_t *, int);
 DIR	*opendir_path(pathname_t *);
 void	process_freq(char *);
@@ -1385,6 +1386,22 @@ namerandpad(int id, char *buf, int i)
 }
 
 int
+open_file_or_dir(pathname_t *name, int flags)
+{
+	int fd;
+
+	fd = open_path(name, flags);
+	if (fd != -1)
+		return fd;
+	if (fd == -1 && errno != EISDIR)
+		return fd;
+	/* Directories can not be opened in write mode. */
+	flags &= ~O_WRONLY;
+	flags |= O_RDONLY | O_DIRECTORY;
+	return open_path(name, flags);
+}
+
+int
 open_path(pathname_t *name, int oflag)
 {
 	char		buf[NAME_MAX + 1];
@@ -3455,13 +3472,13 @@ fsync_f(int opno, long r)
 	int		v;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, NULL, &v)) {
 		if (v)
 			printf("%d/%d: fsync - no filename\n", procid, opno);
 		free_pathname(&f);
 		return;
 	}
-	fd = open_path(&f, O_WRONLY);
+	fd = open_file_or_dir(&f, O_WRONLY);
 	e = fd < 0 ? errno : 0;
 	check_cwd();
 	if (fd < 0) {
-- 
2.11.0
