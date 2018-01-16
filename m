Received: from aserp2130.oracle.com ([141.146.126.79]:53044 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeAPVSC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Jan 2018 16:18:02 -0500
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH] Fstests: btrfs/027 unmount scratch device if test fails
Date: Tue, 16 Jan 2018 13:10:18 -0700
Message-Id: <20180116201018.2008-2-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test, btrfs/027, runs tests against different raid profiles
in a loop, if one of them aborts, it also fails the following ones
with errors like,

Test -m raid10 -d raid10
ERROR: /dev/xxx is mounted
Test -m raid5 -d raid5
ERROR: /dev/xxx is mounted
Test -m raid6 -d raid6
ERROR: /dev/xxx is mounted

_scratch_unmount is added to avoid the above.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
 tests/btrfs/027 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/027 b/tests/btrfs/027
index 625a27f..689cd4c 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -95,6 +95,7 @@ run_test()
 		$SCRATCH_MNT >>$seqres.full 2>&1
 	if [ $? -ne 0 ]; then
 		echo "btrfs replace failed"
+		_scratch_unmount
 		_spare_dev_put
 		_scratch_dev_pool_put
 		return
@@ -102,6 +103,7 @@ run_test()
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
 	if [ $? -ne 0 ]; then
 		echo "btrfs scrub failed"
+		_scratch_unmount
 		_spare_dev_put
 		_scratch_dev_pool_put
 		return
-- 
2.5.0

