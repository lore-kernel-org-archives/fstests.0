Received: from cn.fujitsu.com ([59.151.112.132]:40369 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752558AbbG3GMm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 02:12:42 -0400
From: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: [PATCH 5/5] xfstest: add quota tests to ubifs
Date: Thu, 30 Jul 2015 14:06:57 +0800
Message-ID: <1438236417-24612-6-git-send-email-yangds.fnst@cn.fujitsu.com>
In-Reply-To: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
References: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com, fstests@vger.kernel.org, dedekind1@gmail.com, richard.weinberger@gmail.com
Cc: linux-mtd@lists.infradead.org, Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
---
 common/quota | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/quota b/common/quota
index 23be4f8..b0b1eef 100644
--- a/common/quota
+++ b/common/quota
@@ -29,7 +29,7 @@ _require_quota()
     [ -n $QUOTA_PROG ] || _notrun "Quota user tools not installed"
 
     case $FSTYP in
-    ext2|ext3|ext4|ext4dev|reiserfs)
+    ubifs|ext2|ext3|ext4|ext4dev|reiserfs)
 	if [ ! -d /proc/sys/fs/quota ]; then
 	    _notrun "Installed kernel does not support quotas"
 	fi
@@ -213,7 +213,7 @@ _check_quota_usage()
 
 	VFS_QUOTA=0
 	case $FSTYP in
-	ext2|ext3|ext4|ext4dev|reiserfs|gfs2)
+	ubifs|ext2|ext3|ext4|ext4dev|reiserfs|gfs2)
 		VFS_QUOTA=1
 		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
 		;;
-- 
1.8.4.2

