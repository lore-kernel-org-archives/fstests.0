Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74439C4708F
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 08:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4D6613A9
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 08:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhFAIPr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:15:47 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3315 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhFAIPq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Jun 2021 04:15:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvPvN1D4Cz19VLM;
        Tue,  1 Jun 2021 16:09:20 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:14:00 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 16:14:00 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>, <yuchao0@huawei.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH] generic/042: f2fs-utils 1.14.0 needs at least 52 MB
Date:   Tue, 1 Jun 2021 04:20:05 -0400
Message-ID: <20210601082005.1352814-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change again.
But at least we need to configure mininum size of f2fs image to 52MB now.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/042 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/generic/042 b/tests/generic/042
index ee0e4b400c71..bf3b4180b1a2 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -43,9 +43,12 @@ _crashtest()
 	file=$mnt/file
 	size=25M
 
-	# 25M is too small for f2fs.
+	# f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
+	# f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change
+	# again. But at least we need to configure mininum size of f2fs image
+	# to 52MB now.
 	if [ $FSTYP == "f2fs" ]; then
-		size=38M
+		size=52M
 	fi
 
 	# Create an fs on a small, initialized image. The pattern is written to
-- 
2.25.4

