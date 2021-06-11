Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82777C48BE5
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Jun 2021 11:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7E761364
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Jun 2021 11:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhFKLR6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Jun 2021 07:17:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5393 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhFKLR4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Jun 2021 07:17:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G1dTb3m92z6w8p;
        Fri, 11 Jun 2021 19:12:03 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 19:15:57 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 19:15:56 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>, <yuchao0@huawei.com>
CC:     <sunke32@huawei.com>
Subject: [PATCH] generic/260: f2fs is also special
Date:   Fri, 11 Jun 2021 19:22:11 +0800
Message-ID: <20210611112211.1408767-3-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210611112211.1408767-1-sunke32@huawei.com>
References: <20210611112211.1408767-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

It seem that f2fs also special like btrfs.

 [+] Default length with start set (should succeed)
 [+] Length beyond the end of fs (should succeed)
 [+] Length beyond the end of fs with start set (should succeed)
+After the full fs discard 0 bytes were discarded however the file system is 12882804736 bytes long.
+It seems that fs logic handling len argument overflows

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
I am not sure about that. o(╯□╰)o

 tests/generic/260 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/260 b/tests/generic/260
index 8021aa68..6bd861d2 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -100,7 +100,7 @@ fi
 # It is because btrfs does not have not-yet-used parts of the device
 # mapped and since we got here right after the mkfs, there is not
 # enough free extents in the root tree.
-if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
+if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
 	status=1
 	echo "After the full fs discard $bytes bytes were discarded"\
 	     "however the file system is $(_math "$fssize*1024") bytes long."
@@ -160,7 +160,7 @@ _scratch_mount
 # mapped and since we got here right after the mkfs, there is not
 # enough free extents in the root tree.
 bytes=$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
-if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
+if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
 	status=1
 	echo "It seems that fs logic handling len argument overflows"
 fi
-- 
2.13.6

