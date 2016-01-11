Received: from mail-ob0-f194.google.com ([209.85.214.194]:33163 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbcAKHVm (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 11 Jan 2016 02:21:42 -0500
Received: by mail-ob0-f194.google.com with SMTP id oj9so3947953obc.0
        for <fstests@vger.kernel.org>; Sun, 10 Jan 2016 23:21:41 -0800 (PST)
From: Jia He <hejianet@gmail.com>
Subject: [PATCH V2] fstests: add user friendly debug prompts for already mounted points name
Date: Mon, 11 Jan 2016 15:21:27 +0800
Message-Id: <1452496887-20385-1-git-send-email-hejianet@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Jia He <hejianet@gmail.com>
List-ID: <fstests@vger.kernel.org>

This adds user friendly prompts to output the already mounted point from _mount.
xfstests will do the cleanup (ie. umount) and user can not get the mount name
information when directory is already mounted.

V2: avoid to call _mount twice
Signed-off-by: Jia He <hejianet@gmail.com>
---
 common/rc | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index 5135260..bf444ec 100644
--- a/common/rc
+++ b/common/rc
@@ -1266,12 +1266,15 @@ _require_scratch_nocheck()
     # mounted?
     # Note that we use -F here so grep doesn't try to interpret an NFS over
     # IPv6 server as a regular expression.
-    if _mount | grep -F -q $SCRATCH_DEV
+    mount_rec=`_mount | grep -F $SCRATCH_DEV`
+    if [ "$mount_rec" ]
     then
         # if it's mounted, make sure its on $SCRATCH_MNT
-        if ! _mount | grep -F $SCRATCH_DEV | grep -q $SCRATCH_MNT
+        if ! echo $mount_rec | grep -q $SCRATCH_MNT
         then
-            echo "\$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT - aborting"
+            echo "\$SCRATCH_DEV=$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT=$SCRATCH_MNT - aborting"
+            echo "Already mounted result:"
+            echo $mount_rec
             exit 1
         fi
         # and then unmount it
@@ -1348,12 +1351,15 @@ _require_test()
     # mounted?
     # Note that we use -F here so grep doesn't try to interpret an NFS over
     # IPv6 server as a regular expression.
-    if _mount | grep -F -q $TEST_DEV
+    mount_rec=`_mount | grep -F $TEST_DEV`
+    if [ "$mount_rec" ]
     then
         # if it's mounted, make sure its on $TEST_DIR
-        if ! _mount | grep -F $TEST_DEV | grep -q $TEST_DIR
+        if ! echo $mount_rec | grep -q $TEST_DIR
         then
-            echo "\$TEST_DEV is mounted but not on \$TEST_DIR - aborting"
+            echo "\$TEST_DEV=$TEST_DEV is mounted but not on \$TEST_DIR=$TEST_DIR - aborting"
+            echo "Already mounted result:"
+            echo $mount_rec
             exit 1
         fi
     else
-- 
2.1.4

