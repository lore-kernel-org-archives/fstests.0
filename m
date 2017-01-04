Received: from cn.fujitsu.com ([222.73.24.84]:41908 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1757987AbdADIpI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 4 Jan 2017 03:45:08 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: Fix inconsistent xfs_io error report caused false alert
Date: Wed,  4 Jan 2017 16:37:08 +0800
Message-Id: <20170104083708.5268-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test case like generic/304 and generic/158 can cause false alert due to
the error output change of xfs_io.

For error case, xfs_io mostly reports error like "dedupe: ERROR STRING"
while under certain case, it reports error like "XFS_IOC_FILE_EXTENT_SAME:
ERROR STRING".

Fix it by adding a new filter, _filter_dedupe_ioctl(), to filter out all
"XFS_IOC_FILE_EXTENT_SAME:" to "dedupe:"

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/filter         |  8 ++++++++
 tests/generic/158     |  9 ++++++---
 tests/generic/158.out |  4 ++--
 tests/generic/304     | 12 +++++++++---
 tests/generic/304.out |  2 +-
 5 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/common/filter b/common/filter
index 397b456..f9ad7f9 100644
--- a/common/filter
+++ b/common/filter
@@ -401,5 +401,13 @@ _filter_mknod()
 	sed -e "s/mknod: [\`']\(.*\)': File exists/mknod: \1: File exists/"
 }
 
+# xfs_io has inconsistent error report prefix.
+# For some error it reports like "dedupe: STRING" while for some it
+# reports "XFS_IOC_FILE_EXTENT_SAME: STRING"
+# Use this filter to unify them to "dedupe:"
+_filter_dedupe_ioctl()
+{
+	sed -e "s/^XFS_IOC_FILE_EXTENT_SAME:/dedupe:/"
+}
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/158 b/tests/generic/158
index 086c522..88f3e47 100755
--- a/tests/generic/158
+++ b/tests/generic/158
@@ -98,7 +98,8 @@ echo "Try overlapping dedupe"
 _dedupe_range $testdir1/file1 0 $testdir1/file1 1 $((blksz * 2))
 
 echo "Try dedupe from past EOF"
-_dedupe_range $testdir1/file1 $(( (blks + 10) * blksz)) $testdir1/file1 0 $blksz
+_dedupe_range $testdir1/file1 $(( (blks + 10) * blksz)) $testdir1/file1 0 $blksz \
+	2>&1 | _filter_dedupe_ioctl
 
 echo "Try dedupe to past EOF, destination offset beyond EOF"
 _dedupe_range $testdir1/file1 0 $testdir1/file1 $(( (blks + 10) * blksz)) \
@@ -109,10 +110,12 @@ _dedupe_range $testdir1/file1 0 $testdir1/file1 $(( (blks - 1) * blksz)) \
 	$((blksz * 2))
 
 echo "Try to dedupe a dir"
-_dedupe_range $testdir1/dir1 0 $testdir1/file2 0 $blksz
+_dedupe_range $testdir1/dir1 0 $testdir1/file2 0 $blksz 2>&1 | \
+	_filter_dedupe_ioctl
 
 echo "Try to dedupe a device"
-_dedupe_range $testdir1/dev1 0 $testdir1/file2 0 $blksz 2>&1 | _filter_enotty
+_dedupe_range $testdir1/dev1 0 $testdir1/file2 0 $blksz 2>&1 | \
+	_filter_enotty | _filter_dedupe_ioctl
 
 echo "Try to dedupe to a dir"
 _dedupe_range $testdir1/file1 0 $testdir1/dir1 0 $blksz 2>&1 | _filter_test_dir
diff --git a/tests/generic/158.out b/tests/generic/158.out
index 9b82ddf..3a9596f 100644
--- a/tests/generic/158.out
+++ b/tests/generic/158.out
@@ -14,9 +14,9 @@ dedupe: Invalid argument
 Try dedupe to past EOF, destination offset behind EOF
 dedupe: Invalid argument
 Try to dedupe a dir
-XFS_IOC_FILE_EXTENT_SAME: Is a directory
+dedupe: Is a directory
 Try to dedupe a device
-XFS_IOC_FILE_EXTENT_SAME: Invalid argument
+dedupe: Invalid argument
 Try to dedupe to a dir
 TEST_DIR/test-158/dir1: Is a directory
 Try to dedupe to a device
diff --git a/tests/generic/304 b/tests/generic/304
index b7ee7b9..f8336fd 100755
--- a/tests/generic/304
+++ b/tests/generic/304
@@ -75,13 +75,19 @@ echo "Dedupe high offset to low offset"
 _dedupe_range $testdir/file1 $bigoff_64k $testdir/file6 1048576 65535 >> $seqres.full
 
 echo "Dedupe past source file EOF (should fail)"
-_dedupe_range $testdir/file2 524288 $testdir/file7 0 1048576 >> $seqres.full
+_dedupe_range $testdir/file2 524288 $testdir/file7 0 1048576 >> $seqres.full \
+	2>$tmp.error
+cat $tmp.error | _filter_dedupe_ioctl
 
 echo "Dedupe max size at nonzero offset (should fail)"
-_dedupe_range $testdir/file2 524288 $testdir/file8 0 $len >> $seqres.full
+_dedupe_range $testdir/file2 524288 $testdir/file8 0 $len >> $seqres.full \
+	2>$tmp.error
+cat $tmp.error | _filter_dedupe_ioctl
 
 echo "Dedupe with huge off/len (should fail)"
-_dedupe_range $testdir/file2 $bigoff_64k $testdir/file9 0 $bigoff_64k >> $seqres.full
+_dedupe_range $testdir/file2 $bigoff_64k $testdir/file9 0 $bigoff_64k \
+	>> $seqres.full 2>$tmp.error
+cat $tmp.error | _filter_dedupe_ioctl
 
 echo "Check file creation"
 _test_cycle_mount
diff --git a/tests/generic/304.out b/tests/generic/304.out
index 7b5ff0e..fbba6f3 100644
--- a/tests/generic/304.out
+++ b/tests/generic/304.out
@@ -14,7 +14,7 @@ dedupe: Invalid argument
 Dedupe max size at nonzero offset (should fail)
 dedupe: Invalid argument
 Dedupe with huge off/len (should fail)
-XFS_IOC_FILE_EXTENT_SAME: Invalid argument
+dedupe: Invalid argument
 Check file creation
 file3
 7ffffffffffffffe:  61  a
-- 
2.9.3



