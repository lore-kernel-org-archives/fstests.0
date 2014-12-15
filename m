Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:58533 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaLOUTP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 15:19:15 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so10131737wiv.12
        for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 12:19:14 -0800 (PST)
Received: from [192.168.0.2] (178-222-112-234.dynamic.isp.telekom.rs. [178.222.112.234])
        by mx.google.com with ESMTPSA id e18sm7508270wjz.27.2014.12.15.12.19.13
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2014 12:19:13 -0800 (PST)
Date: Mon, 15 Dec 2014 23:19:43 +0100 (CET)
From: Dushan Tcholich <dusanc@gmail.com>
Subject: [PATCH] Reiser4 initial implementation
Message-ID: <alpine.LNX.2.00.1412152315300.21847@reiser4.gekom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


This is initial xfstests implementation for Reiser4 filesystem.

Signed-off-by: Dushan Tcholich <dusanc@gmail.com>

--- xfstests.orig/common/rc	2014-12-14 15:17:59.000000000 +0100
+++ xfstests/common/rc	2014-12-15 19:40:36.000000000 +0100
@@ -622,7 +622,7 @@
     xfs)
 	def_blksz=`echo $MKFS_OPTIONS|sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
 	;;
-    ext2|ext3|ext4|ext4dev|udf|btrfs)
+    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4)
 	def_blksz=`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 	;;
     esac
@@ -640,6 +640,7 @@
     fi
 
     blocks=`expr $fssize / $blocksize`
+    fssizeK=`expr $fssize / 1024`K
 
     if [ "$HOSTOS" == "Linux" ]; then
 	devsize=`blockdev --getsize64 $SCRATCH_DEV`
@@ -665,6 +666,9 @@
     btrfs)
 	$MKFS_BTRFS_PROG $MKFS_OPTIONS -b $fssize $SCRATCH_DEV
 	;;
+    reiser4)
+        ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV $fssizeK 
+        ;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;

--- xfstests.orig/common/config	2014-12-14 15:17:59.000000000 +0100
+++ xfstests/common/config	2014-12-12 13:27:40.000000000 +0100
@@ -258,6 +256,9 @@
 		# acls & xattrs aren't turned on by default on reiserfs
 		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
 		;;
+	reiser4)
+		export MOUNT_OPTIONS=$REISER4_MOUNT_OPTIONS
+		;;
 	gfs2)
 		# acls aren't turned on by default on gfs2
 		export MOUNT_OPTIONS="-o acl $GFS2_MOUNT_OPTIONS"
@@ -302,6 +303,9 @@
 	reiserfs)
 		export MKFS_OPTIONS="$REISERFS_MKFS_OPTIONS -q"
 		;;
+	reiser4)
+                export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
+                ;;
 	gfs2)
 		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
 		;;
@@ -322,6 +326,9 @@
 	reiserfs)
 		export FSCK_OPTIONS="--yes"
 		;;
+	reiser4)
+                export FSCK_OPTIONS="--yes"
+                ;;
 	*)
 		export FSCK_OPTIONS="-n"
 		;;
