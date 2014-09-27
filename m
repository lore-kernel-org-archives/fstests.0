Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:52794 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbaI0WR6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 27 Sep 2014 18:17:58 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/3] ext4: define MKFS_EXT4_PROG and use it instead of "mkfs.ext4" / "mkfs -t ext4"
Date: Sat, 27 Sep 2014 18:17:49 -0400
Message-Id: <1411856271-30789-1-git-send-email-tytso@mit.edu>
In-Reply-To: <20140927221234.GC11222@thunk.org>
References: <20140927221234.GC11222@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/config   | 1 +
 common/rc       | 7 +++++--
 tests/btrfs/012 | 1 -
 tests/ext4/003  | 2 +-
 tests/ext4/306  | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/common/config b/common/config
index fc21b37..d68d4d0 100644
--- a/common/config
+++ b/common/config
@@ -210,6 +210,7 @@ case "$HOSTOS" in
         ;;
     Linux)
         export MKFS_XFS_PROG="`set_prog_path mkfs.xfs`"
+        export MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
         export MKFS_UDF_PROG="`set_prog_path mkudffs`"
         export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
diff --git a/common/rc b/common/rc
index b8f711a..35d7d5d 100644
--- a/common/rc
+++ b/common/rc
@@ -105,6 +105,9 @@ case "$FSTYP" in
     btrfs)
 	 [ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
 	 ;;
+    ext4)
+	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
+	 ;;
     nfs)
 	 ;;
     cifs)
@@ -459,7 +462,7 @@ _scratch_mkfs_ext4()
 
 	local tmp_dir=/tmp/
 
-	/sbin/mkfs -t ext4 -- -F $MKFS_OPTIONS $extra_mkfs_options $SCRATCH_DEV \
+	$MKFS_EXT4_PROG -F $MKFS_OPTIONS $extra_mkfs_options $SCRATCH_DEV \
 			2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 	local mkfs_status=$?
 
@@ -474,7 +477,7 @@ _scratch_mkfs_ext4()
 		) >> $seqres.full
 
 		# running mkfs again. overwrite previous mkfs output files
-		/sbin/mkfs -t ext4 -- -F $extra_mkfs_options $SCRATCH_DEV \
+		$MKFS_EXT4_PROG -F $extra_mkfs_options $SCRATCH_DEV \
 				2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 		local mkfs_status=$?
 	fi
diff --git a/tests/btrfs/012 b/tests/btrfs/012
index f7e5da5..124c8ae 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -55,7 +55,6 @@ _supported_os Linux
 _require_scratch
 
 BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
-MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
 E2FSCK_PROG="`set_prog_path e2fsck`"
 
 _require_command $BTRFS_CONVERT_PROG btrfs-convert
diff --git a/tests/ext4/003 b/tests/ext4/003
index 572e685..fde0e9c 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -43,7 +43,7 @@ _require_ext4_bigalloc
 
 rm -f $seqres.full
 
-yes | mkfs.ext4 -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
+yes | $MKFS_EXT4_PROG -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
 	>> $seqres.full 2>&1
 _scratch_mount || _fail "couldn't mount fs"
 
diff --git a/tests/ext4/306 b/tests/ext4/306
index fd50b0e..caffe0e 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -48,7 +48,7 @@ _require_scratch
 rm -f $seqres.full
 
 # Make a small ext4 fs with extents disabled & mount it
-yes | mkfs.ext4 -O ^extents,^64bit $SCRATCH_DEV 512m >> $seqres.full 2>&1
+yes | $MKFS_EXT4_PROG -O ^extents,^64bit $SCRATCH_DEV 512m >> $seqres.full 2>&1
 _scratch_mount || _fail "couldn't mount fs"
 
 # Create a small non-extent-based file
-- 
2.1.0

