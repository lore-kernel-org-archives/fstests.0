Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbfDSS3R (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
From: fdmanana@kernel.org
Subject: [PATCH v4 6/7] fsstress: add operation for listing xattrs from files and directories
Date: Fri, 19 Apr 2019 11:55:00 +0100
Message-Id: <20190419105500.12034-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The previous patches added support for operations to set, get and delete
xattrs on regular files and directories, this patch just adds an operation
to list the xattrs of a file/directory.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: New patch in the series, the first version of the patchset did not include
    this patch.
V3: Simplified implementation to not need to open a file descriptor and
    use a path string instead.  
V4: Addressed Eryu's comments.

 ltp/fsstress.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 74100948..450cf4f1 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -71,6 +71,7 @@ typedef enum {
 	OP_GETDENTS,
 	OP_GETFATTR,
 	OP_LINK,
+	OP_LISTFATTR,
 	OP_MKDIR,
 	OP_MKNOD,
 	OP_MREAD,
@@ -188,6 +189,7 @@ void	getattr_f(int, long);
 void	getdents_f(int, long);
 void	getfattr_f(int, long);
 void	link_f(int, long);
+void	listfattr_f(int, long);
 void	mkdir_f(int, long);
 void	mknod_f(int, long);
 void	mread_f(int, long);
@@ -244,6 +246,8 @@ opdesc_t	ops[] = {
 	/* get extended attribute */
 	{ OP_GETFATTR, "getfattr", getfattr_f, 1, 0 },
 	{ OP_LINK, "link", link_f, 1, 1 },
+	/* list extent attributes */
+	{ OP_LISTFATTR, "listfattr", listfattr_f, 1, 0 },
 	{ OP_MKDIR, "mkdir", mkdir_f, 2, 1 },
 	{ OP_MKNOD, "mknod", mknod_f, 2, 1 },
 	{ OP_MREAD, "mread", mread_f, 2, 0 },
@@ -3723,6 +3727,56 @@ link_f(int opno, long r)
 }
 
 void
+listfattr_f(int opno, long r)
+{
+	fent_t	        *fep;
+	int		e;
+	pathname_t	f;
+	int		v;
+	char            *buffer = NULL;
+	int             buffer_len;
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+		if (v)
+			printf("%d/%d: listfattr - no filename\n", procid, opno);
+		goto out;
+	}
+	check_cwd();
+
+	e = listxattr(f.path, NULL, 0);
+	if (e < 0) {
+		if (v)
+			printf("%d/%d: listfattr %s failed %d\n",
+			       procid, opno, f.path, errno);
+		goto out;
+	}
+	buffer_len = e;
+	if (buffer_len == 0) {
+		if (v)
+			printf("%d/%d: listfattr %s - has no extended attributes\n",
+			       procid, opno, f.path);
+		goto out;
+	}
+
+	buffer = malloc(buffer_len);
+	if (!buffer) {
+		if (v)
+			printf("%d/%d: listfattr %s failed to allocate buffer with %d bytes\n",
+			       procid, opno, f.path, buffer_len);
+		goto out;
+	}
+
+	e = listxattr(f.path, buffer, buffer_len) < 0 ? errno : 0;
+	if (v)
+		printf("%d/%d: listfattr %s buffer length %d %d\n",
+		       procid, opno, f.path, buffer_len, e);
+out:
+	free(buffer);
+	free_pathname(&f);
+}
+
+void
 mkdir_f(int opno, long r)
 {
 	int		e;
-- 
2.11.0
