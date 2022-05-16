Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A5C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 06:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiEPGIY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 02:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbiEPGIO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 02:08:14 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 565A820F64
        for <fstests@vger.kernel.org>; Sun, 15 May 2022 23:08:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3338C5345CC
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 16:08:11 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqTtp-00CYbG-Fu
        for fstests@vger.kernel.org; Mon, 16 May 2022 16:08:09 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqTtp-005QwJ-Et
        for fstests@vger.kernel.org;
        Mon, 16 May 2022 16:08:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/3] xfs/122: add attribute log formats to test output.
Date:   Mon, 16 May 2022 16:08:06 +1000
Message-Id: <20220516060807.1295102-3-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516060807.1295102-1-david@fromorbit.com>
References: <20220516060807.1295102-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6281ea4b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=zfnGL-Rk5xkN1Y3xoGsA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Now that we have merged logged attributes, add the attribute log
format sizes to the on-disk structure size checking.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/122.out | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index 608faa4b..a56cbee8 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -63,6 +63,8 @@ sizeof(struct xfs_attr3_leaf_hdr) = 80
 sizeof(struct xfs_attr3_leafblock) = 88
 sizeof(struct xfs_attr3_rmt_hdr) = 56
 sizeof(struct xfs_attr_shortform) = 8
+sizeof(struct xfs_attrd_log_format) = 16
+sizeof(struct xfs_attri_log_format) = 40
 sizeof(struct xfs_btree_block) = 72
 sizeof(struct xfs_btree_block_lhdr) = 64
 sizeof(struct xfs_btree_block_shdr) = 48
-- 
2.35.1

