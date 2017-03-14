Received: from mx1.redhat.com ([209.132.183.28]:42422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752653AbdCND7h (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Mar 2017 23:59:37 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH] DAX DIO: DAX mapped area DIO to non-DAX expected failure
Date: Tue, 14 Mar 2017 11:59:20 +0800
Message-Id: <1489463960-3579-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

It's not supported on raw mode nvdimm, brd ramdisk:
https://lists.01.org/pipermail/linux-nvdimm/2017-February/008959.html

It's working on "memory mode" nvdimm, memmap ramdisk.

Mute output of this subtest to stop the fake failure. Keep this
routine for sanity check.

Updating generic/413 and xfs/260.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/generic/413 | 6 ++++--
 tests/xfs/260     | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/generic/413 b/tests/generic/413
index a1cc514..828ef79 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -89,11 +89,13 @@ t_dax_to_nondax()
 {
 	prep_files
 	src/t_mmap_dio $SCRATCH_MNT/tf_s \
-		$TEST_DIR/tf_d $1 "dio dax to nondax"
+		$TEST_DIR/tf_d $1 "dio dax to nondax" \
+		> /dev/null 2>&1
 
 	prep_files
 	src/t_mmap_dio -b $SCRATCH_MNT/tf_s \
-		$TEST_DIR/tf_d $1 "buffered dax to nondax"
+		$TEST_DIR/tf_d $1 "buffered dax to nondax" \
+		> /dev/null 2>&1
 }
 
 t_both_nondax()
diff --git a/tests/xfs/260 b/tests/xfs/260
index e613cc0..ff7eed2 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -94,13 +94,15 @@ t_dax_to_nondax()
 	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
 	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
-		$1 "dio dax to nondax"
+		$1 "dio dax to nondax" \
+		> /dev/null 2>&1
 
 	prep_files
 	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
 	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
-		$1 "buffered dax to nondax"
+		$1 "buffered dax to nondax" \
+		> /dev/null 2>&1
 }
 
 t_both_nondax()
-- 
1.8.3.1

