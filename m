Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:38999 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756290AbcKBVPa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Nov 2016 17:15:30 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1c22sX-000534-6b
        for fstests@vger.kernel.org; Thu, 03 Nov 2016 08:15:25 +1100
Date: Thu, 3 Nov 2016 08:15:25 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH V2] filter: xfs_io output has dropped "64" from error messages
Message-ID: <20161102211525.GG14023@dastard>
References: <1478060636-25272-1-git-send-email-david@fromorbit.com>
 <20161102210718.GF14023@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102210718.GF14023@dastard>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


From: Dave Chinner <dchinner@redhat.com>

Upstream xfs_io has been converted to always use LFS compliant
(i.e. 64 bit) pwrite() rather than pwrite64(). Similar changes have
been made for multiple syscalls that have "*64" variants. hence the
error output of all these commands has changed, such as "pwrite64:
..." to "pwrite: ....".

Make a filter to catch the *64 variants and strip it, and
convert all the golden output to use the non-*64 variant. This will
make all golden output matching work correctly regardless of what
version of xfs_io is in use.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---

V2: add redirect to f2fs/001

 common/filter         |  7 +++++++
 tests/btrfs/126       |  4 ++--
 tests/btrfs/126.out   |  2 +-
 tests/ext4/306        |  3 ++-
 tests/ext4/306.out    |  2 +-
 tests/f2fs/001        |  6 ++----
 tests/f2fs/001.out    |  2 +-
 tests/generic/171     |  6 ++++--
 tests/generic/171.out |  4 ++--
 tests/generic/172     |  6 ++++--
 tests/generic/172.out |  4 ++--
 tests/generic/174     |  6 ++++--
 tests/generic/174.out |  4 ++--
 tests/generic/230     | 12 ++++++++----
 tests/generic/230.out |  8 ++++----
 tests/generic/271     |  3 ++-
 tests/generic/271.out |  2 +-
 tests/generic/272     |  3 ++-
 tests/generic/272.out |  2 +-
 tests/generic/276     |  3 ++-
 tests/generic/276.out |  2 +-
 tests/generic/278     |  3 ++-
 tests/generic/278.out |  2 +-
 tests/generic/328     |  6 ++++--
 tests/generic/328.out |  4 ++--
 tests/xfs/071         |  4 ++--
 tests/xfs/071.out.64  | 20 ++++++++++----------
 tests/xfs/182         |  6 ++++--
 tests/xfs/182.out     |  2 +-
 29 files changed, 81 insertions(+), 57 deletions(-)

diff --git a/common/filter b/common/filter
index f80cd562af71..397b456f6449 100644
--- a/common/filter
+++ b/common/filter
@@ -226,6 +226,13 @@ _filter_xfs_io()
     sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.]* [EPGMKiBbytes]*\/sec and [infa0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
 }
 
+# stderr filter for xfs_io to handle change of error output format (e.g.
+# pwrite64 -> pwrite).
+_filter_xfs_io_error()
+{
+	sed -e "s/^\(.*\)64\(: .*$\)/\1\2/"
+}
+
 _filter_xfs_io_unique()
 {
     common_line_filter | _filter_xfs_io
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index 6763b3027687..cc51f4a81b3d 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -62,8 +62,8 @@ _run_btrfs_util_prog qgroup limit 512K 0/5 $SCRATCH_MNT
 # so redirect stdout to seqres.full.
 # Also, EDQUOTA is expected, which can't be redirected due to the limitation
 # of _filter_xfs_io, so golden output will include EDQUOTA error message
-_pwrite_byte 0xcdcdcdcd 0 1M $SCRATCH_MNT/test_file | _filter_xfs_io \
-	>> $seqres.full
+_pwrite_byte 0xcdcdcdcd 0 1M $SCRATCH_MNT/test_file 2>&1 >> $seqres.full | \
+	_filter_xfs_io_error
 
 # Fstests will umount the fs, and at umount time, kernel warning will be
 # triggered
diff --git a/tests/btrfs/126.out b/tests/btrfs/126.out
index 31500fddb8d7..2e71709b6ba1 100644
--- a/tests/btrfs/126.out
+++ b/tests/btrfs/126.out
@@ -1,2 +1,2 @@
 QA output created by 126
-pwrite64: Disk quota exceeded
+pwrite: Disk quota exceeded
diff --git a/tests/ext4/306 b/tests/ext4/306
index edc02045bc33..fa3b782db834 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -57,7 +57,8 @@ $XFS_IO_PROG -f $SCRATCH_MNT/testfile1 -c "pwrite 0 1m" | _filter_xfs_io
 
 # Create a large non-extent-based file filling the fs; this will run out & fail
 echo "Create testfile2 to fill the fs"
-$XFS_IO_PROG -f $SCRATCH_MNT/testfile2 -c "pwrite 0 512m" | _filter_xfs_io
+$XFS_IO_PROG -f $SCRATCH_MNT/testfile2 -c "pwrite 0 512m" 2>&1 | \
+	_filter_xfs_io_error
 df -h $SCRATCH_MNT >> $seqres.full
 
 # Grow fs by 512m
diff --git a/tests/ext4/306.out b/tests/ext4/306.out
index ee6c90cffb7c..99f7a76c6efb 100644
--- a/tests/ext4/306.out
+++ b/tests/ext4/306.out
@@ -3,7 +3,7 @@ Create 1m testfile1
 wrote 1048576/1048576 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Create testfile2 to fill the fs
-pwrite64: No space left on device
+pwrite: No space left on device
 Resize to 1g
 append 2m to testfile1
 wrote 2097152/2097152 bytes at offset 1048576
diff --git a/tests/f2fs/001 b/tests/f2fs/001
index c84dbde63ac7..c02363a80254 100755
--- a/tests/f2fs/001
+++ b/tests/f2fs/001
@@ -69,10 +69,8 @@ $XFS_IO_PROG -t -f -c "falloc 0 5g" $dummyfile | _filter_xfs_io
 
 # -ENOSPC should be triggered without any panic
 echo "==== change i_size & write data ===="
-$XFS_IO_PROG							\
-	-c "truncate 96"					\
-	-c "pwrite -S 0x58 8192 4096"				\
-$testfile | _filter_xfs_io
+$XFS_IO_PROG -c "truncate 96" -c "pwrite -S 0x58 8192 4096" $testfile 2>&1 \
+	| _filter_xfs_io_error
 
 echo "==== check data contents ===="
 hexdump -C $testfile
diff --git a/tests/f2fs/001.out b/tests/f2fs/001.out
index 593f82aaaa7d..997aa5b2cdd9 100644
--- a/tests/f2fs/001.out
+++ b/tests/f2fs/001.out
@@ -5,7 +5,7 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ==== Fullfill the partition ====
 fallocate: No space left on device
 ==== change i_size & write data ====
-pwrite64: No space left on device
+pwrite: No space left on device
 ==== check data contents ====
 00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
 *
diff --git a/tests/generic/171 b/tests/generic/171
index a69f798c3e77..b01dbd5cd297 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -81,7 +81,8 @@ _pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2
 sync
 
 echo "CoW the big file"
-out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1)"
+out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1 | \
+	_filter_xfs_io_error)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
 echo ${out}
@@ -89,7 +90,8 @@ echo ${out}
 echo "Remount and try CoW again"
 _scratch_cycle_mount
 
-out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1)"
+out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1 | \
+	_filter_xfs_io_error)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
 echo ${out}
diff --git a/tests/generic/171.out b/tests/generic/171.out
index a999eb009e3d..fed659eb25e3 100644
--- a/tests/generic/171.out
+++ b/tests/generic/171.out
@@ -4,6 +4,6 @@ Reformat with appropriate size
 Create a big file and reflink it
 Allocate the rest of the space
 CoW the big file
-pwrite64: No space left on device
+pwrite: No space left on device
 Remount and try CoW again
-pwrite64: No space left on device
+pwrite: No space left on device
diff --git a/tests/generic/172 b/tests/generic/172
index 8192290ad765..0cbcc1f37916 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -77,7 +77,8 @@ _pwrite_byte 0x61 0 $fs_size $testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
-out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1)"
+out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1 | \
+	_filter_xfs_io_error)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
 echo ${out}
@@ -85,7 +86,8 @@ echo ${out}
 echo "Remount and try CoW again"
 _scratch_cycle_mount
 
-out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1)"
+out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1 | \
+	_filter_xfs_io_error)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
 echo ${out}
diff --git a/tests/generic/172.out b/tests/generic/172.out
index 4d3f710b8fe3..2ce14a15c2e8 100644
--- a/tests/generic/172.out
+++ b/tests/generic/172.out
@@ -4,6 +4,6 @@ Reformat with appropriate size
 Create a big file and reflink it
 Allocate the rest of the space
 CoW the big file
-pwrite64: No space left on device
+pwrite: No space left on device
 Remount and try CoW again
-pwrite64: No space left on device
+pwrite: No space left on device
diff --git a/tests/generic/174 b/tests/generic/174
index e58d64be84f2..38fad1d40de5 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -82,7 +82,8 @@ _pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2
 sync
 
 echo "CoW the big file"
-out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile -d 2>&1)"
+out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile -d 2>&1 | \
+	_filter_xfs_io_error)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
 echo ${out}
@@ -90,7 +91,8 @@ echo ${out}
 echo "Remount and try CoW again"
 _scratch_cycle_mount
 
-out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile -d 2>&1)"
+out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile -d 2>&1 | \
+	_filter_xfs_io_error)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
 echo ${out}
diff --git a/tests/generic/174.out b/tests/generic/174.out
index 1490ca4d0487..41fb189f1db1 100644
--- a/tests/generic/174.out
+++ b/tests/generic/174.out
@@ -4,6 +4,6 @@ Reformat with appropriate size
 Create a big file and reflink it
 Allocate the rest of the space
 CoW the big file
-pwrite64: No space left on device
+pwrite: No space left on device
 Remount and try CoW again
-pwrite64: No space left on device
+pwrite: No space left on device
diff --git a/tests/generic/230 b/tests/generic/230
index 8efa65d83398..28ca87dadd80 100755
--- a/tests/generic/230
+++ b/tests/generic/230
@@ -62,23 +62,27 @@ test_enforcement()
 	# Firstly fit below block soft limit
 	echo "Write 900k..."
 	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 900k' -c fsync \
-		$SCRATCH_MNT/file1" 2>&1 >>$seqres.full | tee -a $seqres.full
+		$SCRATCH_MNT/file1" 2>&1 >>$seqres.full | \
+		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
 	# Secondly overcome block soft limit
 	echo "Rewrite 1001k..."
 	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 1001k' -c fsync \
-		$SCRATCH_MNT/file1" 2>&1 >>$seqres.full | tee -a $seqres.full
+		$SCRATCH_MNT/file1" 2>&1 >>$seqres.full | \
+		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
 	# Now try to overcome block hardlimit
 	echo "Write 1000k..."
 	su $qa_user -c "$XFS_IO_PROG -c 'pwrite 0 1000k' -c fsync \
-		$SCRATCH_MNT/file2" 2>&1 >>$seqres.full | tee -a $seqres.full
+		$SCRATCH_MNT/file2" 2>&1 >>$seqres.full | \
+		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
 	# Now sleep for grace time and check that softlimit got enforced
 	sleep $((grace+1))
 	echo "Write 4096..."
 	su $qa_user -c "$XFS_IO_PROG -c 'truncate 0' -c 'pwrite 0 4096' \
-		$SCRATCH_MNT/file2" 2>&1 >>$seqres.full | tee -a $seqres.full
+		$SCRATCH_MNT/file2" 2>&1 >>$seqres.full | \
+		_filter_xfs_io_error | tee -a $seqres.full
 	repquota -$type $SCRATCH_MNT  | grep -v "^root" >>$seqres.full 2>&1
 	# And now the softlimit test for inodes
 	# First reset space limits so that we don't have problems with
diff --git a/tests/generic/230.out b/tests/generic/230.out
index c3dace9860b7..fcbacf285a66 100644
--- a/tests/generic/230.out
+++ b/tests/generic/230.out
@@ -7,9 +7,9 @@ QA output created by 230
 Write 900k...
 Rewrite 1001k...
 Write 1000k...
-pwrite64: Disk quota exceeded
+pwrite: Disk quota exceeded
 Write 4096...
-pwrite64: Disk quota exceeded
+pwrite: Disk quota exceeded
 Touch 3+4
 Touch 5+6
 touch: cannot touch 'SCRATCH_MNT/file6': Disk quota exceeded
@@ -23,9 +23,9 @@ touch: cannot touch 'SCRATCH_MNT/file5': Disk quota exceeded
 Write 900k...
 Rewrite 1001k...
 Write 1000k...
-pwrite64: Disk quota exceeded
+pwrite: Disk quota exceeded
 Write 4096...
-pwrite64: Disk quota exceeded
+pwrite: Disk quota exceeded
 Touch 3+4
 Touch 5+6
 touch: cannot touch 'SCRATCH_MNT/file6': Disk quota exceeded
diff --git a/tests/generic/271 b/tests/generic/271
index fc3c3c65cf2f..ded88541eea2 100755
--- a/tests/generic/271
+++ b/tests/generic/271
@@ -81,7 +81,8 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 sync
 _dmerror_load_error_table
-$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 \
+	2>&1 >> $seqres.full | _filter_xfs_io_error
 _dmerror_load_working_table
 _dmerror_unmount
 _dmerror_mount
diff --git a/tests/generic/271.out b/tests/generic/271.out
index f7ea0041e395..54d5b0dbf6aa 100644
--- a/tests/generic/271.out
+++ b/tests/generic/271.out
@@ -5,7 +5,7 @@ Compare files
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-271/file1
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-271/file2
 CoW and unmount
-pwrite64: Input/output error
+pwrite: Input/output error
 Compare files
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-271/file1
 Check for damage
diff --git a/tests/generic/272 b/tests/generic/272
index feaadae620ef..5bc5b39afeda 100755
--- a/tests/generic/272
+++ b/tests/generic/272
@@ -81,7 +81,8 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 sync
 _dmerror_load_error_table
-$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 \
+	2>&1 >> $seqres.full | _filter_xfs_io_error
 
 echo "Clean up the mess"
 _dmerror_unmount
diff --git a/tests/generic/272.out b/tests/generic/272.out
index e21e4a8bdaa2..0b8bdca5d103 100644
--- a/tests/generic/272.out
+++ b/tests/generic/272.out
@@ -5,7 +5,7 @@ Compare files
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-272/file1
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-272/file2
 CoW and unmount
-pwrite64: Input/output error
+pwrite: Input/output error
 Clean up the mess
 Compare files
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-272/file1
diff --git a/tests/generic/276 b/tests/generic/276
index c6d7a6399438..83b902e6c5de 100755
--- a/tests/generic/276
+++ b/tests/generic/276
@@ -81,7 +81,8 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 sync
 _dmerror_load_error_table
-$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 \
+	2>&1 >> $seqres.full | _filter_xfs_io_error
 _dmerror_load_working_table
 rm -rf $testdir/file2 >> $seqres.full 2>&1
 _dmerror_unmount
diff --git a/tests/generic/276.out b/tests/generic/276.out
index e2aeacfebc8e..88a01623aad8 100644
--- a/tests/generic/276.out
+++ b/tests/generic/276.out
@@ -5,7 +5,7 @@ Compare files
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-276/file1
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-276/file2
 CoW and unmount
-pwrite64: Input/output error
+pwrite: Input/output error
 Compare files
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-276/file1
 Check for damage
diff --git a/tests/generic/278 b/tests/generic/278
index 527356debf54..415742a08d39 100755
--- a/tests/generic/278
+++ b/tests/generic/278
@@ -82,7 +82,8 @@ md5sum $testdir/file2 | _filter_scratch
 echo "CoW and unmount"
 sync
 _dmerror_load_error_table
-$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $bufsize 0 $filesize" $testdir/file2 \
+	2>&1 >> $seqres.full | _filter_xfs_io_error
 _dmerror_load_working_table
 
 echo "Rewrite"
diff --git a/tests/generic/278.out b/tests/generic/278.out
index 6723b7398f03..9ead4acf7026 100644
--- a/tests/generic/278.out
+++ b/tests/generic/278.out
@@ -5,7 +5,7 @@ Compare files
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-278/file1
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-278/file2
 CoW and unmount
-pwrite64: Input/output error
+pwrite: Input/output error
 Rewrite
 Compare files
 1886e67cf8783e89ce6ddc5bb09a3944  SCRATCH_MNT/test-278/file1
diff --git a/tests/generic/328 b/tests/generic/328
index e0b05504a87b..705368e0d1f3 100755
--- a/tests/generic/328
+++ b/tests/generic/328
@@ -79,11 +79,13 @@ setquota -u fsgqa 0 1024 0 0 $SCRATCH_MNT
 _repquota
 
 echo "Try to dio write the whole file"
-_pwrite_byte 0x62 0 $sz $testdir/file1 -d >> $seqres.full
+_pwrite_byte 0x62 0 $sz $testdir/file1 -d 2>&1 >> $seqres.full | \
+	_filter_xfs_io_error
 _repquota
 
 echo "Try to write the whole file"
-_pwrite_byte 0x62 0 $sz $testdir/file1 >> $seqres.full
+_pwrite_byte 0x62 0 $sz $testdir/file1 2>&1 >> $seqres.full | \
+	_filter_xfs_io_error
 _repquota
 
 echo "Set hard quota to allow rewrite"
diff --git a/tests/generic/328.out b/tests/generic/328.out
index 5e99255acb89..463015111e31 100644
--- a/tests/generic/328.out
+++ b/tests/generic/328.out
@@ -7,11 +7,11 @@ Set hard quota to prevent rewrite
 root      --       0       0       0              4     0     0       
 fsgqa     +-    3072       0    1024              3     0     0       
 Try to dio write the whole file
-pwrite64: Disk quota exceeded
+pwrite: Disk quota exceeded
 root      --       0       0       0              4     0     0       
 fsgqa     +-    3072       0    1024              3     0     0       
 Try to write the whole file
-pwrite64: Disk quota exceeded
+pwrite: Disk quota exceeded
 root      --       0       0       0              4     0     0       
 fsgqa     +-    3072       0    1024              3     0     0       
 Set hard quota to allow rewrite
diff --git a/tests/xfs/071 b/tests/xfs/071
index 12874548db5d..cf69b66b429a 100755
--- a/tests/xfs/071
+++ b/tests/xfs/071
@@ -64,12 +64,12 @@ _filter_off()
 
 _filter_pwrite()
 {
-	sed -e "s/pwrite64: Invalid argument/pwrite64: File too large/g"
+	sed -e "s/pwrite.*: Invalid argument/pwrite: File too large/g"
 }
 
 _filter_pread()
 {
-	sed -e "s/pread64: Invalid argument/read 0\/$bytes bytes at offset <OFFSET>/g" | _filter_io
+	sed -e "s/pread.*: Invalid argument/read 0\/$bytes bytes at offset <OFFSET>/g" | _filter_io
 }
 
 write_block()
diff --git a/tests/xfs/071.out.64 b/tests/xfs/071.out.64
index 2ea0ef02a51e..2b2877ad6aca 100644
--- a/tests/xfs/071.out.64
+++ b/tests/xfs/071.out.64
@@ -40,12 +40,12 @@ read 513/1FSB bytes at offset <OFFSET>
 
 
 Writing 512 bytes, offset is +0 (direct=false)
-pwrite64: File too large
+pwrite: File too large
 Reading 512 bytes (direct=false)
 read 0/512 bytes at offset <OFFSET>
 
 Writing 512 bytes, offset is minus 1 byte (direct=false)
-pwrite64: File too large
+pwrite: File too large
 Reading 512 bytes (direct=false)
 read 0/512 bytes at offset <OFFSET>
 
@@ -60,12 +60,12 @@ Reading 1 bytes (direct=false)
 read 1/1 bytes at offset <OFFSET>
 
 Writing 1FSB bytes, offset is +0 (direct=true)
-pwrite64: File too large
+pwrite: File too large
 Reading 1FSB bytes (direct=true)
 read 0/1FSB bytes at offset <OFFSET>
 
 Writing 1FSB bytes, offset is minus 1FSB (direct=true)
-pwrite64: File too large
+pwrite: File too large
 Reading 1FSB bytes (direct=true)
 read 0/1FSB bytes at offset <OFFSET>
 
@@ -73,32 +73,32 @@ read 0/1FSB bytes at offset <OFFSET>
 
 
 Writing 512 bytes, offset is +0 (direct=false)
-pwrite64: File too large
+pwrite: File too large
 Reading 512 bytes (direct=false)
 read 0/512 bytes at offset <OFFSET>
 
 Writing 512 bytes, offset is minus 1 byte (direct=false)
-pwrite64: File too large
+pwrite: File too large
 Reading 512 bytes (direct=false)
 read 0/512 bytes at offset <OFFSET>
 
 Writing 512 bytes, offset is minus 1FSB (direct=false)
-pwrite64: File too large
+pwrite: File too large
 Reading 512 bytes (direct=false)
 read 0/512 bytes at offset <OFFSET>
 
 Writing 1 bytes, offset is minus 1FSB (direct=false)
-pwrite64: File too large
+pwrite: File too large
 Reading 1 bytes (direct=false)
 read 0/1 bytes at offset <OFFSET>
 
 Writing 1FSB bytes, offset is +0 (direct=true)
-pwrite64: File too large
+pwrite: File too large
 Reading 1FSB bytes (direct=true)
 read 0/1FSB bytes at offset <OFFSET>
 
 Writing 1FSB bytes, offset is minus 1FSB (direct=true)
-pwrite64: File too large
+pwrite: File too large
 Reading 1FSB bytes (direct=true)
 read 0/1FSB bytes at offset <OFFSET>
 
diff --git a/tests/xfs/182 b/tests/xfs/182
index 2545f00362c6..f48a8c748021 100755
--- a/tests/xfs/182
+++ b/tests/xfs/182
@@ -84,8 +84,10 @@ md5sum $testdir/file2 | _filter_scratch
 
 echo "CoW and unmount"
 $XFS_IO_PROG -f -c "cowextsize" $testdir/file2 >> $seqres.full
-$XFS_IO_PROG -d -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $((filesize + 1))" $testdir/file2 >> $seqres.full
-$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $real_blksz 0 $((filesize + 1))" $testdir/file2 >> $seqres.full
+$XFS_IO_PROG -d -f -c "pwrite -R -S 0x63 -b $real_blksz 0 $((filesize + 1))" \
+	$testdir/file2 2>&1 >> $seqres.full | _filter_xfs_io_error
+$XFS_IO_PROG -d -f -c "pwrite -S 0x63 -b $real_blksz 0 $((filesize + 1))" \
+	$testdir/file2 2>&1 >> $seqres.full | _filter_xfs_io_error
 _scratch_cycle_mount
 
 echo "Compare files"
diff --git a/tests/xfs/182.out b/tests/xfs/182.out
index 7b0af93a8978..41384437ad6f 100644
--- a/tests/xfs/182.out
+++ b/tests/xfs/182.out
@@ -5,7 +5,7 @@ Compare files
 2909feb63a37b0e95fe5cfb7f274f7b1  SCRATCH_MNT/test-182/file1
 2909feb63a37b0e95fe5cfb7f274f7b1  SCRATCH_MNT/test-182/file2
 CoW and unmount
-pwrite64: Invalid argument
+pwrite: Invalid argument
 Compare files
 2909feb63a37b0e95fe5cfb7f274f7b1  SCRATCH_MNT/test-182/file1
 c6ba35da9f73ced20d7781a448cc11d4  SCRATCH_MNT/test-182/file2


