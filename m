Received: from imap.thunk.org ([74.207.234.97]:59210 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbeETTqV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 20 May 2018 15:46:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic: drop test 472
Date: Sun, 20 May 2018 15:46:08 -0400
Message-Id: <20180520194608.12198-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: rgoldwyn@suse.de, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

>From Goldwyn Rodrigues <rgoldwyn@suse.de>:

   "From earlier discussions, In between errors of a direct I/O cannot
   be handled correctly and may need a lot of tracking that it is not
   worth performing.

   It would be better to drop this test case and add in the documentation
   that a direct I/O error could mean that the write() may or may not have
   occurred and underlying data may be inconsistent."

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/472     | 96 ---------------------------------------------------
 tests/generic/472.out |  9 -----
 tests/generic/group   |  1 -
 3 files changed, 106 deletions(-)
 delete mode 100755 tests/generic/472
 delete mode 100644 tests/generic/472.out

diff --git a/tests/generic/472 b/tests/generic/472
deleted file mode 100755
index a1326926..00000000
--- a/tests/generic/472
+++ /dev/null
@@ -1,96 +0,0 @@
-#! /bin/bash
-# FS QA Test No. 472
-#
-# write() to a file opened with O_DIRECT with count > remaining
-# bytes. In case of a bug, the write returns ENOSPC wheras the
-# showing no data is written, but the file contents are updated.
-# Result should be the write should return remaining bytes
-# (to aligned bytes) instead of ENOSPC error.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
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
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1    # failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-    cd /
-    rm -rf $tmp.* $testdir1
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/populate
-. ./common/filter
-. ./common/attr
-
-# real QA test starts here
-_supported_os Linux
-_require_odirect
-_require_xfs_io_command pwrite -O
-_require_scratch
-
-rm -f $seqres.full
-
-echo "Reformat with 320M size"
-sz_bytes=$((320 * 1024 * 1024))
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
-_scratch_mount >> $seqres.full 2>&1
-testdir=$SCRATCH_MNT/$seq
-mkdir $testdir
-
-# Reserve some space to remove later
-$XFS_IO_PROG -f -c "pwrite 0 2M" $testdir/reserve > /dev/null
-
-mkdir $testdir/fillspace
-echo "Fill the filesystem"
-_fill_fs $(( 1024 * 1024 * 1024 )) $testdir/fillspace 4096 0 > /dev/null 2>&1
-
-# Remove the reserve file to work on almost full filesystem
-rm $testdir/reserve
-sync
-
-# Create a file using buffered I/O which succeeds only partially
-$XFS_IO_PROG -f -c "pwrite -w -S 0xaa 0 4M" $testdir/partial
-
-# re-write using direct I/O with another pattern using one single buffer, once
-write_size=`$XFS_IO_PROG -d -c "pwrite -O -S 0xbb -V 1 -b 4M 0 4M" $testdir/partial | \
-	$AWK_PROG '/^wrote/ {split($2, bytes, "/"); print bytes[1]}'`
-if [ -z $write_size ]; then
-	write_size=0
-fi
-
-# If bug is not fixed, pwrite will return error and but still write data
-if [ $write_size -gt 0 ]; then
-	echo "pwrite wrote more than zero bytes."
-else
-	echo "pwrite wrote zero bytes"
-fi
-
-# read the partial file to check if data written is of last write
-$XFS_IO_PROG -c "pread 0 1M -v" $testdir/partial | _filter_xfs_io_unique
-
-# success, all done
-status=0
-exit
diff --git a/tests/generic/472.out b/tests/generic/472.out
deleted file mode 100644
index ba018d03..00000000
--- a/tests/generic/472.out
+++ /dev/null
@@ -1,9 +0,0 @@
-QA output created by 472
-Reformat with 320M size
-Fill the filesystem
-pwrite: No space left on device
-pwrite wrote more than zero bytes.
-00000000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
-*
-read 1048576/1048576 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index 659910c6..3bcd07c4 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -474,7 +474,6 @@
 469 auto quick
 470 auto quick dax
 471 auto quick rw
-472 rw
 473 broken
 474 auto quick shutdown metadata
 475 shutdown auto log metadata
-- 
2.16.1.72.g5be1f00a9a

