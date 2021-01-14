Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1663FC433E0
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Jan 2021 02:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B9C23AC8
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Jan 2021 02:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbhAOCwS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:52:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38252 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726894AbhAOCwR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Jan 2021 21:52:17 -0500
X-IronPort-AV: E=Sophos;i="5.79,347,1602518400"; 
   d="scan'208";a="103501289"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Jan 2021 10:50:33 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5147D4CE6037
        for <fstests@vger.kernel.org>; Fri, 15 Jan 2021 10:50:32 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 15 Jan 2021 10:50:32 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] ext4/046: skip test when ext4 doesn't support bs < ps with dioread_nolock
Date:   Thu, 14 Jan 2021 11:55:03 +0800
Message-ID: <1610596503-17149-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 5147D4CE6037.AB8C1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When testing arm machine, this case fails because ps > bs and kernel doesn't
introduced commit c8cc88163f40 ("ext4: Add support for blocksize < pagesize in dioread_nolock").
Only skip this case when mounting failed.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/ext4/046 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/046 b/tests/ext4/046
index 5524024e..e307cbf1 100755
--- a/tests/ext4/046
+++ b/tests/ext4/046
@@ -37,7 +37,8 @@ _require_xfs_io_command "falloc"
 _require_scratch_size $((6 * 1024 * 1024)) #kB
 
 _scratch_mkfs >> $seqres.full 2>&1
-_scratch_mount "-o dioread_nolock" >> $seqres.full 2>&1
+_try_scratch_mount "-o dioread_nolock" >>$seqres.full 2>&1 || \
+	_notrun "mount failed, ext4 doesn't support bs < ps with dioread_nolock?"
 
 # Get blksz
 blksz=$(_get_file_block_size $SCRATCH_MNT)
-- 
2.23.0



