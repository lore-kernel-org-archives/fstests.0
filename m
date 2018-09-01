Received: from mail-qt0-f194.google.com ([209.85.216.194]:33425 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeIAGPV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 1 Sep 2018 02:15:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id r37-v6so16648569qtc.0
        for <fstests@vger.kernel.org>; Fri, 31 Aug 2018 19:05:08 -0700 (PDT)
Date: Fri, 31 Aug 2018 23:05:03 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [RFC PATCH] fstests: add support for hfsplus
Message-ID: <20180901020503.5i4hz4inqtfd3frg@eaf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Eryu Guan <guaneryu@gmail.com>
List-ID: <fstests@vger.kernel.org>

It is not possible to set file system size when running mkfs.hfsplus,
so use the device mapper as a workaround.

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
I've been using this to test hfsplus patches. If there's a better way
please let me know.

 common/config |  7 +++++++
 common/rc     | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 2f1f2720..32a1ccb8 100644
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
diff --git a/common/rc b/common/rc
index ec631ad9..38f61944 100644
--- a/common/rc
+++ b/common/rc
@@ -158,6 +158,9 @@ case "$FSTYP" in
     ubifs)
 	[ "$UBIUPDATEVOL_PROG" =3D "" ] && _fatal "ubiupdatevol not found"
 	;;
+    hfsplus)
+	 [ "$MKFS_HFSPLUS_PROG" =3D "" ] && _fatal "mkfs.hfsplus not found"
+	 ;;
 esac
=20
 if [ ! -z "$REPORT_LIST" ]; then
@@ -746,6 +749,12 @@ _scratch_mkfs()
 		mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter=3D"grep -v -e ^mkfs\.ocfs2"
 		;;
+	hfsplus)
+		mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP --"
+		mkfs_filter=3D"cat"
+		# a test may have been interrupted after _scratch_mkfs_sized()
+		rm -f ${RESULT_DIR}/hfsplus_sectors
+		;;
 	*)
 		mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter=3D"cat"
@@ -995,6 +1004,17 @@ _scratch_mkfs_sized()
 	fi
 	export MOUNT_OPTIONS=3D"-o size=3D$fssize $TMPFS_MOUNT_OPTIONS"
 	;;
+    hfsplus)
+	# mkfs.hfsplus does not allow setting the size of the filesystem
+	_require_dm_target linear
+	local sectors=3D`expr $fssize / 512`
+	local table=3D"0 $sectors linear $SCRATCH_DEV 0"
+	_dmsetup_create hfsplus-tmp --table "$table" || _fatal "dmsetup failed"
+	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize /dev/mapper/hfsplus-tmp
+	_dmsetup_remove hfsplus-tmp
+	# remember the true size of the filesystem for fsck.hfsplus
+	echo -n $sectors > ${RESULT_DIR}/hfsplus_sectors
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
@@ -2661,6 +2681,22 @@ _check_scratch_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    hfsplus)
+	# fsck.hfsplus will always assume the filesystem fills the device
+	if [ -f ${RESULT_DIR}/hfsplus_sectors ]; then
+	    local sectors=3D`cat ${RESULT_DIR}/hfsplus_sectors`
+	    rm -f ${RESULT_DIR}/hfsplus_sectors
+	    local table=3D"0 $sectors linear $SCRATCH_DEV 0"
+	    _dmsetup_create hfsplus-tmp --table "$table" || \
+						_fatal "dmsetup failed"
+	    _check_generic_filesystem /dev/mapper/hfsplus-tmp
+	    local fsck_status=3D$?
+	    _dmsetup_remove hfsplus-tmp
+	    return $fsck_status
+	else
+	    _check_generic_filesystem $device
+	fi
+	;;
     *)
 	_check_generic_filesystem $device
 	;;
@@ -3055,7 +3091,7 @@ _require_metadata_journaling()
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
