From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH v4] generic: make 17[1-4] work well when btrfs compression is enabled
Date: Tue,  1 Nov 2016 16:45:03 +0800
Message-Id: <20161101084503.6578-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, eguan@redhat.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

When enabling btrfs compression, original codes can not fill fs
correctly, here we introduce _fill_fs() in common/rc, which'll keep
creating and writing files until enospc error occurs. Note _fill_fs
is copied from tests/generic/256, but with some minor modifications.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
V2: In common/, I did't find an existing function suitable for
    these 4 test cases to fill fs, so I still use _pwrite_byte() with
    a big enough file length fo fill fs. Note, for btrfs, metadata space
    still is not full, only data space is full, but it's OK for these
    4 test cases.

    All these 4 cases pass in xfs and btrfs(without compression), if
    btrfs has compression enabled, these 4 cases will fail for false
    enospc error, I have sent kernel patches to fix this bug.

V3: Introduce  _fill_fs in common/rc to fill fs.
V4: Fix some issues suggested by Eryu and Darrick.
---
 common/rc         | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/171 |  3 +--
 tests/generic/172 |  4 ++--
 tests/generic/173 |  3 +--
 tests/generic/174 |  3 +--
 tests/generic/256 | 65 ++++------------------------------------------------
 6 files changed, 78 insertions(+), 68 deletions(-)

diff --git a/common/rc b/common/rc
index 7a9fc90..7628a0e 100644
--- a/common/rc
+++ b/common/rc
@@ -4003,6 +4003,74 @@ _require_xfs_mkfs_without_validation()
 	fi
 }
 
+# Fill a file system by repeatedly creating files in the given folder
+# starting with the given file size.  Files are reduced in size when
+# they can no longer fit until no more files can be created.
+_fill_fs()
+{
+	local file_size=$1
+	local dir=$2
+	local block_size=$3
+	local switch_user=$4
+	local file_count=1
+	local bytes_written=0
+	local use_falloc=1;
+
+	if [ $# -ne 4 ]; then
+		echo "Usage: _fill_fs filesize dir blocksize switch_user"
+		exit 1
+	fi
+
+	if [ $switch_user -eq 0 ]; then
+		mkdir -p $dir
+	else
+		_user_do "mkdir -p $dir"
+	fi
+	if [ ! -d $dir ]; then
+		return 0;
+	fi
+
+	testio=`$XFS_IO_PROG -F -fc "falloc 0 $block_size" $dir/$$.xfs_io 2>&1`
+	echo $testio | grep -q "not found" && use_falloc=0
+	echo $testio | grep -q "Operation not supported" && use_falloc=0
+
+	if [ $file_size -lt $block_size ]; then
+		$file_size = $block_size
+	fi
+
+	while [ $file_size -ge $block_size ]; do
+		bytes_written=0
+		if [ $switch_user -eq 0 ]; then
+			if [ $use_falloc -eq 0 ]; then
+				$XFS_IO_PROG -fc "pwrite -b 8388608 0 $file_size" \
+					$dir/$file_count
+			else
+				$XFS_IO_PROG -fc "falloc 0 $file_size" \
+					$dir/$file_count
+			fi
+		else
+			if [ $use_falloc -eq 0 ]; then
+				_user_do "$XFS_IO_PROG -f -c \"pwrite -b 8388608 0 \
+					$file_size\" $dir/$file_count"
+			else
+				_user_do "$XFS_IO_PROG -f -c \"falloc 0 \
+					$file_size\" $dir/$file_count"
+			fi
+		fi
+
+		if [ -f $dir/$file_count ]; then
+			bytes_written=$(stat -c '%s' $dir/$file_count)
+		fi
+
+		# If there was no room to make the file, then divide it in
+		# half, and keep going
+		if [ $bytes_written -lt $file_size ]; then
+			file_size=$((file_size / 2))
+		fi
+		file_count=$((file_count + 1))
+	done
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/171 b/tests/generic/171
index a69f798..906e4db 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -76,8 +76,7 @@ sync
 
 echo "Allocate the rest of the space"
 nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+_fill_fs $((nr_free * blksz)) $testdir/space $blksz 0 >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
diff --git a/tests/generic/172 b/tests/generic/172
index 8192290..f6fcdc9 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -57,6 +57,7 @@ testdir=$SCRATCH_MNT/test-$seq
 mkdir $testdir
 
 echo "Reformat with appropriate size"
+blksz="$(get_block_size $testdir)"
 umount $SCRATCH_MNT
 
 file_size=$((168 * 1024 * 1024))
@@ -72,8 +73,7 @@ _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $fs_size $testdir/eat_my_space >> $seqres.full 2>&1
+_fill_fs $fs_size  $testdir/space $blksz 0 >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
diff --git a/tests/generic/173 b/tests/generic/173
index e35597f..10e303d 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -76,8 +76,7 @@ sync
 
 echo "Allocate the rest of the space"
 nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+_fill_fs $((blksz * nr_free)) $testdir/space $blksz 0 >> $seqres.full 2>&1
 sync
 
 echo "mmap CoW the big file"
diff --git a/tests/generic/174 b/tests/generic/174
index e58d64b..455d6c3 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -77,8 +77,7 @@ sync
 
 echo "Allocate the rest of the space"
 nr_free=$(stat -f -c '%f' $testdir)
-touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+_fill_fs $((blksz * nr_free)) $testdir/space $blksz 0 >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
diff --git a/tests/generic/256 b/tests/generic/256
index cfbf790..9488648 100755
--- a/tests/generic/256
+++ b/tests/generic/256
@@ -53,64 +53,6 @@ _require_test
 
 testfile=$TEST_DIR/256.$$
 
-# _fill_fs()
-#
-# Fills a file system by repeatedly creating files in the given folder
-# starting with the given file size.  Files are reduced in size when
-# they can no longer fit untill no more files can be created.
-#
-# This routine is used by _test_full_fs_punch to test that a hole may
-# still be punched when the disk is full by borrowing reserved blocks.
-# All files are created as a non root user to prevent reserved blocks
-# from being consumed.
-#
-_fill_fs() {
-	local file_size=$1
-	local dir=$2
-	local block_size=$3
-	local file_count=1
-	local bytes_written=0
-
-	if [ $# -ne 3 ]
-	then
-		echo "USAGE: _fill_fs filesize dir block size"
-		exit 1
-	fi
-
-	# Creation of files or folders
-	# must not be done as root or
-	# reserved blocks will be consumed
-	_user_do "mkdir -p $dir &> /dev/null"
-	if [ $? -ne 0 ] ; then
-		return 0
-	fi
-
-	if [ $file_size -lt $block_size ]
-	then
-		$file_size = $block_size
-	fi
-
-	while [ $file_size -ge $block_size ]
-	do
-		bytes_written=0
-		_user_do "$XFS_IO_PROG -f -c \"pwrite 0 $file_size\" $dir/$file_count.bin &> /dev/null"
-
-		if [ -f $dir/$file_count.bin ]
-		then
-			bytes_written=`$XFS_IO_PROG -c "stat"  $dir/$file_count.bin | grep stat.size | cut -d ' ' -f3`
-		fi
-
-		# If there was no room to make the file,
-		# then divide it in half, and keep going
-		if [ $bytes_written -lt $file_size ]
-		then
-			file_size=$(( $file_size / 2 ))
-		fi
-		file_count=$(( $file_count + 1 ))
-
-	done
-}
-
 # _test_full_fs_punch()
 #
 # This function will test that a hole may be punched
@@ -144,7 +86,10 @@ _test_full_fs_punch()
 		-c "fsync" $file_name &> /dev/null
 	chmod 666 $file_name
 
-	_fill_fs $(( 1024 * 1024 * 1024 )) $path/fill $block_size
+	# All files are created as a non root user to prevent reserved blocks
+	# from being consumed.
+	_fill_fs $(( 1024 * 1024 * 1024 )) $path/fill $block_size 1 \
+		> /dev/null 2>&1
 
 	for (( i=0; i<$iterations; i++ ))
 	do
@@ -159,7 +104,7 @@ _test_full_fs_punch()
 
 		hole_offset=$(( $hole_offset + $hole_len + $hole_interval ))
 
-		_fill_fs $hole_len $path/fill.$i $block_size
+		_fill_fs $hole_len $path/fill.$i $block_size 1 > /dev/null 2>&1
 
 	done
 }
-- 
2.9.0
