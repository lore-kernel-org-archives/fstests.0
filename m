Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:6305 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbeLCGnJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 01:43:09 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gThwZ-0003G5-3q
        for fstests@vger.kernel.org; Mon, 03 Dec 2018 17:42:59 +1100
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1gThwZ-00075K-31
        for fstests@vger.kernel.org; Mon, 03 Dec 2018 17:42:59 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/3] generic/43[014]: copy_range beyond source EOF should fail
Date: Mon,  3 Dec 2018 17:42:55 +1100
Message-Id: <20181203064256.26768-3-david@fromorbit.com>
In-Reply-To: <20181203064256.26768-1-david@fromorbit.com>
References: <20181203064256.26768-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

As per the copy_file_range() man page:

EINVAL
	Requested range extends beyond the end of the source file;
.....

These tests actually attempt to copy beyond the end of the source
file and so should fail with EINVAL. The kernel does not check this
and so needs fixing. These operations should fail, so fix the tests.

Also move the tests to the copy_range group so they are distinct
from the copy group which refers to xfs_copy tests.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/430     |  5 +----
 tests/generic/430.out |  6 ++----
 tests/generic/431     |  1 +
 tests/generic/431.out |  1 +
 tests/generic/434     |  5 +++--
 tests/generic/434.out |  4 ++--
 tests/generic/group   | 10 +++++-----
 7 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/tests/generic/430 b/tests/generic/430
index 1b11f60df059..ab15ce0e37d4 100755
--- a/tests/generic/430
+++ b/tests/generic/430
@@ -70,11 +70,8 @@ cmp -n 1000 $testdir/file $testdir/end 4000
 echo "md5sums after copying end:"
 md5sum $testdir/{file,end} | _filter_test_dir
 
-echo "Copy beyond end of original file"
+echo "Copy beyond end of original file - should fail"
 $XFS_IO_PROG -f -c "copy_range -s 4000 -l 2000 $testdir/file" "$testdir/beyond"
-cmp -n 1000 $testdir/file $testdir/beyond 4000
-echo "md5sums after copying beyond:"
-md5sum $testdir/{file,beyond} | _filter_test_dir
 
 echo "Copy creates hole in target file"
 $XFS_IO_PROG -f -c "copy_range -s 1000 -l 3000 -d 1000 $testdir/file" "$testdir/hole"
diff --git a/tests/generic/430.out b/tests/generic/430.out
index 4b4ca75d5980..8dd7870658cb 100644
--- a/tests/generic/430.out
+++ b/tests/generic/430.out
@@ -15,10 +15,8 @@ Copy end of original file
 md5sums after copying end:
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
 e68d4a150c4e42f4f9ea3ffe4c9cf4ed  TEST_DIR/test-430/end
-Copy beyond end of original file
-md5sums after copying beyond:
-e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
-e68d4a150c4e42f4f9ea3ffe4c9cf4ed  TEST_DIR/test-430/beyond
+Copy beyond end of original file - should fail
+copy_range: Invalid argument
 Copy creates hole in target file
 md5sums after creating hole:
 e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
diff --git a/tests/generic/431 b/tests/generic/431
index f04ae2152bae..273068c78d40 100755
--- a/tests/generic/431
+++ b/tests/generic/431
@@ -52,6 +52,7 @@ $XFS_IO_PROG -f -c "copy_range -s 2 -l 1      $testdir/file" "$testdir/c"
 $XFS_IO_PROG -f -c "copy_range -s 3 -l 1      $testdir/file" "$testdir/d"
 $XFS_IO_PROG -f -c "copy_range -s 4 -l 1      $testdir/file" "$testdir/e"
 $XFS_IO_PROG -f -c "copy_range -s 4 -l 1 -d 1 $testdir/file" "$testdir/f"
+# this should fail with EINVAL and leave an empty file behind.
 $XFS_IO_PROG -f -c "copy_range -s 5 -l 1      $testdir/file" "$testdir/g"
 echo -n "a"    | cmp $testdir/a
 echo -n "b"    | cmp $testdir/b
diff --git a/tests/generic/431.out b/tests/generic/431.out
index 978c4a1b56fc..834a5db6f56f 100644
--- a/tests/generic/431.out
+++ b/tests/generic/431.out
@@ -4,6 +4,7 @@ Original md5sums:
 ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
 ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/copy
 Small copies from various points in the original file
+copy_range: Invalid argument
 md5sums after small copies
 ab56b4d92b40713acc5af89985d4b786  TEST_DIR/test-431/file
 0cc175b9c0f1b6a831c399e269772661  TEST_DIR/test-431/a
diff --git a/tests/generic/434 b/tests/generic/434
index 032f933dff76..4bcaf9bac04b 100755
--- a/tests/generic/434
+++ b/tests/generic/434
@@ -41,15 +41,16 @@ $XFS_IO_PROG -f -c 'pwrite -S 0x61 0 1000' $testdir/file >> $seqres.full 2>&1
 mknod $testdir/dev1 c 1 3
 mkfifo $testdir/fifo
 
-echo "Try to copy when source pos > source size"
+echo "Try to copy when source pos > source size - should fail"
 $XFS_IO_PROG -f -c "copy_range -s 1000 -l 100 $testdir/file" "$testdir/copy"
-md5sum $testdir/copy | _filter_test_dir
 
 echo "Try to copy to a read-only file"
+rm -f $testdir/copy
 $XFS_IO_PROG -r -f -c "copy_range -s 0 -l 100 $testdir/file" "$testdir/copy"
 md5sum $testdir/copy | _filter_test_dir
 
 echo "Try to copy to an append-only file"
+rm -f $testdir/copy
 $XFS_IO_PROG -a -f -c "copy_range -s 0 -l 100 $testdir/file" "$testdir/copy"
 md5sum $testdir/copy | _filter_test_dir
 
diff --git a/tests/generic/434.out b/tests/generic/434.out
index 4532ebbaf864..3659592b949b 100644
--- a/tests/generic/434.out
+++ b/tests/generic/434.out
@@ -1,7 +1,7 @@
 QA output created by 434
 Create the original files
-Try to copy when source pos > source size
-d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-434/copy
+Try to copy when source pos > source size - should fail
+copy_range: Invalid argument
 Try to copy to a read-only file
 copy_range: Bad file descriptor
 d41d8cd98f00b204e9800998ecf8427e  TEST_DIR/test-434/copy
diff --git a/tests/generic/group b/tests/generic/group
index 58318608e7a9..cc05792ba3b6 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -432,11 +432,11 @@
 427 auto quick aio rw
 428 auto quick dax
 429 auto encrypt
-430 auto quick copy
-431 auto quick copy
-432 auto quick copy
-433 auto quick copy
-434 auto quick copy
+430 auto quick copy_range
+431 auto quick copy_range
+432 auto quick copy_range
+433 auto quick copy_range
+434 auto quick copy_range
 435 auto encrypt
 436 auto quick rw
 437 auto quick dax
-- 
2.19.1
