Received: from imap.thunk.org ([74.207.234.97]:36942 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdKLNg0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 12 Nov 2017 08:36:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common: rework _require_ext4_mkfs_feature
Date: Sun, 12 Nov 2017 08:36:21 -0500
Message-Id: <20171112133621.2474-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

In all of the places where we need check to see if mkfs.ext4 can
support a set of file system features, we also should be checking to
see if the kernel can support those file system features.  So rename
_require_ext4_mkfs_feature to _require_ext4_feature, and actually
format the file system in $SCRATCH.  To avoid running mkfs twice in
most tests, we will teach the tests to assume that
_require_ext4_feature actually leaves $SCRATCH formatted with a file
system with those features.

Also remove a completely unneeded _require_ext4_mkfs_feature "64bit"
from ext4/306.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

This is a replacement for "ext4/026: skip test if kernel does not
support the ea_inode feature"

 common/rc      | 28 ++++++++++------------------
 tests/ext4/003 |  3 +--
 tests/ext4/025 |  3 +--
 tests/ext4/026 |  3 +--
 tests/ext4/306 |  1 -
 5 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/common/rc b/common/rc
index da6213a0..3febf16f 100644
--- a/common/rc
+++ b/common/rc
@@ -1899,31 +1899,23 @@ _require_scratch_ext4_crc()
 	_scratch_unmount
 }
 
-# Check the specified feature whether it is available in mkfs.ext4 or not.
-_require_ext4_mkfs_feature()
+# Check whether the specified feature whether it is supported by
+# mkfs.ext4 and the kernel.
+_require_ext4_feature()
 {
-	local feature=$1
-	local testfile=/tmp/$$.ext4_mkfs
+	local feature="$1"
+	local sz="$2"
 
 	if [ -z "$feature" ]; then
-                echo "Usage: _require_ext4_mkfs_feature feature"
+                echo "Usage: _require_ext4_feature feature"
                 exit 1
         fi
 
-	touch $testfile
-	local result=$($MKFS_EXT4_PROG -F -O $feature -n $testfile 512m 2>&1)
-	rm -f $testfile
-	echo $result | grep -q "Invalid filesystem option" && \
-		_notrun "mkfs.ext4 doesn't support $feature feature"
-}
-
-# this test requires the ext4 kernel support bigalloc feature
-#
-_require_ext4_bigalloc()
-{
-	$MKFS_EXT4_PROG -F -O bigalloc $SCRATCH_DEV 512m >/dev/null 2>&1
+	$MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$feature" \
+	    $SCRATCH_DEV $sz >>$seqres.full 2>&1 \
+		|| _notrun "mkfs.ext4 doesn't support $feature feature"
 	_scratch_mount >/dev/null 2>&1 \
-	   || _notrun "Ext4 kernel doesn't support bigalloc feature"
+		|| _notrun "Kernel doesn't support the ext4 feature: $feature"
 	_scratch_unmount
 }
 
diff --git a/tests/ext4/003 b/tests/ext4/003
index 9be40178..2498632f 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -38,8 +38,7 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
-_require_ext4_mkfs_feature "bigalloc"
-_require_ext4_bigalloc
+_require_ext4_feature "bigalloc" "512m"
 
 rm -f $seqres.full
 
diff --git a/tests/ext4/025 b/tests/ext4/025
index 49ecb462..013c1940 100755
--- a/tests/ext4/025
+++ b/tests/ext4/025
@@ -48,10 +48,9 @@ _supported_fs ext4
 _supported_os Linux
 _require_scratch_nocheck
 _require_command "$DEBUGFS_PROG" debugfs
-_require_ext4_mkfs_feature "bigalloc,meta_bg,^resize_inode"
+_require_ext4_feature "bigalloc,meta_bg,^resize_inode"
 
 echo "Create ext4 fs and modify first_meta_bg's value"
-_scratch_mkfs "-O bigalloc,meta_bg,^resize_inode" >> $seqres.full 2>&1
 
 # set a big enough first_meta_bg to trigger buffer overrun
 # 842150400 is from original fuzzed ext4 image in bug report
diff --git a/tests/ext4/026 b/tests/ext4/026
index 94a737ce..828b9b89 100755
--- a/tests/ext4/026
+++ b/tests/ext4/026
@@ -50,9 +50,8 @@ _supported_fs ext4
 _supported_os Linux
 _require_scratch
 _require_attrs
-_require_ext4_mkfs_feature ea_inode
+_require_ext4_feature "ea_inode"
 
-_scratch_mkfs_ext4 -O ea_inode >/dev/null 2>&1
 _scratch_mount
 
 # Sets an extended attribute on a file.
diff --git a/tests/ext4/306 b/tests/ext4/306
index be765e6a..fa3b782d 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -44,7 +44,6 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
-_require_ext4_mkfs_feature "64bit"
 
 rm -f $seqres.full
 
-- 
2.11.0.rc0.7.gbe5a750

