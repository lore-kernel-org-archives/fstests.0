Received: from szxga04-in.huawei.com ([45.249.212.190]:17081 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfADIwo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jan 2019 03:52:44 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF82EF5BCECAB
        for <fstests@vger.kernel.org>; Fri,  4 Jan 2019 16:52:41 +0800 (CST)
From: Hou Tao <houtao1@huawei.com>
Subject: [PATCH] xfs: only set XFS_MKFS_HAS_NO_META_SUPPORT for XFS
Date: Fri, 4 Jan 2019 16:56:10 +0800
Message-ID: <20190104085610.93116-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: houtao1@huawei.com
List-ID: <fstests@vger.kernel.org>

No need to set XFS_MKFS_HAS_NO_META_SUPPORT for all filesystems.

Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 common/config | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/common/config b/common/config
index f9e932f1..f7b5b7ae 100644
--- a/common/config
+++ b/common/config
@@ -258,15 +258,17 @@ if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
 fi
 
 # check if mkfs.xfs supports v5 xfs
-XFS_MKFS_HAS_NO_META_SUPPORT=""
-touch /tmp/crc_check.img
-$MKFS_XFS_PROG -N -d file,name=/tmp/crc_check.img,size=32m -m crc=0 \
-	>/dev/null 2>&1;
-if [ $? -ne 0 ]; then
-	XFS_MKFS_HAS_NO_META_SUPPORT=true
+if [ "$FSTYP" == "xfs" ]; then
+	XFS_MKFS_HAS_NO_META_SUPPORT=""
+	touch /tmp/crc_check.img
+	$MKFS_XFS_PROG -N -d file,name=/tmp/crc_check.img,size=32m -m crc=0 \
+		>/dev/null 2>&1;
+	if [ $? -ne 0 ]; then
+		XFS_MKFS_HAS_NO_META_SUPPORT=true
+	fi
+	rm -f /tmp/crc_check.img
+	export XFS_MKFS_HAS_NO_META_SUPPORT
 fi
-rm -f /tmp/crc_check.img
-export XFS_MKFS_HAS_NO_META_SUPPORT
 
 _mount_opts()
 {
-- 
2.16.2.dirty
