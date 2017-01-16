Received: from cn.fujitsu.com ([59.151.112.132]:39273 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750845AbdAPGkg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Jan 2017 01:40:36 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 8AB8847B0CBB
        for <fstests@vger.kernel.org>; Mon, 16 Jan 2017 14:40:23 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/rc: use $FSTYP and $SCRATCH_DEV in _supports_filetype function
Date: Mon, 16 Jan 2017 14:40:19 +0800
Message-ID: <1484548819-4295-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

generic/401 failed on RHEL6.8GA because output option is not
supported by df.  So we use $FSTYP and $SCRATCH_DEV instead of
df --output to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 892c46e..90ad496 100644
--- a/common/rc
+++ b/common/rc
@@ -268,14 +268,12 @@ _supports_filetype()
 {
 	local dir=$1
 
-	local fstyp=$(df --output=fstype $dir | tail -1)
-	case "$fstyp" in
+	case $FSTYP in
 	xfs)
 		xfs_info $dir | grep -q "ftype=1"
 		;;
 	ext2|ext3|ext4)
-		tune2fs -l $(df --output=source $dir | tail -1) | \
-		   grep -q filetype
+		tune2fs -l $SCRATCH_DEV | grep -q filetype
 		;;
 	*)
 		local testfile=$dir/$$.ftype
-- 
1.8.3.1



