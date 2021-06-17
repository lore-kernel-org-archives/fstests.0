Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815EAC2B9F4
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 06:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABE46113C
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Jun 2021 06:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFQG7I (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Jun 2021 02:59:08 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7316 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQG7H (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Jun 2021 02:59:07 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G5CQh40CTz1BN8R;
        Thu, 17 Jun 2021 14:51:56 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 14:56:58 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 17
 Jun 2021 14:56:57 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <guan@eryu.me>,
        <chao@kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH v2] generic/103: special left calculation for f2fs
Date:   Thu, 17 Jun 2021 15:03:09 +0800
Message-ID: <20210617070310.3515665-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
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

It failed on f2fs:
      QA output created by 103
     +fallocate: No space left on device
      Silence is golden.
     ...

f2fs uses index(radix) tree as mapping metadata, its space overhead
is about one thousandth of the data.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/103 | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/generic/103 b/tests/generic/103
index b22b0159..cf610047 100755
--- a/tests/generic/103
+++ b/tests/generic/103
@@ -40,10 +40,18 @@ rm -f $seqres.full
 _consume_freesp()
 {
 	file=$1
+	left=512
 
 	# consume nearly all available space (leave ~512kB)
 	avail=`_get_available_space $SCRATCH_MNT`
-	filesizekb=$((avail / 1024 - 512))
+
+	# f2fs uses index(radix) tree as mapping metadata, its space overhead
+	# is about one thousandth of the data
+	if [ $FSTYP == "f2fs" ]; then
+		left=$((left + avail / 1024000))
+	fi
+
+	filesizekb=$((avail / 1024 - $left))
 	$XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
 }
 
-- 
2.13.6

