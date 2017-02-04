Received: from mga03.intel.com ([134.134.136.65]:26197 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdBDPSP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 4 Feb 2017 10:18:15 -0500
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH] fixup! xfs: test per-inode DAX flag by IO
Date: Sat,  4 Feb 2017 08:17:52 -0700
Message-Id: <1486221472-1007-1-git-send-email-ross.zwisler@linux.intel.com>
In-Reply-To: <1484892950-25178-2-git-send-email-xzhou@redhat.com>
References: <1484892950-25178-2-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, jmoyer@redhat.com, eguan@redhat.com, linux-nvdimm@ml01.01.org
List-ID: <fstests@vger.kernel.org>

This makes a few changes to allow xfs/138 to use PMD faults, and has a few
other changes which I think are improvements.

For PMD faults:
- We need to use MKFS_OPTIONS="-d su=2m,sw=1" to ensure that the block
  allocations we get from XFS are 2MiB sized and aligned.  Without this we
  will fall back to 4k DAX pages for all the tests.

- We need to preallocate the file size with fallocate, rather than using
  "xfs_io -c pwrite".  This lets XFS increase the size of the test files
  before the test starts, giving us 2MiB sized and aligned blocks.  This
  also has the added bonus that we don't start out the mmap portion of the
  test with all the areas of the files written to and allocated.  This
  means that on the first read pass through a portion of a file we exercise
  the zero page DAX path for holes, then on subsequent passes we'll fill
  the holes and exercise the normal DAX path, giving us better overall
  coverage of the DAX code.  It also makes the test run slightly faster.

- For some reason I was having trouble getting XFS to give me 2MiB aligned
  and sized block allocations with file size 1GiB?  The test only needs
  file sizes of 64 MiB, and dropping the files used to that size ensured
  that I always got 2MiB allocations, but truthfully I don't understand
  this behavior from XFS.

And one cleanup thing:

- Changed the sizes above 4k to use bash math instead of having hard coded
  values.  I personally don't have 67108864 memorized to be 64 MiB (maybe
  everyone else does), but the meaning of $((64 * 1024 * 1024)) is more
  obvious to the reader.

I'm working on similar changes for your generic/405, but am still having
trouble getting PMD faults from ext4, even with the mkfs options I had
previously been using for other testing.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tests/xfs/138 | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tests/xfs/138 b/tests/xfs/138
index 9822441..4762534 100755
--- a/tests/xfs/138
+++ b/tests/xfs/138
@@ -79,22 +79,21 @@ do_tests()
 	# page size
 	t_dax_flag_mmap_dio `src/feature -s`
 	# bigger sizes, for PMD faults
-	t_dax_flag_mmap_dio 16777216
-	t_dax_flag_mmap_dio 67108864
+	t_dax_flag_mmap_dio $((16 * 1024 * 1024))
+	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
 }
 
+export MKFS_OPTIONS="-d su=2m,sw=1"
 _scratch_mkfs > /dev/null 2>&1
 
 # mount with dax option
 _scratch_mount "-o dax"
 
 psize=`src/feature -s`
-tsize=$((1024 * 1024 * 1024))
+tsize=$((64 * 1024 * 1024))
 
-$XFS_IO_PROG -f -c "pwrite -W -b $psize 0 $tsize" \
-	$SCRATCH_MNT/tf_s >> $seqres.full 2>&1
-$XFS_IO_PROG -f -c "pwrite -W -b $psize 0 $tsize" \
-	$SCRATCH_MNT/tf_d >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "falloc 0 $tsize" $SCRATCH_MNT/tf_s >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "falloc 0 $tsize" $SCRATCH_MNT/tf_d >> $seqres.full 2>&1
 
 do_tests
 _scratch_unmount
-- 
2.7.4

