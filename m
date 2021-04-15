Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C0C433B4
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 04:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0786113D
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 04:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbhDOEqL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Apr 2021 00:46:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15681 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhDOEqK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Apr 2021 00:46:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FLRXl4ZsfzpXsD
        for <fstests@vger.kernel.org>; Thu, 15 Apr 2021 12:42:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 15 Apr 2021
 12:45:34 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH] generic/619: a better way to get tot_avail_size
Date:   Thu, 15 Apr 2021 00:51:02 -0400
Message-ID: <20210415045102.4099962-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When FSTYP is tmpfs, $DF_PROG --block-size=1 $SCRATCH_DEV is not suitted.

Signei-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/619 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/619 b/tests/generic/619
index 3c43fe746917..76d6b2c470b9 100755
--- a/tests/generic/619
+++ b/tests/generic/619
@@ -89,7 +89,7 @@ calc_thread_cnt()
 	IFS=',' read -ra fratio <<< $file_ratio
 	file_ratio_cnt=${#fratio[@]}
 
-	tot_avail_size=$($DF_PROG --block-size=1 $SCRATCH_DEV | awk 'FNR == 2 { print $5 }')
+	tot_avail_size=$(echo $($DF_PROG | grep -w $SCRATCH_DEV | awk '{print $5}')*1024 | $BC_PROG)
 	avail_size=$(echo $tot_avail_size*$disk_saturation | $BC_PROG)
 	thread_cnt=$(echo "$file_ratio_cnt*($avail_size/$file_ratio_unit)" | $BC_PROG)
 
-- 
2.25.4

