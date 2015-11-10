Received: from mx2.suse.de ([195.135.220.15]:58940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbbKJAaD (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 9 Nov 2015 19:30:03 -0500
Date: Mon, 9 Nov 2015 16:30:02 -0800
From: Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH] btrfs/104: replace ugly sleep with subvol sync
Message-ID: <20151110003002.GK15575@wotan.suse.de>
Reply-To: Mark Fasheh <mfasheh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

Btrfsprogs now has 'subvolume sync' which will wait until deleted subvolumes
are cleaned from disk.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 tests/btrfs/104 | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/104 b/tests/btrfs/104
index 80161a3..6848b87 100644
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -146,11 +146,9 @@ _scratch_remount
 # referenced above.
 _run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
 
-# There is no way from userspace to force btrfs_drop_snapshot to run
-# at a given time (even via mount/unmount). We must wait for it to
-# start and complete. This is the shortest time on my tests systems I
-# have found which always allows drop_snapshot to run to completion.
-sleep 45
+# Subvol delete is a delayed operation, wait for it to complete before
+# unmounting.
+_run_btrfs_util_prog subvolume sync $SCRATCH_MNT
 
 _scratch_unmount
 
-- 
2.1.2

