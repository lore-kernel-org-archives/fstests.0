Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1Syg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 14:54:36 -0400
From: fdmanana@kernel.org
Subject: [PATCH 4/7] fsstress: add operation for removing xattrs from files and directories
Date: Thu, 28 Mar 2019 18:54:30 +0000
Message-Id: <20190328185430.28980-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The previous patches added support for operations to set and get xattrs on
regular files and directories, this patch just adds one operation to remove
xattrs on files and directories.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsstress.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index d7ea1da0..ffe78ef7 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -83,6 +83,7 @@ typedef enum {
 	OP_READ,
 	OP_READLINK,
 	OP_READV,
+	OP_REMOVEXATTR,
 	OP_RENAME,
 	OP_RESVSP,
 	OP_RMDIR,
@@ -196,6 +197,7 @@ void	insert_f(int, long);
 void	read_f(int, long);
 void	readlink_f(int, long);
 void	readv_f(int, long);
+void	removexattr_f(int, long);
 void	rename_f(int, long);
 void	resvsp_f(int, long);
 void	rmdir_f(int, long);
@@ -249,6 +251,7 @@ opdesc_t	ops[] = {
 	{ OP_READ, "read", read_f, 1, 0 },
 	{ OP_READLINK, "readlink", readlink_f, 1, 0 },
 	{ OP_READV, "readv", readv_f, 1, 0 },
+	{ OP_REMOVEXATTR, "removexattr", removexattr_f, 2, 1 },
 	{ OP_RENAME, "rename", rename_f, 2, 1 },
 	{ OP_RESVSP, "resvsp", resvsp_f, 1, 1 },
 	{ OP_RMDIR, "rmdir", rmdir_f, 1, 1 },
@@ -4054,6 +4057,67 @@ readv_f(int opno, long r)
 }
 
 void
+removexattr_f(int opno, long r)
+{
+	int		fd;
+	fent_t	        *fep;
+	int		e;
+	pathname_t	f;
+	int		v;
+	char            name[18];
+	int             xattr_num;
+	DIR             *dir = NULL;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+		if (v)
+			printf("%d/%d: removexattr - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_WRONLY);
+	if (fd < 0 && errno == EISDIR) {
+		dir = opendir_path(&f);
+		if (dir)
+			fd = dirfd(dir);
+	}
+	e = fd < 0 ? errno : 0;
+	if (fd < 0) {
+		if (v)
+			printf("%d/%d: removexattr - open %s failed %d\n",
+			       procid, opno, f.path, e);
+		free_pathname(&f);
+		if (dir)
+			closedir(dir);
+		return;
+	}
+	check_cwd();
+
+	/*
+	 * If the file/dir has xattrs, pick one randomly, otherwise attempt to
+	 * remove a xattr that doesn't exist (fremovexattr should fail with
+	 * errno set to ENOATTR (61) in this case).
+	 */
+	if (fep->xattr_counter > 0)
+		xattr_num = (random() % fep->xattr_counter) + 1;
+	else
+		xattr_num = 0;
+
+	memcpy(name, "user.x", 6);
+	sprintf(name + 6, "%d", xattr_num);
+
+	e = fremovexattr(fd, name) < 0 ? errno : 0;
+	if (v)
+		printf("%d/%d: removexattr file %s name %s %d\n",
+		       procid, opno, f.path, name, e);
+	free_pathname(&f);
+	if (dir)
+		closedir(dir);
+	else
+		close(fd);
+}
+
+void
 rename_f(int opno, long r)
 {
 	fent_t		*dfep;
-- 
2.11.0
