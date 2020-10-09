Return-Path: <SRS0=ffIA=DQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E543C433DF
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Oct 2020 11:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C9322276
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Oct 2020 11:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbgJILvB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Oct 2020 07:51:01 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:50234 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732480AbgJILvA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 9 Oct 2020 07:51:00 -0400
X-Greylist: delayed 1682 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 07:50:59 EDT
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 099B9d7U079390;
        Fri, 9 Oct 2020 14:22:55 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 342m37886a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 14:22:55 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Oct
 2020 14:22:54 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     <fstests@vger.kernel.org>
CC:     Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH] generic/120: add the test to atime test group
Date:   Fri, 9 Oct 2020 14:22:44 +0300
Message-ID: <20201009112244.10558-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=1 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=681
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090080
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test checks "noatime" mount option effect, which makes it reasonable
to include the test into atime test group along with generic/003 and
generic/192 tests.

The test properly depends on _require_atime and for certain filesystems
the test is not run:

    [not run] atime related mount options have no effect on cifs

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 4af4b4945a12..b8db09e2d054 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -122,7 +122,7 @@
 117 attr auto quick
 118 auto quick clone
 119 auto quick clone
-120 other auto quick
+120 other atime auto quick
 121 auto quick clone dedupe
 122 auto quick clone dedupe
 123 perms auto quick
-- 
2.25.1

