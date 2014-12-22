Return-Path: <jaegeuk@kernel.org>
Date: Mon, 22 Dec 2014 14:29:25 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] xfstests: f2fs support
Message-ID: <20141222222925.GA8287@jaegeuk-mac02.mot.com>
References: <1401717572-21731-1-git-send-email-jaegeuk@kernel.org>
 <549866D8.1030507@sandeen.net>
 <20141222213513.GR15665@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141222213513.GR15665@dastard>
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforget.net
List-ID: <fstests@vger.kernel.org>

Thanks Eric,
I totally forgot this patch to repost.

Dave,
Could you please apply this patch?

Thanks,

-- >8 --
>From 86eb93921e1ce28e965e3152ac7066b45bccb4eb Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 2 Jun 2014 20:09:19 +0900
Subject: [PATCH] xfstests: f2fs support

This patch adds to support f2fs file system.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
---
 common/config | 7 +++++++
 common/rc     | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/common/config b/common/config
index e9971fd..06bdee2 100644
--- a/common/config
+++ b/common/config
@@ -219,6 +219,7 @@ case "$HOSTOS" in
         export MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
         export MKFS_UDF_PROG="`set_prog_path mkudffs`"
         export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
+        export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
         export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
         export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
         export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
@@ -254,6 +255,9 @@ _mount_opts()
 		# acls & xattrs aren't turned on by default on ext$FOO
 		export MOUNT_OPTIONS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
 		;;
+	f2fs)
+		export MOUNT_OPTIONS="-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
+		;;
 	reiserfs)
 		# acls & xattrs aren't turned on by default on reiserfs
 		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
@@ -322,6 +326,9 @@ _fsck_opts()
 	reiserfs)
 		export FSCK_OPTIONS="--yes"
 		;;
+	f2fs)
+		export FSCK_OPTIONS=""
+		;;
 	*)
 		export FSCK_OPTIONS="-n"
 		;;
diff --git a/common/rc b/common/rc
index 82a91c2..a39885d 100644
--- a/common/rc
+++ b/common/rc
@@ -108,6 +108,9 @@ case "$FSTYP" in
     ext4)
 	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
 	 ;;
+    f2fs)
+	 [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
+	 ;;
     nfs)
 	 ;;
     cifs)
@@ -598,6 +601,9 @@ _scratch_mkfs()
     tmpfs)
 	# do nothing for tmpfs
 	;;
+    f2fs)
+        $MKFS_F2FS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $SCRATCH_DEV
 	;;
-- 
2.1.1
