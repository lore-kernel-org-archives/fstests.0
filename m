Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfDDQag (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Apr 2019 12:30:36 -0400
From: fdmanana@kernel.org
Subject: [PATCH v3 4/7] fsstress: add operation for reading xattrs from files and directories
Date: Thu,  4 Apr 2019 17:30:30 +0100
Message-Id: <20190404163030.19179-1-fdmanana@kernel.org>
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

V2: Use a different name for the operation (getfattr) and make use of the
    helper functions for opening and closing files or directories, introduced
    in the first patch of this series.
V3: Simplified implementation to not need to open a file descriptor and
    use a path string instead.  

 ltp/fsstress.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index d1db19da..7c924e01 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -69,6 +69,7 @@ typedef enum {
 	OP_FSYNC,
 	OP_GETATTR,
 	OP_GETDENTS,
+	OP_GETFATTR,
 	OP_LINK,
 	OP_MKDIR,
 	OP_MKNOD,
@@ -184,6 +185,7 @@ void	fsync_f(int, long);
 char	*gen_random_string(int);
 void	getattr_f(int, long);
 void	getdents_f(int, long);
+void	getfattr_f(int, long);
 void	link_f(int, long);
 void	mkdir_f(int, long);
 void	mknod_f(int, long);
@@ -237,6 +239,7 @@ opdesc_t	ops[] = {
 	{ OP_FSYNC, "fsync", fsync_f, 1, 1 },
 	{ OP_GETATTR, "getattr", getattr_f, 1, 0 },
 	{ OP_GETDENTS, "getdents", getdents_f, 1, 0 },
+	{ OP_GETFATTR, "getfattr", getfattr_f, 2, 0 },
 	{ OP_LINK, "link", link_f, 1, 1 },
 	{ OP_MKDIR, "mkdir", mkdir_f, 2, 1 },
 	{ OP_MKNOD, "mknod", mknod_f, 2, 1 },
@@ -3585,6 +3588,70 @@ getdents_f(int opno, long r)
 }
 
 void
+getfattr_f(int opno, long r)
+{
+	fent_t	        *fep;
+	int		e;
+	pathname_t	f;
+	int		v;
+	char            name[XATTR_NAME_BUF_SIZE];
+	char            *value = NULL;
+	int             value_len;
+	int             xattr_num;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+		if (v)
+			printf("%d/%d: getfattr - no filename\n", procid, opno);
+		goto out;
+	}
+	check_cwd();
+
+	/*
+	 * If the file/dir has xattrs, pick one randomly, otherwise attempt
+	 * to read a xattr that doesn't exist (getxattr should fail with
+	 * errno set to ENOATTR (61) in this case).
+	 */
+	if (fep->xattr_counter > 0)
+		xattr_num = (random() % fep->xattr_counter) + 1;
+	else
+		xattr_num = 0;
+
+	generate_xattr_name(xattr_num, name);
+
+	value_len = getxattr(f.path, name, NULL, 0);
+	if (value_len < 0) {
+		if (v)
+			printf("%d/%d: getfattr file %s name %s failed %d\n",
+			       procid, opno, f.path, name, errno);
+		goto out;
+	}
+
+	/* A xattr without value.*/
+	if (value_len == 0) {
+		e = 0;
+		goto out_log;
+	}
+
+	value = malloc(value_len);
+	if (!value) {
+		if (v)
+			printf("%d/%d: getfattr file %s failed to allocate buffer with %d bytes\n",
+			       procid, opno, f.path, value_len);
+		goto out;
+	}
+
+	e = getxattr(f.path, name, value, value_len) < 0 ? errno : 0;
+out_log:
+	if (v)
+		printf("%d/%d: getfattr file %s name %s value length %d %d\n",
+		       procid, opno, f.path, name, value_len, e);
+out:
+	free(value);
+	free_pathname(&f);
+}
+
+void
 link_f(int opno, long r)
 {
 	int		e;
-- 
2.11.0
