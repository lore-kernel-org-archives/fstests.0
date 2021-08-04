Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71582C432BE
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Aug 2021 04:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD6F60E53
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Aug 2021 04:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhHDET6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:19:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40594 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229562AbhHDET6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Aug 2021 00:19:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1744Jfcd012778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Aug 2021 00:19:42 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AC5A415C3DE2; Wed,  4 Aug 2021 00:19:41 -0400 (EDT)
Date:   Wed, 4 Aug 2021 00:19:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH RFC] add support for ntfs and ntfs3 file systems
Message-ID: <YQoVXWRFGeY19onQ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Here are some patches which add support for testing the fuse ntfs
implementation (shipped in the ntfs-3g package) as well as Paragon
Software's proposed ntfs3 kernel submission.

Context: https://lore.kernel.org/r/YQnHxIU+EAAxIjZA@mit.edu
Sample test run: https://www.kernel.org/pub/linux/kernel/people/tytso/fstests-results/results-ntfs3-2021-08-03.tar.xz

 common/config |  1 +
 common/rc     | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/common/config b/common/config
index 005fd50a..80510df2 100644
--- a/common/config
+++ b/common/config
@@ -271,6 +271,7 @@ export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
 export E2FSCK_PROG=$(type -P e2fsck)
 export TUNE2FS_PROG=$(type -P tune2fs)
 export FSCK_OVERLAY_PROG=$(type -P fsck.overlay)
+export MKFS_NTFS_PROG=$(type -P mkfs.ntfs)
 
 # SELinux adds extra xattrs which can mess up our expected output.
 # So, mount with a context, and they won't be created.
diff --git a/common/rc b/common/rc
index 0fabea45..12e94b1c 100644
--- a/common/rc
+++ b/common/rc
@@ -140,6 +140,10 @@ case "$FSTYP" in
 	 ;;
     pvfs2)
 	;;
+    ntfs)
+	;;
+    ntfs3)
+	;;
     ubifs)
 	[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
 	;;
@@ -690,6 +694,9 @@ _test_mkfs()
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
+    ntfs|ntfs3)
+	$MKFS_NTFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
@@ -729,6 +736,9 @@ _mkfs_dev()
 	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* \
 		2>$tmp.mkfserr 1>$tmp.mkfsstd
 	;;
+    ntfs|ntfs3)
+        $MKFS_NTFS_PROG $MKFS_OPTIONS $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
 		2>$tmp.mkfserr 1>$tmp.mkfsstd
@@ -826,6 +836,10 @@ _scratch_mkfs()
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
 		;;
+	ntfs|ntfs3)
+		mkfs_cmd="$MKFS_NTFS_PROG"
+		mkfs_filter="cat"
+		;;
 	*)
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="cat"
@@ -1091,6 +1105,10 @@ _scratch_mkfs_sized()
 	bcachefs)
 		$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS --fs_size=$fssize --block_size=$blocksize $SCRATCH_DEV
 		;;
+	ntfs|ntfs3)
+		${MKFS_NTFS_PROG} $MKFS_OPTIONS $SCRATCH_DEV \
+			$(expr $blocks / 2)
+		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 		;;
@@ -1173,6 +1191,9 @@ _scratch_mkfs_blocksized()
 		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS --block_size=$blocksize \
 								$SCRATCH_DEV
 		;;
+	ntfs|ntfs3)
+		${MKFS_NTFS_PROG} -F $MKFS_OPTIONS -s $blocksize $SCRATCH_DEV
+		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
 		;;
@@ -1247,6 +1268,10 @@ _repair_scratch_fs()
 	# want the test to fail:
 	_check_scratch_fs
 	;;
+    ntfs|ntfs3)
+	$FSCK_NTFS_PROG $SCRATCH_DEV
+	return $?
+	;;
     *)
 	local dev=$SCRATCH_DEV
 	local fstyp=$FSTYP
@@ -1294,6 +1319,10 @@ _repair_test_fs()
 			res=$?
 		fi
 		;;
+	ntfs|ntfs3)
+		$FSCK_NTFS_PROG $TEST_DEV > $tmp.repair 2>&1
+		return $?
+		;;
 	*)
 		# Let's hope fsck -y suffices...
 		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
@@ -1433,8 +1462,11 @@ _fs_type()
     # Fix the filesystem type up here so that the callers don't
     # have to bother with this quirk.
     #
-    _df_device $1 | $AWK_PROG '{ print $2 }' | \
-        sed -e 's/nfs4/nfs/' -e 's/fuse.glusterfs/glusterfs/'
+    local sed_prog="-e s/nfs4/nfs/ -e s/fuse.glusterfs/glusterfs/"
+    if [ $FSTYP = ntfs ]; then
+	sed_prog="$sed_prog -e s/fuseblk/ntfs/"
+    fi
+    _df_device $1 | $AWK_PROG '{ print $2 }' | sed $sed_prog
 }
 
 # return the FS mount options of a mounted device
@@ -2897,6 +2929,9 @@ _is_dev_mounted()
 		exit 1
 	fi
 
+	if [ $fstype = ntfs ]; then
+	    fstype=fuseblk
+	fi
 	findmnt -rncv -S $dev -t $fstype -o TARGET | head -1
 }
 
@@ -3017,11 +3052,15 @@ _pre_fsck_prepare()
 _check_generic_filesystem()
 {
     local device=$1
+    local fsck_type=$2
 
     # If type is set, we're mounted
     local type=`_fs_type $device`
     local ok=1
 
+    if [ -z "$fsck_type" ]; then
+       fsck_type="$FSTYP"
+    fi
     if [ "$type" = "$FSTYP" ]
     then
         # mounted ...
@@ -3029,7 +3068,7 @@ _check_generic_filesystem()
     fi
 
     _pre_fsck_prepare $device
-    fsck -t $FSTYP $FSCK_OPTIONS $device >$tmp.fsck 2>&1
+    fsck -t $fsck_type $FSCK_OPTIONS $device >$tmp.fsck 2>&1
     if [ $? -ne 0 ]
     then
 	_log_err "_check_generic_filesystem: filesystem on $device is inconsistent"
@@ -3150,6 +3189,9 @@ _check_test_fs()
     btrfs)
 	_check_btrfs_filesystem $TEST_DEV
 	;;
+    ntfs|ntfs3)
+	_check_generic_filesystem $TEST_DEV $ntfs
+	;;
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
@@ -3211,6 +3253,9 @@ _check_scratch_fs()
     btrfs)
 	_check_btrfs_filesystem $device
 	;;
+    ntfs|ntfs3)
+	_check_generic_filesystem $device ntfs
+	;;
     tmpfs)
 	# no way to check consistency for tmpfs
 	;;
-- 
2.31.0

