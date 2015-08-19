Received: from mx1.redhat.com ([209.132.183.28]:35457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbbHSD6X (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 18 Aug 2015 23:58:23 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] xfs/194: fix the exception when run on 4k sector drives
Date: Wed, 19 Aug 2015 11:58:19 +0800
Message-Id: <1439956699-10491-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, david@fromorbit.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

The below command in "Test 4":

    xfs_io -c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512"

will run failed on 4k sector drives. So I use sector size to
replace the hard-code 512.

And we won't run this case when $sector_size > $page_size / 8.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
---
 tests/xfs/194 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/194 b/tests/xfs/194
index e11b459..e9e8588 100755
--- a/tests/xfs/194
+++ b/tests/xfs/194
@@ -50,6 +50,11 @@ rm -f $seqres.full
 # For this test we use block size = 1/8 page size
 pgsize=`$here/src/feature -s`
 blksize=`expr $pgsize / 8`
+secsize=`_min_dio_alignment $SCRATCH_DEV`
+
+if [ $secsize -gt $blksize ];then
+	_notrun "sector size($secsize) too large for platform page size($pgsize)"
+fi
 
 # Filter out file mountpoint and physical location info
 # Input:
@@ -209,7 +214,7 @@ xfs_io \
 -c "truncate `expr $blksize / 2`" \
 -c "truncate `expr $blksize + 1`" \
 -c "pwrite -S 0x22 -b $blksize `expr $pgsize / 2` $blksize" \
--c "pwrite -S 0x33 -b 512 `expr $blksize \* 2` 512" \
+-c "pwrite -S 0x33 -b $secsize `expr $blksize \* 2` $secsize" \
 -t -d -f $SCRATCH_MNT/testfile4 >> $seqres.full
 
 xfs_bmap -v $SCRATCH_MNT/testfile4 | _filter_bmap
-- 
1.9.3

