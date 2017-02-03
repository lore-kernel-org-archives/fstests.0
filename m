Received: from imap.thunk.org ([74.207.234.97]:46990 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752182AbdBCUup (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 15:50:45 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic/388: use the src/godown program instead of xfs_io
Date: Fri,  3 Feb 2017 15:50:37 -0500
Message-Id: <20170203205037.6027-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The "xfs_io -xc shutdown $MNT" command doesn't work on non-xfs file
systems.  So use the equivalent src/godown program instead, which is
how the other tests which use the shutdown command were converted from
xfs-specific tests to generic tests.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/388 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/388 b/tests/generic/388
index c00a7548..9d4ba9d6 100755
--- a/tests/generic/388
+++ b/tests/generic/388
@@ -71,7 +71,7 @@ for i in $(seq 1 50); do
 	# purposely include 0 second sleeps to test shutdown immediately after
 	# recovery
 	sleep $((RANDOM % 3))
-	$XFS_IO_PROG -xc shutdown $SCRATCH_MNT
+	./src/godown $SCRATCH_MNT
 
 	ps -e | grep fsstress > /dev/null 2>&1
 	while [ $? -eq 0 ]; do
-- 
2.11.0.rc0.7.gbe5a750

