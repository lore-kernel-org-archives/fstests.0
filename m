From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 2/3] fstests: strip quotes from "$XFS_IO_PROG" call sites
Date: Sun, 16 Oct 2016 13:53:41 +0300
Message-Id: <1476615222-7804-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1476615222-7804-1-git-send-email-amir73il@gmail.com>
References: <1476615222-7804-1-git-send-email-amir73il@gmail.com>
To: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The value of "$XFS_IO_PROG" may contain extra flags after the
binary path (e.g. -F), so it is wrong to use the variable inside
quotes in xfs_io execution call sites.

This bug surfaced while testing the new xfs_io -M flag.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc         |  6 +++---
 common/reflink    | 26 +++++++++++++-------------
 tests/generic/176 |  2 +-
 tests/xfs/328     |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/common/rc b/common/rc
index 565ba67..a838750 100644
--- a/common/rc
+++ b/common/rc
@@ -90,7 +90,7 @@ _pwrite_byte() {
 	file="$4"
 	xfs_io_args="$5"
 
-	"$XFS_IO_PROG" $xfs_io_args -f -c "pwrite -S $pattern $offset $len" "$file"
+	$XFS_IO_PROG $xfs_io_args -f -c "pwrite -S $pattern $offset $len" "$file"
 }
 
 # mmap-write a byte into a range of a file
@@ -101,7 +101,7 @@ _mwrite_byte() {
 	mmap_len="$4"
 	file="$5"
 
-	"$XFS_IO_PROG" -f -c "mmap -rw 0 $mmap_len" -c "mwrite -S $pattern $offset $len" "$file"
+	$XFS_IO_PROG -f -c "mmap -rw 0 $mmap_len" -c "mwrite -S $pattern $offset $len" "$file"
 }
 
 # ls -l w/ selinux sometimes puts a dot at the end:
@@ -3437,7 +3437,7 @@ _xfs_bmapx_find() {
 	file="$1"
 	shift
 
-	"$XFS_IO_PROG" -c "bmap -${param}lpv" "$file" | grep -c "$@"
+	$XFS_IO_PROG -c "bmap -${param}lpv" "$file" | grep -c "$@"
 }
 
 _require_chattr()
diff --git a/common/reflink b/common/reflink
index 1363971..8b34046 100644
--- a/common/reflink
+++ b/common/reflink
@@ -52,8 +52,8 @@ _require_test_reflink()
 	_require_xfs_io_command "reflink"
 
 	rm -rf "$TEST_DIR/file1" "$TEST_DIR/file2"
-	"$XFS_IO_PROG" -f -c "pwrite -S 0x61 0 65536" "$TEST_DIR/file1" > /dev/null
-	"$XFS_IO_PROG" -f -c "reflink $TEST_DIR/file1 0 0 65536" "$TEST_DIR/file2" > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -S 0x61 0 65536" "$TEST_DIR/file1" > /dev/null
+	$XFS_IO_PROG -f -c "reflink $TEST_DIR/file1 0 0 65536" "$TEST_DIR/file2" > /dev/null
 	if [ ! -s "$TEST_DIR/file2" ]; then
 		rm -rf "$TEST_DIR/file1" "$TEST_DIR/file2"
 		_notrun "Reflink not supported by test filesystem type: $FSTYP"
@@ -69,8 +69,8 @@ _require_scratch_reflink()
 
 	_scratch_mkfs > /dev/null
 	_scratch_mount
-	"$XFS_IO_PROG" -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file1" > /dev/null
-	"$XFS_IO_PROG" -f -c "reflink $SCRATCH_MNT/file1 0 0 65536" "$SCRATCH_MNT/file2" > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file1" > /dev/null
+	$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/file1 0 0 65536" "$SCRATCH_MNT/file2" > /dev/null
 	if [ ! -s "$SCRATCH_MNT/file2" ]; then
 		_scratch_unmount
 		_notrun "Reflink not supported by scratch filesystem type: $FSTYP"
@@ -85,9 +85,9 @@ _require_test_dedupe()
 	_require_xfs_io_command "dedupe"
 
 	rm -rf "$TEST_DIR/file1" "$TEST_DIR/file2"
-	"$XFS_IO_PROG" -f -c "pwrite -S 0x61 0 65536" "$TEST_DIR/file1" > /dev/null
-	"$XFS_IO_PROG" -f -c "pwrite -S 0x61 0 65536" "$TEST_DIR/file2" > /dev/null
-	testio="$("$XFS_IO_PROG" -f -c "dedupe $TEST_DIR/file1 0 0 65536" "$TEST_DIR/file2" 2>&1)"
+	$XFS_IO_PROG -f -c "pwrite -S 0x61 0 65536" "$TEST_DIR/file1" > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -S 0x61 0 65536" "$TEST_DIR/file2" > /dev/null
+	testio="$($XFS_IO_PROG -f -c "dedupe $TEST_DIR/file1 0 0 65536" "$TEST_DIR/file2" 2>&1)"
 	echo $testio | grep -q "Operation not supported" && \
 		_notrun "Dedupe not supported by test filesystem type: $FSTYP"
 	echo $testio | grep -q "Inappropriate ioctl for device" && \
@@ -105,9 +105,9 @@ _require_scratch_dedupe()
 
 	_scratch_mkfs > /dev/null
 	_scratch_mount
-	"$XFS_IO_PROG" -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file1" > /dev/null
-	"$XFS_IO_PROG" -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file2" > /dev/null
-	testio="$("$XFS_IO_PROG" -f -c "dedupe $SCRATCH_MNT/file1 0 0 65536" "$SCRATCH_MNT/file2" 2>&1)"
+	$XFS_IO_PROG -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file1" > /dev/null
+	$XFS_IO_PROG -f -c "pwrite -S 0x61 0 65536" "$SCRATCH_MNT/file2" > /dev/null
+	testio="$($XFS_IO_PROG -f -c "dedupe $SCRATCH_MNT/file1 0 0 65536" "$SCRATCH_MNT/file2" 2>&1)"
 	echo $testio | grep -q "Operation not supported" && \
 		_notrun "Dedupe not supported by test filesystem type: $FSTYP"
 	echo $testio | grep -q "Inappropriate ioctl for device" && \
@@ -161,7 +161,7 @@ _reflink() {
 	file1="$1"
 	file2="$2"
 
-	"$XFS_IO_PROG" -f -c "reflink $file1" "$file2"
+	$XFS_IO_PROG -f -c "reflink $file1" "$file2"
 }
 
 # Reflink some part of file1 into another part of file2
@@ -173,7 +173,7 @@ _reflink_range() {
 	len="$5"
 	xfs_io_args="$6"
 
-	"$XFS_IO_PROG" $xfs_io_args -f -c "reflink $file1 $offset1 $offset2 $len" "$file2"
+	$XFS_IO_PROG $xfs_io_args -f -c "reflink $file1 $offset1 $offset2 $len" "$file2"
 }
 
 # Dedupe some part of file1 into another part of file2
@@ -185,7 +185,7 @@ _dedupe_range() {
 	len="$5"
 	xfs_io_args="$6"
 
-	"$XFS_IO_PROG" $xfs_io_args -f -c "dedupe $file1 $offset1 $offset2 $len" "$file2"
+	$XFS_IO_PROG $xfs_io_args -f -c "dedupe $file1 $offset1 $offset2 $len" "$file2"
 }
 
 # Create a file of interleaved unwritten and reflinked blocks
diff --git a/tests/generic/176 b/tests/generic/176
index b14255b..76e923a 100755
--- a/tests/generic/176
+++ b/tests/generic/176
@@ -75,7 +75,7 @@ test $fnr -lt 17 && _notrun "Insufficient space for stress test; would only crea
 
 echo "Create a many-block file"
 echo "creating $blocks_needed blocks..." >> "$seqres.full"
-"$XFS_IO_PROG" -f -c "pwrite -S 0x61 -b 4194304 0 $((2 ** (fnr + 1) * blksz))" "$testdir/file1" >> "$seqres.full"
+$XFS_IO_PROG -f -c "pwrite -S 0x61 -b 4194304 0 $((2 ** (fnr + 1) * blksz))" "$testdir/file1" >> "$seqres.full"
 echo "punching..." >> "$seqres.full"
 "$here/src/punch-alternating" "$testdir/file1" >> "$seqres.full"
 echo "...done" >> "$seqres.full"
diff --git a/tests/xfs/328 b/tests/xfs/328
index 33a0bef..8518456 100755
--- a/tests/xfs/328
+++ b/tests/xfs/328
@@ -80,7 +80,7 @@ bytes=$((blocks_needed * blksz))
 echo "Create a many-block file"
 echo "creating $blocks_needed blocks..." >> "$seqres.full"
 _pwrite_byte 0x62 0 $blksz $testdir/file0 >> $seqres.full
-"$XFS_IO_PROG" -f -c "pwrite -S 0x61 -b 4194304 0 $bytes" "$testdir/file1" >> "$seqres.full"
+$XFS_IO_PROG -f -c "pwrite -S 0x61 -b 4194304 0 $bytes" "$testdir/file1" >> "$seqres.full"
 echo "punching..." >> "$seqres.full"
 "$here/src/punch-alternating" "$testdir/file1" >> "$seqres.full"
 seq 0 2 $((2 ** (fnr + 1) )) | while read lblk; do
-- 
2.7.4
