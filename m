Received: from cn.fujitsu.com ([59.151.112.132]:51838 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750934AbdF1Fpk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Jun 2017 01:45:40 -0400
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH] fstests: btrfs: reorder the arguments of btrfs replace in btrfs/027
Date: Wed, 28 Jun 2017 13:45:31 +0800
Message-ID: <20170628054531.17882-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The option parser only accept options before non-option argument.
Although David Sterba has submitted commit df8c7225ba00 ("btrfs: reorder
arguments so that options come first"), but this case seems to be left out.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
 tests/btrfs/027 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/027 b/tests/btrfs/027
index 2c8b458e..625a27f5 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -91,8 +91,8 @@ run_test()
 	_scratch_mount -o degraded >>$seqres.full 2>&1
 
 	# replace $missing_dev with $replace_dev and scrub it to double-check
-	$BTRFS_UTIL_PROG replace start -B -r $missing_dev_id $SPARE_DEV \
-		$SCRATCH_MNT -f >>$seqres.full 2>&1
+	$BTRFS_UTIL_PROG replace start -B -f -r $missing_dev_id $SPARE_DEV \
+		$SCRATCH_MNT >>$seqres.full 2>&1
 	if [ $? -ne 0 ]; then
 		echo "btrfs replace failed"
 		_spare_dev_put
-- 
2.13.2



