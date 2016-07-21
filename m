Received: from userp1040.oracle.com ([156.151.31.81]:29753 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbcGUXr1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:47:27 -0400
Subject: [PATCH 10/17] xfs/179: use scratch device helpers
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:47:19 -0700
Message-ID: <146914483981.11762.15707981777571396710.stgit@birch.djwong.org>
In-Reply-To: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Use the helper functions for scratch devices.  This fixes a problem
where xfs/179 fails when there's a realtime device.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/179 |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


diff --git a/tests/xfs/179 b/tests/xfs/179
index e0b0af8..18459cb 100755
--- a/tests/xfs/179
+++ b/tests/xfs/179
@@ -65,7 +65,7 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
 
 echo "Change reference count"
-umount $SCRATCH_MNT
+_scratch_unmount
 echo "set refcount to -4" >> $seqres.full
 $XFS_DB_PROG -x -c 'agf 0' -c 'addr refcntroot' -c 'write recs[1].refcount 4294967292' $SCRATCH_DEV >> $seqres.full
 echo "check refcount after setting to -4" >> $seqres.full
@@ -80,7 +80,7 @@ _cp_reflink $testdir/file1 $testdir/file6 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file7 >> $seqres.full
 
 echo "Check scratch fs"
-umount $SCRATCH_MNT
+_scratch_unmount
 echo "check refcount after reflinking 5 more times" >> $seqres.full
 $XFS_DB_PROG -c 'agf 0' -c 'addr refcntroot' -c 'p recs[1]' $SCRATCH_DEV >> $seqres.full
 _scratch_mount >> $seqres.full
@@ -91,7 +91,7 @@ _pwrite_byte 0x62 0 $blksz $testdir/file5 >> $seqres.full
 _pwrite_byte 0x62 0 $blksz $testdir/file7 >> $seqres.full
 
 echo "Check scratch fs"
-umount $SCRATCH_MNT
+_scratch_unmount
 echo "check refcount after cowing 3 files" >> $seqres.full
 $XFS_DB_PROG -c 'agf 0' -c 'addr refcntroot' -c 'p recs[1]' $SCRATCH_DEV >> $seqres.full
 _scratch_mount >> $seqres.full
@@ -100,10 +100,10 @@ echo "Remove reflinked files"
 rm -rf $testdir/file*
 
 echo "Check scratch fs"
-umount $SCRATCH_MNT
+_scratch_unmount
 echo "check refcount after removing all files" >> $seqres.full
 $XFS_DB_PROG -c 'agf 0' -c 'addr refcntroot' -c 'p recs[1]' $SCRATCH_DEV >> $seqres.full
-$XFS_REPAIR_PROG -o force_geometry -n $SCRATCH_DEV >> $seqres.full 2>&1
+_scratch_xfs_repair -o force_geometry -n >> $seqres.full 2>&1
 res=$?
 if [ $res -eq 0 ]; then
 	# If repair succeeds then format the device so that the post-test

