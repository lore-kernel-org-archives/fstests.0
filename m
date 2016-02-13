Received: from imap.thunk.org ([74.207.234.97]:34547 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbcBMRlQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 13 Feb 2016 12:41:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 03/16] common: _scratch_mkfs_sized() for tmpfs
Date: Sat, 13 Feb 2016 12:40:56 -0500
Message-Id: <1455385269-26319-4-git-send-email-tytso@mit.edu>
In-Reply-To: <1455385269-26319-1-git-send-email-tytso@mit.edu>
References: <1455385269-26319-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Junho Ryu <jayr@google.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Enable _scratch_mkfs_sized() for use with tmpfs, so that tests which
use this helper can now run.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Junho Ryu <jayr@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 2d91b69..9006392 100644
--- a/common/rc
+++ b/common/rc
@@ -783,6 +783,12 @@ _scratch_pool_mkfs()
     esac
 }
 
+# Return the amount of free memory available on the system
+_free_memory_bytes()
+{
+    free -b | grep ^Mem | awk '{print $4}'
+}
+
 # Create fs of certain size on scratch device
 # _scratch_mkfs_sized <size in bytes> [optional blocksize]
 _scratch_mkfs_sized()
@@ -813,7 +819,7 @@ _scratch_mkfs_sized()
 
     blocks=`expr $fssize / $blocksize`
 
-    if [ "$HOSTOS" == "Linux" ]; then
+    if [ "$HOSTOS" == "Linux" -a -b "$SCRATCH_DEV" ]; then
 	devsize=`blockdev --getsize64 $SCRATCH_DEV`
 	[ "$fssize" -gt "$devsize" ] && _notrun "Scratch device too small"
     fi
@@ -849,6 +855,13 @@ _scratch_mkfs_sized()
 	sector_size=`blockdev --getss $SCRATCH_DEV`
 	$MKFS_F2FS_PROG $MKFS_OPTIONS $SCRATCH_DEV `expr $fssize / $sector_size`
 	;;
+    tmpfs)
+	free_mem=`_free_memory_bytes`
+	if [ "$free_mem" -lt "$fssize" ] ; then
+	   _notrun "Not enough memory ($free_mem) for tmpfs with $fssize bytes"
+	fi
+	export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
-- 
2.5.0

