Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F1C433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Feb 2022 07:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiBHHAf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Feb 2022 02:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiBHHAe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Feb 2022 02:00:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B19C0401EF
        for <fstests@vger.kernel.org>; Mon,  7 Feb 2022 23:00:31 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtDPt0YmCz9sWK;
        Tue,  8 Feb 2022 14:58:58 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 15:00:28 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 15:00:28 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <guan@eryu.me>
CC:     <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <sunke32@huawei.com>
Subject: [PATCH] common/attr: adbjust acl_max of f2fs
Date:   Tue, 8 Feb 2022 15:16:24 +0800
Message-ID: <20220208071624.1095904-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

f2fs has set inline_xattr as a default option, and introduced a new
option named 'noinline_xattr' for disabling default inline_xattr option.
So in _acl_get_max we need to check 'noinline_xattr' string in fs
option, otherwise we may select the wrong max acl number since we always
found the string 'inline_xattr' in fs option.

Additionally, f2fs has changed disk layout of xattr block a bit, so will
contain one more entry in both inline and noinline xattr inode, this
patch will modify the max acl number to adjust it.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 common/attr | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/common/attr b/common/attr
index 35682d7c..dae8a1bb 100644
--- a/common/attr
+++ b/common/attr
@@ -26,11 +26,24 @@ _acl_get_max()
 		echo 8191
 		;;
 	f2fs)
-		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
+		# If noinline_xattr is enabled, max xattr size should be:
+		# (4096 - 24) - (24 + 4) = 4044
+		# then ACL_MAX_ENTRIES should be:
+		# (4044 - (4 + 4 * 4)) / 8 + 4 = 507
+		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
 		if [ $? -eq 0 ]; then
-			echo 531
+			echo 507
 		else
-			echo 506
+			# If inline_xattr is enabled, max xattr size should be:
+			# (4096 - 24 + 200) - (24 + 4) = 4244
+			# then ACL_MAX_ENTRIES should be:
+			# (4244 - (4 + 4 * 4)) / 8 + 4 = 532
+			_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
+			if [ $? -eq 0 ]; then
+				echo 532
+			else
+				echo 507
+			fi
 		fi
 		;;
 	bcachefs)
-- 
2.13.6

