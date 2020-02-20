Return-Path: <SRS0=97QR=4I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C9C34031
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 05:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D979B24656
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Feb 2020 05:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgBTFhn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:37:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:57586 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbgBTFhn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Feb 2020 00:37:43 -0500
X-IronPort-AV: E=Sophos;i="5.70,462,1574092800"; 
   d="scan'208";a="83604649"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Feb 2020 13:37:35 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 504CE50A9962;
        Thu, 20 Feb 2020 13:27:52 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 20 Feb 2020 13:37:30 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 20 Feb 2020 13:37:28 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2] common/log: add -l su option in _xfs_log_config
Date:   Thu, 20 Feb 2020 13:38:01 +0800
Message-ID: <1582177081-6235-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20200220021709.GF9504@magnolia>
References: <20200220021709.GF9504@magnolia>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 504CE50A9962.AC3B6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently, if we don't specify -l sunit or -l su option, mkfs.xfs
will get the stripe size from underlying device.

It works file on most situations. But on some machine, the size of
underlying device greater than logbsize of mount options, it will
report error like "logbuf size must be greater than or equal to log
stripe size". We can specify -l su=4096 to meet this requirement and
case can still run normally.

Also, from xfs manpage, version 2 also supports 16k log buf size for
mount option and case passed(only generic/054,055 used this api) on
my machine. So delete 32k and 64k with different sunit to be consistented
with ext4 test num(10) and we can test all logbuf size.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 common/log | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/log b/common/log
index c7921f50..9b5a2f6d 100644
--- a/common/log
+++ b/common/log
@@ -546,15 +546,15 @@ _xfs_log_config()
 {
     echo "# mkfs-opt             mount-opt"
     echo "# ------------------------------"
-    echo "  version=2            logbsize=32k"
+    echo "  version=2,su=4096    logbsize=16k"
+    echo "  version=2,su=16k     logbsize=16k"
     echo "  version=2,su=4096    logbsize=32k"
-    echo "  version=2,su=32768   logbsize=32k"
-    echo "  version=2,su=32768   logbsize=64k"
-    echo "  version=2            logbsize=64k"
+    echo "  version=2,su=32k     logbsize=32k"
+    echo "  version=2,su=4096    logbsize=64k"
     echo "  version=2,su=64k     logbsize=64k"
-    echo "  version=2            logbsize=128k"
+    echo "  version=2,su=4096    logbsize=128k"
     echo "  version=2,su=128k    logbsize=128k"
-    echo "  version=2            logbsize=256k"
+    echo "  version=2,su=4096    logbsize=256k"
     echo "  version=2,su=256k    logbsize=256k"
 }
 
-- 
2.18.0



