Received: from mail.kernel.org ([198.145.29.99]:45858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSMG3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Jun 2019 08:06:29 -0400
From: fdmanana@kernel.org
Subject: [PATCH 2/2] generic/059: also test that the file's mtime and ctime are updated
Date: Wed, 19 Jun 2019 13:06:24 +0100
Message-Id: <20190619120624.9922-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test as well that hole punch operations that affect a single file block
also update the file's mtime and ctime.

This is motivated by a bug a found in btrfs which is fixed by the
following patch for the linux kernel:

 "Btrfs: add missing inode version, ctime and mtime updates when
  punching hole"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/059 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/generic/059 b/tests/generic/059
index e8cb93d8..fd44b2ea 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -18,6 +18,9 @@
 #
 #  Btrfs: add missing inode update when punching hole
 #
+# Also test the mtime and ctime properties of the file change after punching
+# holes with ranges that operate only on a single block of the file.
+#
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -68,6 +71,13 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 # fsync log.
 sync
 
+# Sleep for 1 second, because we want to check that the next punch operations we
+# do update the file's mtime and ctime.
+sleep 1
+
+mtime_before=$(stat -c %Y $SCRATCH_MNT/foo)
+ctime_before=$(stat -c %Z $SCRATCH_MNT/foo)
+
 # Punch a hole in our file. This small range affects only 1 page.
 # This made the btrfs hole punching implementation write only some zeroes in
 # one page, but it did not update the btrfs inode fields used to determine if
@@ -94,5 +104,13 @@ _flakey_drop_and_remount
 echo "File content after:"
 od -t x1 $SCRATCH_MNT/foo
 
+mtime_after=$(stat -c %Y $SCRATCH_MNT/foo)
+ctime_after=$(stat -c %Z $SCRATCH_MNT/foo)
+
+[ $mtime_after -gt $mtime_before ] || \
+	echo "mtime did not increase (before: $mtime_before after: $mtime_after"
+[ $ctime_after -gt $ctime_before ] || \
+	echo "ctime did not increase (before: $ctime_before after: $mtime_after"
+
 status=0
 exit
-- 
2.11.0
