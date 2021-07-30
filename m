Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9976AC4338F
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Jul 2021 12:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAE260E97
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Jul 2021 12:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhG3MnJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Jul 2021 08:43:09 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51599 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238833AbhG3MnH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Jul 2021 08:43:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0UhRvog2_1627648972;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UhRvog2_1627648972)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Jul 2021 20:42:57 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/attr: fix the MAX_ATTRS and MAX_ATTRVAL_SIZE for nfs
Date:   Fri, 30 Jul 2021 20:42:52 +0800
Message-Id: <20210730124252.113071-1-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The block size of localfs for nfs may be much smaller than nfs itself.
So we'd better set MAX_ATTRS and MAX_ATTRVAL_SIZE to 4096 to avoid
'no space' error when we test adding a bunch of xattrs to nfs.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---

It's better to set BLOCK_SIZE to `_get_block_size $variable`
here $variable is the localfs for nfs, since I'm not familiar with
xfstests, anyone tell what's the name of it.

 common/attr | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/common/attr b/common/attr
index 42ceab92335a..a833f00e0884 100644
--- a/common/attr
+++ b/common/attr
@@ -253,9 +253,13 @@ _getfattr()
 
 # set maximum total attr space based on fs type
 case "$FSTYP" in
-xfs|udf|pvfs2|9p|ceph|nfs)
+xfs|udf|pvfs2|9p|ceph)
 	MAX_ATTRS=1000
 	;; 
+nfs)
+	BLOCK_SIZE=4096
+	let MAX_ATTRS=$BLOCK_SIZE/40
+	;;
 *)
 	# Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
@@ -273,12 +277,15 @@ xfs|udf|btrfs)
 pvfs2)
 	MAX_ATTRVAL_SIZE=8192
 	;;
-9p|ceph|nfs)
+9p|ceph)
 	MAX_ATTRVAL_SIZE=65536
 	;;
 bcachefs)
 	MAX_ATTRVAL_SIZE=1024
 	;;
+nfs)
+	MAX_ATTRVAL_SIZE=3840
+	;;
 *)
 	# Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
-- 
2.24.4

