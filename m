Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A4DC433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Apr 2021 12:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1E1611F0
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Apr 2021 12:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhDSM3v (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:29:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17360 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhDSM3v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Apr 2021 08:29:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FP5fV2gJ4z7vtL;
        Mon, 19 Apr 2021 20:26:58 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Mon, 19 Apr 2021
 20:29:12 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>
CC:     <sunke32@huawei.com>
Subject: [v2] generic/619: a better way to get tot_avail_size
Date:   Mon, 19 Apr 2021 08:34:37 -0400
Message-ID: <20210419123437.101855-1-sunke32@huawei.com>
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
index 3c43fe746917..460699d1bdf0 100755
--- a/tests/generic/619
+++ b/tests/generic/619
@@ -89,7 +89,7 @@ calc_thread_cnt()
 	IFS=',' read -ra fratio <<< $file_ratio
 	file_ratio_cnt=${#fratio[@]}
 
-	tot_avail_size=$($DF_PROG --block-size=1 $SCRATCH_DEV | awk 'FNR == 2 { print $5 }')
+	tot_avail_size=$($DF_PROG --block-size=1 $SCRATCH_MNT | $AWK_PROG 'FNR == 2 { print $5 }')
 	avail_size=$(echo $tot_avail_size*$disk_saturation | $BC_PROG)
 	thread_cnt=$(echo "$file_ratio_cnt*($avail_size/$file_ratio_unit)" | $BC_PROG)
 
-- 
2.25.4

