Received: from imap.thunk.org ([74.207.234.97]:51045 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756219AbcBJBuQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 20:50:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 02/12] common: _scratch_mkfs_sized() for tmpfs
Date: Tue,  9 Feb 2016 20:49:51 -0500
Message-Id: <1455069001-17846-3-git-send-email-tytso@mit.edu>
In-Reply-To: <1455069001-17846-1-git-send-email-tytso@mit.edu>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Junho Ryu <jayr@google.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

_scratch_mkfs_sized() avoid blockdev and update MOUNT_OPTIONS with
required size on tmpfs, so those tests using it can now run.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Junho Ryu <jayr@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 76e02e4..aca723f 100644
--- a/common/rc
+++ b/common/rc
@@ -813,7 +813,7 @@ _scratch_mkfs_sized()
 
     blocks=`expr $fssize / $blocksize`
 
-    if [ "$HOSTOS" == "Linux" ]; then
+    if [ "$HOSTOS" == "Linux" -a -b "$SCRATCH_DEV" ]; then
 	devsize=`blockdev --getsize64 $SCRATCH_DEV`
 	[ "$fssize" -gt "$devsize" ] && _notrun "Scratch device too small"
     fi
@@ -849,6 +849,9 @@ _scratch_mkfs_sized()
 	sector_size=`blockdev --getss $SCRATCH_DEV`
 	$MKFS_F2FS_PROG $MKFS_OPTIONS $SCRATCH_DEV `expr $fssize / $sector_size`
 	;;
+    tmpfs)
+	export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
-- 
2.5.0

