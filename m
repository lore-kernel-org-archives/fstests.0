Received: from aserp2130.oracle.com ([141.146.126.79]:34694 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQOxk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Apr 2018 10:53:40 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/1] fstests: btrfs/130 fix Invalid argument
Date: Tue, 17 Apr 2018 22:55:37 +0800
Message-Id: <20180417145537.12689-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>

btrfs-progs patch[1] replaced read(2) write(2) with splice(2) and caused the
append-redirect to stop working.

Before:
 btrfs send /btrfs/ro_send > /dev/null
 At subvol /btrfs/ro_snap

 btrfs send /btrfs/ro_send >> /dev/null
 At subvol /btrfs/ro_snap

After:
 btrfs send /btrfs/ro_send > /dev/null
 At subvol /btrfs/ro_snap

 btrfs send /btrfs/ro_send >> /dev/null
 At subvol /btrfs/ro_snap
 ERROR: failed to read stream from kernel: Invalid argument

Further in the test case the line..
btrfs/130
  ::
 _run_btrfs_util_prog send $SCRATCH_MNT/ro_snap > /dev/null 2>&1

which intended to redirect send output to /dev/null, but ended up append
redirect to the $seqres.full file. And so this test case failed as
'Invalid argument' for sometime now.

Still as append of a btrfs send output doesn't make sense, so fix the fstests.

Also adds logs going into $seqres.full.

[1]
ba23855cdc8961bbaef1fcad4854d494cdb3afd3
 btrfs-progs: send: use splice syscall instead of read/write to transfer buffer

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/130 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/130 b/tests/btrfs/130
index edb7397a1ceb..96c8f9d9d526 100755
--- a/tests/btrfs/130
+++ b/tests/btrfs/130
@@ -67,12 +67,14 @@ nr_extents=$((4096 * $LOAD_FACTOR))
 blocksize=$((128 * 1024))
 file=$SCRATCH_MNT/foobar
 
+echo LOAD_FACTOR=$LOAD_FACTOR nr_extents=$nr_extents blocksize=$blocksize >> $seqres.full
+
 # create the initial file, whose file extents are all point to one extent
 _pwrite_byte 0xcdcdcdcd 0 $blocksize  $file | _filter_xfs_io
 
 for i in $(seq 1 $(($nr_extents - 1))); do
 	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize \
-		> /dev/null 2>&1
+		>> $seqres.full 2>&1
 done
 
 # create a RO snapshot, so we can send out the snapshot
@@ -82,7 +84,8 @@ _run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/ro_snap
 # 1) OOM since memory is allocated inside a O(n^3) loop
 # 2) Softlock since time consuming backref walk is called without scheduling.
 # the send destination is not important, just send will cause the problem
-_run_btrfs_util_prog send $SCRATCH_MNT/ro_snap > /dev/null 2>&1
+echo "# $BTRFS_UTIL_PROG send $SCRATCH_MNT/ro_snap > /dev/null" >> $seqres.full
+$BTRFS_UTIL_PROG send $SCRATCH_MNT/ro_snap > /dev/null 2>>$seqres.full
 
 # success, all done
 status=0
-- 
2.15.0

