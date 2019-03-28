Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1SyX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 14:54:23 -0400
From: fdmanana@kernel.org
Subject: [PATCH 3/7] fsstress: add operation for reading xattrs from files and directories
Date: Thu, 28 Mar 2019 18:54:16 +0000
Message-Id: <20190328185416.28930-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The previous patch added support for an operation to set xattrs on regular
files and directories, this patch just adds one operation to read (get)
them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsstress.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 03e40eb6..d7ea1da0 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -70,6 +70,7 @@ typedef enum {
 	OP_FSYNC,
 	OP_GETATTR,
 	OP_GETDENTS,
+	OP_GETXATTR,
 	OP_LINK,
 	OP_MKDIR,
 	OP_MKNOD,
@@ -182,6 +183,7 @@ void	freesp_f(int, long);
 void	fsync_f(int, long);
 void	getattr_f(int, long);
 void	getdents_f(int, long);
+void	getxattr_f(int, long);
 void	link_f(int, long);
 void	mkdir_f(int, long);
 void	mknod_f(int, long);
@@ -234,6 +236,7 @@ opdesc_t	ops[] = {
 	{ OP_FSYNC, "fsync", fsync_f, 1, 1 },
 	{ OP_GETATTR, "getattr", getattr_f, 1, 0 },
 	{ OP_GETDENTS, "getdents", getdents_f, 1, 0 },
+	{ OP_GETXATTR, "getxattr", getxattr_f, 2, 0 },
 	{ OP_LINK, "link", link_f, 1, 1 },
 	{ OP_MKDIR, "mkdir", mkdir_f, 2, 1 },
 	{ OP_MKNOD, "mknod", mknod_f, 2, 1 },
@@ -3522,6 +3525,87 @@ getdents_f(int opno, long r)
 }
 
 void
+getxattr_f(int opno, long r)
+{
+	int		fd;
+	fent_t	        *fep;
+	int		e;
+	pathname_t	f;
+	int		v;
+	char            name[18];
+	char            *value = NULL;
+	int             value_len;
+	int             xattr_num;
+	DIR             *dir = NULL;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+		if (v)
+			printf("%d/%d: getxattr - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_RDONLY);
+	if (fd < 0 && errno == EISDIR) {
+		dir = opendir_path(&f);
+		if (dir)
+			fd = dirfd(dir);
+	}
+	e = fd < 0 ? errno : 0;
+	if (fd < 0) {
+		if (v)
+			printf("%d/%d: getxattr - open %s failed %d\n",
+			       procid, opno, f.path, e);
+		free_pathname(&f);
+		if (dir)
+			closedir(dir);
+		return;
+	}
+	check_cwd();
+
+	/*
+	 * If the file/dir has xattrs, pick one randomly, otherwise attempt
+	 * to read a xattr that doesn't exist (fgetxattr should fail with
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
+	value_len = fgetxattr(fd, name, NULL, 0);
+	if (value_len < 0) {
+		if (v)
+			printf("%d/%d: getxattr file %s failed %d\n",
+			       procid, opno, f.path, errno);
+		goto out;
+	}
+
+	value = malloc(value_len);
+	if (!value) {
+		if (v)
+			printf("%d/%d: getxattr file %s failed to allocate buffer with %d bytes\n",
+			       procid, opno, f.path, value_len);
+		goto out;
+	}
+
+	e = fgetxattr(fd, name, value, value_len) < 0 ? errno : 0;
+	if (v)
+		printf("%d/%d: getxattr file %s name %s value length %d %d\n",
+		       procid, opno, f.path, name, value_len, e);
+out:
+	free(value);
+	free_pathname(&f);
+	if (dir)
+		closedir(dir);
+	else
+		close(fd);
+}
+
+void
 link_f(int opno, long r)
 {
 	int		e;
-- 
2.11.0
