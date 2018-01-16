Received: from userp2120.oracle.com ([156.151.31.85]:54682 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeAPVSB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Jan 2018 16:18:01 -0500
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH] Fstests: btrfs/011 fix device mounted when tests aborts
Date: Tue, 16 Jan 2018 13:10:17 -0700
Message-Id: <20180116201018.2008-1-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

One of btrfs tests, btrfs/011, uses SCRATCH_DEV_POOL and puts a
non-SCRATCH_DEV device as the first one when doing mkfs, and this makes
_require_scratch{_nocheck} confused since it checks mount point with
SCRATCH_DEV only.

This adds _scratch_umount to cleanup() to umount SCRATCH_MNT by
011 itself.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
 tests/btrfs/011 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 28f1388..f4c5309 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -51,6 +51,7 @@ _cleanup()
 	fi
 	wait
 	rm -f $tmp.tmp
+	_scratch_unmount > /dev/null 2>&1
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-- 
2.5.0

