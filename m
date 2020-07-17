Return-Path: <SRS0=NoLx=A4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278FCC433E1
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015272074B
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jul 2020 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQIWQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:22:16 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:35078 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgGQIWQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Jul 2020 04:22:16 -0400
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 06H89auT093084;
        Fri, 17 Jul 2020 11:22:14 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 32b87w00dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 11:22:13 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Jul
 2020 11:22:13 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH] generic: fix insert test group associations
Date:   Fri, 17 Jul 2020 11:22:07 +0300
Message-ID: <20200717082207.21088-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_04:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=938
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170062
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The change makes one-in-one correspondence between generic tests in
'insert' test group and tests with $(_require_xfs_io_command "finsert")
runtime check:

* generic/348 -- insert group association is removed,
* generic/458 -- insert group association is added.

The intention of the change is to get better summarized association
between tests and test groups to be able to operate with test groups
in a better way.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 tests/generic/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index d9ab9a31f2ed..764eeafc0f42 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -350,7 +350,7 @@
 345 auto
 346 auto quick rw
 347 auto quick rw thin
-348 auto quick metadata insert
+348 auto quick metadata
 349 blockdev rw zero
 350 blockdev rw punch
 351 blockdev rw punch collapse insert zero
@@ -460,7 +460,7 @@
 455 auto log replay
 456 auto quick metadata collapse zero prealloc
 457 auto log replay clone
-458 auto quick clone collapse zero
+458 auto quick clone collapse insert zero
 459 auto freeze thin
 460 auto quick rw
 461 auto shutdown stress
-- 
2.25.1

