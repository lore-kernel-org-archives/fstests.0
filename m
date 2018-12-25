Received: from mx1.redhat.com ([209.132.183.28]:36860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbeLYI4j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Dec 2018 03:56:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3655E36809
        for <fstests@vger.kernel.org>; Tue, 25 Dec 2018 08:56:39 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DF3E101963A
        for <fstests@vger.kernel.org>; Tue, 25 Dec 2018 08:56:38 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 1/2] fsstress: add splice support
Date: Tue, 25 Dec 2018 16:56:31 +0800
Message-Id: <20181225085632.9875-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Support the splice syscall in fsstress.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 ltp/fsstress.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 99a1d733..cdf73026 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -85,6 +85,7 @@ typedef enum {
 	OP_RMDIR,
 	OP_SETATTR,
 	OP_SETXATTR,
+	OP_SPLICE,
 	OP_STAT,
 	OP_SYMLINK,
 	OP_SYNC,
@@ -194,6 +195,7 @@ void	resvsp_f(int, long);
 void	rmdir_f(int, long);
 void	setattr_f(int, long);
 void	setxattr_f(int, long);
+void	splice_f(int, long);
 void	stat_f(int, long);
 void	symlink_f(int, long);
 void	sync_f(int, long);
@@ -244,6 +246,7 @@ opdesc_t	ops[] = {
 	{ OP_RMDIR, "rmdir", rmdir_f, 1, 1 },
 	{ OP_SETATTR, "setattr", setattr_f, 0, 1 },
 	{ OP_SETXATTR, "setxattr", setxattr_f, 1, 1 },
+	{ OP_SPLICE, "splice", splice_f, 1, 1 },
 	{ OP_STAT, "stat", stat_f, 1, 0 },
 	{ OP_SYMLINK, "symlink", symlink_f, 2, 1 },
 	{ OP_SYNC, "sync", sync_f, 1, 1 },
@@ -2764,6 +2767,147 @@ setxattr_f(int opno, long r)
 #endif
 }
 
+void
+splice_f(int opno, long r)
+{
+	struct pathname		fpath1;
+	struct pathname		fpath2;
+	struct stat64		stat1;
+	struct stat64		stat2;
+	char			inoinfo1[1024];
+	char			inoinfo2[1024];
+	loff_t			lr;
+	loff_t			off1;
+	loff_t			off2;
+	size_t			len;
+	size_t			total;
+	int			v1;
+	int			v2;
+	int			fd1;
+	int			fd2;
+	size_t			ret;
+	int			e;
+	int			filedes[2];
+
+	/* Load paths */
+	init_pathname(&fpath1);
+	if (!get_fname(FT_REGm, r, &fpath1, NULL, NULL, &v1)) {
+		if (v1)
+			printf("%d/%d: splice read - no filename\n",
+				procid, opno);
+		goto out_fpath1;
+	}
+
+	init_pathname(&fpath2);
+	if (!get_fname(FT_REGm, random(), &fpath2, NULL, NULL, &v2)) {
+		if (v2)
+			printf("%d/%d: splice write - no filename\n",
+				procid, opno);
+		goto out_fpath2;
+	}
+
+	/* Open files */
+	fd1 = open_path(&fpath1, O_RDONLY);
+	e = fd1 < 0 ? errno : 0;
+	check_cwd();
+	if (fd1 < 0) {
+		if (v1)
+			printf("%d/%d: splice read - open %s failed %d\n",
+				procid, opno, fpath1.path, e);
+		goto out_fpath2;
+	}
+
+	fd2 = open_path(&fpath2, O_WRONLY);
+	e = fd2 < 0 ? errno : 0;
+	check_cwd();
+	if (fd2 < 0) {
+		if (v2)
+			printf("%d/%d: splice write - open %s failed %d\n",
+				procid, opno, fpath2.path, e);
+		goto out_fd1;
+	}
+
+	/* Get file stats */
+	if (fstat64(fd1, &stat1) < 0) {
+		if (v1)
+			printf("%d/%d: splice read - fstat64 %s failed %d\n",
+				procid, opno, fpath1.path, errno);
+		goto out_fd2;
+	}
+	inode_info(inoinfo1, sizeof(inoinfo1), &stat1, v1);
+
+	if (fstat64(fd2, &stat2) < 0) {
+		if (v2)
+			printf("%d/%d: splice write - fstat64 %s failed %d\n",
+				procid, opno, fpath2.path, errno);
+		goto out_fd2;
+	}
+	inode_info(inoinfo2, sizeof(inoinfo2), &stat2, v2);
+
+	/* Calculate offsets */
+	len = (random() % FILELEN_MAX) + 1;
+	if (len == 0)
+		len = stat1.st_blksize;
+	if (len > stat1.st_size)
+		len = stat1.st_size;
+
+	lr = ((int64_t)random() << 32) + random();
+	if (stat1.st_size == len)
+		off1 = 0;
+	else
+		off1 = (off64_t)(lr % MIN(stat1.st_size - len, MAXFSIZE));
+	off1 %= maxfsize;
+
+	if (pipe(filedes) < 0) {
+		if (v1 || v2) {
+			printf("%d/%d: splice - pipe failed %d\n",
+			       procid, opno, errno);
+			goto out_fd2;
+		}
+	}
+
+	while (len > 0) {
+		/* move to pipe buffer */
+		ret = splice(fd1, &off1, filedes[1], NULL, len, 0);
+		if (ret < 0) {
+			break;
+		}
+		/* move from pipe buffer to dst file */
+		ret = splice(filedes[0], NULL, fd2, &off2, len, 0);
+		if (ret < 0) {
+			break;
+		}
+                len -= ret;
+                total += ret;
+	}
+
+	e = ret < 0 ? errno : 0;
+	if (v1 || v2) {
+		printf("%d/%d: splice %s%s [%lld,%lld] -> %s%s [%lld,%lld]",
+			procid, opno,
+			fpath1.path, inoinfo1, (long long)off1, (long long)len,
+			fpath2.path, inoinfo2, (long long)off2, (long long)len);
+
+		if (ret < 0)
+			printf(" error %d", e);
+		else if (len && ret > len)
+			printf(" asked for %lld, copied %lld??\n",
+				(long long)len, (long long)total);
+		printf("\n");
+	}
+
+	close(filedes[0]);
+	close(filedes[1]);
+out_fd2:
+	close(fd2);
+out_fd1:
+	close(fd1);
+out_fpath2:
+	free_pathname(&fpath2);
+out_fpath1:
+	free_pathname(&fpath1);
+}
+
 void
 creat_f(int opno, long r)
 {
-- 
2.17.2
