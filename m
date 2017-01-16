Received: from cn.fujitsu.com ([59.151.112.132]:61511 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750855AbdAPIHa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Jan 2017 03:07:30 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] common/rc: Fix _supports_filetype function
Date: Mon, 16 Jan 2017 16:07:20 +0800
Message-ID: <1484554040-4231-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170116072352.GE1859@eguan.usersys.redhat.com>
References: <20170116072352.GE1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

generic/401 failed on RHEL6.8GA because "--output=xxx"
option is not supported by df.  So we remove it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 892c46e..87ef849 100644
--- a/common/rc
+++ b/common/rc
@@ -268,14 +268,14 @@ _supports_filetype()
 {
 	local dir=$1
 
-	local fstyp=$(df --output=fstype $dir | tail -1)
+	local fstyp=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $2}'`
 	case "$fstyp" in
 	xfs)
 		xfs_info $dir | grep -q "ftype=1"
 		;;
 	ext2|ext3|ext4)
-		tune2fs -l $(df --output=source $dir | tail -1) | \
-		   grep -q filetype
+		local mntdir=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $1}'`
+		tune2fs -l $mntdir | grep -q filetype
 		;;
 	*)
 		local testfile=$dir/$$.ftype
-- 
1.8.3.1



