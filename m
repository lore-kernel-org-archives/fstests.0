Return-Path: <SRS0=NoLx=A4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFFFC433DF
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 11:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342382070E
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 11:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGQLJ5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:09:57 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:58264 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgGQLJ5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Jul 2020 07:09:57 -0400
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06HB51vD127396;
        Fri, 17 Jul 2020 14:09:45 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 32ba9rg1a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 14:09:45 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Jul
 2020 14:09:44 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] generic/587: associate the test with quota test group
Date:   Fri, 17 Jul 2020 14:09:36 +0300
Message-ID: <20200717110936.24602-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_06:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170081
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test checks regressions on quota accounting and therefore it relies
on quota support by a tested filesystem, this makes it reasonable to
include the test into 'quota' test group for better managing of test
groups.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 0797cc9984c1..23f9cfdc7fcb 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -589,7 +589,7 @@
 584 auto quick encrypt
 585 auto rename
 586 auto quick rw prealloc
-587 auto quick rw prealloc
+587 auto quick rw prealloc quota
 588 auto quick log clone
 589 auto mount
 590 auto prealloc preallocrw
-- 
2.25.1

