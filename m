Received: from mx1.redhat.com ([209.132.183.28]:47428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754305AbdDLOqv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Apr 2017 10:46:51 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v3 1/4] DAX-DIO: make dax_to_non_dax dio test solo
Date: Wed, 12 Apr 2017 22:46:17 +0800
Message-Id: <1492008380-29164-2-git-send-email-xzhou@redhat.com>
In-Reply-To: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
References: <20170412062608.y2u5og3xz2oly44b@XZHOUW.usersys.redhat.com>
 <1492008380-29164-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Split it from old testsets in generic/413 and xfs/260, since this
test need pmem device underneath has memory(struct page) backend.
We will _notrun the solo if the device is not compatible for the
test, preveting its confusing failure.

The other dax/nondax dio tests don't have this limitation.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/generic/413 | 13 +------------
 tests/xfs/260     | 19 +++----------------
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/tests/generic/413 b/tests/generic/413
index a1cc514..32843d4 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -85,17 +85,6 @@ t_nondax_to_dax()
 		$SCRATCH_MNT/tf_d $1 "buffered nondax to dax"
 }
 
-t_dax_to_nondax()
-{
-	prep_files
-	src/t_mmap_dio $SCRATCH_MNT/tf_s \
-		$TEST_DIR/tf_d $1 "dio dax to nondax"
-
-	prep_files
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_s \
-		$TEST_DIR/tf_d $1 "buffered dax to nondax"
-}
-
 t_both_nondax()
 {
 	prep_files
@@ -109,8 +98,8 @@ t_both_nondax()
 # $1 mmap read/write size
 t_mmap_dio_dax()
 {
+	# split t_dax_to_nondax to another case
 	t_both_dax $1
-	t_dax_to_nondax $1
 	t_nondax_to_dax $1
 	t_both_nondax $1
 }
diff --git a/tests/xfs/260 b/tests/xfs/260
index e613cc0..3066cb9 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -88,21 +88,6 @@ t_nondax_to_dax()
 		$1 "buffered nondax to dax"
 }
 
-t_dax_to_nondax()
-{
-	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
-		$1 "dio dax to nondax"
-
-	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
-		$1 "buffered dax to nondax"
-}
-
 t_both_nondax()
 {
 	prep_files
@@ -119,8 +104,8 @@ t_both_nondax()
 # $1 mmap read/write size
 t_dax_flag_mmap_dio()
 {
+	# split t_dax_to_nondax to another case
 	t_both_dax $1
-	t_dax_to_nondax $1
 	t_nondax_to_dax $1
 	t_both_nondax $1
 }
@@ -146,9 +131,11 @@ tsize=$((128 * 1024 * 1024))
 
 do_tests
 _scratch_unmount
+_check_scratch_fs
 
 # mount again without dax option
 export MOUNT_OPTIONS=""
+export TEST_FS_MOUNT_OPTS=""
 _scratch_mount
 do_tests
 
-- 
1.8.3.1

