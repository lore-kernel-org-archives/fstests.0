Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424ACC2B9F4
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE14613F3
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 06:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhFQG7N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Jun 2021 02:59:13 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7343 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQG7N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Jun 2021 02:59:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5CS03fLDz6yNJ;
        Thu, 17 Jun 2021 14:53:04 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 14:56:59 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 17
 Jun 2021 14:56:58 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <guan@eryu.me>,
        <chao@kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH v2] generic/260: f2fs is also special
Date:   Thu, 17 Jun 2021 15:03:10 +0800
Message-ID: <20210617070310.3515665-2-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210617070310.3515665-1-sunke32@huawei.com>
References: <20210617070310.3515665-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It fail on f2fs:

 [+] Default length with start set (should succeed)
 [+] Length beyond the end of fs (should succeed)
 [+] Length beyond the end of fs with start set (should succeed)
+After the full fs discard 0 bytes were discarded however the file system is 12882804736 bytes long.
+It seems that fs logic handling len argument overflows

The root cause is f2fs can tag a special flag TRIMMED_FLAG to indicate
the whole filesystem is trimmed, so after mkfs/fstrim(), following
fstrim() won't trim any block.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/260 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/generic/260 b/tests/generic/260
index 8021aa68..4ab35a56 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -100,7 +100,10 @@ fi
 # It is because btrfs does not have not-yet-used parts of the device
 # mapped and since we got here right after the mkfs, there is not
 # enough free extents in the root tree.
-if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
+# F2fs is also special. F2fs can tag a special flag TRIMMED_FLAG to
+# indicate the whole filesystem is trimmed, so after mkfs/fstrim(),
+# following fstrim() won't trim any block.
+if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
 	status=1
 	echo "After the full fs discard $bytes bytes were discarded"\
 	     "however the file system is $(_math "$fssize*1024") bytes long."
@@ -159,8 +162,11 @@ _scratch_mount
 # It is because btrfs does not have not-yet-used parts of the device
 # mapped and since we got here right after the mkfs, there is not
 # enough free extents in the root tree.
+# F2fs is also special. F2fs can tag a special flag TRIMMED_FLAG to
+# indicate the whole filesystem is trimmed, so after mkfs/fstrim(),
+# following fstrim() won't trim any block.
 bytes=$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
-if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
+if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
 	status=1
 	echo "It seems that fs logic handling len argument overflows"
 fi
-- 
2.13.6

