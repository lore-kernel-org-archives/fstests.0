Received: from cn.fujitsu.com ([222.73.24.84]:11304 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1755106AbcK2Hdb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:31 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 09/10] fstests: btrfs/122: Use _btrfs_check_scratch_qgroup to replace open code
Date: Tue, 29 Nov 2016 15:33:02 +0800
Message-Id: <20161129073303.14776-10-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/122 | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 82252ab..899ede5 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -77,12 +77,7 @@ _run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/snap1"
 _run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/snap2"
 
 _scratch_unmount
-
-# generate a qgroup report and look for inconsistent groups
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-			grep -q -E "Counts for qgroup.*are different"
-if [ $? -ne 0 ]; then
-	status=0
-fi
+_btrfs_check_scratch_qgroup
+status=0
 
 exit
-- 
2.7.4



