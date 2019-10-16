Return-Path: <SRS0=dVie=YJ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E63ECE59D
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Oct 2019 01:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840D62067B
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Oct 2019 01:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfJPBIQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:08:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730242AbfJPBIQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Oct 2019 21:08:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E51BCBA3D51CDCC0B7D5;
        Wed, 16 Oct 2019 09:08:08 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 09:07:57 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <guaneryu@gmail.com>, <darrick.wong@oracle.com>,
        <ebiggers@google.com>, <yi.zhang@huawei.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH xfstests v2] common/rc: Add path $here before src/t_dir_type
Date:   Wed, 16 Oct 2019 09:15:00 +0800
Message-ID: <1571188500-82985-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Running generic/192 with overlayfs(Let ubifs as base fs) yields the
following output:

  generic/192 - output mismatch
     QA output created by 192
     sleep for 5 seconds
     test
    +./common/rc: line 316: src/t_dir_type: No such file or directory
     delta1 is in range
     delta2 is in range
    ...

When the use case fails, the call stack in generic/192 is:

  local unknowns=$(src/t_dir_type $dir u | wc -l)	common/rc:316
  _supports_filetype					common/rc:299
  _overlay_mount					common/overlay:52
  _overlay_test_mount					common/overlay:93
  _test_mount						common/rc:407
  _test_cycle_mount					generic/192:50

Before _test_cycle_mount() being invoked, generic/192 executed 'cd /'
to change work dir from 'xfstests-dev' to '/', so src/t_dir_type was not
found.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index cfaabf10..28c27975 100644
--- a/common/rc
+++ b/common/rc
@@ -313,7 +313,7 @@ _supports_filetype()
 		local testfile=$dir/$$.ftype
 		touch $testfile
 		# look for DT_UNKNOWN files
-		local unknowns=$(src/t_dir_type $dir u | wc -l)
+		local unknowns=$($here/src/t_dir_type $dir u | wc -l)
 		rm $testfile
 		# 0 unknowns is success
 		return $unknowns
-- 
2.13.6

