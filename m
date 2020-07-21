Return-Path: <SRS0=G+6p=BA=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F9C433E3
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jul 2020 09:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647442070A
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jul 2020 09:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGUJiZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:38:25 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:55032 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgGUJiZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Jul 2020 05:38:25 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06L9cDf1080357;
        Tue, 21 Jul 2020 12:38:19 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 32bvr3jayr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 12:38:19 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jul
 2020 12:38:18 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] generic: associate a few tests with punch and zero test groups
Date:   Tue, 21 Jul 2020 12:38:09 +0300
Message-ID: <20200721093809.12432-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_02:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210067
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In runtime the modified tests requires and utilizes fpunch command
of xfs_io, thus a tested filesystem shall support the feature and
running a filesystem check by "punch" group selection should include
these tests:

  * generic/176
  * generic/415
  * generic/447
  * generic/469
  * generic/562

In addition and due to the same reasons add generic/469 to zero test
group, the test already contains _require_xfs_io_command "fzero" check.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/group | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index 1d98ed5f29f6..99eca4874c13 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -178,7 +178,7 @@
 173 auto quick clone
 174 auto quick clone
 175 auto clone
-176 auto clone
+176 auto clone punch
 177 auto quick prealloc metadata punch log
 178 auto quick clone punch
 179 auto quick clone punch
@@ -417,7 +417,7 @@
 412 auto quick metadata
 413 auto quick dax
 414 auto quick clone
-415 auto clone
+415 auto clone punch
 416 auto enospc
 417 auto quick shutdown log
 418 auto rw
@@ -449,7 +449,7 @@
 444 auto quick acl
 445 auto quick rw seek prealloc
 446 auto quick rw punch
-447 auto clone
+447 auto clone punch
 448 auto quick rw seek
 449 auto quick acl attr enospc
 450 auto quick rw
@@ -471,7 +471,7 @@
 466 auto quick rw
 467 auto quick exportfs
 468 shutdown auto quick metadata
-469 auto quick
+469 auto quick punch zero
 470 auto quick dax
 471 auto quick rw
 472 auto quick swap
@@ -564,7 +564,7 @@
 559 auto stress dedupe
 560 auto stress dedupe
 561 auto stress dedupe
-562 auto clone
+562 auto clone punch
 563 auto quick
 564 auto quick copy_range
 565 auto quick copy_range
-- 
2.25.1

