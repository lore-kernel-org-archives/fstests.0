Received: from aserp1040.oracle.com ([141.146.126.69]:46030 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdDLB27 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Apr 2017 21:28:59 -0400
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH] fstests: introduce btrfs-map-logical
Date: Tue, 11 Apr 2017 18:27:43 -0700
Message-Id: <1491960463-28680-1-git-send-email-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

A typical use case of 'btrfs-map-logical' is to translate btrfs logical
address to physical address on each disk.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 59041a3..b7c06bf 100644
--- a/common/config
+++ b/common/config
@@ -249,6 +249,7 @@ case "$HOSTOS" in
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
 	export BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
+	export BTRFS_MAP_LOGICAL_PROG="`set_prog_path btrfs-map-logical`"
         export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
         export MKFS_NFS_PROG="false"
         export MKFS_CIFS_PROG="false"
-- 
2.5.0

