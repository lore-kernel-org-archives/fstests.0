Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37292 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbbD3Iou (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Apr 2015 04:44:50 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/204: use more space for inode allocation
Date: Thu, 30 Apr 2015 16:44:20 +0800
Message-Id: <1430383460-32206-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On v4/512b and v5/1k xfs, there're not enough free inodes for new files
and generic/204 fails because of running out of inode not space.

Adding "-i maxpct=50" to MKFS_OPTIONS to bump up the inode limit at mkfs
time, and test could pass on all configurations.

Suggested-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/204 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/204 b/tests/generic/204
index 13069d8..42985ab 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -52,8 +52,10 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 . $tmp.mkfs
 
 # For xfs, we need to handle the different default log sizes that different
-# versions of mkfs create. All should be valid with a 5MB log, so use that.
-[ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=7m"
+# versions of mkfs create. All should be valid with a 7MB log, so use that.
+# And v4/512 v5/1k xfs don't have enough free inodes, set imaxpct=50 at mkfs
+# time solves this problem.
+[ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=7m -i maxpct=50"
 
 SIZE=`expr 106 \* 1024 \* 1024`
 _scratch_mkfs_sized $SIZE $dbsize 2> /dev/null \
-- 
1.8.3.1

