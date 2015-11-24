Received: from cn.fujitsu.com ([59.151.112.132]:6995 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752228AbbKXMLZ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Nov 2015 07:11:25 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id A5C1B408D460
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2015 20:10:28 +0800 (CST)
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH v2] fstests: Update generic/077 for newest version of btrfs progs
Date: Tue, 24 Nov 2015 20:09:26 +0800
Message-ID: <303122319b2f81902b981db5f1aeb8608be9be7d.1448366932.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

generic/077 fails on btrfs progs v4.3:
 # ./check generic/077
 FSTYP         -- btrfs
 PLATFORM      -- Linux/x86_64 lenovo 4.4.0-rc2_HEAD_1ec218373b8ebda821aec00bb156a9c94fad9cd4_
 MKFS_OPTIONS  -- /dev/sdb6
 MOUNT_OPTIONS -- /dev/sdb6 /var/ltf/tester/scratch_mnt

 generic/077 344s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//generic/077.out.bad)
     --- tests/generic/077.out   2015-11-23 17:06:27.144983112 +0800
     +++ /var/lib/xfstests/results//generic/077.out.bad  2015-11-23 17:41:25.187062895 +0800
     @@ -1,7 +1,5 @@
      QA output created by 077
      *** create filesystem
     -*** set default ACL
     -*** populate filesystem, pass #1
     -*** populate filesystem, pass #2
     -*** all done
     +mkfs failed
     +(see /var/lib/xfstests/results//generic/077.full for details)
      *** unmount
 Ran: generic/077
 Failures: generic/077
 Failed 1 of 1 tests

Reason:
 btrfs progs v4.3 use non-mixed blockgroup for small volume as default,
 it need at least 100M to build a filesystem.

Fix:
 Force mixed mode for small-size fs, to make mkfs success.

Changelog v1->v2:
 Use mixed mode for small-size fs, instead of increase test fs size
 in v1.
Suggested-by: Dave Chinner <david@fromorbit.com>

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 common/rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 4c2f42c..0670102 100644
--- a/common/rc
+++ b/common/rc
@@ -732,7 +732,9 @@ _scratch_mkfs_sized()
 	$MKFS_UDF_PROG $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
 	;;
     btrfs)
-	$MKFS_BTRFS_PROG $MKFS_OPTIONS -b $fssize $SCRATCH_DEV
+	local mixed_opt=
+	(( fssize <= 100 * 1024 * 1024 )) && mixed_opt='--mixed'
+	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
 	;;
     reiser4)
 	# mkfs.resier4 requires size in KB as input for creating filesystem
-- 
1.8.5.1


-- 
This message has been scanned for viruses and
dangerous content by Fujitsu, and is believed to be clean.

