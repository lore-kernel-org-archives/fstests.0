Received: from mail.kernel.org ([198.145.29.136]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753520AbdD1NPY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Apr 2017 09:15:24 -0400
From: Chao Yu <chao@kernel.org>
Subject: [PATCH] attr: adbjust acl_max of f2fs
Date: Fri, 28 Apr 2017 21:13:07 +0800
Message-Id: <20170428131307.3384-1-chao@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, eguan@redhat.com
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

From: Chao Yu <yuchao0@huawei.com>

f2fs has set inline_xattr as a default option, and introduced a new option
named 'noinline_xattr' for disabling default inline_xattr option. So in
_acl_get_max we need to check 'noinline_xattr' string in fs option,
otherwise we may select the wrong max acl number since we always found
the string 'ininline_xattr' in fs option.

Additionally, f2fs has changed disk layout of xattr block a bit, so will
contain one more entry in both inline and noinline xattr inode, this patch
will modify the max acl number to adjust it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/attr | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/attr b/common/attr
index ac139e61..6d4f68ed 100644
--- a/common/attr
+++ b/common/attr
@@ -43,11 +43,11 @@ _acl_get_max()
 		echo 8191
 		;;
 	f2fs)
-		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
+		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
 		if [ $? -eq 0 ]; then
-			echo 531
+			echo 507
 		else
-			echo 506
+			echo 532
 		fi
 		;;
 	*)
-- 
2.12.2.575.gb14f27f

