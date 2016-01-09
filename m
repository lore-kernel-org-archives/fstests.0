Received: from mail-oi0-f67.google.com ([209.85.218.67]:36224 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcAIDzI (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 8 Jan 2016 22:55:08 -0500
Received: by mail-oi0-f67.google.com with SMTP id a202so1492260oib.3
        for <fstests@vger.kernel.org>; Fri, 08 Jan 2016 19:55:08 -0800 (PST)
From: Jia He <hejianet@gmail.com>
Subject: [PATCH V2 1/2] fstests: add user friendly prompts for already mounted points name
Date: Sat,  9 Jan 2016 11:54:52 +0800
Message-Id: <1452311693-27529-2-git-send-email-hejianet@gmail.com>
In-Reply-To: <1452311693-27529-1-git-send-email-hejianet@gmail.com>
References: <1452311693-27529-1-git-send-email-hejianet@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Jia He <hejianet@gmail.com>
List-ID: <fstests@vger.kernel.org>

This adds user friendly prompts to output the already mounted point from _mount.
xfstests will do the cleanup (ie. umount) and user can not get the mount name
information.

Signed-off-by: Jia He <hejianet@gmail.com>
---
 common/rc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index d33e3fb..f0caef2 100644
--- a/common/rc
+++ b/common/rc
@@ -1271,7 +1271,9 @@ _require_scratch_nocheck()
         # if it's mounted, make sure its on $SCRATCH_MNT
         if ! _mount | grep -F $SCRATCH_DEV | grep -q $SCRATCH_MNT
         then
-            echo "\$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT - aborting"
+            echo "\$SCRATCH_DEV=$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT=$SCRATCH_MNT - aborting"
+            echo "Already mounted result:"
+            _mount | grep -F $SCRATCH_DEV
             exit 1
         fi
         # and then unmount it
@@ -1353,7 +1355,9 @@ _require_test()
         # if it's mounted, make sure its on $TEST_DIR
         if ! _mount | grep -F $TEST_DEV | grep -q $TEST_DIR
         then
-            echo "\$TEST_DEV is mounted but not on \$TEST_DIR - aborting"
+            echo "\$TEST_DEV=$TEST_DEV is mounted but not on \$TEST_DIR=$TEST_DIR - aborting"
+            echo "Already mounted result:"
+            _mount | grep -F $TEST_DEV
             exit 1
         fi
     else
-- 
2.1.4

