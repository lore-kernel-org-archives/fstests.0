Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F48C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 25 May 2022 07:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbiEYHeu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 May 2022 03:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbiEYHef (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 May 2022 03:34:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B22654BF7
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 00:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7F05B81CBA
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 07:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A794C34114
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653464071;
        bh=qS8ssO1YQaX3xYqZdOSEvhEegK0FX9J8Cv8aoNqtz70=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ggX+tB1oJgmsjGCTSqilQazhYGpJWT+cv0RntxgY1ZK/e8I6H92XmDBNfuvqxPapa
         BP1Uhg0nB6OF/kxfLNvQ6iq9aFMq3K7vGPcokMQEV7wrxznXTC1Ie0zTHe75cELF3P
         Db0CL91qt7CcuoJP1CQSSw2V+AkSmVuQHHrmPa34IMfxM4aFBYn0nbB5edyyRZM+b9
         Q4VaLl31+7GyIoUHObvqunVP0mFM4UMoSbPpq+xRWSca9sREFkL+eQfqGmkFbrYxXs
         BWwfoa/Gb8UvA2OcZexBJLcfKRpGKMLtnGTtDgWsk1yPB+f28uQMl3GvWrFd4QG6f6
         wM5bQuGZPnndw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/2] common: source base fs specific common file
Date:   Wed, 25 May 2022 15:34:26 +0800
Message-Id: <20220525073427.3355242-2-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220525073427.3355242-1-zlang@kernel.org>
References: <20220525073427.3355242-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When tests overlayfs, sometimes we need the underlying fs specific
helpers, e.g. common/rc has:
  _filesystem_timestamp_range $OVL_BASE_TEST_DEV $OVL_BASE_FSTYP

So when we source common/overlay, better to source OVL_BASE_FSTYP
too.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/config  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 common/overlay |  4 ++++
 common/rc      | 49 +----------------------------------------
 3 files changed, 64 insertions(+), 48 deletions(-)

diff --git a/common/config b/common/config
index c6428f90..558f148b 100644
--- a/common/config
+++ b/common/config
@@ -481,6 +481,65 @@ _fsck_opts()
 	esac
 }
 
+# check necessary running dependences then source sepcific fs helpers
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
 known_hosts()
 {
 	[ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
diff --git a/common/overlay b/common/overlay
index c4e7ee58..e35419d0 100644
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
index 70a15f9c..2f31ca46 100644
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

