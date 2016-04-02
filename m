Received: from imap.thunk.org ([74.207.234.97]:32806 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbcDBQ4V (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 2 Apr 2016 12:56:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] common: teach _require_odirect that ext4 encryption doesn't support DIO
Date: Sat,  2 Apr 2016 12:56:14 -0400
Message-Id: <1459616174-31557-2-git-send-email-tytso@mit.edu>
In-Reply-To: <1459616174-31557-1-git-send-email-tytso@mit.edu>
References: <1459616174-31557-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/rc b/common/rc
index 2ccca3b..961601b 100644
--- a/common/rc
+++ b/common/rc
@@ -1916,6 +1916,10 @@ _require_xfs_db_command()
 # check that kernel and filesystem support direct I/O
 _require_odirect()
 {
+       if [ $FSTYP = "ext4" ] &&
+	  echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption" ; then
+		_notrun "ext4 encryption doesn't support O_DIRECT"
+       fi
        testfile=$TEST_DIR/$$.direct
        $XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
        if [ $? -ne 0 ]; then
-- 
2.5.0

