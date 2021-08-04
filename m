Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD2BC4338F
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Aug 2021 07:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEA060F25
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Aug 2021 07:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhHDHmI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Aug 2021 03:42:08 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56835 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235899AbhHDHmH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Aug 2021 03:42:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UhwuaaJ_1628062908;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UhwuaaJ_1628062908)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 15:41:54 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH] common/attr: remove the MAX_ATTRS and MAX_ATTRVAL_SIZE for nfs
Date:   Wed,  4 Aug 2021 15:41:48 +0800
Message-Id: <20210804074148.203065-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The block size of localfs for nfs may be different with nfs itself.
So it's pointless to test nfs on xattrs size, just remove the special
judge code.

Fixes: commit da3cdb3b91ca ("common/attr: set MAX_ATTR values correctly for NFS")
Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 common/attr | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/attr b/common/attr
index 42ceab92335a..542dff34bf55 100644
--- a/common/attr
+++ b/common/attr
@@ -253,7 +253,7 @@ _getfattr()
 
 # set maximum total attr space based on fs type
 case "$FSTYP" in
-xfs|udf|pvfs2|9p|ceph|nfs)
+xfs|udf|pvfs2|9p|ceph)
 	MAX_ATTRS=1000
 	;;
 *)
@@ -273,7 +273,7 @@ xfs|udf|btrfs)
 pvfs2)
 	MAX_ATTRVAL_SIZE=8192
 	;;
-9p|ceph|nfs)
+9p|ceph)
 	MAX_ATTRVAL_SIZE=65536
 	;;
 bcachefs)
-- 
2.24.4

