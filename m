Return-Path: <SRS0=RNsM=DX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1353FC433E7
	for <linux-fstests@archiver.kernel.org>; Fri, 16 Oct 2020 09:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B758A206ED
	for <linux-fstests@archiver.kernel.org>; Fri, 16 Oct 2020 09:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405891AbgJPJcX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 16 Oct 2020 05:32:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56744 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405871AbgJPJcW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Oct 2020 05:32:22 -0400
X-IronPort-AV: E=Sophos;i="5.77,382,1596470400"; 
   d="scan'208";a="100227468"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Oct 2020 17:32:19 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1456B48990F8;
        Fri, 16 Oct 2020 17:32:16 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 16 Oct 2020 17:32:15 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH 1/2] xfs/521: use _try_scratch_mount instead of _scratch_mount
Date:   Fri, 16 Oct 2020 17:31:23 +0800
Message-ID: <1602840684-25524-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 1456B48990F8.AB727
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Here will check the return code of mount option. So update it
to use _try_scratch_mount.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/xfs/521 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/521 b/tests/xfs/521
index 3aaa1296..e6c417b8 100755
--- a/tests/xfs/521
+++ b/tests/xfs/521
@@ -49,7 +49,7 @@ echo "Format and mount 100m rt volume"
 export USE_EXTERNAL=yes
 export SCRATCH_RTDEV=$rtdev
 _scratch_mkfs -r size=100m > $seqres.full
-_scratch_mount || _notrun "Could not mount scratch with synthetic rt volume"
+_try_scratch_mount || _notrun "Could not mount scratch with synthetic rt volume"
 
 testdir=$SCRATCH_MNT/test-$seq
 mkdir $testdir
-- 
2.23.0



