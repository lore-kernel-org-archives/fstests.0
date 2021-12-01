Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF0EC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Dec 2021 05:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346853AbhLAFzj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Dec 2021 00:55:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40526 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346819AbhLAFz1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Dec 2021 00:55:27 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B10XTUh017766
        for <fstests@vger.kernel.org>; Tue, 30 Nov 2021 21:52:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=TeJdnCYUtR2ZfS8YsGKDJBK2B1Hak9oS6h8b+/bnybQ=;
 b=JU2y/FYqrMYuXw6S6/ZMdZy4kry/v/vh7Y6nDxjRoSmqIqw0lrdLLQEt91mNK6RUroVS
 yC5SEeA9rAJKe2ryb/vfUBTrlzjYGOx6Rbf6p435aZl79yBk7LWYQqknJRdlpRp0ylI5
 ry+xT5ssNi2owtXUiJxSrX0QNRGpy+ZLZHU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cnhx4fh3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Tue, 30 Nov 2021 21:52:06 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 21:52:05 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id F3AF27227209; Tue, 30 Nov 2021 21:52:03 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v2 0/2] Add support for using liburing xattr
Date:   Tue, 30 Nov 2021 21:52:00 -0800
Message-ID: <20211201055202.3142034-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: eOBVsaEW4mSUpVMFZgb9RYITNuGNgAfP
X-Proofpoint-ORIG-GUID: eOBVsaEW4mSUpVMFZgb9RYITNuGNgAfP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=489 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010033
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


Signed-off-by: Stefan Roesch <shr@fb.com>
base-commit: 2050356437e3576673ec5ead79ad72eb619f0d72
---
V2: - Introduce dedicated functions for uring getxattr and
      uring setxattr, so they are not automatically linked
      in if liburing is available.


Stefan Roesch (2):
  fstress: add suport for using liburing setxattr
  fstress: add suport for using liburing getxattr

 ltp/fsstress.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 6 deletions(-)

--=20
2.30.2

