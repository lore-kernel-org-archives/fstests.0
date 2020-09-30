Return-Path: <SRS0=elmR=DH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F75AC4727F
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Sep 2020 05:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D332216C4
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Sep 2020 05:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgI3FW4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Sep 2020 01:22:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8355 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725879AbgI3FWy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Sep 2020 01:22:54 -0400
X-IronPort-AV: E=Sophos;i="5.77,321,1596470400"; 
   d="scan'208";a="99769467"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Sep 2020 13:22:49 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1147848990F2;
        Wed, 30 Sep 2020 13:22:49 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 30 Sep 2020 13:22:48 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 30 Sep 2020 13:22:45 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <amir73il@gmail.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] overlay/071: Fix undefined OVL_BASE_SCRATCH_DIR
Date:   Wed, 30 Sep 2020 13:04:09 +0800
Message-ID: <20200930050409.24705-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1147848990F2.AA2F8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Replace undefined OVL_BASE_SCRATCH_DIR with OVL_BASE_SCRATCH_MNT

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/overlay/071 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/overlay/071 b/tests/overlay/071
index f18429c9..ac2324c8 100755
--- a/tests/overlay/071
+++ b/tests/overlay/071
@@ -59,9 +59,9 @@ lower=$OVL_BASE_TEST_DIR/$OVL_LOWER-$seq
 upper=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
 work=$OVL_BASE_SCRATCH_MNT/$OVL_WORK
 # Lower dir of nested overlay is the scratch overlay mount at SCRATCH_MNT
-upper2=$OVL_BASE_SCRATCH_DIR/$OVL_UPPER.2
-work2=$OVL_BASE_SCRATCH_DIR/$OVL_WORK.2
-mnt2=$OVL_BASE_SCRATCH_DIR/$OVL_MNT.2
+upper2=$OVL_BASE_SCRATCH_MNT/$OVL_UPPER.2
+work2=$OVL_BASE_SCRATCH_MNT/$OVL_WORK.2
+mnt2=$OVL_BASE_SCRATCH_MNT/$OVL_MNT.2
 
 lowerdir=$lower/lowertestdir
 upperdir=$upper/uppertestdir
-- 
2.25.1



