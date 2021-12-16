Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D4C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 17:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbhLPR0b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:26:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36480 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239791AbhLPR0a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 12:26:30 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BGA5cu1007574
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 09:26:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=zZ7KwEhfB7GqIc0dKSpdsH7MrS7Ff5c3zr8nq2dgdDQ=;
 b=NbB5NlEAhOeGTeBRHDpb/3VjdZjf+Vw2dAr8q14nQiYJqGV2uq8/96+O3ODof3i3MF1U
 I7MVguYXV01KVT1mBjsz4L9A7bsr9BTy0fx2aWtgzodV0nu7uUpD/lbfKpSnJJ0XTTq1
 B2xlCzTdxgJNtjfAUCqinRTYJDUXtlKAstg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3d03d1b48j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 09:26:29 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 09:26:27 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 1BCF2823FADF; Thu, 16 Dec 2021 09:26:21 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v3 0/2] Add support for using liburing xattr
Date:   Thu, 16 Dec 2021 09:26:17 -0800
Message-ID: <20211216172619.4034842-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: nxKHS5KV1Vcy5YIjTmSsRkAsuWaKVhIN
X-Proofpoint-GUID: nxKHS5KV1Vcy5YIjTmSsRkAsuWaKVhIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_05,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=457 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160098
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
V3: - Rebased patch series.
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

