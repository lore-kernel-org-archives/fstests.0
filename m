Received: from mx2.suse.de ([195.135.220.15]:47183 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754354AbcKBJBM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Nov 2016 05:01:12 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12B00ABFB
        for <fstests@vger.kernel.org>; Wed,  2 Nov 2016 09:01:11 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] common: add CephFS support
Date: Wed,  2 Nov 2016 10:00:54 +0100
Message-Id: <20161102090054.6394-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Joao Eduardo Luis <joao@suse.de>
List-ID: <fstests@vger.kernel.org>

From: Joao Eduardo Luis <joao@suse.de>

Add basic CephFS support. No new CephFS specific tests are included,
just basic enablement, with ./check now accepting a -ceph parameter.

Signed-off-by: Joao Eduardo Luis <joao@suse.de>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
 README        |  1 +
 check         |  2 ++
 common/config |  9 +++++++++
 common/rc     | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/README b/README
index bc2058d..b1cafe2 100644
--- a/README
+++ b/README
@@ -126,6 +126,7 @@ Running tests:
       Running all the udf tests: ./check -udf -g udf
     - for running nfs tests: ./check -nfs [test(s)]
     - for running cifs/smb3 tests: ./check -cifs [test(s)]
+    - for running CephFS tests: ./check -ceph [test(s)]
     - To randomize test order: ./check -r [test(s)]
 
     
diff --git a/check b/check
index 69341d8..adc2347 100755
--- a/check
+++ b/check
@@ -63,6 +63,7 @@ usage()
 check options
     -nfs                test NFS
     -cifs               test CIFS
+    -ceph               test CephFS
     -overlay		test overlay
     -tmpfs              test TMPFS
     -l			line mode diff
@@ -212,6 +213,7 @@ while [ $# -gt 0 ]; do
 	-cifs)		FSTYP=cifs ;;
 	-overlay)	FSTYP=overlay ;;
 	-tmpfs)		FSTYP=tmpfs ;;
+	-ceph)		FSTYP=ceph ;;
 
 	-g)	group=$2 ; shift ;
 		GROUP_LIST="$GROUP_LIST ${group//,/ }"
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
index a84efe4..d057962 100644
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
@@ -1499,6 +1508,15 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+        ceph)
+		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
+		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	cifs)
 		echo $SCRATCH_DEV | grep -q "//" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
@@ -1584,6 +1602,15 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	ceph)
+		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
+		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$TEST_DEV"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+		     _notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	cifs)
 		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
@@ -2658,6 +2685,9 @@ _check_test_fs()
     cifs)
 	# no way to check consistency for cifs
 	;;
+    ceph)
+	# no way to check consistency for CephFS
+	;;
     overlay)
 	# no way to check consistency for overlay
 	;;
@@ -2702,6 +2732,9 @@ _check_scratch_fs()
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

