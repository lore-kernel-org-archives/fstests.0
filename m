Received: from mx2.mpynet.fi ([82.197.21.85]:15491 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbdLLRMM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Dec 2017 12:12:12 -0500
From: Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: [PATCH] fstests: Add 9p network filesystem support
Date: Tue, 12 Dec 2017 19:11:54 +0200
Message-ID: <20171212171154.5222-1-tuomas@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Tuomas Tynkkynen <tuomas@tuxera.com>
List-ID: <fstests@vger.kernel.org>

This commit adds support for the 9p network file system, which is mainly
used by QEMU for sharing a file system from the host to the guest VM.

To run xfstests on it, launch QEMU with e.g.:

-virtfs local,path=$TMPDIR/p9-test,security_model=mapped-xattr,mount_tag=p9-test
-virtfs local,path=$TMPDIR/p9-scratch,security_model=mapped-xattr,mount_tag=p9-scratch

and inside the VM run xfstests with:

export TEST_DEV=p9-test
export SCRATCH_DEV=p9-scratch
export MOUNT_OPTIONS="-o trans=virtio,version=9p2000.L,cache=loose,posixacl"
export TEST_FS_MOUNT_OPTS="$MOUNT_OPTIONS"

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 check         |  2 ++
 common/attr   |  4 ++--
 common/config |  3 +++
 common/rc     | 32 +++++++++++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git check check
index f8db3cd6..6078b1ef 100755
--- check
+++ check
@@ -67,6 +67,7 @@ check options
     -nfs                test NFS
     -glusterfs                test GlusterFS
     -cifs               test CIFS
+    -9p			test 9p
     -overlay		test overlay
     -pvfs2          test PVFS2
     -tmpfs              test TMPFS
@@ -265,6 +266,7 @@ while [ $# -gt 0 ]; do
 	-nfs)		FSTYP=nfs ;;
 	-glusterfs)	FSTYP=glusterfs ;;
 	-cifs)		FSTYP=cifs ;;
+	-9p)		FSTYP=9p ;;
 	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
 	-pvfs2)		FSTYP=pvfs2 ;;
 	-tmpfs)		FSTYP=tmpfs ;;
diff --git common/attr common/attr
index 8a5c9eac..66b0227f 100644
--- common/attr
+++ common/attr
@@ -243,7 +243,7 @@ _sort_getfattr_output()
 
 # set maximum total attr space based on fs type
 case "$FSTYP" in
-xfs|udf|pvfs2|ceph)
+xfs|udf|pvfs2|9p|ceph)
 	MAX_ATTRS=1000
 	;;
 *)
@@ -263,7 +263,7 @@ xfs|udf|btrfs)
 pvfs2)
 	MAX_ATTRVAL_SIZE=8192
 	;;
-ceph)
+9p|ceph)
 	MAX_ATTRVAL_SIZE=65536
 	;;
 *)
diff --git common/config common/config
index d0fbfe55..5e4a73ed 100644
--- common/config
+++ common/config
@@ -459,6 +459,9 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
+	9p)
+		# 9p mount tags are just plain strings, so anything is allowed
+		;;
 	overlay)
 		if [ ! -d "$dev" ]; then
 			_fatal "common/config: $name ($dev) is not a directory for overlay"
diff --git common/rc common/rc
index 4c053a53..0d2da68c 100644
--- common/rc
+++ common/rc
@@ -166,6 +166,8 @@ case "$FSTYP" in
 	 ;;
     cifs)
 	 ;;
+    9p)
+	 ;;
     ceph)
 	 ;;
     glusterfs)
@@ -578,6 +580,9 @@ _test_mkfs()
     cifs)
 	# do nothing for cifs
 	;;
+    9p)
+	# do nothing for 9p
+	;;
     ceph)
 	# do nothing for ceph
 	;;
@@ -612,6 +617,9 @@ _mkfs_dev()
     nfs*)
 	# do nothing for nfs
 	;;
+    9p)
+	# do nothing for 9p
+	;;
     overlay)
 	# do nothing for overlay
 	;;
@@ -676,7 +684,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1448,6 +1456,14 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	9p)
+		if [ -z "$SCRATCH_DEV" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	nfs*|ceph)
 		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
@@ -1554,6 +1570,14 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	9p)
+		if [ -z "$TEST_DEV" ]; then
+			_notrun "this test requires a valid \$TEST_DEV"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	nfs*|ceph)
 		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
@@ -2500,6 +2524,9 @@ _check_test_fs()
     cifs)
 	# no way to check consistency for cifs
 	;;
+    9p)
+	# no way to check consistency for 9p
+	;;
     ceph)
 	# no way to check consistency for CephFS
 	;;
@@ -2555,6 +2582,9 @@ _check_scratch_fs()
     cifs)
 	# Don't know how to check a CIFS filesystem, yet.
 	;;
+    9p)
+	# no way to check consistency for 9p
+	;;
     ceph)
 	# no way to check consistency for CephFS
 	;;
-- 
2.15.0

