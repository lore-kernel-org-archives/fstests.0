Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E919C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Dec 2021 18:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhLTSQE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:16:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64476 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235769AbhLTSQA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Dec 2021 13:16:00 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BKC6N1v029457
        for <fstests@vger.kernel.org>; Mon, 20 Dec 2021 10:16:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=zn6jxkM4Y25aTbJWFdGLUkBW+V+Z0uRa1A14SVmat/k=;
 b=g3NNhp1Sv4CdZ32aXulQytRmRfItGoyG8f85dWSb/QWJlALMyTCCpzDemhxGB9waeZTw
 fPESPgVoJoki6tUnLXwUbcVbTwTg0JdL9D1exty9OTKSlH+yrr5o/0yrELQZGL9aEIaU
 jNTGwbLRlFZ1dtvFG7LRfcKzfDpYYwt/sUo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d2shkjg08-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 20 Dec 2021 10:16:00 -0800
Received: from twshared12416.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 10:15:49 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 194F184C9B81; Mon, 20 Dec 2021 10:15:45 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v5 1/2] fstress: add suport for using liburing setxattr
Date:   Mon, 20 Dec 2021 10:15:39 -0800
Message-ID: <20211220181540.1557109-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211220181540.1557109-1-shr@fb.com>
References: <20211220181540.1557109-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sg19ubFA3l_LlOFa0wvF6dAle8iwOthr
X-Proofpoint-GUID: sg19ubFA3l_LlOFa0wvF6dAle8iwOthr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_08,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112200102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Summary:

Liburing added support for setxattr. This change adds
support for this this in fsstress when fsstress is built
with liburing support.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 ltp/fsstress.c | 181 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 118 insertions(+), 63 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 5f3126e6..bc4db73a 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -142,6 +142,7 @@ typedef enum {
 	OP_UNLINK,
 	OP_UNRESVSP,
 	OP_URING_READ,
+	OP_URING_SETXATTR,
 	OP_URING_WRITE,
 	OP_WRITE,
 	OP_WRITEV,
@@ -151,6 +152,7 @@ typedef enum {
 typedef long long opnum_t;
=20
 typedef void (*opfnc_t)(opnum_t, long);
+typedef int (*setxattr_cbk)(const char *, const char *, const void *, si=
ze_t, int);
=20
 typedef struct opdesc {
 	char	*name;
@@ -273,79 +275,81 @@ void	truncate_f(opnum_t, long);
 void	unlink_f(opnum_t, long);
 void	unresvsp_f(opnum_t, long);
 void	uring_read_f(opnum_t, long);
+void	uring_setxattr_f(opnum_t, long);
 void	uring_write_f(opnum_t, long);
 void	write_f(opnum_t, long);
 void	writev_f(opnum_t, long);
 char	*xattr_flag_to_string(int);
=20
 struct opdesc	ops[OP_LAST]	=3D {
-     /* [OP_ENUM]	   =3D {"name",	       function,	freq, iswrite }, */
-	[OP_AFSYNC]	   =3D {"afsync",	       afsync_f,	0, 1 },
-	[OP_ALLOCSP]	   =3D {"allocsp",       allocsp_f,	1, 1 },
-	[OP_AREAD]	   =3D {"aread",	       aread_f,		1, 0 },
-	[OP_ATTR_REMOVE]   =3D {"attr_remove",   attr_remove_f,	0, 1 },
-	[OP_ATTR_SET]	   =3D {"attr_set",      attr_set_f,	0, 1 },
-	[OP_AWRITE]	   =3D {"awrite",	       awrite_f,	1, 1 },
-	[OP_BULKSTAT]	   =3D {"bulkstat",      bulkstat_f,	1, 0 },
-	[OP_BULKSTAT1]	   =3D {"bulkstat1",     bulkstat1_f,	1, 0 },
-	[OP_CHOWN]	   =3D {"chown",	       chown_f,		3, 1 },
-	[OP_CLONERANGE]	   =3D {"clonerange",    clonerange_f,	4, 1 },
-	[OP_COPYRANGE]	   =3D {"copyrange",     copyrange_f,	4, 1 },
-	[OP_CREAT]	   =3D {"creat",	       creat_f,		4, 1 },
-	[OP_DEDUPERANGE]   =3D {"deduperange",   deduperange_f,	4, 1 },
-	[OP_DREAD]	   =3D {"dread",	       dread_f,		4, 0 },
-	[OP_DWRITE]	   =3D {"dwrite",	       dwrite_f,	4, 1 },
-	[OP_FALLOCATE]	   =3D {"fallocate",     fallocate_f,	1, 1 },
-	[OP_FDATASYNC]	   =3D {"fdatasync",     fdatasync_f,	1, 1 },
-	[OP_FIEMAP]	   =3D {"fiemap",	       fiemap_f,	1, 1 },
-	[OP_FREESP]	   =3D {"freesp",	       freesp_f,	1, 1 },
-	[OP_FSYNC]	   =3D {"fsync",	       fsync_f,		1, 1 },
-	[OP_GETATTR]	   =3D {"getattr",       getattr_f,	1, 0 },
-	[OP_GETDENTS]	   =3D {"getdents",      getdents_f,	1, 0 },
+	/* [OP_ENUM]	   	=3D {"name",		function,		freq, iswrite }, */
+	[OP_AFSYNC]	   	=3D {"afsync",		afsync_f,		0, 1 },
+	[OP_ALLOCSP]	   	=3D {"allocsp",		allocsp_f,		1, 1 },
+	[OP_AREAD]	   	=3D {"aread",		aread_f,		1, 0 },
+	[OP_ATTR_REMOVE]   	=3D {"attr_remove",	attr_remove_f,		0, 1 },
+	[OP_ATTR_SET]	   	=3D {"attr_set",		attr_set_f,		0, 1 },
+	[OP_AWRITE]	   	=3D {"awrite",		awrite_f,		1, 1 },
+	[OP_BULKSTAT]	   	=3D {"bulkstat",		bulkstat_f,		1, 0 },
+	[OP_BULKSTAT1]	   	=3D {"bulkstat1",		bulkstat1_f,		1, 0 },
+	[OP_CHOWN]	   	=3D {"chown",		chown_f,		3, 1 },
+	[OP_CLONERANGE]	   	=3D {"clonerange",	clonerange_f,		4, 1 },
+	[OP_COPYRANGE]	   	=3D {"copyrange",		copyrange_f,		4, 1 },
+	[OP_CREAT]	   	=3D {"creat",		creat_f,		4, 1 },
+	[OP_DEDUPERANGE]   	=3D {"deduperange",	deduperange_f,		4, 1 },
+	[OP_DREAD]	   	=3D {"dread",		dread_f,		4, 0 },
+	[OP_DWRITE]	   	=3D {"dwrite",		dwrite_f,		4, 1 },
+	[OP_FALLOCATE]	   	=3D {"fallocate",		fallocate_f,		1, 1 },
+	[OP_FDATASYNC]	   	=3D {"fdatasync",		fdatasync_f,		1, 1 },
+	[OP_FIEMAP]	   	=3D {"fiemap",		fiemap_f,		1, 1 },
+	[OP_FREESP]	   	=3D {"freesp",		freesp_f,		1, 1 },
+	[OP_FSYNC]	   	=3D {"fsync",		fsync_f,		1, 1 },
+	[OP_GETATTR]	   	=3D {"getattr",		getattr_f,		1, 0 },
+	[OP_GETDENTS]	   	=3D {"getdents",		getdents_f,		1, 0 },
 	/* get extended attribute */
-	[OP_GETFATTR]	   =3D {"getfattr",      getfattr_f,	1, 0 },
-	[OP_LINK]	   =3D {"link",	       link_f,		1, 1 },
+	[OP_GETFATTR]	   	=3D {"getfattr",		getfattr_f,		1, 0 },
+	[OP_LINK]	   	=3D {"link",		link_f,			1, 1 },
 	/* list extent attributes */
-	[OP_LISTFATTR]	   =3D {"listfattr",     listfattr_f,	1, 0 },
-	[OP_MKDIR]	   =3D {"mkdir",	       mkdir_f,		2, 1 },
-	[OP_MKNOD]	   =3D {"mknod",	       mknod_f,		2, 1 },
-	[OP_MREAD]	   =3D {"mread",	       mread_f,		2, 0 },
-	[OP_MWRITE]	   =3D {"mwrite",	       mwrite_f,	2, 1 },
-	[OP_PUNCH]	   =3D {"punch",	       punch_f,		1, 1 },
-	[OP_ZERO]	   =3D {"zero",	       zero_f,		1, 1 },
-	[OP_COLLAPSE]	   =3D {"collapse",      collapse_f,	1, 1 },
-	[OP_INSERT]	   =3D {"insert",	       insert_f,	1, 1 },
-	[OP_READ]	   =3D {"read",	       read_f,		1, 0 },
-	[OP_READLINK]	   =3D {"readlink",      readlink_f,	1, 0 },
-	[OP_READV]	   =3D {"readv",	       readv_f,		1, 0 },
+	[OP_LISTFATTR]	   	=3D {"listfattr",		listfattr_f,		1, 0 },
+	[OP_MKDIR]	   	=3D {"mkdir",		mkdir_f,		2, 1 },
+	[OP_MKNOD]	   	=3D {"mknod",		mknod_f,		2, 1 },
+	[OP_MREAD]	   	=3D {"mread",		mread_f,		2, 0 },
+	[OP_MWRITE]	   	=3D {"mwrite",		mwrite_f,		2, 1 },
+	[OP_PUNCH]	   	=3D {"punch",		punch_f,		1, 1 },
+	[OP_ZERO]	   	=3D {"zero",		zero_f,			1, 1 },
+	[OP_COLLAPSE]	   	=3D {"collapse",		collapse_f,		1, 1 },
+	[OP_INSERT]	   	=3D {"insert",		insert_f,		1, 1 },
+	[OP_READ]	   	=3D {"read",		read_f,			1, 0 },
+	[OP_READLINK]	   	=3D {"readlink",		readlink_f,		1, 0 },
+	[OP_READV]	   	=3D {"readv",		readv_f,		1, 0 },
 	/* remove (delete) extended attribute */
-	[OP_REMOVEFATTR]   =3D {"removefattr",   removefattr_f,	1, 1 },
-	[OP_RENAME]	   =3D {"rename",	       rename_f,	2, 1 },
-	[OP_RNOREPLACE]	   =3D {"rnoreplace",    rnoreplace_f,	2, 1 },
-	[OP_REXCHANGE]	   =3D {"rexchange",     rexchange_f,	2, 1 },
-	[OP_RWHITEOUT]	   =3D {"rwhiteout",     rwhiteout_f,	2, 1 },
-	[OP_RESVSP]	   =3D {"resvsp",	       resvsp_f,	1, 1 },
-	[OP_RMDIR]	   =3D {"rmdir",	       rmdir_f,		1, 1 },
+	[OP_REMOVEFATTR]   	=3D {"removefattr",	removefattr_f,		1, 1 },
+	[OP_RENAME]	   	=3D {"rename",		rename_f,		2, 1 },
+	[OP_RNOREPLACE]	   	=3D {"rnoreplace",	rnoreplace_f,		2, 1 },
+	[OP_REXCHANGE]	   	=3D {"rexchange",		rexchange_f,		2, 1 },
+	[OP_RWHITEOUT]	   	=3D {"rwhiteout",		rwhiteout_f,		2, 1 },
+	[OP_RESVSP]	   	=3D {"resvsp",		resvsp_f,		1, 1 },
+	[OP_RMDIR]	   	=3D {"rmdir",		rmdir_f,		1, 1 },
 	/* set attribute flag (FS_IOC_SETFLAGS ioctl) */
-	[OP_SETATTR]	   =3D {"setattr",       setattr_f,	0, 1 },
+	[OP_SETATTR]	   	=3D {"setattr",		setattr_f,		0, 1 },
 	/* set extended attribute */
-	[OP_SETFATTR]	   =3D {"setfattr",      setfattr_f,	2, 1 },
+	[OP_SETFATTR]	   	=3D {"setfattr",		setfattr_f,		2, 1 },
 	/* set project id (XFS_IOC_FSSETXATTR ioctl) */
-	[OP_SETXATTR]	   =3D {"setxattr",      setxattr_f,	1, 1 },
-	[OP_SNAPSHOT]	   =3D {"snapshot",      snapshot_f,	1, 1 },
-	[OP_SPLICE]	   =3D {"splice",	       splice_f,	1, 1 },
-	[OP_STAT]	   =3D {"stat",	       stat_f,		1, 0 },
-	[OP_SUBVOL_CREATE] =3D {"subvol_create", subvol_create_f,	1, 1 },
-	[OP_SUBVOL_DELETE] =3D {"subvol_delete", subvol_delete_f,	1, 1 },
-	[OP_SYMLINK]	   =3D {"symlink",       symlink_f,	2, 1 },
-	[OP_SYNC]	   =3D {"sync",	       sync_f,		1, 1 },
-	[OP_TRUNCATE]	   =3D {"truncate",      truncate_f,	2, 1 },
-	[OP_UNLINK]	   =3D {"unlink",	       unlink_f,	1, 1 },
-	[OP_UNRESVSP]	   =3D {"unresvsp",      unresvsp_f,	1, 1 },
-	[OP_URING_READ]	   =3D {"uring_read",    uring_read_f,	1, 0 },
-	[OP_URING_WRITE]   =3D {"uring_write",   uring_write_f,	1, 1 },
-	[OP_WRITE]	   =3D {"write",	       write_f,		4, 1 },
-	[OP_WRITEV]	   =3D {"writev",	       writev_f,	4, 1 },
+	[OP_SETXATTR]	   	=3D {"setxattr",		setxattr_f,		1, 1 },
+	[OP_SNAPSHOT]	   	=3D {"snapshot",		snapshot_f,		1, 1 },
+	[OP_SPLICE]	   	=3D {"splice",		splice_f,		1, 1 },
+	[OP_STAT]	   	=3D {"stat",		stat_f,			1, 0 },
+	[OP_SUBVOL_CREATE] 	=3D {"subvol_create",	subvol_create_f,	1, 1 },
+	[OP_SUBVOL_DELETE] 	=3D {"subvol_delete",	subvol_delete_f,	1, 1 },
+	[OP_SYMLINK]	   	=3D {"symlink",		symlink_f,		2, 1 },
+	[OP_SYNC]	   	=3D {"sync",		sync_f,			1, 1 },
+	[OP_TRUNCATE]	   	=3D {"truncate",		truncate_f,		2, 1 },
+	[OP_UNLINK]	   	=3D {"unlink",		unlink_f,		1, 1 },
+	[OP_UNRESVSP]	   	=3D {"unresvsp",		unresvsp_f,		1, 1 },
+	[OP_URING_READ]	   	=3D {"uring_read",	uring_read_f,		1, 0 },
+	[OP_URING_SETXATTR]	=3D {"uring_setxattr",	uring_setxattr_f,	1, 1 },
+	[OP_URING_WRITE]   	=3D {"uring_write",	uring_write_f,		1, 1 },
+	[OP_WRITE]	   	=3D {"write",		write_f,		4, 1 },
+	[OP_WRITEV]	   	=3D {"writev",		writev_f,		4, 1 },
 }, *ops_end;
=20
 flist_t	flist[FT_nft] =3D {
@@ -4771,8 +4775,45 @@ setattr_f(opnum_t opno, long r)
 	close(fd);
 }
=20
+static int
+io_uring_setxattr(const char *path, const char *name, const void *value,=
 size_t size,
+		int flags)
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	int ret;
+
+	sqe =3D io_uring_get_sqe(&ring);
+	if (!sqe) {
+		printf("io_uring_get_sqe failed\n");
+		ret =3D -1;
+		goto out;
+	}
+
+	io_uring_prep_setxattr(sqe, name, value, path, flags, size);
+
+	ret =3D io_uring_submit_and_wait(&ring, 1);
+	if (ret !=3D 1) {
+		printf("io_uring_submit_and_wait failed, ret=3D%d\n", ret);
+		ret =3D -1;
+		goto out;
+	}
+
+	ret =3D io_uring_wait_cqe(&ring, &cqe);
+	if (ret < 0) {
+		printf("io_uring_wait_cqe failed, ret=3D%d\n", ret);
+		goto out;
+	}
+
+	ret =3D cqe->res;
+	io_uring_cqe_seen(&ring, cqe);
+
+out:
+	return ret;
+}
+
 void
-setfattr_f(opnum_t opno, long r)
+setfattr_f_cbk(opnum_t opno, long r, setxattr_cbk cbk)
 {
 	int		e;
 	pathname_t	f;
@@ -4834,7 +4875,7 @@ setfattr_f(opnum_t opno, long r)
 		goto out;
 	}
=20
-	e =3D setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
+	e =3D cbk(f.path, name, value, value_len, flag) < 0 ? errno : 0;
 	if (e =3D=3D 0)
 		fep->xattr_counter++;
 	if (v)
@@ -4846,6 +4887,20 @@ out:
 	free_pathname(&f);
 }
=20
+void
+uring_setxattr_f(opnum_t opno, long r)
+{
+#ifdef URING
+	setfattr_f_cbk(opno, r, io_uring_setxattr);
+#endif
+}
+
+void
+setfattr_f(opnum_t opno, long r)
+{
+	setfattr_f_cbk(opno, r, setxattr);
+}
+
 void
 snapshot_f(opnum_t opno, long r)
 {
--=20
2.30.2

