Return-Path: <SRS0=z/AK=4G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06233C34034
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 07:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D344B2176D
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 07:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgBRHXy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:23:54 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29089 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726074AbgBRHXy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Feb 2020 02:23:54 -0500
X-IronPort-AV: E=Sophos;i="5.70,455,1574092800"; 
   d="scan'208,223";a="83483586"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Feb 2020 15:23:51 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 2883250A9975;
        Tue, 18 Feb 2020 15:14:14 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 18 Feb 2020 15:23:49 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 18 Feb 2020 15:23:50 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v1 2/2] common/log: add 16k logbuf size for xfs_log_config
Date:   Tue, 18 Feb 2020 15:24:11 +0800
Message-ID: <1582010652-1124-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582010652-1124-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1582010652-1124-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 2883250A9975.A7D7F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From xfs manpage, version 2 also supports 16k log buf size for mount option
and case passed(only generic/054,055 used this api) on my machine. So
delete 32k and 64k with different sunit to be consistented with ext4 test num(10)
and we can test all logbuf size.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 common/log | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/log b/common/log
index f82919a6..98e0d638 100644
--- a/common/log
+++ b/common/log
@@ -547,10 +547,10 @@ _xfs_log_config()
 {
     echo "# mkfs-opt             mount-opt"
     echo "# ------------------------------"
+    echo "  version=2            logbsize=16k"
+    echo "  version=2,su=16384   logbsize=16k"
     echo "  version=2            logbsize=32k"
-    echo "  version=2,su=4096    logbsize=32k"
     echo "  version=2,su=32768   logbsize=32k"
-    echo "  version=2,su=32768   logbsize=64k"
     echo "  version=2            logbsize=64k"
     echo "  version=2,su=64k     logbsize=64k"
     echo "  version=2            logbsize=128k"
-- 
2.18.0



