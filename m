Received: from imap.thunk.org ([74.207.234.97]:33796 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbcFISmp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 9 Jun 2016 14:42:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common: ext4's data=journal mode doesn't support O_DIRECT
Date: Thu,  9 Jun 2016 14:42:42 -0400
Message-Id: <1465497762-3333-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Teach _require_odirect that ext4's data=journal mode doesn't support
O_DIRECT.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 069df58..791e6e5 100644
--- a/common/rc
+++ b/common/rc
@@ -1932,9 +1932,13 @@ _require_xfs_db_command()
 # check that kernel and filesystem support direct I/O
 _require_odirect()
 {
-       if [ $FSTYP = "ext4" ] &&
-	  echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption" ; then
-		_notrun "ext4 encryption doesn't support O_DIRECT"
+       if [ $FSTYP = "ext4" ] ; then
+           if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption" ; then
+	       _notrun "ext4 encryption doesn't support O_DIRECT"
+	   fi
+           if echo "$MOUNT_OPTIONS" | grep -q "data=journal" ; then
+	       _notrun "ext4 data=journal mode doesn't support O_DIRECT"
+	   fi
        fi
        testfile=$TEST_DIR/$$.direct
        $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
-- 
2.5.0

