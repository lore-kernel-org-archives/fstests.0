Received: from cn.fujitsu.com ([222.73.24.84]:3767 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1754047AbcLZE60 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 25 Dec 2016 23:58:26 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: btrfs/132: Use better method to wait the writer to avoid EBUSY
Date: Mon, 26 Dec 2016 12:57:52 +0800
Message-Id: <20161226045752.19979-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The kill and wait method will only wait for the children process to
exit, while the xfs_io can still run at background.

This makes the test always fails on HDD backed physical machine.

Use the "while ps aux | grep" method in btrfs/069 to truely wait the
xfs_io to finish.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/132 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/132 b/tests/btrfs/132
index 0516177..db0dcb0 100755
--- a/tests/btrfs/132
+++ b/tests/btrfs/132
@@ -94,9 +94,10 @@ sleep $sleep_time
 kill $pids
 wait
 
-# Sync the fs to avoid EBUSY while umount, which is quite common for btrfs
-# compression
-sync
+# Wait all writers really exits
+while ps aux | grep "$SCRATCH_MNT" | grep -qv grep; do
+	sleep 1
+done
 
 echo "Silence is golden"
 status=0
-- 
2.7.4



