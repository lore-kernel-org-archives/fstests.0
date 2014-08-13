Return-Path: <fstests-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.232.25]:43716 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaHMPgp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 13 Aug 2014 11:36:45 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 1/2] xfstest: shared/298 fixup mkfs options
Date: Wed, 13 Aug 2014 19:36:27 +0400
Message-Id: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

Currently mkfs faile due to incorrect options

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 tests/shared/298 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/shared/298 b/tests/shared/298
index 372fd02..685ba27 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -134,8 +134,8 @@ mkdir $loop_mnt
 
 [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
 
-$MKFS_PROG -t $FSTYP $MKFS_OPTIONS $loop_dev &> /dev/null
-$MOUNT_PROG $loop_dev $loop_mnt
+run_check $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $loop_dev
+run_check $MOUNT_PROG $loop_dev $loop_mnt
 
 echo -n "Generating garbage on loop..."
 # Goal is to fill it up, ignore any errors.
-- 
1.7.1

