Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6717C47094
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Jun 2021 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC87A61359
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Jun 2021 12:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFJMnX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:43:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5493 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhFJMnW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Jun 2021 08:43:22 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G13Rs54jPzZfy8;
        Thu, 10 Jun 2021 20:38:33 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 20:41:24 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 20:41:24 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>, <yuchao0@huawei.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH v2] generic/042: make a bigger img for f2fs
Date:   Thu, 10 Jun 2021 20:47:41 +0800
Message-ID: <20210610124741.313944-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change again.
So, just set it to 128M.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/042 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/042 b/tests/generic/042
index ee0e4b40..6437ef07 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -43,9 +43,11 @@ _crashtest()
 	file=$mnt/file
 	size=25M
 
-	# 25M is too small for f2fs.
+	# f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
+	# f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change
+	# again. So just set it 128M.
 	if [ $FSTYP == "f2fs" ]; then
-		size=38M
+		size=128M
 	fi
 
 	# Create an fs on a small, initialized image. The pattern is written to
-- 
2.13.6

