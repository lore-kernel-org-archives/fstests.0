Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F936C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 17:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357378AbiELR4V (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357370AbiELR4P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 13:56:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10936D4FC
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 10:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 014C1B82ACE
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 17:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7D0C34116;
        Thu, 12 May 2022 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652378170;
        bh=9NQWpq4v841k3RlDwFJKqb0hHokp8NBRugssywNlBxY=;
        h=From:To:Cc:Subject:Date:From;
        b=YftYCTh4bQPN5laXXL9x8mBkFO917huI7lGnLiVQ4vG05M2Qh0PVpkmENorQgJmv+
         MBrTZ15UkMLWHPnGsqQwOArUQzAIYUW64d+HKnQL6SoZjkxmb0fJD3E8mDHKZovNKM
         gX8SNOk3+xQboVYj1sNqftsOtWeYcSDfUmmOE1WIVWDIqktq/wndiwCCYp021v6Yzc
         Zgg0/WuqFjo/89bdqY3D8DLUEPoHwEdBIwC5dEODzXSYBpJnI4zLQ3x/arupgEU/4n
         6rGy+b/BUkEEK6CEM2VYMMNPaw5kfPLTZrzq6wmFAVDSNamcNgkkomVVdMOLXNqRIJ
         X2vijJu28yQYg==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     amir73il@gmail.com
Subject: [PATCH] common/overlay: source base fs specific common file
Date:   Fri, 13 May 2022 01:56:03 +0800
Message-Id: <20220512175603.2833164-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When tests overlayfs, sometimes we need the underlying fs specific
helpers, e.g. common/rc has:
  _filesystem_timestamp_range $OVL_BASE_TEST_DEV $OVL_BASE_FSTYP

So when we source common/overlay, better to source then OVL_BASE_FSTYP
too.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

The generic/402 always fails on overlayfs as:

  QA output created by 402
  ./common/rc: line 2441: _xfs_timestamp_range: command not found
  ./common/rc: line 2403: [: syntax error: '-1' unexpected
  ./common/rc: line 2408: [: -le: unary operator expected
  ./common/rc: line 2441: _xfs_timestamp_range: command not found
  0;0 != 1;1
  0;0 != 1;1
  Silence is golden

Due to if FSTYP is overlay, we only source common/overlay file. But we
still need the helpers of the underlying filesystem. So I think we need
to source the common/$OVL_BASE_FSTYP in common/overlay. What do you think?

Thanks,
Zorro


 common/config  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 common/overlay |  4 ++++
 common/rc      | 49 +----------------------------------------
 3 files changed, 64 insertions(+), 48 deletions(-)

diff --git a/common/config b/common/config
index efcf12e9..b4b2a8d4 100644
--- a/common/config
+++ b/common/config
@@ -481,6 +481,65 @@ _fsck_opts()
 	esac
 }
 
+_source_specific_fs()
+{
+	local fs=$1
+
+	if [ -z "$fs" ];then
+		fs=$FSTYP
+	fi
+
+	case "$fs" in
+	xfs)
+		[ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
+		[ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
+		[ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
+		[ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
+		[ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
+
+		. ./common/xfs
+		;;
+	udf)
+		[ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
+		;;
+	btrfs)
+		[ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
+
+		. ./common/btrfs
+		;;
+	ext4)
+		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
+		;;
+	f2fs)
+		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
+		;;
+	nfs)
+		. ./common/nfs
+		;;
+	cifs)
+		;;
+	9p)
+		;;
+	ceph)
+		. ./common/ceph
+		;;
+	glusterfs)
+		;;
+	overlay)
+		. ./common/overlay
+		;;
+	reiser4)
+		[ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
+		;;
+	pvfs2)
+		;;
+	ubifs)
+		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
+		;;
+	esac
+}
+
+
 known_hosts()
 {
 	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
diff --git a/common/overlay b/common/overlay
index fff67ba1..4708d393 100644
--- a/common/overlay
+++ b/common/overlay
@@ -12,6 +12,10 @@ export OVL_XATTR_NLINK="trusted.overlay.nlink"
 export OVL_XATTR_UPPER="trusted.overlay.upper"
 export OVL_XATTR_METACOPY="trusted.overlay.metacopy"
 
+if [ -n "$OVL_BASE_FSTYP" ];then
+	_source_specific_fs $OVL_BASE_FSTYP
+fi
+
 # helper function to do the actual overlayfs mount operation
 _overlay_mount_dirs()
 {
diff --git a/common/rc b/common/rc
index e907e362..ebdeeb93 100644
--- a/common/rc
+++ b/common/rc
@@ -96,54 +96,7 @@ _log_err()
 umask 022
 
 # check for correct setup and source the $FSTYP specific functions now
-case "$FSTYP" in
-    xfs)
-	 [ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
-	 [ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
-	 [ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
-	 [ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
-	 [ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
-
-	 . ./common/xfs
-	 ;;
-    udf)
-	 [ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
-	 ;;
-    btrfs)
-	 [ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
-
-	 . ./common/btrfs
-	 ;;
-    ext4)
-	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
-	 ;;
-    f2fs)
-	 [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
-	 ;;
-    nfs)
-	 . ./common/nfs
-	 ;;
-    cifs)
-	 ;;
-    9p)
-	 ;;
-    ceph)
-	 . ./common/ceph
-	 ;;
-    glusterfs)
-	 ;;
-    overlay)
-	 . ./common/overlay
-	 ;;
-    reiser4)
-	 [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
-	 ;;
-    pvfs2)
-	;;
-    ubifs)
-	[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
-	;;
-esac
+_source_specific_fs $FSTYP
 
 if [ ! -z "$REPORT_LIST" ]; then
 	. ./common/report
-- 
2.31.1

