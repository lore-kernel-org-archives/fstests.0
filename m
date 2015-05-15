Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47684 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423102AbbEONgv (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 May 2015 09:36:51 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4FDaoqD000904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 15 May 2015 09:36:50 -0400
Received: from plato.andrewprice.me.uk.com (ovpn-116-107.ams2.redhat.com [10.36.116.107])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4FDakLK015736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 15 May 2015 09:36:50 -0400
From: Andrew Price <anprice@redhat.com>
Subject: [PATCH 3/3] common/rc: support gfs2 in _scratch_mkfs_sized
Date: Fri, 15 May 2015 14:36:44 +0100
Message-Id: <1431697004-3032-3-git-send-email-anprice@redhat.com>
In-Reply-To: <1431697004-3032-1-git-send-email-anprice@redhat.com>
References: <1431697004-3032-1-git-send-email-anprice@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This enables tests which use _scratch_mkfs_sized when $FSTYP == gfs2.
Where tests use a fs size too small to contain a gfs2 fs created with
default options, specify a smaller journal size to make it fit.

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 common/config     | 1 +
 common/rc         | 5 ++++-
 tests/generic/015 | 3 +++
 tests/generic/083 | 3 +++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 3732287..2454418 100644
--- a/common/config
+++ b/common/config
@@ -228,6 +228,7 @@ case "$HOSTOS" in
         export MKFS_NFS_PROG="false"
         export MKFS_CIFS_PROG="false"
         export MKFS_REISER4_PROG="`set_prog_path mkfs.reiser4`"
+        export MKFS_GFS2_PROG="`set_prog_path mkfs.gfs2`"
         ;;
 esac
 
diff --git a/common/rc b/common/rc
index 6ea107e..a269c2b 100644
--- a/common/rc
+++ b/common/rc
@@ -652,7 +652,7 @@ _scratch_mkfs_sized()
     xfs)
 	def_blksz=`echo $MKFS_OPTIONS|sed -rn 's/.*-b ?size= ?+([0-9]+).*/\1/p'`
 	;;
-    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4)
+    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|gfs2)
 	def_blksz=`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 	;;
     esac
@@ -700,6 +700,9 @@ _scratch_mkfs_sized()
 	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
 			   `expr $fssize / 1024`
 	;;
+    gfs2)
+	$MKFS_GFS2_PROG $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
diff --git a/tests/generic/015 b/tests/generic/015
index 8d3fd5f..d1805a7 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -53,6 +53,9 @@ _supported_os IRIX Linux
 _require_scratch
 _require_no_large_scratch_dev
 
+# GFS2 needs a smaller journal size to fit in 50M
+[ $FSTYP = "gfs2" ] && MKFS_OPTIONS="$MKFS_OPTIONS -J16"
+
 _scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
     || _fail "mkfs failed"
 _scratch_mount || _fail "mount failed"
diff --git a/tests/generic/083 b/tests/generic/083
index 61316bf..4e38f81 100755
--- a/tests/generic/083
+++ b/tests/generic/083
@@ -88,6 +88,9 @@ workout()
 
 echo "*** test out-of-space handling for random write operations"
 
+# GFS2 needs a smaller journal size to fit in 100M
+[ $FSTYP = "gfs2" ] && MKFS_OPTIONS="$MKFS_OPTIONS -J64"
+
 filesize=`expr 100 \* 1024 \* 1024`
 agcount=6
 numprocs=15
-- 
2.1.0

