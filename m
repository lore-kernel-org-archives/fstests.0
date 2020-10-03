Return-Path: <SRS0=D0rD=DK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F522C46466
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Oct 2020 03:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE65D20672
	for <linux-fstests@archiver.kernel.org>; Sat,  3 Oct 2020 03:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgJCD41 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 2 Oct 2020 23:56:27 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40791 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725801AbgJCD41 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Oct 2020 23:56:27 -0400
X-IronPort-AV: E=Sophos;i="5.77,330,1596470400"; 
   d="scan'208";a="99856001"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Oct 2020 11:56:25 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 164EE48990D5;
        Sat,  3 Oct 2020 11:56:21 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Sat, 3 Oct 2020 11:56:21 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Sat, 3 Oct 2020 11:56:18 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <amir73il@gmail.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] overlay/071: Don't compare inode numbers in lower overlay and nested overlay
Date:   Sat, 3 Oct 2020 11:37:35 +0800
Message-ID: <20201003033735.32452-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 164EE48990D5.AE67C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) If underlying filesystem is ext4, the lower overlay inodes do not
   have the MSB set (e.g. file ino 8590721028 = 0x2000C0004) because
   ext4 has a known inode number limit of 32bit (see ovl_can_decode_fh).
2) With nested xino feature, the nested overlay inodes have the MSB set
   (e.g. file ino 9223372045445496836  = 0x80000002000C0004).
It is expected different inode numbers which casue the failure of
overlay/071, so fix this failure by removing the unneeded comparision.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/overlay/071 | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/overlay/071 b/tests/overlay/071
index ac2324c8..90770936 100755
--- a/tests/overlay/071
+++ b/tests/overlay/071
@@ -194,12 +194,8 @@ mount_dirs
 record_inode_numbers $SCRATCH_MNT/lowertestdir $tmp.lower.lo
 record_inode_numbers $SCRATCH_MNT/uppertestdir $tmp.lower.up
 
-# Compare inode numbers in lower overlay vs. nested overlay
-# With nested xino lower/lower, all inode numbers overflow xino bits and
-# d_ino/i_ino in nested overlay are the same as in lower overlay.
-check_inode_numbers $lowertestdir $tmp.lower.lo $tmp.before.lo
-
 # Record inode numbers before copy up from nested upper
+record_inode_numbers $lowertestdir $tmp.before.lo
 record_inode_numbers $uppertestdir $tmp.before.up
 
 # Copy up all files
-- 
2.25.1



