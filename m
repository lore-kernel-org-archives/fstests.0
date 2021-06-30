Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83561C11F6A
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Jun 2021 11:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB3C61419
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Jun 2021 11:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhF3LeS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Jun 2021 07:34:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9438 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhF3LeS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Jun 2021 07:34:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GFJy13ZfRzZpDQ;
        Wed, 30 Jun 2021 19:28:41 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 19:31:48 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 30
 Jun 2021 19:31:47 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <guan@eryu.me>,
        <chao@kernel.org>
CC:     <sunke32@huawei.com>
Subject: [PATCH v3 2/3] generic/103: special left calculation for f2fs
Date:   Wed, 30 Jun 2021 19:37:35 +0800
Message-ID: <20210630113736.551843-3-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210630113736.551843-1-sunke32@huawei.com>
References: <20210630113736.551843-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
index 795f851dc6c8..4efa1dc366f9 100755
--- a/tests/generic/103
+++ b/tests/generic/103
@@ -27,10 +27,18 @@ _require_xfs_io_command "falloc"
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
2.25.4

