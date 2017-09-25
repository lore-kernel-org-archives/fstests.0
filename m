Received: from mx1.redhat.com ([209.132.183.28]:43144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933296AbdIYIlS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Sep 2017 04:41:18 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v5 3/3] xfs/260: remove per-inode DAX flag test
Date: Mon, 25 Sep 2017 16:40:47 +0800
Message-Id: <1506328847-1669-4-git-send-email-xzhou@redhat.com>
In-Reply-To: <1506328847-1669-1-git-send-email-xzhou@redhat.com>
References: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1506328847-1669-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

This flag has been disabled upstream kernel.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/xfs/260     | 158 ------------------------------------------------------
 tests/xfs/260.out |   2 -
 tests/xfs/group   |   1 -
 3 files changed, 161 deletions(-)
 delete mode 100755 tests/xfs/260
 delete mode 100644 tests/xfs/260.out

diff --git a/tests/xfs/260 b/tests/xfs/260
deleted file mode 100755
index e613cc0..0000000
--- a/tests/xfs/260
+++ /dev/null
@@ -1,158 +0,0 @@
-#! /bin/bash
-# FS QA Test 260
-#
-# Test per-inode DAX flag by mmap direct/buffered IO.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# remove previous $seqres.full before test
-rm -f $seqres.full
-
-_supported_fs xfs
-_supported_os Linux
-_require_scratch_dax
-_require_test_program "feature"
-_require_test_program "t_mmap_dio"
-_require_xfs_io_command "chattr" "+/-x"
-_require_xfs_io_command "falloc"
-
-prep_files()
-{
-	rm -f $SCRATCH_MNT/tf_{s,d}
-
-	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
-		$SCRATCH_MNT/tf_{s,d} >> $seqres.full 2>&1
-}
-
-t_both_dax()
-{
-	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
-	# with O_DIRECT first
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
-
-	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
-	# again with buffered IO
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
-		$1 "buffered both dax"
-}
-
-t_nondax_to_dax()
-{
-	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
-		$1 "dio nondax to dax"
-
-	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
-		$1 "buffered nondax to dax"
-}
-
-t_dax_to_nondax()
-{
-	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
-		$1 "dio dax to nondax"
-
-	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
-		$1 "buffered dax to nondax"
-}
-
-t_both_nondax()
-{
-	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
-	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
-		$1 "dio both nondax"
-
-	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
-	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
-		$1 "buffered both nondax"
-}
-
-# $1 mmap read/write size
-t_dax_flag_mmap_dio()
-{
-	t_both_dax $1
-	t_dax_to_nondax $1
-	t_nondax_to_dax $1
-	t_both_nondax $1
-}
-
-do_tests()
-{
-	# less than page size
-	t_dax_flag_mmap_dio 1024
-	# page size
-	t_dax_flag_mmap_dio `src/feature -s`
-	# bigger sizes, for PMD faults
-	t_dax_flag_mmap_dio $((16 * 1024 * 1024))
-	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
-}
-
-# make xfs 2Mb aligned for PMD fault testing
-_scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
-
-# mount with dax option
-_scratch_mount "-o dax"
-
-tsize=$((128 * 1024 * 1024))
-
-do_tests
-_scratch_unmount
-
-# mount again without dax option
-export MOUNT_OPTIONS=""
-_scratch_mount
-do_tests
-
-# success, all done
-echo "Silence is golden"
-status=0
-exit
diff --git a/tests/xfs/260.out b/tests/xfs/260.out
deleted file mode 100644
index 18ca517..0000000
--- a/tests/xfs/260.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 260
-Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index 0a449b9..2b89f0e 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -256,7 +256,6 @@
 257 auto quick clone
 258 auto quick clone
 259 auto quick
-260 auto attr quick
 261 auto quick quota
 262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 263 auto quick quota
-- 
1.8.3.1

