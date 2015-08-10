Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:19514 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751640AbbHJAoo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 9 Aug 2015 20:44:44 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1ZObCk-0000Jp-6u
	for fstests@vger.kernel.org; Mon, 10 Aug 2015 10:44:42 +1000
Received: from dave by disappointment with local (Exim 4.86_RC4)
	(envelope-from <dave@disappointment.disaster>)
	id 1ZObCk-0007Y3-5v
	for fstests@vger.kernel.org; Mon, 10 Aug 2015 10:44:42 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] xfs/042: reduce runtime of the test
Date: Mon, 10 Aug 2015 10:44:42 +1000
Message-Id: <1439167482-28977-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

xfs/042 is really an xfs_fsr test, and it only writes about 60MB of
data. however, because it is trying to write lots of data in ENOSPC
conditions, it can take a long time as XFS does flushes to maximise
space usage at ENOSPC. e.g. on a slow 1p VM:

 xfs/042 426s ... 425s

It takes a long time to write a small amount of data. To avoid this
slow flushing problem, create the fragmented files with fallocate()
rather than write(), which fails much faster as there is no dirty
data to flush before retrying the allocation and failing. THis
results in:

 xfs/042 425s ... 11s

A massive reduction in runtime, such that we can consider putting
xfs/042 into the quick group....

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/042     | 58 +++++++++++++++++++------------------------------------
 tests/xfs/042.out |  2 +-
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/tests/xfs/042 b/tests/xfs/042
index 77dd704..446fa80 100755
--- a/tests/xfs/042
+++ b/tests/xfs/042
@@ -52,40 +52,23 @@ _require_scratch
 
 [ "$XFS_FSR_PROG" = "" ] && _notrun "xfs_fsr not found"
 
-_cull_files()
-{
-    perl -e "\$manifest=\"$tmp.manifest\";" -e '
-	open MANIFEST, $manifest;
-	@in = <MANIFEST>;
-	close MANIFEST;
-	open MANIFEST, ">$manifest";
-	for ($i = 0; $i < @in; $i++) {
-	    if (($i+1) % 2 == 0) {
-		# remove every second file
-		chomp($s = $in[$i]);
-		if (unlink($s) != 1) {
-		    print "_cull_files: could not delete \"$s\"\n";
-		    exit(1);
-		}
-	    }
-	    else {
-		print MANIFEST $in[$i];
-	    }
-	}
-	close MANIFEST;
-	exit(0);'
-}
-
-# create a large contiguous file using dd
-# use fill2fs to fill the filesystem up with 4k sized files
-# fill any remaining space using dd
-# delete every second 4k file - remaining free space should be fragmented
-# use fill2 to generate a very large file - run it until it fails producing a truncated file
-# delete the dd-generated file
-# run xfs_fsr on the filesystem
-# check checksums for remaining files
-# create 3 minimum sized (16Mb) allocation groups
-# xfs_repair is going to need three to verify the superblock
+# Test performs several operations to produce a badly fragmented file, then
+# create enough contiguous free space for xfs_fsr to defragment the fragmented
+# file:
+#
+# - create fs with 3 minimum sized (16Mb) allocation groups
+# - create 16x1MB contiguous files which will become large free space extents
+#   when deleted
+# - put a small "space" between each of the 16 contiuguous files to ensure we
+#   have separated free space extents
+# - fill the remaining free space with a "fill file"
+# - mount/unmount/fill remaining free space with a pad file
+# - punch alternate single block holes in the the "fill file" to create
+#   fragmented free space.
+# - use fill2 to generate a very large fragmented file
+# - delete the 16 large contiguous files created initially
+# - run xfs_fsr on the filesystem
+# - check checksums for remaining files
 
 rm -f $seqres.full
 _do_die_on_error=message_only
@@ -101,7 +84,6 @@ for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
 do
 	_do "$XFS_IO_PROG -f -c \"resvsp 0 1m\" $SCRATCH_MNT/hole$i"
 	_do "$XFS_IO_PROG -f -c \"resvsp 0 4k\" $SCRATCH_MNT/space$i"
-	_do "$XFS_IO_PROG -f -c \"resvsp 0 1m\" $SCRATCH_MNT/hole$i"
 	_do "xfs_bmap -vp $SCRATCH_MNT/hole$i"
 done
 echo "done" 
@@ -109,15 +91,15 @@ echo "done"
 # set up filesystem
 echo -n "Fill filesystem with fill file... "
 for i in `seq 0 1 31`; do
-	_do "$XFS_IO_PROG -fs -c \"pwrite -S$i ${i}m 1m\" $SCRATCH_MNT/fill"
+	_do "$XFS_IO_PROG -f -c \"falloc ${i}m 1m\" $SCRATCH_MNT/fill"
 done
 _do "xfs_bmap -vp $SCRATCH_MNT/fill"
 echo "done"
 # flush the filesystem - make sure there is no space "lost" to pre-allocation
 _do "umount $SCRATCH_MNT"
 _do "_scratch_mount"
-echo -n "Use up any further available space using dd... "
-_do "dd if=/dev/zero of=$SCRATCH_MNT/pad bs=4096"
+echo -n "Use up any further available space... "
+_do "$XFS_IO_PROG -f -c \"falloc 0 1m\" $SCRATCH_MNT/pad"
 echo "done"
 
 # create fragmented file
diff --git a/tests/xfs/042.out b/tests/xfs/042.out
index 41baf09..a25885b 100644
--- a/tests/xfs/042.out
+++ b/tests/xfs/042.out
@@ -2,7 +2,7 @@ QA output created by 042
 Make a 48 megabyte filesystem on SCRATCH_DEV and mount... done
 Reserve 16 1Mb unfragmented regions... done
 Fill filesystem with fill file... done
-Use up any further available space using dd... done
+Use up any further available space... done
 Punch every second 4k block... done
 Create one very large file... done
 Remove other files... done
-- 
2.1.4

