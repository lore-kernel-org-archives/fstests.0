Return-Path: <SRS0=ARln=6E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F03DC3815B
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 08:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AC1206B8
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 08:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgDTISW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:18:22 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9735 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbgDTISW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Apr 2020 04:18:22 -0400
X-IronPort-AV: E=Sophos;i="5.72,405,1580745600"; 
   d="scan'208";a="89269351"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Apr 2020 16:18:19 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A785E46B5FAA;
        Mon, 20 Apr 2020 16:07:39 +0800 (CST)
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 20 Apr 2020 16:18:16 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 20 Apr 2020 16:18:15 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <jack@suse.cz>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/456: document the other kernel commit
Date:   Mon, 20 Apr 2020 16:18:17 +0800
Message-ID: <1587370697-13249-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: A785E46B5FAA.AFA5A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/456 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/456 b/tests/generic/456
index 434a0ffa..b588fc07 100755
--- a/tests/generic/456
+++ b/tests/generic/456
@@ -10,6 +10,10 @@
 # Fixed by commit 51e3ae81ec58 ("ext4: fix interaction between i_size,
 # fallocate, and delalloc after a crash")
 #
+# This is also a regression test for ext4 bug that zero range can beyond
+# i_disksize and fixed by commit 801674f34ecf ("ext4: do not zeroout extents
+# beyond i_disksize").
+#
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
-- 
2.23.0



