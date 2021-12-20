Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AC4C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Dec 2021 18:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbhLTSQF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Dec 2021 13:16:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240343AbhLTSQB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Dec 2021 13:16:01 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BKGAfvU016620
        for <fstests@vger.kernel.org>; Mon, 20 Dec 2021 10:16:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=iXLpvyySiDgl8LbInVgCmQNXpNScrgJCZIHcIdZYgOs=;
 b=kjGLBKVRtut1QmoPzluM9p3Sps4bV0rogVwqCqopcNUX/UjrQS8gPPsVK+GeIKroMRCM
 JuMM6C3K2akTTVfxz7ZawK7D6iRqdyhB2BpIsmbxIJDj2Dd6Dnr1aS4BQjnYsfZQQHvy
 t31wDKXaA1SEMJKJrFyu55a+5Yr2PiPMcRc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d2hv253sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 20 Dec 2021 10:16:00 -0800
Received: from twshared12416.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 10:15:49 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 161BB84C9B7F; Mon, 20 Dec 2021 10:15:45 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v5 0/2] Add support for using liburing xattr
Date:   Mon, 20 Dec 2021 10:15:38 -0800
Message-ID: <20211220181540.1557109-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: d-CAOotqPO9L1FQFg2PtNLZSHOKl4ww8
X-Proofpoint-ORIG-GUID: d-CAOotqPO9L1FQFg2PtNLZSHOKl4ww8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_08,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=709 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200102
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

---
V5: - fix some whitespace issues, order enum definition in correct
      position and rebase
V4: - fix a whitespace/tab issue
V3: - Rebased patch series.
V2: - Introduce dedicated functions for uring getxattr and
      uring setxattr, so they are not automatically linked
      in if liburing is available.

Stefan Roesch (2):
  fstress: add suport for using liburing setxattr
  fstress: add suport for using liburing getxattr

 ltp/fsstress.c | 244 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 177 insertions(+), 67 deletions(-)


base-commit: 58e358032ac1f50acdb66615c04875d5375a6053
--=20
2.30.2

