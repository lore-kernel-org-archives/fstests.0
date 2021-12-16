Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18972C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 17:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhLPR0b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:26:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41818 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239805AbhLPR0a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 12:26:30 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGHMTVE021034
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 09:26:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LnrL4h64TCHkhSmikAepcGcFzY/PgMVO0GaRXEALtTs=;
 b=Hsef7RjCjBBdIAY/CB5o88RDnbsyRObNJ98qrQSChbvAwYjBpvGobD6Oh4kBjj9fuln+
 WIfvKV2HF4w5esRp3h9xO+/6ORy9F70lt27Y9FyZ8VDdD7SbaYUqqFoqAyVRpapKFEnI
 wyaLsoxShxWqmJkNL/kreYsbVSlxcFLPOb0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d09t2g10d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 09:26:29 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 09:26:28 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 20BD1823FAE1; Thu, 16 Dec 2021 09:26:21 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v3 1/2] fstress: add suport for using liburing setxattr
Date:   Thu, 16 Dec 2021 09:26:18 -0800
Message-ID: <20211216172619.4034842-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216172619.4034842-1-shr@fb.com>
References: <20211216172619.4034842-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 42ZiUgRptha9ku-Lw-I046jpb4JLekdj
X-Proofpoint-GUID: 42ZiUgRptha9ku-Lw-I046jpb4JLekdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_05,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112160098
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
 ltp/fsstress.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 5f3126e6..48d93436 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -145,12 +145,14 @@ typedef enum {
 	OP_URING_WRITE,
 	OP_WRITE,
 	OP_WRITEV,
+	OP_URING_SETXATTR,
 	OP_LAST
 } opty_t;
=20
 typedef long long opnum_t;
=20
 typedef void (*opfnc_t)(opnum_t, long);
+typedef int (*setxattr_cbk)(const char *, const char *, const void *, si=
ze_t, int);
=20
 typedef struct opdesc {
 	char	*name;
@@ -276,6 +278,7 @@ void	uring_read_f(opnum_t, long);
 void	uring_write_f(opnum_t, long);
 void	write_f(opnum_t, long);
 void	writev_f(opnum_t, long);
+void	uring_setxattr_f(opnum_t, long);
 char	*xattr_flag_to_string(int);
=20
 struct opdesc	ops[OP_LAST]	=3D {
@@ -346,6 +349,7 @@ struct opdesc	ops[OP_LAST]	=3D {
 	[OP_URING_WRITE]   =3D {"uring_write",   uring_write_f,	1, 1 },
 	[OP_WRITE]	   =3D {"write",	       write_f,		4, 1 },
 	[OP_WRITEV]	   =3D {"writev",	       writev_f,	4, 1 },
+	[OP_URING_SETXATTR] =3D {"uring_setxattr", uring_setxattr_f, 1, 1 },
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
+	  	 int flags)
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
+    	}
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

