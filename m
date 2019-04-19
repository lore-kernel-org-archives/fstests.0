Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbfDSS3R (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
From: fdmanana@kernel.org
Subject: [PATCH v4 5/7] fsstress: add operation for deleting xattrs from files and directories
Date: Fri, 19 Apr 2019 11:54:48 +0100
Message-Id: <20190419105448.11984-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The previous patches added support for operations to set and get xattrs on
regular files and directories, this patch just adds one operation to delete
xattrs on files and directories.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Use a different name for the operation (delfattr) and make use of the
    helper functions for opening and closing files or directories, introduced
    in the first patch of this series.
V3: Simplified implementation to not need to open a file descriptor and
    use a path string instead.  
V4: Addressed Eryu's comments.

 ltp/fsstress.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index f24dd42d..74100948 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -82,6 +82,7 @@ typedef enum {
 	OP_READ,
 	OP_READLINK,
 	OP_READV,
+	OP_REMOVEFATTR,
 	OP_RENAME,
 	OP_RESVSP,
 	OP_RMDIR,
@@ -198,6 +199,7 @@ void	insert_f(int, long);
 void	read_f(int, long);
 void	readlink_f(int, long);
 void	readv_f(int, long);
+void	removefattr_f(int, long);
 void	rename_f(int, long);
 void	resvsp_f(int, long);
 void	rmdir_f(int, long);
@@ -253,6 +255,8 @@ opdesc_t	ops[] = {
 	{ OP_READ, "read", read_f, 1, 0 },
 	{ OP_READLINK, "readlink", readlink_f, 1, 0 },
 	{ OP_READV, "readv", readv_f, 1, 0 },
+	/* remove (delete) extended attribute */
+	{ OP_REMOVEFATTR, "removefattr", removefattr_f, 1, 1 },
 	{ OP_RENAME, "rename", rename_f, 2, 1 },
 	{ OP_RESVSP, "resvsp", resvsp_f, 1, 1 },
 	{ OP_RMDIR, "rmdir", rmdir_f, 1, 1 },
@@ -4115,6 +4119,49 @@ readv_f(int opno, long r)
 }
 
 void
+removefattr_f(int opno, long r)
+{
+	fent_t	        *fep;
+	int		e;
+	pathname_t	f;
+	int		v;
+	char            name[XATTR_NAME_BUF_SIZE];
+	int             xattr_num;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+		if (v)
+			printf("%d/%d: removefattr - no filename\n", procid, opno);
+		goto out;
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
+	e = generate_xattr_name(xattr_num, name, sizeof(name));
+	if (e < 0) {
+		printf("%d/%d: removefattr - file %s failed to generate xattr name: %d\n",
+		       procid, opno, f.path, e);
+		goto out;
+	}
+
+	e = removexattr(f.path, name) < 0 ? errno : 0;
+	if (v)
+		printf("%d/%d: removefattr file %s name %s %d\n",
+		       procid, opno, f.path, name, e);
+out:
+	free_pathname(&f);
+}
+
+void
 rename_f(int opno, long r)
 {
 	fent_t		*dfep;
-- 
2.11.0
