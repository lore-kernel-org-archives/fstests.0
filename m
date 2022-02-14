Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA81AC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Feb 2022 11:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbiBNLzl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:55:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiBNLzl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Feb 2022 06:55:41 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4346CC3A
        for <fstests@vger.kernel.org>; Mon, 14 Feb 2022 03:55:33 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jy2dV14kpz8wbn
        for <fstests@vger.kernel.org>; Mon, 14 Feb 2022 19:52:14 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 19:55:31 +0800
Received: from huawei.com (10.67.174.154) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Feb
 2022 19:55:31 +0800
From:   Chen Long <chenlongcl.chen@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <chenlongcl.chen@huawei.com>
Subject: [PATCH] fsstress: add new syscall(fadvise) to op list
Date:   Mon, 14 Feb 2022 19:55:34 +0800
Message-ID: <20220214115534.50514-1-chenlongcl.chen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.154]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

fsstress currently does not support fadvise operation, in order to
enrich the operation of fsstress, add posix_fadvise operation.

Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
---
 ltp/fsstress.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 5f3126e6..7f81817f 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -85,6 +85,12 @@ static int renameat2(int dfd1, const char *path1,
 #define FILELEN_MAX		(32*4096)
 
 typedef enum {
+	OP_FADV_NORMAL,
+	OP_FADV_SEQUENTIAL,
+	OP_FADV_RANDOM,
+	OP_FADV_NOREUSE,
+	OP_FADV_WILLNEED,
+	OP_FADV_DONTNEED,
 	OP_AFSYNC,
 	OP_ALLOCSP,
 	OP_AREAD,
@@ -230,6 +236,12 @@ void	creat_f(opnum_t, long);
 void	deduperange_f(opnum_t, long);
 void	dread_f(opnum_t, long);
 void	dwrite_f(opnum_t, long);
+void	fadv_normal_f(opnum_t, long);
+void	fadv_sequential_f(opnum_t, long);
+void	fadv_random_f(opnum_t, long);
+void	fadv_noreuse_f(opnum_t, long);
+void	fadv_willneed_f(opnum_t, long);
+void	fadv_dontneed_f(opnum_t, long);
 void	fallocate_f(opnum_t, long);
 void	fdatasync_f(opnum_t, long);
 void	fiemap_f(opnum_t, long);
@@ -295,6 +307,12 @@ struct opdesc	ops[OP_LAST]	= {
 	[OP_DEDUPERANGE]   = {"deduperange",   deduperange_f,	4, 1 },
 	[OP_DREAD]	   = {"dread",	       dread_f,		4, 0 },
 	[OP_DWRITE]	   = {"dwrite",	       dwrite_f,	4, 1 },
+	[OP_FADV_NORMAL]    = {"fadv_normal",	fadv_normal_f,    1, 0 },
+	[OP_FADV_SEQUENTIAL]	= {"fadv_sequential",   fadv_sequential_f,    1, 0 },
+	[OP_FADV_RANDOM]    = {"fadv_random",   fadv_random_f,    1, 0 },
+	[OP_FADV_NOREUSE]    = {"fadv_noreuse",   fadv_noreuse_f,    1, 0 },
+	[OP_FADV_WILLNEED]    = {"fadv_willneed",   fadv_willneed_f,    1, 0 },
+	[OP_FADV_DONTNEED]    = {"fadv_dontneed",   fadv_dontneed_f,    1, 0 },
 	[OP_FALLOCATE]	   = {"fallocate",     fallocate_f,	1, 1 },
 	[OP_FDATASYNC]	   = {"fdatasync",     fdatasync_f,	1, 1 },
 	[OP_FIEMAP]	   = {"fiemap",	       fiemap_f,	1, 1 },
@@ -5337,3 +5355,91 @@ xattr_flag_to_string(int flag)
 		return "replace";
 	return "none";
 }
+
+void
+do_posix_fadvise(opnum_t opno, long r, int advice)
+{
+	int		fd;
+	size_t		len;
+	off64_t		off;
+	int			e;
+	pathname_t	f;
+	int64_t		lr;
+	struct stat64	stb;
+	int		v;
+	char		st[1024];
+
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGm, r, &f, NULL, NULL, &v)) {
+		if (v)
+			printf("%d/%lld: fadvise - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_RDWR);
+	e = fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%lld: fadvise - open %s failed %d\n",
+				   procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%lld: fadvise - fstat64 %s failed %d\n",
+				   procid, opno, f.path, errno);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	inode_info(st, sizeof(st), &stb, v);
+	lr = ((int64_t)random() << 32) + random();
+	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	off %= maxfsize;
+	len = (random() % FILELEN_MAX) + 1;
+	e = posix_fadvise(fd, off, len, advice);
+	if (v)
+		printf("%d/%lld: fadvise %s%s %lld %d %d\n", procid, opno, f.path,
+			   st, (long long)off, advice, e);
+	free_pathname(&f);
+	close(fd);
+}
+
+void
+fadv_normal_f(opnum_t opno, long r)
+{
+	do_posix_fadvise(opno, r, POSIX_FADV_NORMAL);
+}
+
+void
+fadv_sequential_f(opnum_t opno, long r)
+{
+	do_posix_fadvise(opno, r, POSIX_FADV_SEQUENTIAL);
+}
+
+void
+fadv_random_f(opnum_t opno, long r)
+{
+	do_posix_fadvise(opno, r, POSIX_FADV_RANDOM);
+}
+
+void
+fadv_noreuse_f(opnum_t opno, long r)
+{
+	do_posix_fadvise(opno, r, POSIX_FADV_NOREUSE);
+}
+
+void
+fadv_willneed_f(opnum_t opno, long r)
+{
+	do_posix_fadvise(opno, r, POSIX_FADV_WILLNEED);
+}
+
+void
+fadv_dontneed_f(opnum_t opno, long r)
+{
+	do_posix_fadvise(opno, r, POSIX_FADV_DONTNEED);
+}
-- 
2.17.1

