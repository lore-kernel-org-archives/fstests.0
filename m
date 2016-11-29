Received: from cn.fujitsu.com ([222.73.24.84]:38188 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1755785AbcK2Hde (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 02:33:34 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 02/10] fstests: btrfs/017: Use new _btrfs_check_scratch_qgroup function
Date: Tue, 29 Nov 2016 15:32:55 +0800
Message-Id: <20161129073303.14776-3-quwenruo@cn.fujitsu.com>
In-Reply-To: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Now this test case can handle inode_map mount option and expose error
for that mount option.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/btrfs/017     | 4 ++--
 tests/btrfs/017.out | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/017 b/tests/btrfs/017
index 3f409d3..356cef5 100755
--- a/tests/btrfs/017
+++ b/tests/btrfs/017
@@ -86,8 +86,8 @@ rm -fr $SCRATCH_MNT/snap/foo*
 
 sync
 
-units=`_btrfs_qgroup_units`
-$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | $AWK_PROG '/[0-9]/ {print $2" "$3}'
+_scratch_unmount
+_btrfs_check_scratch_qgroup
 
 # success, all done
 status=0
diff --git a/tests/btrfs/017.out b/tests/btrfs/017.out
index 503eb88..bbc8eb4 100644
--- a/tests/btrfs/017.out
+++ b/tests/btrfs/017.out
@@ -1,4 +1,2 @@
 QA output created by 017
 Blocks modified: [0 - 1]
-65536 65536
-65536 65536
-- 
2.7.4



