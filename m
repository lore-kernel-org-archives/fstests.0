Received: from imap.thunk.org ([74.207.234.97]:34551 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbcBMRlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 12/16] xfstests: remove dependency on /proc/partitions for generic/312
Date: Sat, 13 Feb 2016 12:41:05 -0500
Message-Id: <1455385269-26319-13-git-send-email-tytso@mit.edu>
In-Reply-To: <1455385269-26319-1-git-send-email-tytso@mit.edu>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

This allows this test to work with tmpfs, if the system has at least
5G of free memory.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/312 | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/generic/312 b/tests/generic/312
index b570814..639eb57 100755
--- a/tests/generic/312
+++ b/tests/generic/312
@@ -51,12 +51,15 @@ _require_scratch
 
 # 5G in byte
 fssize=$((2**30 * 5))
-required_blocks=$(($fssize / 1024))
-dev_blocks=$(grep -w $(_short_dev $SCRATCH_DEV) /proc/partitions | $AWK_PROG '{print $3}')
-if [ $required_blocks -gt $dev_blocks ];then
-	_notrun "this test requires \$SCRATCH_DEV has ${fssize}B space"
-fi
 
+# We don't need to do this check for tmpfs because _scratch_mkfs_size
+# will validate the size against the available memory
+if [ "$FSTYP" != "tmpfs" ]; then
+   _scratch_mkfs
+   _scratch_mount
+   _require_fs_space $SCRATCH_MNT $(($fssize / 1024))
+   _scratch_unmount
+fi
 rm -f $seqres.full
 _scratch_mkfs_sized $fssize >>$seqres.full 2>&1
 _scratch_mount >>$seqres.full 2>&1
-- 
2.5.0

