Return-Path: <SRS0=xPHB=6M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54191C83000
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Apr 2020 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372E3206D9
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Apr 2020 14:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgD1OLA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:11:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3371 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727114AbgD1OLA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 28 Apr 2020 10:11:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7F4BB266EE3D358CD341
        for <fstests@vger.kernel.org>; Tue, 28 Apr 2020 22:10:58 +0800 (CST)
Received: from ubuntu.huawei.com (10.175.104.218) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 22:10:48 +0800
From:   mafeng 00292095 <mafeng.ma@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     mafeng 00292095 <mafeng.ma@huawei.com>
Subject: [PATCH] ext4/308: Fix misspelling in comment
Date:   Tue, 28 Apr 2020 22:18:50 +0800
Message-ID: <1588083530-8282-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.218]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Just fix three word misspellings in one commet.

Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 tests/ext4/308 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/308 b/tests/ext4/308
index 9469084..2e636c3 100755
--- a/tests/ext4/308
+++ b/tests/ext4/308
@@ -48,7 +48,7 @@ _workout()
 	# Fill holes for half of range , as result file will contain nr*1.5 fragments
 	$XFS_IO_PROG -c "falloc 0 $((204800*nr))"  \
 	    $SCRATCH_MNT/test.$nr | _filter_xfs_io
-	# Data wrilte will convert extetns to inialized ones
+	# Data write will convert extents to initialized ones
 	for ((i=0;i<nr;i++))
 	do
 		patt=`printf "0x%x" $i`
-- 
2.7.4

