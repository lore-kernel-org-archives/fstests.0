Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:45239 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaLQU3d (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Dec 2014 15:29:33 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so98208wid.6
        for <fstests@vger.kernel.org>; Wed, 17 Dec 2014 12:29:31 -0800 (PST)
Received: from [192.168.0.2] (109-93-61-240.dynamic.isp.telekom.rs. [109.93.61.240])
        by mx.google.com with ESMTPSA id bs2sm6372762wjc.43.2014.12.17.12.29.30
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Dec 2014 12:29:31 -0800 (PST)
Date: Wed, 17 Dec 2014 23:29:55 +0100 (CET)
From: Dushan Tcholich <dusanc@gmail.com>
Subject: [PATCH v2] Reiser4 initial implementation
Message-ID: <alpine.LNX.2.00.1412172318240.29081@reiser4.gekom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Initial xfstests implementation for Reiser4 filesystem.

Signed-off-by: Dushan Tcholich <dusanc@gmail.com>

---
v2:
Added support for MKFS_REISER4_PROG into common/config
Used reiser* wherever possible
Added setup checks for mkfs.reiser4 in common/rc
Added comment that mkfs.reiser4 expects KB for size

diff -urN xfstests.orig/common/config xfstests/common/config
--- xfstests.orig/common/config	2014-12-17 01:00:05.000000000 +0100
+++ xfstests/common/config	2014-12-17 01:22:41.000000000 +0100
@@ -224,6 +224,7 @@
         export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
         export MKFS_NFS_PROG="false"
         export MKFS_CIFS_PROG="false"
+        export MKFS_REISER4_PROG="`set_prog_path mkfs.reiser4`"
         ;;
 esac
 
@@ -258,6 +259,10 @@
 		# acls & xattrs aren't turned on by default on reiserfs
 		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
 		;;
+       reiser4)
+               # acls & xattrs aren't supported by reiser4
+               export MOUNT_OPTIONS=$REISER4_MOUNT_OPTIONS
+               ;;
 	gfs2)
 		# acls aren't turned on by default on gfs2
 		export MOUNT_OPTIONS="-o acl $GFS2_MOUNT_OPTIONS"
@@ -302,6 +307,9 @@
 	reiserfs)
 		export MKFS_OPTIONS="$REISERFS_MKFS_OPTIONS -q"
 		;;
+       reiser4)
+		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
+		;;
 	gfs2)
 		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
 		;;
@@ -319,7 +327,7 @@
 	ext2|ext3|ext4|ext4dev)
 		export FSCK_OPTIONS="-nf"
 		;;
-	reiserfs)
+	reiser*)
 		export FSCK_OPTIONS="--yes"
 		;;
 	*)
diff -urN xfstests.orig/common/rc xfstests/common/rc
--- xfstests.orig/common/rc	2014-12-17 01:00:05.000000000 +0100
+++ xfstests/common/rc	2014-12-17 22:58:38.000000000 +0100
@@ -112,6 +112,9 @@
 	 ;;
     cifs)
 	 ;;
+    reiser4)
+	 [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
+	 ;;
 esac
 
 # make sure we have a standard umask
@@ -633,7 +636,7 @@
     xfs)
 	def_blksz=`echo $MKFS_OPTIONS|sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
 	;;
-    ext2|ext3|ext4|ext4dev|udf|btrfs)
+    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4)
 	def_blksz=`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 	;;
     esac
@@ -676,6 +679,11 @@
     btrfs)
 	$MKFS_BTRFS_PROG $MKFS_OPTIONS -b $fssize $SCRATCH_DEV
 	;;
+    reiser4)
+	# mkfs.resier4 requires size in KB as input for creating filesystem
+	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
+			   `expr $fssize / 1024`
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
