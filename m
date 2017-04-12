Received: from userp1040.oracle.com ([156.151.31.81]:40175 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdDLB2d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Apr 2017 21:28:33 -0400
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH] fstests: remove snapshot aware defrag test
Date: Tue, 11 Apr 2017 18:27:18 -0700
Message-Id: <1491960438-28375-1-git-send-email-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since snapshot aware defrag has been disabled in kernel, and we all have
learned to ignore the failure of btrfs/010, lets just remove it.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
 tests/btrfs/010     | 93 -----------------------------------------------------
 tests/btrfs/010.out |  2 --
 tests/btrfs/group   |  1 -
 3 files changed, 96 deletions(-)
 delete mode 100755 tests/btrfs/010
 delete mode 100644 tests/btrfs/010.out

diff --git a/tests/btrfs/010 b/tests/btrfs/010
deleted file mode 100755
index 6cfc561..0000000
--- a/tests/btrfs/010
+++ /dev/null
@@ -1,93 +0,0 @@
-#! /bin/bash
-# BTRFS QA Test No. 010
-#
-# Test if snapshot-aware defrag can work well on partial extents, ie.
-# extent_offset is not zero.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2013 Oracle.  All Rights Reserved.
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
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-    cd /
-    rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/defrag
-
-# real QA test starts here
-
-# Modify as appropriate.
-_supported_fs btrfs
-_supported_os Linux
-_require_scratch
-
-rm -f $seqres.full
-
-_scratch_mkfs > /dev/null 2>&1
-_scratch_mount
-
-subvol=$SCRATCH_MNT/subvol
-
-$BTRFS_UTIL_PROG subvolume create $subvol >> $seqres.full
-
-for i in `seq 5 -1 1`
-do
-	dd if=/dev/zero of=$subvol/foobar bs=6k count=1 seek=$i conv=notrunc oflag=dsync 2>> $seqres.full
-done
-
-sync
-for i in `seq 2 -1 1`
-do
-	$BTRFS_UTIL_PROG subvolume snapshot $subvol $SCRATCH_MNT/snap-$i >> $seqres.full
-done
-
-$BTRFS_UTIL_PROG filesystem defrag $subvol/foobar && sync
-
-num_extent_orig=`_extent_count $subvol/foobar`
-num_extent_snap1=`_extent_count $SCRATCH_MNT/snap-1/foobar`
-num_extent_snap2=`_extent_count $SCRATCH_MNT/snap-2/foobar`
-
-echo "$num_extent_orig $num_extent_snap1 $num_extent_snap2" >> $seqres.full
-
-# if error
-if [ "x$num_extent_snap1" != "x$num_extent_orig" -o "x$num_extent_snap2" != "x$num_extent_orig" ]; then
-	echo "number of extents mis-match!"
-	exit
-fi
-
-# optional stuff if your test has verbose output to help resolve problems
-#echo
-#echo "If failure, check $seqres.full (this) and $seqres.full.ok (reference)"
-
-# success, all done
-echo "done"
-status=0
-exit
diff --git a/tests/btrfs/010.out b/tests/btrfs/010.out
deleted file mode 100644
index 76b6290..0000000
--- a/tests/btrfs/010.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 010
-done
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 641d826..9d4b80b 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -12,7 +12,6 @@
 007 auto quick rw metadata send
 008 auto quick send
 009 auto quick subvol
-010 auto quick defrag
 011 auto replace
 012 auto convert
 013 auto quick balance
-- 
2.5.0

