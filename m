Received: from mx2.suse.de ([195.135.220.15]:51393 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759924AbcKDKEv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Nov 2016 06:04:51 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9C43DABE7
        for <fstests@vger.kernel.org>; Fri,  4 Nov 2016 10:04:49 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3] common: add CephFS support
Date: Fri,  4 Nov 2016 11:04:39 +0100
Message-Id: <20161104100439.23292-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Joao Eduardo Luis <joao@suse.de>
List-ID: <fstests@vger.kernel.org>

From: Joao Eduardo Luis <joao@suse.de>

Add basic CephFS support. No new CephFS specific tests are included,
just FSTYP="ceph" enablement.

Signed-off-by: Joao Eduardo Luis <joao@suse.de>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
Changes since v2:
- remove reference to ./check -ceph from commit msg.

 README.config-sections |  6 ++++++
 common/config          |  9 +++++++++
 common/rc              | 21 ++++++++++++++++++---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/README.config-sections b/README.config-sections
index 865ca93..df7c929 100644
--- a/README.config-sections
+++ b/README.config-sections
@@ -115,3 +115,9 @@ FSTYP=xfs
 [ext3_filesystem]
 FSTYP=ext3
 MOUNT_OPTIONS="-o noatime"
+
+[cephfs]
+TEST_DIR=/mnt/test
+TEST_DEV=192.168.14.1:6789:/
+TEST_FS_MOUNT_OPTS="-o name=admin,secret=AQDuEBtYKEYRINGSECRETriSC8YJGDZsQHcr7g=="
+FSTYP="ceph"
diff --git a/common/config b/common/config
index 168f46c..59638d6 100644
--- a/common/config
+++ b/common/config
@@ -298,6 +298,9 @@ _mount_opts()
 	cifs)
 		export MOUNT_OPTIONS=$CIFS_MOUNT_OPTIONS
 		;;
+	ceph)
+		export MOUNT_OPTIONS=$CEPHFS_MOUNT_OPTIONS
+		;;
 	overlay)
 		export MOUNT_OPTIONS=$OVERLAY_MOUNT_OPTIONS
 		;;
@@ -335,6 +338,9 @@ _test_mount_opts()
 	cifs)
 		export TEST_FS_MOUNT_OPTS=$CIFS_MOUNT_OPTIONS
 		;;
+	ceph)
+		export TEST_FS_MOUNT_OPTS=$CEPHFS_MOUNT_OPTIONS
+		;;
 	*)
 		;;
 	esac
@@ -357,6 +363,9 @@ _mkfs_opts()
 	cifs)
 		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
 		;;
+	ceph)
+		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
+		;;
 	reiserfs)
 		export MKFS_OPTIONS="$REISERFS_MKFS_OPTIONS -q"
 		;;
diff --git a/common/rc b/common/rc
index a84efe4..e3b54ec 100644
--- a/common/rc
+++ b/common/rc
@@ -147,6 +147,8 @@ case "$FSTYP" in
 	 ;;
     cifs)
 	 ;;
+    ceph)
+	 ;;
     overlay)
 	 ;;
     reiser4)
@@ -705,6 +707,9 @@ _test_mkfs()
     cifs)
 	# do nothing for cifs
 	;;
+    ceph)
+	# do nothing for ceph
+	;;
     overlay)
 	# do nothing for overlay
 	;;
@@ -791,6 +796,10 @@ _scratch_mkfs()
 	# avoid EEXIST caused by the leftover files created in previous runs
         _scratch_cleanup_files
 	;;
+    ceph)
+	# Don't re-create CephFS, just remove all files
+	_scratch_cleanup_files
+	;;
     overlay)
 	# unable to re-create overlay, remove all files in $SCRATCH_MNT to
 	# avoid EEXIST caused by the leftover files created in previous runs
@@ -1490,7 +1499,7 @@ _reload_btrfs_ko()
 _require_scratch_nocheck()
 {
     case "$FSTYP" in
-	nfs*)
+	nfs*|ceph)
 		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
@@ -1575,10 +1584,10 @@ _require_scratch()
 _require_test()
 {
     case "$FSTYP" in
-	nfs*)
+	nfs*|ceph)
 		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
-			_notrun "this test requires a valid \$TEST_DIR"
+			_notrun "this test requires a valid \$TEST_DEV"
 		fi
 		if [ ! -d "$TEST_DIR" ]; then
 			_notrun "this test requires a valid \$TEST_DIR"
@@ -2658,6 +2667,9 @@ _check_test_fs()
     cifs)
 	# no way to check consistency for cifs
 	;;
+    ceph)
+	# no way to check consistency for CephFS
+	;;
     overlay)
 	# no way to check consistency for overlay
 	;;
@@ -2702,6 +2714,9 @@ _check_scratch_fs()
     cifs)
 	# Don't know how to check a CIFS filesystem, yet.
 	;;
+    ceph)
+	# no way to check consistency for CephFS
+	;;
     overlay)
 	# no way to check consistency for overlay
 	;;
-- 
2.10.0

