Received: from imap.thunk.org ([74.207.234.97]:56580 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdLJR5g (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 10 Dec 2017 12:57:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RESEND -v4] common: rework _require_ext4_mkfs_feature
Date: Sun, 10 Dec 2017 12:57:30 -0500
Message-Id: <20171210175730.11889-1-tytso@mit.edu>
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

Also allow ext4/306 to run on systems where mke2fs doesn't support the
"64bit" option.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc      | 38 +++++++++++++-------------------------
 tests/ext4/003 |  3 +--
 tests/ext4/025 |  2 +-
 tests/ext4/026 |  2 +-
 tests/ext4/306 |  7 +++++--
 5 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/common/rc b/common/rc
index 63876a3e..c388fcd3 100644
--- a/common/rc
+++ b/common/rc
@@ -1899,32 +1899,20 @@ _require_scratch_ext4_crc()
 	_scratch_unmount
 }
 
-# Check the specified feature whether it is available in mkfs.ext4 or not.
-_require_ext4_mkfs_feature()
+# Check whether the specified feature whether it is supported by
+# mkfs.ext4 and the kernel.
+_require_scratch_ext4_feature()
 {
-	local feature=$1
-	local testfile=/tmp/$$.ext4_mkfs
-
-	if [ -z "$feature" ]; then
-                echo "Usage: _require_ext4_mkfs_feature feature"
-                exit 1
-        fi
-
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
-	_scratch_mount >/dev/null 2>&1 \
-	   || _notrun "Ext4 kernel doesn't support bigalloc feature"
-	_scratch_unmount
+    if [ -z "$1" ]; then
+        echo "Usage: _require_scratch_ext4_feature feature"
+        exit 1
+    fi
+    $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
+		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
+	|| _notrun "mkfs.ext4 doesn't support $feature feature"
+    _scratch_mount >/dev/null 2>&1 \
+	|| _notrun "Kernel doesn't support the ext4 feature(s): $1"
+    _scratch_unmount
 }
 
 # this test requires that external log/realtime devices are not in use
diff --git a/tests/ext4/003 b/tests/ext4/003
index 9be40178..eafe9a53 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -38,8 +38,7 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
-_require_ext4_mkfs_feature "bigalloc"
-_require_ext4_bigalloc
+_require_scratch_ext4_feature "bigalloc"
 
 rm -f $seqres.full
 
diff --git a/tests/ext4/025 b/tests/ext4/025
index 49ecb462..2a7b35fc 100755
--- a/tests/ext4/025
+++ b/tests/ext4/025
@@ -48,7 +48,7 @@ _supported_fs ext4
 _supported_os Linux
 _require_scratch_nocheck
 _require_command "$DEBUGFS_PROG" debugfs
-_require_ext4_mkfs_feature "bigalloc,meta_bg,^resize_inode"
+_require_scratch_ext4_feature "bigalloc,meta_bg,^resize_inode"
 
 echo "Create ext4 fs and modify first_meta_bg's value"
 _scratch_mkfs "-O bigalloc,meta_bg,^resize_inode" >> $seqres.full 2>&1
diff --git a/tests/ext4/026 b/tests/ext4/026
index 94a737ce..7731e923 100755
--- a/tests/ext4/026
+++ b/tests/ext4/026
@@ -50,7 +50,7 @@ _supported_fs ext4
 _supported_os Linux
 _require_scratch
 _require_attrs
-_require_ext4_mkfs_feature ea_inode
+_require_scratch_ext4_feature "ea_inode"
 
 _scratch_mkfs_ext4 -O ea_inode >/dev/null 2>&1
 _scratch_mount
diff --git a/tests/ext4/306 b/tests/ext4/306
index be765e6a..70f281db 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -44,12 +44,15 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
-_require_ext4_mkfs_feature "64bit"
 
 rm -f $seqres.full
 
 # Make a small ext4 fs with extents disabled & mount it
-$MKFS_EXT4_PROG -F -O ^extents,^64bit $SCRATCH_DEV 512m >> $seqres.full 2>&1
+features="^extents"
+if grep -q 64bit /etc/mke2fs.conf ; then
+    features="^extents,^64bit"
+fi
+$MKFS_EXT4_PROG -F -O "$features" $SCRATCH_DEV 512m >> $seqres.full 2>&1
 _scratch_mount || _fail "couldn't mount fs"
 
 # Create a small non-extent-based file
-- 
2.11.0.rc0.7.gbe5a750

