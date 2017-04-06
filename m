Received: from mail-yb0-f181.google.com ([209.85.213.181]:36236 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbdDFWZg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Apr 2017 18:25:36 -0400
Received: by mail-yb0-f181.google.com with SMTP id i124so13560183ybc.3
        for <fstests@vger.kernel.org>; Thu, 06 Apr 2017 15:25:36 -0700 (PDT)
From: Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH] fstests: add orangefs (pvfs2) support
Date: Thu,  6 Apr 2017 18:25:14 -0400
Message-Id: <1491517514-15633-1-git-send-email-martin@omnibond.com>
Sender: fstests-owner@vger.kernel.org
To: hubcap@omnibond.com, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
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
 common/rc   | 23 +++++++++++++++++++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

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
index e1ab2c6..140658d 100644
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
@@ -714,6 +716,8 @@ _test_mkfs()
     overlay)
 	# do nothing for overlay
 	;;
+    pvfs2)
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
@@ -738,6 +742,8 @@ _mkfs_dev()
     overlay)
 	# do nothing for overlay
 	;;
+    pvfs2)
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 	;;
@@ -793,7 +799,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1504,7 +1510,7 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
-	nfs*|ceph)
+	nfs*|ceph|pvfs2)
 		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
@@ -1618,6 +1624,15 @@ _require_test()
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
 	tmpfs)
 		if [ -z "$TEST_DEV" -o ! -d "$TEST_DIR" ];
 		then
@@ -2451,6 +2466,8 @@ _check_test_fs()
     overlay)
 	# no way to check consistency for overlay
 	;;
+    pvfs2)
+	;;
     udf)
 	# do nothing for now
 	;;
@@ -2501,6 +2518,8 @@ _check_scratch_fs()
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

