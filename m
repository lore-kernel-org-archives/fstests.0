Received: from aserp1040.oracle.com ([141.146.126.69]:29135 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbcGUXqj (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2016 19:46:39 -0400
Subject: [PATCH 02/17] xfs: use rmapbt-checking helper
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 21 Jul 2016 16:46:29 -0700
Message-ID: <146914478956.11762.1523179302392973799.stgit@birch.djwong.org>
In-Reply-To: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

Don't open-code _notrun checks for the rmapbt, just use the helper.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/310 |    4 +---
 tests/xfs/314 |    4 +---
 tests/xfs/317 |    4 +---
 tests/xfs/322 |    4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)


diff --git a/tests/xfs/310 b/tests/xfs/310
index 36b683c..bfdec39 100755
--- a/tests/xfs/310
+++ b/tests/xfs/310
@@ -47,6 +47,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs xfs
 _require_scratch
+_require_xfs_scratch_rmapbt
 _require_xfs_io_command "falloc"
 
 rm -f $seqres.full
@@ -56,9 +57,6 @@ echo "Figure out block size"
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount >> $seqres.full
 
-is_rmap=$(xfs_info $SCRATCH_MNT | grep -c "rmapbt=1")
-test $is_rmap -gt 0 || _notrun "rmap not supported on scratch fs"
-
 testdir=$SCRATCH_MNT/test-$seq
 blksz="$(stat -f $SCRATCH_MNT -c '%S')"
 
diff --git a/tests/xfs/314 b/tests/xfs/314
index 6b867b8..ec16c6f 100755
--- a/tests/xfs/314
+++ b/tests/xfs/314
@@ -48,6 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
+_require_xfs_scratch_rmapbt
 _require_error_injection
 _require_xfs_io_error_injection "rmap_finish_one"
 
@@ -60,9 +61,6 @@ echo "Format filesystem"
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount >> $seqres.full
 
-is_rmap=$(xfs_info $SCRATCH_MNT | grep -c "rmapbt=1")
-test $is_rmap -gt 0 || _notrun "rmap not supported on scratch fs"
-
 echo "Create files"
 _pwrite_byte 0x66 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
 _cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
diff --git a/tests/xfs/317 b/tests/xfs/317
index ac9f3ae..507c2a9 100755
--- a/tests/xfs/317
+++ b/tests/xfs/317
@@ -45,6 +45,7 @@ _cleanup()
 _supported_os Linux
 _supported_fs xfs
 _require_scratch
+_require_xfs_scratch_rmapbt
 _require_error_injection
 _require_xfs_io_error_injection "rmap_finish_one"
 
@@ -57,9 +58,6 @@ echo "Format filesystem"
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount >> $seqres.full
 
-is_rmap=$(xfs_info $SCRATCH_MNT | grep -c "rmapbt=1")
-test $is_rmap -gt 0 || _notrun "rmap not supported on scratch fs"
-
 echo "Create files"
 touch $SCRATCH_MNT/file1
 _pwrite_byte 0x67 0 $sz $SCRATCH_MNT/file0 >> $seqres.full
diff --git a/tests/xfs/322 b/tests/xfs/322
index 0dddb1f..ef402c8 100755
--- a/tests/xfs/322
+++ b/tests/xfs/322
@@ -48,6 +48,7 @@ _supported_os Linux
 _supported_fs xfs
 _require_cp_reflink
 _require_scratch_reflink
+_require_xfs_scratch_rmapbt
 _require_xfs_io_error_injection "rmap_finish_one"
 
 rm -f $seqres.full
@@ -59,9 +60,6 @@ echo "Format filesystem"
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount >> $seqres.full
 
-is_rmap=$(xfs_info $SCRATCH_MNT | grep -c "rmapbt=1")
-test $is_rmap -gt 0 || _notrun "rmap not supported on scratch fs"
-
 echo "Create files"
 _pwrite_byte 0x66 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
 $XFS_IO_PROG -f -c "truncate $sz" $SCRATCH_MNT/file3 >> $seqres.full

