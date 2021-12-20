Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86421C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Dec 2021 18:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbhLTSQE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:16:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30500 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232777AbhLTSQA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Dec 2021 13:16:00 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BKHNhuY008403
        for <fstests@vger.kernel.org>; Mon, 20 Dec 2021 10:16:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kah7li1vYIV9zvMRkB8+JbYEgjGfhybErksyiN57sJU=;
 b=cbzFwSYtCnAYhrSo0I+OEDucWPB7hi9LWpF9qtextg4Ikm28euFqCF/Pg+cTj9gZ0dXp
 D+V7mDlswP3QK2/0uv3JU7877teI7hA9YI5nEZvF7cJmlt0K23LLRQARa7t24jzxUyih
 jnTwg5Ko6L2UaPCnBJLbFYLgkGN2JFnWPWk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d2maq4g4g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 20 Dec 2021 10:16:00 -0800
Received: from twshared7460.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 10:15:59 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 1EB7A84C9B83; Mon, 20 Dec 2021 10:15:45 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v5 2/2] fstress: add suport for using liburing getxattr
Date:   Mon, 20 Dec 2021 10:15:40 -0800
Message-ID: <20211220181540.1557109-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211220181540.1557109-1-shr@fb.com>
References: <20211220181540.1557109-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FwXEh5-7BG9VIc01iYIN3qmp7p_zSr2P
X-Proofpoint-ORIG-GUID: FwXEh5-7BG9VIc01iYIN3qmp7p_zSr2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_08,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 mlxlogscore=895 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112200102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Liburing added support for getxattr. This change adds
support for this this in fsstress when fsstress is built
with liburing support.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 ltp/fsstress.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index bc4db73a..efd154a6 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -141,6 +141,7 @@ typedef enum {
 	OP_TRUNCATE,
 	OP_UNLINK,
 	OP_UNRESVSP,
+	OP_URING_GETXATTR,
 	OP_URING_READ,
 	OP_URING_SETXATTR,
 	OP_URING_WRITE,
@@ -152,6 +153,7 @@ typedef enum {
 typedef long long opnum_t;
=20
 typedef void (*opfnc_t)(opnum_t, long);
+typedef ssize_t (*getxattr_cbk)(const char *, const char *, void *, size=
_t);
 typedef int (*setxattr_cbk)(const char *, const char *, const void *, si=
ze_t, int);
=20
 typedef struct opdesc {
@@ -274,6 +276,7 @@ void	sync_f(opnum_t, long);
 void	truncate_f(opnum_t, long);
 void	unlink_f(opnum_t, long);
 void	unresvsp_f(opnum_t, long);
+void	uring_getxattr_f(opnum_t, long);
 void	uring_read_f(opnum_t, long);
 void	uring_setxattr_f(opnum_t, long);
 void	uring_write_f(opnum_t, long);
@@ -345,6 +348,7 @@ struct opdesc	ops[OP_LAST]	=3D {
 	[OP_TRUNCATE]	   	=3D {"truncate",		truncate_f,		2, 1 },
 	[OP_UNLINK]	   	=3D {"unlink",		unlink_f,		1, 1 },
 	[OP_UNRESVSP]	   	=3D {"unresvsp",		unresvsp_f,		1, 1 },
+	[OP_URING_GETXATTR]	=3D {"uring_getxattr",	uring_getxattr_f,	1, 0 },
 	[OP_URING_READ]	   	=3D {"uring_read",	uring_read_f,		1, 0 },
 	[OP_URING_SETXATTR]	=3D {"uring_setxattr",	uring_setxattr_f,	1, 1 },
 	[OP_URING_WRITE]   	=3D {"uring_write",	uring_write_f,		1, 1 },
@@ -3891,8 +3895,44 @@ getdents_f(opnum_t opno, long r)
 	closedir(dir);
 }
=20
-void
-getfattr_f(opnum_t opno, long r)
+static ssize_t
+io_uring_getxattr(const char *path, const char *name, void *value, size_=
t size)
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
+	io_uring_prep_getxattr(sqe, name, value, path, size);
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
+static void
+getfattr_f_cbk(opnum_t opno, long r, getxattr_cbk cbk)
 {
 	fent_t	        *fep;
 	int		e;
@@ -3928,7 +3968,7 @@ getfattr_f(opnum_t opno, long r)
 		goto out;
 	}
=20
-	value_len =3D getxattr(f.path, name, NULL, 0);
+	value_len =3D cbk(f.path, name, NULL, 0);
 	if (value_len < 0) {
 		if (v)
 			printf("%d/%lld: getfattr file %s name %s failed %d\n",
@@ -3950,7 +3990,8 @@ getfattr_f(opnum_t opno, long r)
 		goto out;
 	}
=20
-	e =3D getxattr(f.path, name, value, value_len) < 0 ? errno : 0;
+	e =3D cbk(f.path, name, value, value_len) < 0 ? errno : 0;
+
 out_log:
 	if (v)
 		printf("%d/%lld: getfattr file %s name %s value length %d %d\n",
@@ -3960,6 +4001,20 @@ out:
 	free_pathname(&f);
 }
=20
+void
+uring_getxattr_f(opnum_t opno, long r)
+{
+#ifdef URING
+	getfattr_f_cbk(opno, r, io_uring_getxattr);
+#endif
+}
+
+void
+getfattr_f(opnum_t opno, long r)
+{
+	getfattr_f_cbk(opno, r, getxattr);
+}
+
 void
 link_f(opnum_t opno, long r)
 {
--=20
2.30.2

