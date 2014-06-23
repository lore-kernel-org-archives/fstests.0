Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20848 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbaFWOyX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 Jun 2014 10:54:23 -0400
From: Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 1/2] xfstests: Introduce get_block_size() helper
Date: Mon, 23 Jun 2014 16:54:14 +0200
Message-Id: <1403535255-14601-1-git-send-email-lczerner@redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: fdmanana@gmail.com, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Currently many tests and other functions uses it's own way to get block
size of the file system. Introduce get_block_size(), a generic way to
get block size of mounted file system and use that instead.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 common/attr       | 4 ++--
 common/punch      | 2 +-
 common/rc         | 9 +++++++++
 tests/generic/240 | 2 +-
 tests/generic/256 | 2 +-
 tests/generic/308 | 2 +-
 tests/shared/298  | 2 +-
 7 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/common/attr b/common/attr
index 42a1a16..4c70c9e 100644
--- a/common/attr
+++ b/common/attr
@@ -251,7 +251,7 @@ _sort_getfattr_output()
 if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" ]; then
 	MAX_ATTRS=1000
 else # Assume max ~1 block of attrs
-	BLOCK_SIZE=`stat -f $TEST_DIR | grep "Block size" | cut -d " " -f3`
+	BLOCK_SIZE=`get_block_size $TEST_DIR`
 	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
 	let MAX_ATTRS=$BLOCK_SIZE/40
 fi
@@ -262,7 +262,7 @@ export MAX_ATTRS
 if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" -o "$FSTYP" == "btrfs" ]; then
 	MAX_ATTRVAL_SIZE=64
 else # Assume max ~1 block of attrs
-	BLOCK_SIZE=`stat -f $TEST_DIR | grep "Block size" | cut -d " " -f3`
+	BLOCK_SIZE=`get_block_size $TEST_DIR`
 	# leave a little overhead
 	let MAX_ATTRVAL_SIZE=$BLOCK_SIZE-256
 fi
diff --git a/common/punch b/common/punch
index f2d538c..237b4d8 100644
--- a/common/punch
+++ b/common/punch
@@ -557,7 +557,7 @@ _test_generic_punch()
 	if [ "$remove_testfile" ]; then
 		rm -f $testfile
 	fi
-	block_size=`stat -f $TEST_DIR | grep "Block size" | cut -d " " -f3`
+	block_size=`get_block_size $TEST_DIR`
 	$XFS_IO_PROG -f -c "truncate $block_size" \
 		-c "pwrite 0 $block_size" $sync_cmd \
 		-c "$zero_cmd 128 128" \
diff --git a/common/rc b/common/rc
index 2c83340..95030ae 100644
--- a/common/rc
+++ b/common/rc
@@ -2281,6 +2281,15 @@ _short_dev()
 	echo `basename $(_real_dev $1)`
 }
 
+get_block_size()
+{
+	if [ -z $1 ] || [ ! -d $1 ]; then
+		echo "Missing mount point argument for get_block_size"
+		exit 1
+	fi
+	echo `stat -f -c %S $1`
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/240 b/tests/generic/240
index 74dbba6..44ba0d3 100755
--- a/tests/generic/240
+++ b/tests/generic/240
@@ -61,7 +61,7 @@ rm -f $seqres.full
 rm -f $TEST_DIR/aiodio_sparse
 
 logical_block_size=`_min_dio_alignment $TEST_DEV`
-fs_block_size=`stat -f $TEST_DIR | grep "Block size:" | awk '{print $3}'`
+fs_block_size=`get_block_size $TEST_DIR`
 file_size=$((8 * $fs_block_size))
 
 if [ $fs_block_size -le $logical_block_size ]; then
diff --git a/tests/generic/256 b/tests/generic/256
index e6cc7dc..92c4f30 100755
--- a/tests/generic/256
+++ b/tests/generic/256
@@ -170,7 +170,7 @@ _scratch_mount
 # Test must be able to write files with non-root permissions
 chmod 777 $SCRATCH_MNT
 
-block_size=`stat -f $SCRATCH_DEV | grep "Block size" | cut -d " " -f3`
+block_size=`get_block_size $SCRATCH_MNT`
 _test_full_fs_punch $(( $block_size * 2 )) $block_size 500 $SCRATCH_MNT/252.$$ $block_size
 
 status=0 ; exit
diff --git a/tests/generic/308 b/tests/generic/308
index 8037c08..5646486 100755
--- a/tests/generic/308
+++ b/tests/generic/308
@@ -48,7 +48,7 @@ _supported_os Linux
 rm -f $seqres.full
 echo "Silence is golden"
 
-block_size=`stat -f -c %s $TEST_DIR`
+block_size=`get_block_size $TEST_DIR`
 
 # On unpatched ext4, if an extent exists which includes the block right
 # before the maximum file offset, and the block for the maximum file offset
diff --git a/tests/shared/298 b/tests/shared/298
index 8211da3..c1a6316 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -164,7 +164,7 @@ echo "done."
 
 echo -n "Comparing holes to the reported space from FS..."
 # Get block size
-block_size=$(stat -f -c "%S" $loop_mnt/)
+block_size=$(get_block_size $loop_mnt/)
 sectors_per_block=`expr $block_size / 512`
 
 # Obtain free space from filesystem
-- 
1.8.3.1

