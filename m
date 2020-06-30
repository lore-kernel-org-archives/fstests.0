Return-Path: <SRS0=QKYl=AL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC26C433DF
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 06:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB68D20759
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 06:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgF3GXe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:23:34 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26891 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725845AbgF3GXe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jun 2020 02:23:34 -0400
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; 
   d="scan'208";a="95549934"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jun 2020 14:23:27 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E6A574CE4B1A
        for <fstests@vger.kernel.org>; Tue, 30 Jun 2020 14:12:54 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 30 Jun 2020 14:23:22 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/516: Use scratch_xfs_get/set_sb_field api
Date:   Tue, 30 Jun 2020 14:23:07 +0800
Message-ID: <1593498187-21213-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: E6A574CE4B1A.A0DEB
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When using old xfsprogs, this case fails as below:
    +write: invalid option -- 'd'

xfs_db write command support -d options since xfsprogs commit
86769b32d01 ("xfs_db: allow recalculating CRCs on invalid metadata").
For avoid invalid error, use scratch_xfs_set_sb_field api instead.

Also add missing "rm -f $seqres.full" at the beginning of the test.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/xfs/516 | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/516 b/tests/xfs/516
index ca8c0412..3a7afd0e 100755
--- a/tests/xfs/516
+++ b/tests/xfs/516
@@ -22,6 +22,8 @@ _cleanup()
 	cd /
 }
 
+rm -f $seqres.full
+
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/fuzzy
@@ -60,7 +62,8 @@ __test_mount_opts()
 	else
 		echo "mount failed" >> $seqres.full
 	fi
-	_scratch_xfs_db -c 'sb 0' -c 'p unit width' >> $seqres.full
+	_scratch_xfs_get_sb_field unit >> $seqres.full
+	_scratch_xfs_get_sb_field width  >> $seqres.full
 
 	# Run xfs_repair in repair mode to see if it can be baited into nuking
 	# the root filesystem on account of the sunit update.
@@ -119,9 +122,12 @@ test_repair_detection()
 	fi
 
 	# Update the superblock like the kernel used to do.
-	_scratch_xfs_db -c 'sb 0' -c 'p unit width' >> $seqres.full
-	_scratch_xfs_db -x -c 'sb 0' -c 'write -d unit 256' -c 'write -d width 1024' >> $seqres.full
-	_scratch_xfs_db -c 'sb 0' -c 'p unit width' >> $seqres.full
+	_scratch_xfs_get_sb_field unit >> $seqres.full
+	_scratch_xfs_get_sb_field width >> $seqres.full
+	_scratch_xfs_set_sb_field unit 256 >> $seqres.full
+	_scratch_xfs_set_sb_field width 1024 >> $seqres.full
+	_scratch_xfs_get_sb_field unit >> $seqres.full
+	_scratch_xfs_get_sb_field width >> $seqres.full
 
 	# Run xfs_repair in repair mode to see if it can be baited into nuking
 	# the root filesystem on account of the sunit update.
-- 
2.23.0



