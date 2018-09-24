Received: from mail-qt1-f194.google.com ([209.85.160.194]:35550 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeIYDsN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Sep 2018 23:48:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id z14-v6so6216111qtn.2
        for <fstests@vger.kernel.org>; Mon, 24 Sep 2018 14:43:57 -0700 (PDT)
Date: Mon, 24 Sep 2018 18:43:52 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [PATCH v2] fstests: add support for hfsplus
Message-ID: <20180924214352.7fjpxbcnxpugnoms@eaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Eryu Guan <guaneryu@gmail.com>, Eric Sandeen <sandeen@sandeen.net>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

Running tests on hfsplus requires patched versions of the mkfs and fsck
tools [1] that support filesystems smaller than the device.

[1] https://github.com/eafer/hfsprogs-linux.git

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
 common/config | 10 ++++++++++
 common/rc     | 15 ++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 1ba8d96c..315f8b1e 100644
--- a/common/config
+++ b/common/config
@@ -229,6 +229,7 @@ case "$HOSTOS" in
 	export MKFS_CIFS_PROG=3D"false"
 	export MKFS_OVERLAY_PROG=3D"false"
 	export MKFS_REISER4_PROG=3D$(type -P mkfs.reiser4)
+	export MKFS_HFSPLUS_PROG=3D$(type -P mkfs.hfsplus)
 	export E2FSCK_PROG=3D$(type -P e2fsck)
 	export TUNE2FS_PROG=3D$(type -P tune2fs)
 	export FSCK_OVERLAY_PROG=3D$(type -P fsck.overlay)
@@ -313,6 +314,9 @@ _mount_opts()
 	ubifs)
 		export MOUNT_OPTIONS=3D$UBIFS_MOUNT_OPTIONS
 		;;
+	hfsplus)
+		export MOUNT_OPTIONS=3D$HFSPLUS_MOUNT_OPTIONS
+		;;
 	*)
 		;;
 	esac
@@ -380,6 +384,9 @@ _mkfs_opts()
 	f2fs)
 		export MKFS_OPTIONS=3D"$F2FS_MKFS_OPTIONS"
 		;;
+	hfsplus)
+		export MKFS_OPTIONS=3D$HFSPLUS_MKFS_OPTIONS
+		;;
 	*)
 		;;
 	esac
@@ -397,6 +404,9 @@ _fsck_opts()
 	f2fs)
 		export FSCK_OPTIONS=3D""
 		;;
+	hfsplus)
+		export FSCK_OPTIONS=3D"-nX"
+		;;
 	*)
 		export FSCK_OPTIONS=3D"-n"
 		;;
diff --git a/common/rc b/common/rc
index d5bb1fee..a843e9f6 100644
--- a/common/rc
+++ b/common/rc
@@ -158,6 +158,12 @@ case "$FSTYP" in
     ubifs)
 	[ "$UBIUPDATEVOL_PROG" =3D "" ] && _fatal "ubiupdatevol not found"
 	;;
+    hfsplus)
+	[ "$MKFS_HFSPLUS_PROG" =3D "" ] && _fatal "mkfs.hfsplus not found"
+	mkfs.hfsplus -X |& grep "invalid" &&
+		_fatal "A patched version of mkfs.hfsplus is required:" \
+		       "https://github.com/eafer/hfsprogs-linux.git"
+	;;
 esac
=20
 if [ ! -z "$REPORT_LIST" ]; then
@@ -746,6 +752,10 @@ _scratch_mkfs()
 		mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter=3D"grep -v -e ^mkfs\.ocfs2"
 		;;
+	hfsplus)
+		mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP -- -X"
+		mkfs_filter=3D"cat"
+		;;
 	*)
 		mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter=3D"cat"
@@ -995,6 +1005,9 @@ _scratch_mkfs_sized()
 	fi
 	export MOUNT_OPTIONS=3D"-o size=3D$fssize $TMPFS_MOUNT_OPTIONS"
 	;;
+    hfsplus)
+	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -X $fssize -b $blocksize $SCRATCH_DEV
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
@@ -3055,7 +3068,7 @@ _require_metadata_journaling()
 	fi
=20
 	case "$FSTYP" in
-	ext2|vfat|msdos|udf)
+	ext2|vfat|msdos|udf|hfsplus)
 		_notrun "$FSTYP does not support metadata journaling"
 		;;
 	ext4)
--=20
2.11.0
