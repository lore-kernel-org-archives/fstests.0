Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416FAC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Nov 2021 22:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhK2WVE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:21:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233476AbhK2WTX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Nov 2021 17:19:23 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ATIlKbb000892
        for <fstests@vger.kernel.org>; Mon, 29 Nov 2021 14:16:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Wbq8VAqdFQkrt8Kjmjmptch1z/ln7lv0IwpmCtyGOUY=;
 b=KEwMsO+0Yuv2qEdmHPrBKU3lU1plUHjlx5weVYvfzQoT4LswjDzYX7SnovGQMo4yzLjG
 MsK43weMtgy7FqPC4Qiu4Pst7BGvomf7d5XaFVWBlKx5uH1Qvp1YkSm56qZoSu9zKiX2
 NKNq8QSHEMDU3yxj0yo/1c4ImWrYuGsBbYU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3cms5jx6t2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 29 Nov 2021 14:15:55 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:15:47 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 34A8D7101DE6; Mon, 29 Nov 2021 14:15:44 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1 0/2] Add support for using liburing xattr
Date:   Mon, 29 Nov 2021 14:15:40 -0800
Message-ID: <20211129221542.2549306-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 3D5IqPXMfBR9w2fI1i4E4CdD1GJRVw3z
X-Proofpoint-GUID: 3D5IqPXMfBR9w2fI1i4E4CdD1GJRVw3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_11,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=477
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This adds support for using the xattr implementation in liburing.

Patch 1: fstress: add suport for using liburing setxattr
  Uses the liburing setxattr implementation in fsstress.

Patch 2: fstress: add suport for using liburing getxattr
  Uses the liburing getxattr implementation in fsstress.

There are two additional patch series related to this:
- io_uring: add xattr support
- liburing: add xattr support


Stefan Roesch (2):
  fstress: add suport for using liburing setxattr
  fstress: add suport for using liburing getxattr

 ltp/fsstress.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)


Signed-off-by: Stefan Roesch <shr@fb.com>
base-commit: 2050356437e3576673ec5ead79ad72eb619f0d72
--=20
2.30.2

