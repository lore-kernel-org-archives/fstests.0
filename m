Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C05CC433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 18:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhLPSnd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:43:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229532AbhLPSna (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 13:43:30 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BGHOu31013107
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 10:43:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=t5Qh5KgJHynyYnOPc4NMUJyTkc4ud22MJUgw92j6DVo=;
 b=llumKh55rI1e1/ELdNYLa+WeOZBMIVSjdcN7zcTflGlLQ6zLY9ya2SiH7xD6ync8Cnr8
 F/2Ezc1eHxSbK5xKSsB2W+Q0KEryzfE1h6t37zLF41GBPGLrvNXq+QDXCI82LcoLAM+5
 bgBkSsZFN5LoHUrASo+KngOAITnfhXc8icM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyyrr4yac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 10:43:29 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:43:28 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 0EBA1824FCD6; Thu, 16 Dec 2021 10:43:21 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <fstests@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v4 0/2] Add support for using liburing xattr
Date:   Thu, 16 Dec 2021 10:43:17 -0800
Message-ID: <20211216184319.851514-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: f2zlKlOvTtp-Oq4pB87nvIH9TFD4MOaY
X-Proofpoint-ORIG-GUID: f2zlKlOvTtp-Oq4pB87nvIH9TFD4MOaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_07,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=598 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160104
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
V4: - fix a whitespace/tab issue
V3: - Rebased patch series.
V2: - Introduce dedicated functions for uring getxattr and
      uring setxattr, so they are not automatically linked
      in if liburing is available.

*** BLURB HERE ***

Stefan Roesch (2):
  fstress: add suport for using liburing setxattr
  fstress: add suport for using liburing getxattr

 ltp/fsstress.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 6 deletions(-)


base-commit: 13dd19cee4298ffc323737029ca36f70f52f88e9
--=20
2.30.2

