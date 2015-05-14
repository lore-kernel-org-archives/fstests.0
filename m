Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:59570 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933462AbbENBx7 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 13 May 2015 21:53:59 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YsiLD-0004WU-Ev
	for fstests@vger.kernel.org; Thu, 14 May 2015 11:53:39 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YsiLD-0001hA-Do
	for fstests@vger.kernel.org; Thu, 14 May 2015 11:53:39 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/3] generic/223, xfs/203: IO is not well aligned
Date: Thu, 14 May 2015 11:53:36 +1000
Message-Id: <1431568417-6462-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1431568417-6462-1-git-send-email-david@fromorbit.com>
References: <1431568417-6462-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

On certain configurations (e.g. MOUNT_OPTIONS="-o dax") we get
different allocation patterns due to the writes being done in
multiple pwrite() calls. e.g. the write is 8k, but the buffer size
is 4k, and so the filesystem sees 4k writes. If the filesytem is not
using delayed allocation, then the allocation context is a 4k write
rather than an 8k write and so they don't get appropriately aligned.

Fix this by making the write buffer the same size and the writes
being done.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/223 | 2 +-
 tests/xfs/203     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/223 b/tests/generic/223
index a67b8d5..f150dc9 100755
--- a/tests/generic/223
+++ b/tests/generic/223
@@ -69,7 +69,7 @@ for SUNIT_K in 8 16 32 64 128; do
 			$XFS_IO_PROG -f -c "falloc 0 $SIZE" \
 				$SCRATCH_MNT/file-$FILE-$SIZE-falloc \
 					>> $seqres.full 2>&1
-			$XFS_IO_PROG -f -c "pwrite 0 $SIZE" \
+			$XFS_IO_PROG -f -c "pwrite -b $SIZE 0 $SIZE" \
 				$SCRATCH_MNT/file-$FILE-$SIZE-write \
 					>> $seqres.full 2>&1
 			src/t_stripealign $SCRATCH_MNT/file-$FILE-$SIZE-falloc \
diff --git a/tests/xfs/203 b/tests/xfs/203
index 7e18ca3..2ac5290 100755
--- a/tests/xfs/203
+++ b/tests/xfs/203
@@ -38,11 +38,11 @@ _write_holes()
 	let fsize=$(($writes * 0x100000))
 
 	# prevent EOF preallocation from affecting results
-	xfs_io -f $file -c "truncate $fsize"
+	$XFS_IO_PROG -f $file -c "truncate $fsize"
 
 	offset=0
 	for i in `seq 0 $writes`; do
-		xfs_io -f $file -c "pwrite -q $offset 64k"
+		$XFS_IO_PROG -f $file -c "pwrite -b 64k -q $offset 64k"
 		let offset=$offset+0x100000
 	done
 }
-- 
2.0.0

