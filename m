Received: from imap.thunk.org ([74.207.234.97]:56242 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbcF2BdC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 28 Jun 2016 21:33:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common: ext4 doesn't support O_DIRECT with encryption
Date: Tue, 28 Jun 2016 21:32:55 -0400
Message-Id: <1467163975-11183-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Teach _require_odirect to skip the O_DIRECT tests if the ext4 mount
option "test_dummy_encryption" is enabled, since O_DIRECT doesen't
make sense when file system level encryption is enabled, and several
tests which use O_DIRECT --- ext4/301, ext4/304, generic/250 and
generic/252 --- fail when encryption is enabled.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/common/rc b/common/rc
index adda940..003400d 100644
--- a/common/rc
+++ b/common/rc
@@ -1933,12 +1933,18 @@ _require_xfs_db_command()
 # check that kernel and filesystem support direct I/O
 _require_odirect()
 {
-       testfile=$TEST_DIR/$$.direct
-       $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
-       if [ $? -ne 0 ]; then
-               _notrun "O_DIRECT is not supported"
-       fi
-       rm -f $testfile 2>&1 > /dev/null
+	if [ $FSTYP = "ext4" ] ; then
+		if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"
+		then
+			_notrun "ext4 encryption doesn't support O_DIRECT"
+		fi
+	fi
+	testfile=$TEST_DIR/$$.direct
+	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		_notrun "O_DIRECT is not supported"
+	fi
+	rm -f $testfile 2>&1 > /dev/null
 }
 
 # Check that a fs has enough free space (in 1024b blocks)
-- 
2.5.0

