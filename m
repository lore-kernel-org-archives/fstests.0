Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D79C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Nov 2021 22:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhK2WU4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:20:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233411AbhK2WTM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Nov 2021 17:19:12 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATIlGU8012625
        for <fstests@vger.kernel.org>; Mon, 29 Nov 2021 14:15:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=eGq4C0MmcH/n3QEHsW3LPuT+SHg8ViUlI1/3sNtX+NI=;
 b=q62bnQaJGI4jwt+mbx2srRoOSQUosBFbT2H1wFDFfi2j1SEvBZRNiszBxNoCqSv7vg7B
 n5cV7nNaqL2HwKGJcsVJfI+V19Y0QeTCndUofJFRRmynoO80HsR5rYgxjSewXmnFHyia
 ppsZ8l/QQKP0B/RYiHF7Q3jgt3R8Sw2euow= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cmxgsm9nh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 29 Nov 2021 14:15:54 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:15:50 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 3FE157101DEC; Mon, 29 Nov 2021 14:15:44 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1 2/2] fstress: add suport for using liburing getxattr
Date:   Mon, 29 Nov 2021 14:15:42 -0800
Message-ID: <20211129221542.2549306-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129221542.2549306-1-shr@fb.com>
References: <20211129221542.2549306-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: fW3s9OHXtaeWXpXceSe8DPzN9jSfbHLE
X-Proofpoint-ORIG-GUID: fW3s9OHXtaeWXpXceSe8DPzN9jSfbHLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_11,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 mlxlogscore=973 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Summary:

Liburing added support for getxattr. This change adds
support for this this in fsstress when fsstress is built
with liburing support.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 ltp/fsstress.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 4a5c4afe..df7820d6 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -3895,6 +3895,42 @@ getdents_f(opnum_t opno, long r)
 	closedir(dir);
 }
=20
+static int
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
 getfattr_f(opnum_t opno, long r)
 {
@@ -3932,7 +3968,11 @@ getfattr_f(opnum_t opno, long r)
 		goto out;
 	}
=20
-	value_len =3D getxattr(f.path, name, NULL, 0);
+	if (have_io_uring)
+        	value_len =3D io_uring_getxattr(f.path, name, NULL, 0);
+    	else
+        	value_len =3D getxattr(f.path, name, NULL, 0);
+
 	if (value_len < 0) {
 		if (v)
 			printf("%d/%lld: getfattr file %s name %s failed %d\n",
@@ -3954,7 +3994,11 @@ getfattr_f(opnum_t opno, long r)
 		goto out;
 	}
=20
-	e =3D getxattr(f.path, name, value, value_len) < 0 ? errno : 0;
+	if (have_io_uring)
+		e =3D io_uring_getxattr(f.path, name, value, value_len);
+	else
+		e =3D getxattr(f.path, name, value, value_len) < 0 ? errno : 0;
+
 out_log:
 	if (v)
 		printf("%d/%lld: getfattr file %s name %s value length %d %d\n",
--=20
2.30.2

