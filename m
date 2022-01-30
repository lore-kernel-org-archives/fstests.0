Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF3AC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Jan 2022 09:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354445AbiA3JSW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Jan 2022 04:18:22 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17832 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbiA3JSU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Jan 2022 04:18:20 -0500
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JmlvC2KYxz9sP2;
        Sun, 30 Jan 2022 17:16:55 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500011.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 30 Jan 2022 17:18:18 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sun, 30 Jan
 2022 17:18:17 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>
CC:     <chao@kernel.org>, <sunke32@huawei.com>
Subject: [PATCH] common/attr: _acl_get_max echo 532 for f2fs
Date:   Sun, 30 Jan 2022 17:28:58 +0800
Message-ID: <20220130092858.1260210-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Run generic/026 on f2fs, the diff:

    -chacl: cannot set access acl on "largeaclfile": Argument list too long
    +Wrong ACL count - 532 != 531

The ACL_MAX_ENTRIES depend on MAX_VALUE_LEN(inode), MAX_VALUE_LEN(inode) I got
by printk is 4244, so I think the ACL_MAX_ENTRIES should be
(4244 - 20) / 8 + 4 =532.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 common/attr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/attr b/common/attr
index 35682d7c..56ac5cca 100644
--- a/common/attr
+++ b/common/attr
@@ -28,7 +28,7 @@ _acl_get_max()
 	f2fs)
 		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
 		if [ $? -eq 0 ]; then
-			echo 531
+			echo 532
 		else
 			echo 506
 		fi
-- 
2.13.6

