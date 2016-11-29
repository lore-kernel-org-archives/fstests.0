Received: from cn.fujitsu.com ([222.73.24.84]:39314 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1756073AbcK2Hdo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:44 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 06/10] fstests: btrfs/091: Use _btrfs_check_scratch_qgroup other than fixed golden output
Date: Tue, 29 Nov 2016 15:32:59 +0800
Message-Id: <20161129073303.14776-7-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/091     | 5 ++---
 tests/btrfs/091.out | 4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/tests/btrfs/091 b/tests/btrfs/091
index e3c43c7..ab4ff4e 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -94,9 +94,8 @@ cp --reflink $SCRATCH_MNT/subv1/file1 $SCRATCH_MNT/subv3/file1
 # in commit tree. So need to sync to update the qgroup commit tree.
 sync
 
-units=`_btrfs_qgroup_units`
-$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | $SED_PROG -n '/[0-9]/p' | \
-	$AWK_PROG '{print $2" "$3}'
+_scratch_unmount
+_btrfs_check_scratch_qgroup
 
 # success, all done
 status=0
diff --git a/tests/btrfs/091.out b/tests/btrfs/091.out
index 68fe2df..f2981b5 100644
--- a/tests/btrfs/091.out
+++ b/tests/btrfs/091.out
@@ -1,7 +1,3 @@
 QA output created by 091
 wrote 262144/262144 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-65536 65536
-327680 65536
-327680 65536
-327680 65536
-- 
2.7.4



