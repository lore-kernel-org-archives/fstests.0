Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17BCC433E3
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 13:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0FF20657
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 13:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgGONIs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:08:48 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:54800 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgGONIs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Jul 2020 09:08:48 -0400
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06FD6rXp081485;
        Wed, 15 Jul 2020 16:08:45 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 329m9srnwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 16:08:45 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Jul
 2020 16:08:45 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] generic/038: assign the test to trim group of tests
Date:   Wed, 15 Jul 2020 16:08:38 +0300
Message-ID: <20200715130838.22263-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_11:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150107
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test runs fstrim utility to stress a filesystem, however it implies
that the filesystem supports ioctl(FITRIM), this is checked in runtime by
_require_batched_discard() in the test itself, however the assignment of
the test to trim group is missing.

The intention of the change is to get better association between tests
and test groups.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
Please note that this change may show a trivial merge conflict with by
previously sent patch "generic: assign a number of tests to attr group".

 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index d9ab9a31f2ed..c2e7d063fa85 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -40,7 +40,7 @@
 035 auto quick
 036 auto aio rw stress
 037 metadata auto quick
-038 auto stress
+038 auto stress trim
 039 metadata auto quick log
 040 metadata auto quick log
 041 metadata auto quick log
-- 
2.25.1

