Received: from cn.fujitsu.com ([59.151.112.132]:29047 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751836AbbGVEeS (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 22 Jul 2015 00:34:18 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6M4WPvh012279
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2015 12:32:25 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH] Make -g and -x option meet description in manual
Date: Wed, 22 Jul 2015 12:32:37 +0800
Message-ID: <faccdf430dfe4d06f656f267f4f176a32193d2da.1437539516.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

In manual:
 # ./check --help
 ...
 -g group[,group...] include tests from these groups
 -x group[,group...] exclude tests from these groups
 ...

Above format is not supported, because ',' is not parsed in code.
This patch fixed it.

Before patch:
 # ./check -g scrub,replace
 Group "scrub,replace" is empty or not defined?

After patch:
 # ./check -g scrub,replace
 FSTYP         -- btrfs
 PLATFORM      -- Linux/x86_64 kerneldev 4.2.0-rc2_HEAD_c65b99f046843d2455aa231747b5a07a999a9f3d_+
 MKFS_OPTIONS  -- /dev/vdd
 MOUNT_OPTIONS -- /dev/vdd /var/ltf/tester/scratch_mnt
 ...(right result)...

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 check | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/check b/check
index a300130..330c3e8 100755
--- a/check
+++ b/check
@@ -209,11 +209,11 @@ while [ $# -gt 0 ]; do
 	-tmpfs)	FSTYP=tmpfs ;;
 
 	-g)	group=$2 ; shift ;
-		GROUP_LIST="$GROUP_LIST $group"
+		GROUP_LIST="$GROUP_LIST ${group//,/ }"
 		;;
 
 	-x)	xgroup=$2 ; shift ;
-		XGROUP_LIST="$XGROUP_LIST $xgroup"
+		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
 		;;
 
 	-X)	xfile=$2; shift ;
-- 
1.8.5.1

