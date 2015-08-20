Received: from mx1.redhat.com ([209.132.183.28]:60670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724AbbHTO2f (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 20 Aug 2015 10:28:35 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] ext4/305: reduce runtime by limiting mount/umount cycles
Date: Thu, 20 Aug 2015 22:28:27 +0800
Message-Id: <1440080907-25163-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: tytso@mit.edu, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

ext4/305 sleeps 3 minutes and does mount/umount loop in background,
which produces lots of logs in dmesg and 3 minutes is not necessary.

Ted pointed out that 30 mount/umount cycles is enough to crash a buggy
kernel, so just limit the mount/umount loop to reduce the runtime. And
now the runtime is about 2s.

Reported-by: Theodore Ts'o <tytso@mit.edu>
Suggested-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/ext4/305 | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tests/ext4/305 b/tests/ext4/305
index 860d0a6..1711aae 100755
--- a/tests/ext4/305
+++ b/tests/ext4/305
@@ -53,19 +53,18 @@ DEV_BASENAME=$(_short_dev $SCRATCH_DEV)
 echo "Start test on device $SCRATCH_DEV, basename $DEV_BASENAME" >$seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 
-while true;do
-	mount $SCRATCH_DEV $SCRATCH_MNT
-	umount $SCRATCH_DEV
-done &
-PIDS=$!
-
-while true;do
+while true; do
 	cat /proc/fs/ext4/$DEV_BASENAME/mb_groups > /dev/null 2>&1
 done &
-PIDS="$PIDS $!"
+PIDS=$!
 
-# sleep for 180s, in most cases a buggy kernel could hit BUG_ON within 3 minutes
-sleep 180
+# 30 loops is enough to crash a buggy kernel
+i=0
+while [ $i -lt 30 ]; do
+	mount $SCRATCH_DEV $SCRATCH_MNT
+	umount $SCRATCH_DEV
+	let i=i+1
+done
 
 # no BUG_ON, all done
 kill $PIDS >/dev/null 2>&1
-- 
2.4.3

