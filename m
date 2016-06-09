Received: from imap.thunk.org ([74.207.234.97]:33786 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbcFISmd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 9 Jun 2016 14:42:33 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] shared: don't try to use O_DIRECT in shared/277
Date: Thu,  9 Jun 2016 14:42:31 -0400
Message-Id: <1465497751-3280-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

A comment in shared/277 claims that ext4 supports O_DIRECT in
data=journalling mode.  Actually, it doesn't, it was just silently
ignoring O_DIRECT, let's not try to test O_DIRECT for either ext3 or
ext4 in this test.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/shared/272 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/shared/272 b/tests/shared/272
index e5adf38..df1366a 100755
--- a/tests/shared/272
+++ b/tests/shared/272
@@ -31,10 +31,8 @@ tmp=/tmp/$$
 status=1	# failure is the default!
 trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
 
-# ext3 doesn't support direct IO in journalling mode
+# ext3 and ext4 doesn't support direct IO in journalling mode
 write_opt_list="iflag=noatime conv=notrunc conv=fsync"
-# For filesystems that can handle it, add also direct IO test
-[ $FSTYP = "ext4" ] && write_opt_list="$write_opt_list oflag=direct"
 
 # get standard environment, filters and checks
 . ./common/rc
-- 
2.5.0

