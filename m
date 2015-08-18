Received: from mx1.redhat.com ([209.132.183.28]:39391 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813AbbHRRVz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 18 Aug 2015 13:21:55 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 3B73F98C1D
	for <fstests@vger.kernel.org>; Tue, 18 Aug 2015 17:21:55 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/194: fix the exception when run on 4k sector drives
Date: Wed, 19 Aug 2015 01:21:51 +0800
Message-Id: <1439918511-2859-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

The below command in "Test 4":

    xfs_io -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512"

will run failed on 4k sector drives. So I use min_alignment size
to replace the hard-code 512.

Also I make sure the blksize won't less than min_alignment size,
after blksize=`expr $pgsize / 8`.

If blksize really less than min_alignment size, I set blksize =
min_alignment size, and for sure the consistency of test result,
I repair pgsize(already not real page size) number according to
the new blksize.

Because IRIX can't use _min_dio_alignment(), so remove it from
supported os list.

At last, make the crc flag be disabled only when blksize=512.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/194 | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/194 b/tests/xfs/194
index e11b459..4491dd4 100755
--- a/tests/xfs/194
+++ b/tests/xfs/194
@@ -42,7 +42,7 @@ _cleanup()
 
 # only xfs supported due to use of xfs_bmap
 _supported_fs xfs
-_supported_os IRIX Linux
+_supported_os Linux
 
 # real QA test starts here
 rm -f $seqres.full
@@ -50,6 +50,16 @@ rm -f $seqres.full
 # For this test we use block size = 1/8 page size
 pgsize=`$here/src/feature -s`
 blksize=`expr $pgsize / 8`
+secsize=`_min_dio_alignment $SCRATCH_DEV`
+
+# The minimal blksize can't less than sector size, So if
+# blksize < secsize, we should adjust blksize and pgsize number.
+# Of course, if we adjust pgsize, pgsize won't equal to the
+# real page size of system.
+if [ $blksize -lt $secsize ];then
+        blksize=$secsize
+        pgsize=`expr $blksize \* 8`
+fi
 
 # Filter out file mountpoint and physical location info
 # Input:
@@ -84,8 +94,13 @@ _require_scratch
 unset MKFS_OPTIONS
 unset XFS_MKFS_OPTIONS
 
-# we need 512 byte block size, so crc's are turned off
-_scratch_mkfs_xfs -m crc=0 -b size=$blksize >/dev/null 2>&1
+# If we use 512 byte block size, can't use crc
+if [ $blksize -eq 512 ];then
+        crcflag=0
+else
+        crcflag=1
+fi
+_scratch_mkfs_xfs -m crc=$crcflag -b size=$blksize >/dev/null 2>&1
 _scratch_mount
 
 # 512b block / 4k page example:
@@ -209,7 +224,7 @@ xfs_io \
 -c "truncate `expr $blksize / 2`" \
 -c "truncate `expr $blksize + 1`" \
 -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
--c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
+-c "pwrite -S 0x33 -b $secsize `expr $blksize \* 2` $secsize" \
 -t -d -f $SCRATCH_MNT/testfile4 >> $seqres.full
 
 xfs_bmap -v $SCRATCH_MNT/testfile4 | _filter_bmap
-- 
1.9.3

