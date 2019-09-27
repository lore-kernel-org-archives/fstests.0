Return-Path: <SRS0=31Kr=XW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB27C4360C
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 10:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849E0217D7
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 10:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfI0KIe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:08:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57944 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfI0KIe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 06:08:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D413EAB0951E7E945C2F;
        Fri, 27 Sep 2019 18:08:32 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 27 Sep 2019 18:08:22 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        "Chao Yu" <yuchao0@huawei.com>
Subject: [PATCH] generic/group: add missing dedupe tag for generic/493
Date:   Fri, 27 Sep 2019 18:08:10 +0800
Message-ID: <20190927100810.9351-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org
Message-ID: <20190927100810.lPEXCFWYZb_nT5GpzlD8pq96_SJatwdX1jUvNiCzvZM@z>

We missed to add the tag, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 7cf4f6c4..18b5a545 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -495,7 +495,7 @@
 490 auto quick rw seek
 491 auto quick freeze mount
 492 auto quick
-493 auto quick swap
+493 auto quick swap dedupe
 494 auto quick swap punch
 495 auto quick swap
 496 auto quick swap
-- 
2.18.0.rc1

