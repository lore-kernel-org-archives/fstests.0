Received: from cn.fujitsu.com ([222.73.24.84]:38188 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1754367AbcK2Hd3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:29 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 10/10] fstests: btrfs/123: Use _btrfs_check_scratch_qgroup to replace open code
Date: Tue, 29 Nov 2016 15:33:03 +0800
Message-Id: <20161129073303.14776-11-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/123 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/btrfs/123 b/tests/btrfs/123
index e89d541..36d24c4 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -76,9 +76,7 @@ _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
 _run_btrfs_util_prog balance start -d $SCRATCH_MNT
 
 _scratch_unmount
-# generate a qgroup report and look for inconsistent groups
-$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 | \
-		grep -E "Counts for qgroup.*are different"
+_btrfs_check_scratch_qgroup
 
 # success, all done
 status=0
-- 
2.7.4



