Received: from mail-yw0-f173.google.com ([209.85.161.173]:34998 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbdDGUJ4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Apr 2017 16:09:56 -0400
Received: by mail-yw0-f173.google.com with SMTP id d191so39388806ywe.2
        for <fstests@vger.kernel.org>; Fri, 07 Apr 2017 13:09:56 -0700 (PDT)
From: Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH] fstests: add orangefs (pvfs2) support
Date: Fri,  7 Apr 2017 16:09:43 -0400
Message-Id: <1491595783-16079-1-git-send-email-martin@omnibond.com>
In-Reply-To: <alpine.DEB.2.11.1704071608320.16149@mbmbp.sysblue.org>
References: <alpine.DEB.2.11.1704071608320.16149@mbmbp.sysblue.org>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com, hubcap@omnibond.com, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Martin Brandenburg <martin@omnibond.com>
List-ID: <fstests@vger.kernel.org>

The filesystem was renamed OrangeFS from PVFS2 recently.  The mount -t
type remains pvfs2, so I have used that name throughout despite the
kernel module being named orangefs.

We've been maintaining this as a patch for quite some time.

The easiest way to use is to setup a single server installation with
multiple filesystems orangefs and scratch, put the following in
/etc/xfsqa.config, and run ./check -pvfs2 -g quick.

TEST_DIR=/mnt
TEST_DEV=tcp://server1vm:3334/orangefs
SCRATCH_MNT=/scratch
SCRATCH_DEV=tcp://server1vm:3334/scratch

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 check       |  2 ++
 common/attr |  4 +++-
 common/rc   | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 2fcf385..9cef58b 100755
--- a/check
+++ b/check
@@ -68,6 +68,7 @@ check options
     -glusterfs                test GlusterFS
     -cifs               test CIFS
     -overlay		test overlay
+    -pvfs2          test PVFS2
     -tmpfs              test TMPFS
     -l			line mode diff
     -udiff		show unified diff (default)
@@ -264,6 +265,7 @@ while [ $# -gt 0 ]; do
 	-glusterfs)	FSTYP=glusterfs ;;
 	-cifs)		FSTYP=cifs ;;
 	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
+	-pvfs2)		FSTYP=pvfs2 ;;
 	-tmpfs)		FSTYP=tmpfs ;;
 
 	-g)	group=$2 ; shift ;
diff --git a/common/attr b/common/attr
index 08643e6..ac139e6 100644
--- a/common/attr
+++ b/common/attr
@@ -254,7 +254,7 @@ _sort_getfattr_output()
 }
 
 # set maximum total attr space based on fs type
-if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" ]; then
+if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" -o "$FSTYP" == "pvfs2" ]; then
 	MAX_ATTRS=1000
 else # Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
@@ -267,6 +267,8 @@ export MAX_ATTRS
 # Set max attr value size based on fs type
 if [ "$FSTYP" == "xfs" -o "$FSTYP" == "udf" -o "$FSTYP" == "btrfs" ]; then
 	MAX_ATTRVAL_SIZE=64
+elif [ "$FSTYP" == "pvfs2" ]; then
+	MAX_ATTRVAL_SIZE=8192
 else # Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
 	# leave a little overhead
diff --git a/common/rc b/common/rc
index e1ab2c6..be2bc26 100644
--- a/common/rc
+++ b/common/rc
@@ -174,6 +174,8 @@ case "$FSTYP" in
     reiser4)
 	 [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
 	 ;;
+    pvfs2)
+	;;
 esac
 
 if [ ! -z "$REPORT_LIST" ]; then
@@ -714,6 +716,9 @@ _test_mkfs()
     overlay)
 	# do nothing for overlay
 	;;
+    pvfs2)
+	# do nothing for pvfs2
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
@@ -738,6 +743,9 @@ _mkfs_dev()
     overlay)
 	# do nothing for overlay
 	;;
+    pvfs2)
+	# do nothing for pvfs2
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 	;;
@@ -793,7 +801,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1513,6 +1521,14 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	pvfs2)
+		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
+		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
 	cifs)
 		echo $SCRATCH_DEV | grep -q "//" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
@@ -1610,6 +1626,15 @@ _require_test()
 		     _notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	pvfs2)
+		echo $TEST_DEV | grep -q "://" > /dev/null 2>&1
+		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	overlay)
 		if [ -z "$OVL_BASE_TEST_DIR" -o ! -d "$OVL_BASE_TEST_DIR" ]; then
 			_notrun "this test requires a valid \$TEST_DIR as ovl base dir"
@@ -2451,6 +2476,8 @@ _check_test_fs()
     overlay)
 	# no way to check consistency for overlay
 	;;
+    pvfs2)
+	;;
     udf)
 	# do nothing for now
 	;;
@@ -2501,6 +2528,8 @@ _check_scratch_fs()
     overlay)
 	# no way to check consistency for overlay
 	;;
+    pvfs2)
+	;;
     btrfs)
 	_check_btrfs_filesystem $device
 	;;
-- 
2.1.4

