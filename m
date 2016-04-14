Received: from mx2.suse.de ([195.135.220.15]:52265 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbcDNXEQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Apr 2016 19:04:16 -0400
Date: Thu, 14 Apr 2016 16:04:09 -0700
From: Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH] btrfs/104: remove ugly sleep
Message-ID: <20160414230409.GO2187@wotan.suse.de>
Reply-To: Mark Fasheh <mfasheh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

Latest btrfsprogs can now do 'subvolume sync' to wait on snapshots to be
dropped. Replace the sleep call in btrfs/104 with this. We can also add this
test to the 'quick' group now.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 tests/btrfs/104   | 8 +++-----
 tests/btrfs/group | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/104 b/tests/btrfs/104
index 6afaa02..627e77b 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -145,11 +145,9 @@ _scratch_cycle_mount
 # referenced above.
 _run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
 
-# There is no way from userspace to force btrfs_drop_snapshot to run
-# at a given time (even via mount/unmount). We must wait for it to
-# start and complete. This is the shortest time on my tests systems I
-# have found which always allows drop_snapshot to run to completion.
-sleep 45
+# Removing snapshots on btrfs is a delayed operation, so we must wait for
+# btrfs_drop_snapshot to complete.
+_run_btrfs_util_prog subvolume sync $SCRATCH_MNT
 
 _scratch_unmount
 
diff --git a/tests/btrfs/group b/tests/btrfs/group
index ef6c260..9403daa 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -104,7 +104,7 @@
 101 auto quick replace
 102 auto quick metadata enospc
 103 auto quick clone compress
-104 auto qgroup
+104 auto quick qgroup
 105 auto quick send
 106 auto quick clone compress
 107 auto quick prealloc
-- 
2.1.4

