Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5099DC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Nov 2021 22:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhK2WUy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:20:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233477AbhK2WTJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Nov 2021 17:19:09 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ATIlCFJ032259
        for <fstests@vger.kernel.org>; Mon, 29 Nov 2021 14:15:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=o+PhvJMNPPowpTiqwMVzpfb68f1sY32hgEmR2h0pLbk=;
 b=i9cRrzgybnkVU6oJezFjufJy8HL1t9jXwFZDHY2QlGRP28GKBLsH8ypr3/SRHpVeqBal
 +W5V7yFbMEiDB2UUMjygBwZKhzx/GRVFd1x4szOxrbvUqUwF31HtAQakPQdyobS9QMH9
 DZrNboYrlp+d+YPSMgYStURX4+f1nRU9EDE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3cmna672ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 29 Nov 2021 14:15:50 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:15:48 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 3A4837101DE8; Mon, 29 Nov 2021 14:15:44 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1 1/2] fstress: add suport for using liburing setxattr
Date:   Mon, 29 Nov 2021 14:15:41 -0800
Message-ID: <20211129221542.2549306-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129221542.2549306-1-shr@fb.com>
References: <20211129221542.2549306-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: kT7DxSQJN8mi64vQw7mLufLBtgWRnDr7
X-Proofpoint-ORIG-GUID: kT7DxSQJN8mi64vQw7mLufLBtgWRnDr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_11,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111290105
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
 ltp/fsstress.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 003e0e49..4a5c4afe 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -4779,6 +4779,43 @@ setattr_f(opnum_t opno, long r)
 	close(fd);
 }
=20
+static int
+io_uring_setxattr(const char *path, const char *name, const void *value,=
 size_t size,
+	  	  int flags)
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
 setfattr_f(opnum_t opno, long r)
 {
@@ -4842,7 +4879,11 @@ setfattr_f(opnum_t opno, long r)
 		goto out;
 	}
=20
-	e =3D setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
+	if (have_io_uring)
+		e =3D io_uring_setxattr(f.path, name, value, value_len, flag);
+	else
+		e =3D setxattr(f.path, name, value, value_len, flag) < 0 ? errno : 0;
+
 	if (e =3D=3D 0)
 		fep->xattr_counter++;
 	if (v)
--=20
2.30.2

