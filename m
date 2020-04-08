Return-Path: <SRS0=Dt1E=5Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC69C2D0EA
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Apr 2020 14:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7351720936
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Apr 2020 14:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgDHOWO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:22:14 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:37260 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgDHOWN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Apr 2020 10:22:13 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 038Drw7U124068;
        Wed, 8 Apr 2020 16:56:56 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 3091pn1418-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Apr 2020 16:56:56 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 8 Apr
 2020 16:56:55 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH 4/4] Add generic/530 test to shutdown group of tests
Date:   Wed, 8 Apr 2020 16:56:48 +0300
Message-ID: <20200408135648.5824-5-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408135648.5824-1-vladimir@tuxera.com>
References: <20200408135648.5824-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004080116
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If a scratch filesystem does not support shutdown feature, the generic/530
test execution is not run due to a `_require_scratch_shutdown' check
executed in runtime.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index cad08e045001..718575baeef9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -531,7 +531,7 @@
 527 auto quick log
 528 auto quick
 529 auto quick acl attr
-530 auto quick unlink
+530 auto quick shutdown unlink
 531 auto quick unlink
 532 auto quick
 533 auto quick attr
-- 
2.25.1

