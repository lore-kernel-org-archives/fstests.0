Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D49EC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 05:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C022070B
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 05:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgG2FY1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:24:27 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:42283 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbgG2FY0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jul 2020 01:24:26 -0400
X-IronPort-AV: E=Sophos;i="5.75,409,1589212800"; 
   d="scan'208";a="97045380"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jul 2020 13:24:23 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9105F46B5FAE
        for <fstests@vger.kernel.org>; Wed, 29 Jul 2020 13:24:22 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 29 Jul 2020 13:24:22 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 29 Jul 2020 13:24:22 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] tests/generic/452: Fix the wrong commit id
Date:   Wed, 29 Jul 2020 13:17:01 +0800
Message-ID: <20200729051701.15387-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9105F46B5FAE.A862F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The mentioned commit 42d4a99b09cb doesn't exist so use the correct one.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/452 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/452 b/tests/generic/452
index 1e38b612..f6d6a0d7 100755
--- a/tests/generic/452
+++ b/tests/generic/452
@@ -5,7 +5,7 @@
 # FS QA Test 452
 #
 # This is a regression test for kernel patch:
-#   commit 42d4a99b09cb ("ext4: fix fault handling when mounted with -o dax,ro")
+#   commit fd96b8da68d3 ("ext4: fix fault handling when mounted with -o dax,ro")
 # created by Ross Zwisler <ross.zwisler@linux.intel.com>
 #
 seq=`basename $0`
-- 
2.21.0



