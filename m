Return-Path: <SRS0=s9tj=AV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28AC433DF
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jul 2020 14:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1295206A1
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jul 2020 14:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGJOpq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:45:46 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:52296 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJOpq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Jul 2020 10:45:46 -0400
X-Greylist: delayed 1903 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2020 10:45:45 EDT
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06AECZdA082044;
        Fri, 10 Jul 2020 17:14:00 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 326ba70qnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 17:13:59 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Jul
 2020 17:13:59 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] common/rc: fix false positives due to leaked mkfs output to stderr
Date:   Fri, 10 Jul 2020 17:13:50 +0300
Message-ID: <20200710141350.2383-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_07:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100100
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The change fixes false positives reported by a few generic tests under
circumstances, when an mkfs utility prints its output to stderr and then it
appears in produced *.out files. The change is intended to fix such issues
in the tests, which utilize _require_scratch_swapfile().

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index f17b19f2d4cb..1b7b25758d25 100644
--- a/common/rc
+++ b/common/rc
@@ -2311,7 +2311,7 @@ _require_scratch_swapfile()
 	_require_scratch
 	_require_command "$MKSWAP_PROG" "mkswap"
 
-	_scratch_mkfs >/dev/null
+	_scratch_mkfs >/dev/null 2>&1
 
 	# With mounting SELinux context(e.g. system_u:object_r:root_t:s0),
 	# standard mkswap tried to reset the type of default context to
-- 
2.25.1

