Received: from szxga06-in.huawei.com ([45.249.212.32]:43822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732316AbfGWJZ6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jul 2019 05:25:58 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] common/quota: support f2fs in _require_quota() and _check_quota_usage()
Date: Tue, 23 Jul 2019 17:25:28 +0800
Message-ID: <20190723092529.112426-2-yuchao0@huawei.com>
In-Reply-To: <20190723092529.112426-1-yuchao0@huawei.com>
References: <20190723092529.112426-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.orga, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

This can let f2fs pass the check of quota testcases.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/quota | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/quota b/common/quota
index f19f81a1..9af280a2 100644
--- a/common/quota
+++ b/common/quota
@@ -12,7 +12,7 @@ _require_quota()
     [ -n "$QUOTA_PROG" ] || _notrun "Quota user tools not installed"
 
     case $FSTYP in
-    ext2|ext3|ext4|ext4dev|reiserfs)
+    ext2|ext3|ext4|ext4dev|f2fs|reiserfs)
 	if [ ! -d /proc/sys/fs/quota ]; then
 	    _notrun "Installed kernel does not support quotas"
 	fi
@@ -257,7 +257,7 @@ _check_quota_usage()
 
 	VFS_QUOTA=0
 	case $FSTYP in
-	ext2|ext3|ext4|ext4dev|reiserfs|gfs2)
+	ext2|ext3|ext4|ext4dev|f2fs|reiserfs|gfs2)
 		VFS_QUOTA=1
 		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
 		;;
-- 
2.18.0.rc1
