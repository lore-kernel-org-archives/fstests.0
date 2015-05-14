Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:59570 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933345AbbENBx4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 13 May 2015 21:53:56 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YsiLD-0004WT-E2
	for fstests@vger.kernel.org; Thu, 14 May 2015 11:53:39 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YsiLD-0001h4-Cr
	for fstests@vger.kernel.org; Thu, 14 May 2015 11:53:39 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/3] generic/018: use xfs_io and larger buffers for writes
Date: Thu, 14 May 2015 11:53:35 +1000
Message-Id: <1431568417-6462-2-git-send-email-david@fromorbit.com>
In-Reply-To: <1431568417-6462-1-git-send-email-david@fromorbit.com>
References: <1431568417-6462-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

The test currently uses 'dd' directly for writing to files; instead
we should be using the xfs_io pwrite command.

Also, when we have a configuration that does not do delayed
allocation (e.g. dax), there is no guarantee that the files will be
allocated in the pattern expected, so do all the writes from a
single buffer so the kernel can allocate extents in the manner the
test expects as much as possible.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/018 | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tests/generic/018 b/tests/generic/018
index 2b804b5..fbefbe2 100755
--- a/tests/generic/018
+++ b/tests/generic/018
@@ -57,6 +57,7 @@ fragfile=$SCRATCH_MNT/fragfile.$$
 rm -f $fragfile
 
 # Craft some fragmented files, defrag them, check the result.
+bsize=4096
 
 echo "zero-length file:" | tee -a $seqres.full
 touch $fragfile
@@ -67,24 +68,28 @@ $XFS_IO_PROG -f -c "truncate 1m" $fragfile
 _defrag --before 0 --after 0 $fragfile
 
 echo "Contiguous file:" | tee -a $seqres.full
-dd if=/dev/zero of=$fragfile bs=4k count=4 &>/dev/null
+$XFS_IO_PROG -f -c "pwrite -b $((4 * bsize)) 0 $((4 * bsize))" $fragfile \
+					> /dev/null
 _defrag --before 1 --after 1 $fragfile
 
 echo "Write backwards sync, but contiguous - should defrag to 1 extent" | tee -a $seqres.full
-for I in `seq 9 -1 0`; do
-	dd if=/dev/zero of=$fragfile bs=4k count=1 conv=notrunc seek=$I oflag=sync &>/dev/null
+for i in `seq 9 -1 0`; do
+	$XFS_IO_PROG -fs -c "pwrite $((i * bsize)) $bsize" $fragfile \
+					> /dev/null
 done
 _defrag --before 10 --after 1 $fragfile
 
 echo "Write backwards sync leaving holes - defrag should do nothing" | tee -a $seqres.full
-for I in `seq 31 -2 0`; do
-	dd if=/dev/zero of=$fragfile bs=4k count=1 conv=notrunc seek=$I oflag=sync &>/dev/null
+for i in `seq 31 -2 0`; do
+	$XFS_IO_PROG -fs -c "pwrite $((i * bsize)) $bsize" $fragfile \
+					> /dev/null
 done
 _defrag --before 16 --after 16 $fragfile
 
 echo "Write forwards sync leaving holes - defrag should do nothing" | tee -a $seqres.full
-for I in `seq 0 2 31`; do
-	dd if=/dev/zero of=$fragfile bs=4k count=1 conv=notrunc seek=$I oflag=sync &>/dev/null
+for i in `seq 0 2 31`; do
+	$XFS_IO_PROG -fs -c "pwrite $((i * bsize)) $bsize" $fragfile \
+					> /dev/null
 done
 _defrag --before 16 --after 16 $fragfile
 
-- 
2.0.0

