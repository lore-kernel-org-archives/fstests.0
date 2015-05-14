Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:59570 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933439AbbENBx5 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 13 May 2015 21:53:57 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YsiLD-0004WV-FN
	for fstests@vger.kernel.org; Thu, 14 May 2015 11:53:39 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YsiLD-0001hF-Ee
	for fstests@vger.kernel.org; Thu, 14 May 2015 11:53:39 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/3] generic/275: writes may not partially succeed
Date: Thu, 14 May 2015 11:53:37 +1000
Message-Id: <1431568417-6462-4-git-send-email-david@fromorbit.com>
In-Reply-To: <1431568417-6462-1-git-send-email-david@fromorbit.com>
References: <1431568417-6462-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

When a large IO is done as a single buffer, there is no guarantee
that it will partially succeed when close to ENOSPC. The test
assumes that the kernel is going to break the write down into
smaller chunks (i.e. buffered IO breaking it down into PAGE_SIZE
allocations), but certain configurations will not do this. e.g.
extent size hints are set or DAX is being used) and hence the large
write fails completely as there is not space for the entire
allocation to be made.

Hence break the final write in the test up into multiple small
writes, thereby acheiving the same effect - ensuring that we can
write more data after removing some space....

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/275 | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/generic/275 b/tests/generic/275
index 7382edb..f1963d8 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -57,6 +57,8 @@ umount $SCRATCH_DEV 2>/dev/null
 _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
+# this file will get removed to create 256k of free space after ENOSPC
+# conditions are created.
 dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=256K count=1 >>$seqres.full 2>&1
 [ $? -ne 0 ] && _fail "Error creating file"
 
@@ -79,14 +81,16 @@ $DF_PROG $SCRATCH_MNT >>$seqres.full 2>&1
 _freespace=`$DF_PROG -k $SCRATCH_MNT | tail -n 1 | awk '{print $5}'`
 [ $_freespace -gt 1024 ] && _fail "could not sufficiently fill filesystem"
 
-# Try a write larger than available space
-dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=1M count=1 >>$seqres.full 2>&1
+# Try to write more than available space in chunks that will allow at least one
+# full write to succeed.
+dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=128k count=8 >>$seqres.full 2>&1
 echo "Bytes written until ENOSPC:" >>$seqres.full
 du $SCRATCH_MNT/tmp1 >>$seqres.full
 
 # And at least some of it should succeed.
 _filesize=`ls -l $SCRATCH_MNT/tmp1 | awk '{print $5}'`
-[ $_filesize -eq 0 ] && _fail "write file err: Partial write until enospc failed; wrote 0 bytes."
+[ $_filesize -lt $((128 * 1024)) ] && \
+	_fail "Partial write until enospc failed; wrote $_filesize bytes."
 
 echo "done"
 status=0
-- 
2.0.0

