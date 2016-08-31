Received: from cn.fujitsu.com ([222.73.24.84]:50016 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S933428AbcHaLzC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 31 Aug 2016 07:55:02 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] generic/172: raise fs size
Date: Wed, 31 Aug 2016 19:50:55 +0800
Message-Id: <20160831115055.2294-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

In original codes, if block size is 4096, fs size will be limited
to 60MB. In such small fs, btrfs is not able to write 40MB data,
because some space has been reserved internally, so the first
_pwrite_byte in this test case will fail for enospc error.

Also from this test case's test purpose, it tries to reflink a file
that uses more than half of the fs space, so here we can just define
fs size to be 256MB, the file to be reflinked to be 168MB.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/generic/172 | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tests/generic/172 b/tests/generic/172
index 26fb305..8192290 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -57,31 +57,27 @@ testdir=$SCRATCH_MNT/test-$seq
 mkdir $testdir
 
 echo "Reformat with appropriate size"
-blksz="$(stat -f $testdir -c '%S')"
-nr_blks=10240
 umount $SCRATCH_MNT
-sz_bytes=$((nr_blks * 3 / 2 * blksz))
-if [ $sz_bytes -lt $((32 * 1048576)) ]; then
-	sz_bytes=$((32 * 1048576))
-fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+
+file_size=$((168 * 1024 * 1024))
+fs_size=$((256 * 1024 * 1024))
+_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
 
 echo "Create a big file and reflink it"
-_pwrite_byte 0x61 0 $((blksz * nr_blks)) $testdir/bigfile >> $seqres.full 2>&1
+_pwrite_byte 0x61 0 $file_size $testdir/bigfile >> $seqres.full 2>&1
 _cp_reflink $testdir/bigfile $testdir/clonefile
 sync
 
 echo "Allocate the rest of the space"
-nr_free=$(stat -f -c '%f' $testdir)
 touch $testdir/file0 $testdir/file1
-_pwrite_byte 0x61 0 $((blksz * nr_free)) $testdir/eat_my_space >> $seqres.full 2>&1
+_pwrite_byte 0x61 0 $fs_size $testdir/eat_my_space >> $seqres.full 2>&1
 sync
 
 echo "CoW the big file"
-out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1)"
+out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
 echo ${out}
@@ -89,7 +85,7 @@ echo ${out}
 echo "Remount and try CoW again"
 _scratch_cycle_mount
 
-out="$(_pwrite_byte 0x62 0 $((blksz * nr_blks)) $testdir/bigfile 2>&1)"
+out="$(_pwrite_byte 0x62 0 $file_size $testdir/bigfile 2>&1)"
 echo ${out} | grep -q "No space left on device" || echo "CoW should have failed with ENOSPC"
 echo ${out} >> $seqres.full 2>&1
 echo ${out}
-- 
2.9.0



