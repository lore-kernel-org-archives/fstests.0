Received: from userp2120.oracle.com ([156.151.31.85]:33736 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeIJIRT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Sep 2018 04:17:19 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] fstests: btrfs/149 make it sectorsize independent
Date: Mon, 10 Sep 2018 11:25:18 +0800
Message-Id: <1536549918-7249-1-git-send-email-anand.jain@oracle.com>
In-Reply-To: <1536129312-18788-1-git-send-email-anand.jain@oracle.com>
References: <1536129312-18788-1-git-send-email-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Originally this test case was designed to work with only 4K sectorsize.
Now enhance it to work with any sector sizes and makes the following
changes:
Output file not to contain any traces of sector size.
Use max_inline=0 mount option so that it meets the requisite of non inline
regular extent.
Don't log the md5sum results to the output file as the data size vary by
the sectorsize.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1->v2: rename _scratch_sectorsize() to _scratch_btrfs_sectorsize()
	add _require_btrfs_command inspect-internal dump-super

 common/btrfs        |  7 +++++++
 common/filter       |  5 +++++
 tests/btrfs/149     | 30 +++++++++++++++++++++---------
 tests/btrfs/149.out | 12 ++++++------
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 79c687f73376..26dc0bb9600f 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -367,3 +367,10 @@ _run_btrfs_balance_start()
 
 	run_check $BTRFS_UTIL_PROG balance start $bal_opt $*
 }
+
+#return the sector size of the btrfs scratch fs
+_scratch_btrfs_sectorsize()
+{
+	$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
+		grep sectorsize | awk '{print $2}'
+}
diff --git a/common/filter b/common/filter
index 3965c2eb752b..e87740ddda3f 100644
--- a/common/filter
+++ b/common/filter
@@ -271,6 +271,11 @@ _filter_xfs_io_pages_modified()
 	_filter_xfs_io_units_modified "Page" $PAGE_SIZE
 }
 
+_filter_xfs_io_numbers()
+{
+        _filter_xfs_io | sed -E 's/[0-9]+/XXXX/g'
+}
+
 _filter_test_dir()
 {
 	# TEST_DEV may be a prefix of TEST_DIR (e.g. /mnt, /mnt/ovl-mnt)
diff --git a/tests/btrfs/149 b/tests/btrfs/149
index 3e955a305e0f..9b0f00b0ed81 100755
--- a/tests/btrfs/149
+++ b/tests/btrfs/149
@@ -36,6 +36,7 @@ _require_test
 _require_scratch
 _require_scratch_reflink
 _require_odirect
+_require_btrfs_command inspect-internal dump-super
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
@@ -44,21 +45,27 @@ rm -fr $send_files_dir
 mkdir $send_files_dir
 
 _scratch_mkfs >>$seqres.full 2>&1
-_scratch_mount "-o compress"
+# On 64K pagesize systems the compression is more efficient, so max_inline
+# helps to create regular (non inline) extent irrespective of the final
+# write size.
+_scratch_mount "-o compress -o max_inline=0"
 
 # Write to our file using direct IO, so that this way the write ends up not
 # getting compressed, that is, we get a regular extent which is neither
 # inlined nor compressed.
 # Alternatively, we could have mounted the fs without compression enabled,
 # which would result as well in an uncompressed regular extent.
-$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4K" $SCRATCH_MNT/foobar | _filter_xfs_io
+sectorsize=$(_scratch_btrfs_sectorsize)
+$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 $sectorsize" $SCRATCH_MNT/foobar |\
+	_filter_xfs_io_numbers
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 	$SCRATCH_MNT/mysnap1 > /dev/null
 
 # Clone the regular (not inlined) extent.
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foobar 0 8K 4K" $SCRATCH_MNT/foobar \
-	| _filter_xfs_io
+$XFS_IO_PROG -c \
+	"reflink $SCRATCH_MNT/foobar 0 $((2 * $sectorsize)) $sectorsize" \
+	$SCRATCH_MNT/foobar | _filter_xfs_io_numbers
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 	$SCRATCH_MNT/mysnap2 > /dev/null
@@ -76,21 +83,26 @@ $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 		 $SCRATCH_MNT/mysnap2 2>&1 >/dev/null | _filter_scratch
 
 echo "File digests in the original filesystem:"
-md5sum $SCRATCH_MNT/mysnap1/foobar | _filter_scratch
-md5sum $SCRATCH_MNT/mysnap2/foobar | _filter_scratch
+sum_src_snap1=$(md5sum $SCRATCH_MNT/mysnap1/foobar | awk '{print $1}')
+sum_src_snap2=$(md5sum $SCRATCH_MNT/mysnap2/foobar | awk '{print $1}')
+echo "src checksum created"
 
 # Now recreate the filesystem by receiving both send streams and verify we get
 # the same file content that the original filesystem had.
 _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
-_scratch_mount "-o compress"
+_scratch_mount "-o compress,max_inline=0"
 
 $BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
 $BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
 
 echo "File digests in the new filesystem:"
-md5sum $SCRATCH_MNT/mysnap1/foobar | _filter_scratch
-md5sum $SCRATCH_MNT/mysnap2/foobar | _filter_scratch
+sum_dest_snap1=$(md5sum $SCRATCH_MNT/mysnap1/foobar | awk '{print $1}')
+sum_dest_snap2=$(md5sum $SCRATCH_MNT/mysnap2/foobar | awk '{print $1}')
+echo "dest checksum created"
+
+[[ $sum_src_snap1 == $sum_dest_snap1 ]] && echo "src and dest checksum matched"
+[[ $sum_src_snap2 == $sum_dest_snap2 ]] && echo "src and dest checksum matched"
 
 status=0
 exit
diff --git a/tests/btrfs/149.out b/tests/btrfs/149.out
index 303de928d35a..6ba251799ff2 100644
--- a/tests/btrfs/149.out
+++ b/tests/btrfs/149.out
@@ -1,14 +1,14 @@
 QA output created by 149
-wrote 4096/4096 bytes at offset 0
+wrote XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-linked 4096/4096 bytes at offset 8192
+linked XXXX/XXXX bytes at offset XXXX
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 At subvol SCRATCH_MNT/mysnap1
 At subvol SCRATCH_MNT/mysnap2
 File digests in the original filesystem:
-1696b8fe138e867797eb6683cf13d99c  SCRATCH_MNT/mysnap1/foobar
-28feb14349a6f6c67a11967278ed7359  SCRATCH_MNT/mysnap2/foobar
+src checksum created
 At subvol mysnap1
 File digests in the new filesystem:
-1696b8fe138e867797eb6683cf13d99c  SCRATCH_MNT/mysnap1/foobar
-28feb14349a6f6c67a11967278ed7359  SCRATCH_MNT/mysnap2/foobar
+dest checksum created
+src and dest checksum matched
+src and dest checksum matched
-- 
1.8.3.1
