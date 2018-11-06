Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387480AbeKGBAa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Nov 2018 20:00:30 -0500
From: fdmanana@kernel.org
Subject: [PATCH] btrfs: fix computation of max fs size for multiple device fs tests
Date: Tue,  6 Nov 2018 15:34:37 +0000
Message-Id: <20181106153437.26870-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

We were sorting numerical values with the 'sort' tool without telling it
that we are sorting numbers, giving us unexpected ordering. So just pass
the '-n' option to the 'sort' tool.

Example:

$ echo -e "11\n9\n20" | sort
11
20
9

$ echo -e "11\n9\n20" | sort -n
9
11
20

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/124 | 2 +-
 tests/btrfs/125 | 2 +-
 tests/btrfs/154 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/124 b/tests/btrfs/124
index ce3ad6aa..a52c65f6 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -61,7 +61,7 @@ dev2=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
 dev1_sz=`blockdev --getsize64 $dev1`
 dev2_sz=`blockdev --getsize64 $dev2`
 # get min of both
-max_fs_sz=`echo -e "$dev1_sz\n$dev2_sz" | sort | head -1`
+max_fs_sz=`echo -e "$dev1_sz\n$dev2_sz" | sort -n | head -1`
 # Need disks with more than 2G.
 if [ $max_fs_sz -lt 2000000000 ]; then
 	_scratch_dev_pool_put
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index e38de264..5ac68b67 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -68,7 +68,7 @@ dev2_sz=`blockdev --getsize64 $dev2`
 dev3_sz=`blockdev --getsize64 $dev3`
 
 # get min of both.
-max_fs_sz=`echo -e "$dev1_sz\n$dev2_sz\n$dev3_sz" | sort | head -1`
+max_fs_sz=`echo -e "$dev1_sz\n$dev2_sz\n$dev3_sz" | sort -n | head -1`
 # Need disks with more than 2G
 if [ $max_fs_sz -lt 2000000000 ]; then
 	_scratch_dev_pool_put
diff --git a/tests/btrfs/154 b/tests/btrfs/154
index 99ea232a..cd6c688f 100755
--- a/tests/btrfs/154
+++ b/tests/btrfs/154
@@ -51,7 +51,7 @@ DEV1_SZ=`blockdev --getsize64 $DEV1`
 DEV2_SZ=`blockdev --getsize64 $DEV2`
 
 # get min
-MAX_FS_SZ=`echo -e "$DEV1_SZ\n$DEV2_SZ" | sort | head -1`
+MAX_FS_SZ=`echo -e "$DEV1_SZ\n$DEV2_SZ" | sort -n | head -1`
 # Need disks with more than 2G
 if [ $MAX_FS_SZ -lt 2000000000 ]; then
 	_scratch_dev_pool_put
-- 
2.11.0
