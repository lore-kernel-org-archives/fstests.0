Received: from cn.fujitsu.com ([222.73.24.84]:17078 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1754124AbcLTBZl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 19 Dec 2016 20:25:41 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: btrfs: Remove btrfs/047 since upstream don't accept stream-version
Date: Tue, 20 Dec 2016 09:24:56 +0800
Message-Id: <20161220012456.19363-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Btrfs upstream doesn't accept stream-version, so the test is never ran
on upstream kernel nor btrfs-progs.

Just remove it.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/btrfs        |  14 ------
 tests/btrfs/047     | 120 ----------------------------------------------------
 tests/btrfs/047.out |  35 ---------------
 tests/btrfs/group   |   1 -
 4 files changed, 170 deletions(-)
 delete mode 100755 tests/btrfs/047
 delete mode 100644 tests/btrfs/047.out

diff --git a/common/btrfs b/common/btrfs
index 237bb3d..c821d54 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -53,20 +53,6 @@ _run_btrfs_util_prog()
 	run_check $BTRFS_UTIL_PROG $*
 }
 
-_require_btrfs_send_stream_version()
-{
-	$BTRFS_UTIL_PROG send 2>&1 | \
-		grep '^[ \t]*\-\-stream\-version <version>' > /dev/null 2>&1
-	if [ $? -ne 0 ]; then
-		_notrun "Missing btrfs-progs send --stream-version command line option, skipped this test"
-	fi
-
-	# test if btrfs kernel supports send stream version 2
-	if [ ! -f /sys/fs/btrfs/send/stream_version ]; then
-		_notrun "Missing btrfs kernel patch for send stream version 2, skipped this test"
-	fi
-}
-
 _require_btrfs_mkfs_feature()
 {
 	if [ -z $1 ]; then
diff --git a/tests/btrfs/047 b/tests/btrfs/047
deleted file mode 100755
index 6d7d351..0000000
--- a/tests/btrfs/047
+++ /dev/null
@@ -1,120 +0,0 @@
-#! /bin/bash
-# FS QA Test No. btrfs/047
-#
-# Verify that after an incremental btrfs send the replicated file has
-# the same exact hole and data structure as in the origin filesystem.
-# This didn't use to be the case before the send stream version 2 -
-# holes were sent as write operations of 0 valued bytes instead of punching
-# holes with the fallocate system call, and pre-allocated extents were sent
-# as well as write operations of 0 valued bytes instead of intructions for
-# the receiver to use the fallocate system call. Also check that prealloc
-# extents that lie beyond the file's size are replicated by an incremental
-# send.
-#
-# More specifically, this structure preserving guarantee was added by the
-# following linux kernel commits:
-#
-#    Btrfs: send, use fallocate command to punch holes
-#    Btrfs: send, use fallocate command to allocate extents
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2014 Filipe Manana.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-    rm -fr $send_files_dir
-    rm -fr $tmp
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/punch
-
-# real QA test starts here
-_supported_fs btrfs
-_supported_os Linux
-_require_test
-_require_scratch
-_require_fssum
-_require_xfs_io_command "fiemap"
-_require_btrfs_send_stream_version
-
-send_files_dir=$TEST_DIR/btrfs-test-$seq
-
-rm -f $seqres.full
-rm -fr $send_files_dir
-mkdir $send_files_dir
-
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-$XFS_IO_PROG -f -c "pwrite -S 0x01 -b 300000 0 300000" $SCRATCH_MNT/foo \
-	| _filter_xfs_io
-
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
-
-$XFS_IO_PROG -c "fpunch 100000 50000" $SCRATCH_MNT/foo
-$XFS_IO_PROG -c "falloc 100000 50000" $SCRATCH_MNT/foo
-$XFS_IO_PROG -c "pwrite -S 0xff -b 1000 120000 1000" $SCRATCH_MNT/foo \
-	| _filter_xfs_io
-$XFS_IO_PROG -c "fpunch 250000 20000" $SCRATCH_MNT/foo
-
-$XFS_IO_PROG -c "falloc -k 300000 1000000" $SCRATCH_MNT/foo
-$XFS_IO_PROG -c "falloc -k 9000000 2000000" $SCRATCH_MNT/foo
-
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
-
-_run_btrfs_util_prog send --stream-version 2 $SCRATCH_MNT/mysnap1 \
-	-f $send_files_dir/1.snap
-_run_btrfs_util_prog send --stream-version 2 -p $SCRATCH_MNT/mysnap1 \
-	$SCRATCH_MNT/mysnap2 -f $send_files_dir/2.snap
-
-md5sum $SCRATCH_MNT/mysnap2/foo | _filter_scratch
-# List all hole and data segments.
-$XFS_IO_PROG -r -c "seek -r -a 0" $SCRATCH_MNT/mysnap2/foo
-# List all extents, we're interested here in prealloc extents that lie beyond
-# the file's size.
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/mysnap2/foo | _filter_fiemap
-
-_scratch_unmount
-_check_scratch_fs
-
-_scratch_mkfs >/dev/null 2>&1
-_scratch_mount
-
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
-_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
-
-md5sum $SCRATCH_MNT/mysnap2/foo | _filter_scratch
-# List all hole and data segments.
-$XFS_IO_PROG -r -c "seek -r -a 0" $SCRATCH_MNT/mysnap2/foo
-# List all extents, we're interested here in prealloc extents that lie beyond
-# the file's size.
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/mysnap2/foo | _filter_fiemap
-
-status=0
-exit
diff --git a/tests/btrfs/047.out b/tests/btrfs/047.out
deleted file mode 100644
index be39edc..0000000
--- a/tests/btrfs/047.out
+++ /dev/null
@@ -1,35 +0,0 @@
-QA output created by 047
-wrote 300000/300000 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 1000/1000 bytes at offset 120000
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-5a88aa0da62c8999c16515050947a70a  SCRATCH_MNT/mysnap2/foo
-Whence	Result
-DATA	0
-HOLE	102400
-DATA	118784
-HOLE	122880
-DATA	147456
-HOLE	253952
-DATA	266240
-HOLE	300000
-0: [0..495]: data
-1: [496..519]: hole
-2: [520..2543]: data
-3: [2544..17575]: hole
-4: [17576..21487]: data
-5a88aa0da62c8999c16515050947a70a  SCRATCH_MNT/mysnap2/foo
-Whence	Result
-DATA	0
-HOLE	102400
-DATA	118784
-HOLE	122880
-DATA	147456
-HOLE	253952
-DATA	266240
-HOLE	300000
-0: [0..495]: data
-1: [496..519]: hole
-2: [520..2543]: data
-3: [2544..17575]: hole
-4: [17576..21487]: data
diff --git a/tests/btrfs/group b/tests/btrfs/group
index b4e4ff2..3fbf706 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -49,7 +49,6 @@
 044 auto quick send
 045 auto quick send
 046 auto quick send
-047 auto quick send
 048 auto quick
 049 auto quick
 050 auto quick send
-- 
2.10.2



