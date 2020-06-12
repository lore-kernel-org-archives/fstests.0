Return-Path: <SRS0=NbcK=7Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E38C433E0
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Jun 2020 05:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB94220878
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Jun 2020 05:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLFSs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:18:48 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48690 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgFLFSs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Jun 2020 01:18:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U.Ka63O_1591939125;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0U.Ka63O_1591939125)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 13:18:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     joseph.qi@linux.alibaba.com, Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] common/dmthin: modify DMTHIN_POOL_NAME
Date:   Fri, 12 Jun 2020 13:18:20 +0800
Message-Id: <20200612051820.80814-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_dmthin_set_queue() gets $cluster_size by 'dmsetup table | grep
$DMTHIN_POOL_NAME'. The original name 'thin-pool' is accidently
the same as the fourth field of the output of 'dmsetup table'.

For example,
vg-pool-tpool: 0 64864256 thin-pool 252:0 252:1 128 0 0

Thus if there is other thin-pool in the test environment, except
for the thin-pool created by _dmthin_init(), the parsed $cluster_size
may be a multi-line string, which is unexpected.

This issue caused a failure of generic/347 and generic/500, while the
dmesg reports 'Invalid argument count'.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 common/dmthin | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/dmthin b/common/dmthin
index 61dd6f89..c58c3948 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -15,7 +15,7 @@ DMTHIN_DATA_DEV="/dev/mapper/$DMTHIN_DATA_NAME"
 DMTHIN_META_NAME="thin-meta"
 DMTHIN_META_DEV="/dev/mapper/$DMTHIN_META_NAME"
 # Backing pool dev (combination of above)
-DMTHIN_POOL_NAME="thin-pool"
+DMTHIN_POOL_NAME="thin-provision-pool"
 DMTHIN_POOL_DEV="/dev/mapper/$DMTHIN_POOL_NAME"
 # Thin volume
 DMTHIN_VOL_NAME="thin-vol"
-- 
2.27.0

