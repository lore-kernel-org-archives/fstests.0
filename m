Received: from cn.fujitsu.com ([222.73.24.84]:11304 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbcK2Hd3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:29 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 08/10] fstests: btrfs/104: Use _btrfs_check_scratch_qgroup to replace open codes
Date: Tue, 29 Nov 2016 15:33:01 +0800
Message-Id: <20161129073303.14776-9-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/104 | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tests/btrfs/104 b/tests/btrfs/104
index 6afaa02..a5d2070 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -152,14 +152,7 @@ _run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
 sleep 45
 
 _scratch_unmount
-
-# generate a qgroup report and look for inconsistent groups
-#  - don't use _run_btrfs_util_prog here as it captures the output and
-#    we need to grep it.
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-			grep -E -q "Counts for qgroup.*are different"
-if [ $? -ne 0 ]; then
-	status=0
-fi
+_btrfs_check_scratch_qgroup
+status=0
 
 exit
-- 
2.7.4



