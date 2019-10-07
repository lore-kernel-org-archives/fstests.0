Return-Path: <SRS0=x6C3=YA=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61614C4740A
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Oct 2019 07:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E8D2133F
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Oct 2019 07:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfJGHPP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:15:15 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60147 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726202AbfJGHPP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Oct 2019 03:15:15 -0400
X-IronPort-AV: E=Sophos;i="5.67,265,1566835200"; 
   d="scan'208";a="76578535"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Oct 2019 15:15:13 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id E65E64CE14FA
        for <fstests@vger.kernel.org>; Mon,  7 Oct 2019 15:15:11 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 7 Oct 2019 15:15:14 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/097: Remove wrong broken assignment operation
Date:   Mon, 7 Oct 2019 15:15:15 +0800
Message-ID: <1570432515-13184-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: E65E64CE14FA.AD376
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On old kernel, since commit ded188b8609 ("xfs: Fix the situation that mount 
operation rejects corrupted XFS") running this case got the mismatched output,
as below:
-----------------------------------
 + check fs
 + corrupt image
 + mount image && modify files
-broken: 1
+broken: 0
 + repair fs
 + mount image (2)
------------------------------------

It fails because the broken is always equal to 0 when _try_scratch_mount
succeed. So remove this wrong assignment operation.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/xfs/097 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/xfs/097 b/tests/xfs/097
index 1cb7d69c..20791738 100755
--- a/tests/xfs/097
+++ b/tests/xfs/097
@@ -81,8 +81,6 @@ done
 echo "+ mount image && modify files"
 broken=1
 if _try_scratch_mount >> $seqres.full 2>&1; then
-
-	broken=0
 	for x in `seq 65 70`; do
 		touch "${TESTFILE}.${x}" 2> /dev/null && broken=0
 	done
-- 
2.18.1



