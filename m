Received: from mail.kernel.org ([198.145.29.99]:53238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfDAMu1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 1 Apr 2019 08:50:27 -0400
From: fdmanana@kernel.org
Subject: [PATCH v2 1/7] fsstress: allow fsync on directories too
Date: Mon,  1 Apr 2019 13:50:18 +0100
Message-Id: <20190401125018.10009-1-fdmanana@kernel.org>
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

 ltp/fsstress.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 2223fd7d..1169b840 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -303,6 +303,7 @@ int	attr_remove_path(pathname_t *, const char *, int);
 int	attr_set_path(pathname_t *, const char *, const char *, const int, int);
 void	check_cwd(void);
 void	cleanup_flist(void);
+void	close_file_or_dir(int, DIR *);
 int	creat_path(pathname_t *, mode_t);
 void	dcache_enter(int, int);
 void	dcache_init(void);
@@ -324,6 +325,7 @@ void	make_freq_table(void);
 int	mkdir_path(pathname_t *, mode_t);
 int	mknod_path(pathname_t *, mode_t, dev_t);
 void	namerandpad(int, char *, int);
+int	open_file_or_dir(pathname_t *, int, DIR **);
 int	open_path(pathname_t *, int);
 DIR	*opendir_path(pathname_t *);
 void	process_freq(char *);
@@ -852,6 +854,15 @@ cleanup_flist(void)
 	}
 }
 
+void
+close_file_or_dir(int fd, DIR *dir)
+{
+	if (dir)
+		closedir(dir);
+	else
+		close(fd);
+}
+
 int
 creat_path(pathname_t *name, mode_t mode)
 {
@@ -1385,6 +1396,30 @@ namerandpad(int id, char *buf, int i)
 }
 
 int
+open_file_or_dir(pathname_t *name, int flags, DIR **dir)
+{
+	int fd;
+
+	fd = open_path(name, flags);
+	if (fd < 0 && errno == EISDIR) {
+		*dir = opendir_path(name);
+		if (*dir) {
+			fd = dirfd(*dir);
+			if (fd < 0) {
+				int e = errno;
+
+				closedir(*dir);
+				*dir = NULL;
+				errno = e;
+			}
+		}
+	} else {
+		*dir = NULL;
+	}
+	return fd;
+}
+
+int
 open_path(pathname_t *name, int oflag)
 {
 	char		buf[NAME_MAX + 1];
@@ -3440,15 +3475,16 @@ fsync_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	int		v;
+	DIR             *dir;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, NULL, &v)) {
 		if (v)
 			printf("%d/%d: fsync - no filename\n", procid, opno);
 		free_pathname(&f);
 		return;
 	}
-	fd = open_path(&f, O_WRONLY);
+	fd = open_file_or_dir(&f, O_WRONLY, &dir);
 	e = fd < 0 ? errno : 0;
 	check_cwd();
 	if (fd < 0) {
@@ -3462,7 +3498,7 @@ fsync_f(int opno, long r)
 	if (v)
 		printf("%d/%d: fsync %s %d\n", procid, opno, f.path, e);
 	free_pathname(&f);
-	close(fd);
+	close_file_or_dir(fd, dir);
 }
 
 void
-- 
2.11.0
