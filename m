Received: from mx1.redhat.com ([209.132.183.28]:49054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932719AbdDQHO3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Apr 2017 03:14:29 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v4 1/4] DAX-DIO: make dax_to_non_dax dio test solo
Date: Mon, 17 Apr 2017 15:14:12 +0800
Message-Id: <1492413255-11146-2-git-send-email-xzhou@redhat.com>
In-Reply-To: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
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
 tests/xfs/260     | 17 +----------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/tests/generic/413 b/tests/generic/413
index a1cc514..32e0966 100755
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
+	# t_dax_to_nondax run in separated case
 	t_both_dax $1
-	t_dax_to_nondax $1
 	t_nondax_to_dax $1
 	t_both_nondax $1
 }
diff --git a/tests/xfs/260 b/tests/xfs/260
index e613cc0..0763450 100755
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
+	# t_dax_to_nondax run in separated case
 	t_both_dax $1
-	t_dax_to_nondax $1
 	t_nondax_to_dax $1
 	t_both_nondax $1
 }
-- 
1.8.3.1

