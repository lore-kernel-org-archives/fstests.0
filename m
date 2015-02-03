Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56429 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbbBCXHg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 3 Feb 2015 18:07:36 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/8 v4] common/rc: add _require_bmap
Date: Tue,  3 Feb 2015 15:07:14 -0800
Message-Id: <1423004840-45315-3-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This is to detect whether the filesystem tool supports bmap or not.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/config |  2 ++
 common/rc     | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/common/config b/common/config
index 235f4a1..9fb3703 100644
--- a/common/config
+++ b/common/config
@@ -168,6 +168,7 @@ if [ -n "$__XFSDUMP_PROG" ]; then
 else
 	export XFSDUMP_PROG=""
 fi
+export BMAP_XFS_PROG="`set_prog_path xfs_bmap`"
 export XFSRESTORE_PROG="`set_prog_path xfsrestore`"
 export XFSINVUTIL_PROG="`set_prog_path xfsinvutil`"
 export GETFATTR_PROG="`set_prog_path getfattr`"
@@ -220,6 +221,7 @@ case "$HOSTOS" in
         export MKFS_UDF_PROG="`set_prog_path mkudffs`"
         export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
         export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
+        export BMAP_F2FS_PROG="`set_prog_path fibmap.f2fs`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
         export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
diff --git a/common/rc b/common/rc
index 438cd51..d413721 100644
--- a/common/rc
+++ b/common/rc
@@ -2331,6 +2331,24 @@ _require_scratch_shutdown()
 	_scratch_unmount
 }
 
+# Does bmap work on this fs?
+_require_bmap()
+{
+	case "$FSTYP" in
+	xfs)
+		_require_command $BMAP_XFS_PROG
+		export BMAP_PROG=$BMAP_XFS_PROG
+		;;
+	f2fs)
+		_require_command $BMAP_F2FS_PROG
+		export BMAP_PROG=$BMAP_F2FS_PROG
+		;;
+	*)
+		_notrun "$FSTYP does not support bmap"
+		;;
+	esac
+}
+
 # arg 1 is dev to remove and is output of the below eg.
 # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
 _devmgt_remove()
-- 
2.1.1

