Return-Path: <SRS0=mI6p=55=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99302C2BBC7
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Apr 2020 07:25:09 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC9C2076A
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Apr 2020 07:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC9C2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=fstests-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgDMHZI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDMHZI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Apr 2020 03:25:08 -0400
Received: from mgw-02.mpynet.fi (mgw-02.mpynet.fi [82.197.21.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D623C008651
        for <fstests@vger.kernel.org>; Mon, 13 Apr 2020 00:25:08 -0700 (PDT)
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 03D7OtGs090672;
        Mon, 13 Apr 2020 10:25:00 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 30b1k1j3gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 10:25:00 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Apr
 2020 10:24:59 +0300
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH v2] generic: assign a few tests to additional groups
Date:   Mon, 13 Apr 2020 10:24:49 +0300
Message-ID: <20200413072449.14268-1-vladimir@tuxera.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_02:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130065
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The rationale behind the proposed changes is to correct and improve
granularity of some generic tests, so it becomes possible to control
lists of run tests better, if there is given additional information
about a test environment and tested filesystems.

* generic/459 test is added to freeze group
* generic/482 test is added to thin group
* generic/529 test is added to acl group
* generic/530 test is added to shutdown group

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
Changes from v1 to v2:
* squashed the changes into one as asked by Eryu Guan

tests/generic/group | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index 99d06c9ad945..718575baeef9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -461,7 +461,7 @@
 456 auto quick metadata collapse zero prealloc
 457 auto log replay clone
 458 auto quick clone collapse zero
-459 auto thin
+459 auto freeze thin
 460 auto quick rw
 461 auto shutdown stress
 462 auto quick dax
@@ -484,7 +484,7 @@
 479 auto quick metadata log
 480 auto quick metadata log
 481 auto quick log metadata
-482 auto metadata replay
+482 auto metadata replay thin
 483 auto quick log metadata
 485 auto quick insert
 486 auto quick attr
@@ -530,8 +530,8 @@
 526 auto quick log
 527 auto quick log
 528 auto quick
-529 auto quick attr
-530 auto quick unlink
+529 auto quick acl attr
+530 auto quick shutdown unlink
 531 auto quick unlink
 532 auto quick
 533 auto quick attr
-- 
2.25.1

