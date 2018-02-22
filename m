Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:23994 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751312AbeBVAcc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Feb 2018 19:32:32 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1eoenr-0007JX-Tv
        for fstests@vger.kernel.org; Thu, 22 Feb 2018 11:32:03 +1100
Received: from dave by discord.disaster.area with local (Exim 4.90_1)
        (envelope-from <david@fromorbit.com>)
        id 1eoenr-0005H0-Ri
        for fstests@vger.kernel.org; Thu, 22 Feb 2018 11:32:03 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] generic/25[02]: increase filesystem size
Date: Thu, 22 Feb 2018 11:32:03 +1100
Message-Id: <20180222003203.20231-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

On reflink+rmapbt XFs filesystems there isn't enough free space to
run this test on the 64MB filesystem image created. It notruns with
a curious error message - needs at least 0GB free:

generic/250             [10:01:57] [10:01:58] [not run]
        generic/250 -- This test requires at least 0GB free on /mnt/scratch to run

Fix this by increasing the size of the base filesystem image.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/250 | 6 +++---
 tests/generic/252 | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/generic/250 b/tests/generic/250
index a8fd97e31ff0..6b0f7e3126af 100755
--- a/tests/generic/250
+++ b/tests/generic/250
@@ -54,10 +54,10 @@ _require_no_rtinherit
 
 rm -f $seqres.full
 
-
+fssize=$((100 * 1048576))
 echo "Format and mount"
-$XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $((64 * 1048576))" $SCRATCH_DEV >> $seqres.full
-_scratch_mkfs_sized $((64 * 1048576)) > $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
+_scratch_mkfs_sized $fssize > $seqres.full 2>&1
 _dmerror_init
 _dmerror_mount >> $seqres.full 2>&1
 _dmerror_unmount
diff --git a/tests/generic/252 b/tests/generic/252
index b506d599f638..e102945d83b7 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -56,9 +56,10 @@ AIO_TEST="src/aio-dio-regress/aiocp"
 rm -f $seqres.full
 
 
+fssize=$((100 * 1048576))
 echo "Format and mount"
-$XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $((64 * 1048576))" $SCRATCH_DEV >> $seqres.full
-_scratch_mkfs_sized $((64 * 1048576)) > $seqres.full 2>&1
+$XFS_IO_PROG -d -c "pwrite -S 0x69 -b 1048576 0 $fssize" $SCRATCH_DEV >> $seqres.full
+_scratch_mkfs_sized $fssize > $seqres.full 2>&1
 _dmerror_init
 _dmerror_mount >> $seqres.full 2>&1
 _dmerror_unmount
-- 
2.16.1

