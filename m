Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C6AC433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jan 2021 06:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E8764DCC
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jan 2021 06:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhA1GpG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:45:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11455 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhA1GpA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Jan 2021 01:45:00 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DR9sL3xVPzjC1H
        for <fstests@vger.kernel.org>; Thu, 28 Jan 2021 14:43:18 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Thu, 28 Jan 2021
 14:44:08 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH] src/swapon.c: initiate p to NULL
Date:   Thu, 28 Jan 2021 14:50:10 +0800
Message-ID: <20210128065010.218830-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

when run make, show:
swapon.c:135:3: warning: 'p' may be used uninitialized in this function
[-Wmaybe-uninitialized]
   memcpy(p, buf, BUF_SIZE);
      ^~~~~~~~~~~~~~~~~~~~~~~~
fix it.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 src/swapon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/swapon.c b/src/swapon.c
index afaed405..fe8949a3 100644
--- a/src/swapon.c
+++ b/src/swapon.c
@@ -41,7 +41,7 @@ int main(int argc, char **argv)
 		.sa_handler	= handle_signal,
 	};
 	enum verbs verb = TEST_SWAPON;
-	void *p;
+	void *p = NULL;
 	ssize_t sz;
 	int fd = -1;
 	int ret, c;
-- 
2.13.6

