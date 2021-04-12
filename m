Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30156C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 07:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EE361207
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 07:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhDLH3V (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:29:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16528 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhDLH3E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Apr 2021 03:29:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJgJL3h4kzPqNg;
        Mon, 12 Apr 2021 15:25:54 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 15:28:36 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>
CC:     <sunke32@huawei.com>
Subject: [PATCH] generic/591: add _require_odirect
Date:   Mon, 12 Apr 2021 03:34:03 -0400
Message-ID: <20210412073403.393034-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

src/splice-test will open a file with O_DIRECT flag, so add _require_odirect.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/591 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/591 b/tests/generic/591
index d40204636248..e243db10f96c 100755
--- a/tests/generic/591
+++ b/tests/generic/591
@@ -27,6 +27,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs generic
 _require_test
+_require_odirect
 _require_test_program "splice-test"
 
 rm -f $seqres.full
-- 
2.25.4

