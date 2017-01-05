From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] generic/158,304: filter dedupe error message
Date: Thu,  5 Jan 2017 15:28:37 +0800
Message-Id: <20170105072837.8679-1-eguan@redhat.com>
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Kernel commit 22725ce4e4a0 ("vfs: fix isize/pos/len checks for reflink &
dedupe") added more checks on reflink and dedupe, rejected dedupe past
EOF early and explicitly, and causes generic/158 and generic/304 to fail.

  Try dedupe from past EOF
 -dedupe: Invalid argument
 +XFS_IOC_FILE_EXTENT_SAME: Invalid argument
  Try dedupe to past EOF, destination offset beyond EOF

Also there's an xfsprogs patch from Darrick ("xfs_io: prefix dedupe
command error messages consistently") to change all xfs_io dedupe
error message prefixes to "XFS_IOC_FILE_EXTENT_SAME".

So introduce a new _filter_dedupe_error, change all "dedupe" prefix
to XFS_IOC_FILE_EXTENT_SAME, make tests pass with both old/new
kernel & userspace.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- filter "dedupe:" to "XFS_IOC_FILE_EXTENT_SAME:" and update more _dedupe_range
  lines accordingly

 common/reflink        |  6 ++++++
 tests/generic/158     | 30 +++++++++++++++++++-----------
 tests/generic/158.out | 16 ++++++++--------
 tests/generic/304     | 21 ++++++++++++++-------
 tests/generic/304.out | 12 ++++++------
 5 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/common/reflink b/common/reflink
index 64ee04f..9dc67f0 100644
--- a/common/reflink
+++ b/common/reflink
@@ -241,6 +241,12 @@ _dedupe_range() {
 	$XFS_IO_PROG $xfs_io_args -f -c "dedupe $file1 $offset1 $offset2 $len" "$file2"
 }
 
+# Unify xfs_io dedupe ioctl error message prefix
+_filter_dedupe_error()
+{
+	sed -e 's/^dedupe:/XFS_IOC_FILE_EXTENT_SAME:/g'
+}
+
 # Create a file of interleaved unwritten and reflinked blocks
 _weave_reflink_unwritten() {
 	blksz=$1
diff --git a/tests/generic/158 b/tests/generic/158
index 086c522..2d34df9 100755
--- a/tests/generic/158
+++ b/tests/generic/158
@@ -81,41 +81,48 @@ mkfifo $testdir1/fifo1
 sync
 
 _filter_enotty() {
+	_filter_dedupe_error | \
 	sed -e 's/Inappropriate ioctl for device/Invalid argument/g'
 }
 
 _filter_eperm() {
+	_filter_dedupe_error | \
 	sed -e 's/Permission denied/Invalid argument/g'
 }
 
 echo "Try cross-device dedupe"
-_dedupe_range $testdir1/file1 0 $testdir2/file1 0 $blksz
+_dedupe_range $testdir1/file1 0 $testdir2/file1 0 $blksz \
+	2>&1 | _filter_dedupe_error
 
 echo "Try unaligned dedupe"
-_dedupe_range $testdir1/file1 37 $testdir1/file1 59 23
+_dedupe_range $testdir1/file1 37 $testdir1/file1 59 23 \
+	2>&1 | _filter_dedupe_error
 
 echo "Try overlapping dedupe"
-_dedupe_range $testdir1/file1 0 $testdir1/file1 1 $((blksz * 2))
+_dedupe_range $testdir1/file1 0 $testdir1/file1 1 $((blksz * 2)) \
+	2>&1 | _filter_dedupe_error
 
 echo "Try dedupe from past EOF"
-_dedupe_range $testdir1/file1 $(( (blks + 10) * blksz)) $testdir1/file1 0 $blksz
+_dedupe_range $testdir1/file1 $(( (blks + 10) * blksz)) $testdir1/file1 0 $blksz \
+	2>&1 | _filter_dedupe_error
 
 echo "Try dedupe to past EOF, destination offset beyond EOF"
-_dedupe_range $testdir1/file1 0 $testdir1/file1 $(( (blks + 10) * blksz)) \
-	$blksz
+_dedupe_range $testdir1/file1 0 $testdir1/file1 $(( (blks + 10) * blksz)) $blksz \
+	2>&1 | _filter_dedupe_error
 
 echo "Try dedupe to past EOF, destination offset behind EOF"
-_dedupe_range $testdir1/file1 0 $testdir1/file1 $(( (blks - 1) * blksz)) \
-	$((blksz * 2))
+_dedupe_range $testdir1/file1 0 $testdir1/file1 $(( (blks - 1) * blksz)) $((blksz * 2)) \
+	2>&1 | _filter_dedupe_error
 
 echo "Try to dedupe a dir"
-_dedupe_range $testdir1/dir1 0 $testdir1/file2 0 $blksz
+_dedupe_range $testdir1/dir1 0 $testdir1/file2 0 $blksz 2>&1 | _filter_dedupe_error
 
 echo "Try to dedupe a device"
 _dedupe_range $testdir1/dev1 0 $testdir1/file2 0 $blksz 2>&1 | _filter_enotty
 
 echo "Try to dedupe to a dir"
-_dedupe_range $testdir1/file1 0 $testdir1/dir1 0 $blksz 2>&1 | _filter_test_dir
+_dedupe_range $testdir1/file1 0 $testdir1/dir1 0 $blksz \
+	2>&1 | _filter_test_dir | _filter_dedupe_error
 
 echo "Try to dedupe to a device"
 _dedupe_range $testdir1/file1 0 $testdir1/dev1 0 $blksz 2>&1 | _filter_eperm
@@ -124,7 +131,8 @@ echo "Try to dedupe to a fifo"
 _dedupe_range $testdir1/file1 0 $testdir1/fifo1 0 $blksz -n 2>&1 | _filter_eperm
 
 echo "Try to dedupe an append-only file"
-_dedupe_range $testdir1/file1 0 $testdir1/file3 0 $blksz -a >> $seqres.full
+_dedupe_range $testdir1/file1 0 $testdir1/file3 0 $blksz -a \
+	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Dedupe two files"
 _dedupe_range $testdir1/file1 0 $testdir1/file2 0 $blksz >> $seqres.full
diff --git a/tests/generic/158.out b/tests/generic/158.out
index 9b82ddf..8df9d9a 100644
--- a/tests/generic/158.out
+++ b/tests/generic/158.out
@@ -2,17 +2,17 @@ QA output created by 158
 Format and mount
 Create the original files
 Try cross-device dedupe
-dedupe: Invalid cross-device link
+XFS_IOC_FILE_EXTENT_SAME: Invalid cross-device link
 Try unaligned dedupe
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Try overlapping dedupe
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Try dedupe from past EOF
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Try dedupe to past EOF, destination offset beyond EOF
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Try dedupe to past EOF, destination offset behind EOF
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Try to dedupe a dir
 XFS_IOC_FILE_EXTENT_SAME: Is a directory
 Try to dedupe a device
@@ -20,8 +20,8 @@ XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Try to dedupe to a dir
 TEST_DIR/test-158/dir1: Is a directory
 Try to dedupe to a device
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Try to dedupe to a fifo
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Try to dedupe an append-only file
 Dedupe two files
diff --git a/tests/generic/304 b/tests/generic/304
index b7ee7b9..6c36a68 100755
--- a/tests/generic/304
+++ b/tests/generic/304
@@ -63,25 +63,32 @@ _pwrite_byte 0x61 $bigoff 1 $testdir/file3 >> $seqres.full
 _pwrite_byte 0x61 1048575 1 $testdir/file2 >> $seqres.full
 
 echo "Dedupe large single byte file"
-_dedupe_range $testdir/file1 0 $testdir/file3 0 $len >> $seqres.full
+_dedupe_range $testdir/file1 0 $testdir/file3 0 $len \
+	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Dedupe large empty file"
-_dedupe_range $testdir/file0 0 $testdir/file4 0 $len >> $seqres.full
+_dedupe_range $testdir/file0 0 $testdir/file4 0 $len \
+	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Dedupe past maximum file size in dest file (should fail)"
-_dedupe_range $testdir/file1 0 $testdir/file5 4611686018427322368 $len >> $seqres.full
+_dedupe_range $testdir/file1 0 $testdir/file5 4611686018427322368 $len \
+	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Dedupe high offset to low offset"
-_dedupe_range $testdir/file1 $bigoff_64k $testdir/file6 1048576 65535 >> $seqres.full
+_dedupe_range $testdir/file1 $bigoff_64k $testdir/file6 1048576 65535 \
+	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Dedupe past source file EOF (should fail)"
-_dedupe_range $testdir/file2 524288 $testdir/file7 0 1048576 >> $seqres.full
+_dedupe_range $testdir/file2 524288 $testdir/file7 0 1048576 \
+	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Dedupe max size at nonzero offset (should fail)"
-_dedupe_range $testdir/file2 524288 $testdir/file8 0 $len >> $seqres.full
+_dedupe_range $testdir/file2 524288 $testdir/file8 0 $len \
+	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Dedupe with huge off/len (should fail)"
-_dedupe_range $testdir/file2 $bigoff_64k $testdir/file9 0 $bigoff_64k >> $seqres.full
+_dedupe_range $testdir/file2 $bigoff_64k $testdir/file9 0 $bigoff_64k \
+	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Check file creation"
 _test_cycle_mount
diff --git a/tests/generic/304.out b/tests/generic/304.out
index 7b5ff0e..a979099 100644
--- a/tests/generic/304.out
+++ b/tests/generic/304.out
@@ -2,17 +2,17 @@ QA output created by 304
 Format and mount
 Create the original files
 Dedupe large single byte file
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Dedupe large empty file
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Dedupe past maximum file size in dest file (should fail)
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Dedupe high offset to low offset
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Dedupe past source file EOF (should fail)
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Dedupe max size at nonzero offset (should fail)
-dedupe: Invalid argument
+XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Dedupe with huge off/len (should fail)
 XFS_IOC_FILE_EXTENT_SAME: Invalid argument
 Check file creation
-- 
2.9.3
