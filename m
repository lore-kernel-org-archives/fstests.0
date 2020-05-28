Return-Path: <SRS0=vBw0=7K=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DF5C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 28 May 2020 07:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A154208E4
	for <linux-fstests@archiver.kernel.org>; Thu, 28 May 2020 07:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgE1Hdb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 May 2020 03:33:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52719 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgE1Hda (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 May 2020 03:33:30 -0400
X-IronPort-AV: E=Sophos;i="5.73,443,1583164800"; 
   d="scan'208";a="93265727"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 May 2020 15:33:27 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 728EF50A9981
        for <fstests@vger.kernel.org>; Thu, 28 May 2020 15:33:23 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 28 May 2020 15:33:14 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/484: add _require_xfs_io_command "syncfs"
Date:   Thu, 28 May 2020 15:32:59 +0800
Message-ID: <1590651179-5695-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 728EF50A9981.AC91D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When using old xfsprogs version, xfs_io doesn't support syncfs command.
It was not fixed until xfsprogs commit eb24bcffc0("xfs_io: fix missing syncfs command").
Add a require for this so that we can skip this case if xfs_io doesn't
support syncfs command.

Reported-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/484 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/484 b/tests/generic/484
index cf257c6b..dad411e9 100755
--- a/tests/generic/484
+++ b/tests/generic/484
@@ -42,6 +42,7 @@ _require_scratch_nocheck
 # realtime subvolume, thus the test will fail with rtinherit=1
 _require_no_rtinherit
 _require_dm_target error
+_require_xfs_io_command "syncfs"
 
 rm -f $seqres.full
 
-- 
2.23.0



