Received: from mail.kernel.org ([198.145.29.99]:35514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbdGZSne (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Jul 2017 14:43:34 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [xfstests PATCH] gfs2: allow testing with gfs2
Date: Wed, 26 Jul 2017 14:43:31 -0400
Message-Id: <20170726184331.27953-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, cluster-devel@redhat.com
List-ID: <fstests@vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

For now, just have it avoid locking. With a fixed kernel,
generic/441 now passes.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 common/config     | 1 +
 common/rc         | 7 +++++++
 tests/generic/441 | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 5091db9d5099..eb32efc105db 100644
--- a/common/config
+++ b/common/config
@@ -244,6 +244,7 @@ case "$HOSTOS" in
         export MKFS_REISER4_PROG="`set_prog_path mkfs.reiser4`"
 	export E2FSCK_PROG="`set_prog_path e2fsck`"
 	export TUNE2FS_PROG="`set_prog_path tune2fs`"
+        export MKFS_GFS2_PROG="`set_prog_path mkfs.gfs2`"
         ;;
 esac
 
diff --git a/common/rc b/common/rc
index bd989bb5f4dd..70bb39225368 100644
--- a/common/rc
+++ b/common/rc
@@ -158,6 +158,9 @@ case "$FSTYP" in
     ext4)
 	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
 	 ;;
+    gfs2)
+	 [ "$MKFS_GFS2_PROG" = "" ] && _fatal "mkfs.gfs2 not found"
+	 ;;
     f2fs)
 	 [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
 	 ;;
@@ -861,6 +864,10 @@ _scratch_mkfs()
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
 		;;
+	gfs2)
+		mkfs_cmd="$MKFS_GFS2_PROG -p lock_nolock -O"
+		mkfs_filter="cat"
+		;;
 	*)
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="cat"
diff --git a/tests/generic/441 b/tests/generic/441
index 075d87723ca1..b98f709cb6eb 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -55,7 +55,7 @@ case $FSTYP in
 	btrfs)
 		_notrun "btrfs has a specialized test for this"
 		;;
-	ext3|ext4|xfs)
+	ext3|ext4|gfs2|xfs)
 		# Do the more thorough test if we have a logdev
 		_has_logdev && sflag=''
 		;;
-- 
2.13.3

