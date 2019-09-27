Return-Path: <SRS0=31Kr=XW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDDC4360C
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A691C217D7
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 10:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfI0KHK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:07:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfI0KHK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 06:07:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5112D5ABBF7E19DD27E2;
        Fri, 27 Sep 2019 18:07:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 27 Sep 2019 18:06:56 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        "Chao Yu" <yuchao0@huawei.com>
Subject: [PATCH 2/2] common/casefold: support f2fs
Date:   Fri, 27 Sep 2019 18:06:27 +0800
Message-ID: <20190927100627.9086-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190927100627.9086-1-yuchao0@huawei.com>
References: <20190927100627.9086-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org
Message-ID: <20190927100627.nPRugl6tCRor-64VtkQyD0JCfUobga9y4MM79APXNaU@z>

Now, f2fs has ported casefold feature from ext4, let's enable the
testcase.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/casefold | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/casefold b/common/casefold
index 2a7ab3eb..9172d818 100644
--- a/common/casefold
+++ b/common/casefold
@@ -9,6 +9,9 @@ _has_casefold_kernel_support()
 	ext4)
 		test -f '/sys/fs/ext4/features/casefold'
 		;;
+	f2fs)
+		test -f '/sys/fs/f2fs/features/casefold'
+		;;
 	*)
 		# defaults to unsupported
 		false
@@ -46,6 +49,9 @@ _scratch_mkfs_casefold()
 	ext4)
 		_scratch_mkfs -O casefold $*
 		;;
+	f2fs)
+		_scratch_mkfs -C utf8 $*
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold support on $FSTYP"
 		;;
@@ -58,6 +64,9 @@ _scratch_mkfs_casefold_strict()
 	ext4)
 		_scratch_mkfs -O casefold -E encoding_flags=strict
 		;;
+	f2fs)
+		_scratch_mkfs -C utf8:strict
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
 		;;
-- 
2.18.0.rc1

