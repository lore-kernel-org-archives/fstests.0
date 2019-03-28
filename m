Received: from mail.kernel.org ([198.145.29.99]:44960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1Sx7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Mar 2019 14:53:59 -0400
From: fdmanana@kernel.org
Subject: [PATCH 1/7] fsstress: rename setxattr operation to chproj
Date: Thu, 28 Mar 2019 18:53:52 +0000
Message-Id: <20190328185352.28829-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The existing setxattr operation is used to change the project identifier
attribute associated with an inode, and not about setting a xattr (the
name and value pair) for a file/directory, which is confusing. So rename
the operation to chproj, which is more descriptive about what it does
and avoids any confusion.

Fsstress currently has no operations for setting and getting xattrs of a
file (for any namespace), and this patch is a preparation for adding such
operations in a subsequent patch.

This operation actually used to be named chproj until the following
commit:

 commit 6449a993f2dfb3faaaa44e29d2f7d1bb7c5db9ba
 Author: Nathan Scott <nathans@sgi.com>
 Date:   Mon Dec 5 21:41:47 2005 +0000

     Switch to always using get/setxattr rather than a separate projid call on IRIX.
     Merge of master-melb:xfs-cmds:24692a by kenmcd.

Which does not explain the rationale for the renaming at all.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsstress.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 2223fd7d..cc4f520e 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -55,6 +55,7 @@ typedef enum {
 	OP_BULKSTAT,
 	OP_BULKSTAT1,
 	OP_CHOWN,
+	OP_CHPROJ,
 	OP_CLONERANGE,
 	OP_COPYRANGE,
 	OP_CREAT,
@@ -84,7 +85,6 @@ typedef enum {
 	OP_RESVSP,
 	OP_RMDIR,
 	OP_SETATTR,
-	OP_SETXATTR,
 	OP_SPLICE,
 	OP_STAT,
 	OP_SYMLINK,
@@ -165,6 +165,7 @@ void	awrite_f(int, long);
 void	bulkstat_f(int, long);
 void	bulkstat1_f(int, long);
 void	chown_f(int, long);
+void	chproj_f(int, long);
 void	clonerange_f(int, long);
 void	copyrange_f(int, long);
 void	creat_f(int, long);
@@ -194,7 +195,6 @@ void	rename_f(int, long);
 void	resvsp_f(int, long);
 void	rmdir_f(int, long);
 void	setattr_f(int, long);
-void	setxattr_f(int, long);
 void	splice_f(int, long);
 void	stat_f(int, long);
 void	symlink_f(int, long);
@@ -216,6 +216,7 @@ opdesc_t	ops[] = {
 	{ OP_BULKSTAT, "bulkstat", bulkstat_f, 1, 0 },
 	{ OP_BULKSTAT1, "bulkstat1", bulkstat1_f, 1, 0 },
 	{ OP_CHOWN, "chown", chown_f, 3, 1 },
+	{ OP_CHPROJ, "chproj", chproj_f, 1, 1 },
 	{ OP_CLONERANGE, "clonerange", clonerange_f, 4, 1 },
 	{ OP_COPYRANGE, "copyrange", copyrange_f, 4, 1 },
 	{ OP_CREAT, "creat", creat_f, 4, 1 },
@@ -245,7 +246,6 @@ opdesc_t	ops[] = {
 	{ OP_RESVSP, "resvsp", resvsp_f, 1, 1 },
 	{ OP_RMDIR, "rmdir", rmdir_f, 1, 1 },
 	{ OP_SETATTR, "setattr", setattr_f, 0, 1 },
-	{ OP_SETXATTR, "setxattr", setxattr_f, 1, 1 },
 	{ OP_SPLICE, "splice", splice_f, 1, 1 },
 	{ OP_STAT, "stat", stat_f, 1, 0 },
 	{ OP_SYMLINK, "symlink", symlink_f, 2, 1 },
@@ -2732,7 +2732,7 @@ out_fdr:
 }
 
 void
-setxattr_f(int opno, long r)
+chproj_f(int opno, long r)
 {
 #ifdef XFS_XFLAG_EXTSIZE
 	struct fsxattr	fsx;
@@ -2761,7 +2761,7 @@ setxattr_f(int opno, long r)
 		e = xfsctl(f.path, fd, XFS_IOC_FSSETXATTR, &fsx);
 	}
 	if (v)
-		printf("%d/%d: setxattr %s %u %d\n", procid, opno, f.path, p, e);
+		printf("%d/%d: chproj %s %u %d\n", procid, opno, f.path, p, e);
 	free_pathname(&f);
 	close(fd);
 #endif
-- 
2.11.0
