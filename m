Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759A7C4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 05:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EFD60FBF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Aug 2021 05:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhHLFAl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Aug 2021 01:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhHLFAk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Aug 2021 01:00:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6681FC061765
        for <fstests@vger.kernel.org>; Wed, 11 Aug 2021 22:00:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bo18so7523395pjb.0
        for <fstests@vger.kernel.org>; Wed, 11 Aug 2021 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbXOTkk4PEWs9fPrbcGetO9OkDZKcfSJ25zvsH+g12o=;
        b=EaTHJLE0fte00n/ePrNzZ6aYSrq9hETo7D3hGkVoG2gPh+9Y1j39PyzZlo2jAbrnAk
         kO308dL/WMeziFo52VoPSI9uFq6sARQRyrsbES60O2HjzfoFCqbrtEQGFPV4AakG8cT5
         snk8haUc2LU/YNvCZA3OhxKD/pY5KbpRTA2apn9aixMeO+3G7wlyuIN8211ECxiYjf5N
         H7Cm1iQ+xfEgBY8komvIft4t6s+pLeHRpJI3FSAj2abreHZfj+t4sFpxTxKxVTct9SEP
         0AtgF5fMOogUS6UrrYoMsSn0Zgf5asRrOc/HgMhc3055b6afqRG72fJ2N5lZllr/yqSo
         7AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AbXOTkk4PEWs9fPrbcGetO9OkDZKcfSJ25zvsH+g12o=;
        b=GLFJ8WtWrRK4q4f4U82fmvmidU2LnM3d16CvjxLu5v7Hb0cbaik4mImDNb/1DbWwbZ
         ZdbVrfJtmyj7vJ7gg+oWI/0ZaXnzUxp+9Niq4+v9JQiUjO5Xzp0fac7/qvEFrNdD0j9U
         2PiuZYU7lTB331ovNpt/KlnDE9zs3FqXYYVdPNlbO8n03kdfv+yyL07xPIPg6Mb4PujO
         ItW0j5k6wkixMi5HnXi/xnnKFJuA+kwOEGJqwIMYUN6fWo+EIAqBpkofiOQOj0CQAF66
         JhGd9LTygKy4RRXDbQ03jO8a8S70qgvLQ99qAB5+wapX5u+NdC++MGQOEqqUTk/5C9XC
         XHpg==
X-Gm-Message-State: AOAM532jYKK6YuoaQUbZdt9abx8S59N7EPuQP2COG7/wkU43L+Srm0aP
        +3svncoCnXV54VrqtxZ1DPgoufeBXVVUOw==
X-Google-Smtp-Source: ABdhPJwT0RutsgDR51fxNmN9qXvkDdti/l+vtT3U7bR84SgcRoZuyfAcuUHxJ9sFsVD3cumHil6/AQ==
X-Received: by 2002:a17:902:c405:b029:12c:cbce:26b9 with SMTP id k5-20020a170902c405b029012ccbce26b9mr2062547plk.69.1628744414629;
        Wed, 11 Aug 2021 22:00:14 -0700 (PDT)
Received: from localhost.localdomain ([103.117.61.119])
        by smtp.gmail.com with ESMTPSA id i14sm1489622pgh.79.2021.08.11.22.00.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 22:00:14 -0700 (PDT)
From:   Bhumit Attarde <bhumitattarde01@gmail.com>
X-Google-Original-From: Bhumit Attarde <bhumit.attarde01@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Bhumit Attarde <bhumit.attarde01@gmail.com>
Subject: [PATCH 1/1] Added FUSE support
Date:   Thu, 12 Aug 2021 10:29:50 +0530
Message-Id: <20210812045950.3190-1-bhumit.attarde01@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This allows any FUSE filesystem that can mounted like
`mount -t fuse.$FUSE_SUBTYP`
to be tested using XFSTESTS.

This patch is an improvment on the patch originally submitted by Miklos
Szeredi.

Signed-off-by: Bhumit Attarde <bhumit.attarde01@gmail.com>
---
 README.fuse   | 29 +++++++++++++++++++++++++++++
 check         |  2 ++
 common/attr   |  4 ++--
 common/config | 10 ++++++++--
 common/rc     | 31 +++++++++++++++++++++++--------
 5 files changed, 64 insertions(+), 12 deletions(-)
 create mode 100644 README.fuse

diff --git a/README.fuse b/README.fuse
new file mode 100644
index 00000000..839db5dd
--- /dev/null
+++ b/README.fuse
@@ -0,0 +1,29 @@
+Make sure you've followed instructions from the principal README.
+Instructions to test FUSE using the passthrough_ll example filesystem provided in the libfuse source tree:
+
+git clone git://github.com/libfuse/libfuse.git
+cd libfuse
+meson build
+cd build
+ninja
+cp example/passthrough_ll /usr/bin
+cd
+cat << 'EOF' > /sbin/mount.fuse.passthrough_ll
+#!/bin/bash
+ulimit -n 1048576
+exec /usr/bin/passthrough_ll -ofsname="$@"
+EOF
+chmod +x /sbin/mount.fuse.passthrough_ll
+mkdir -p /mnt/test /mnt/scratch /home/test/test /home/test/scratch
+
+
+Use the following config file:
+
+export TEST_DEV=passthrough_ll
+export TEST_DIR=/mnt/test
+export SCRATCH_DEV=passthrough_ll
+export SCRATCH_MNT=/mnt/scratch
+export FSTYP=fuse
+export FUSE_SUBTYP=.passthrough_ll
+export FUSE_MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
+export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"
diff --git a/check b/check
index a0863121..bae9fddd 100755
--- a/check
+++ b/check
@@ -59,6 +59,7 @@ check options
     -glusterfs		test GlusterFS
     -cifs		test CIFS
     -9p			test 9p
+    -fuse		test fuse
     -virtiofs		test virtiofs
     -overlay		test overlay
     -pvfs2		test PVFS2
@@ -281,6 +282,7 @@ while [ $# -gt 0 ]; do
 	-glusterfs)	FSTYP=glusterfs ;;
 	-cifs)		FSTYP=cifs ;;
 	-9p)		FSTYP=9p ;;
+	-fuse)		FSTYP=fuse ;;
 	-virtiofs)	FSTYP=virtiofs ;;
 	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
 	-pvfs2)		FSTYP=pvfs2 ;;
diff --git a/common/attr b/common/attr
index 35682d7c..f3342d25 100644
--- a/common/attr
+++ b/common/attr
@@ -253,7 +253,7 @@ _getfattr()
 
 # set maximum total attr space based on fs type
 case "$FSTYP" in
-xfs|udf|pvfs2|9p|ceph|nfs)
+xfs|udf|pvfs2|9p|ceph|nfs|fuse)
 	MAX_ATTRS=1000
 	;;
 ext2|ext3|ext4)
@@ -312,7 +312,7 @@ xfs|udf|btrfs)
 pvfs2)
 	MAX_ATTRVAL_SIZE=8192
 	;;
-9p|ceph|nfs)
+9p|ceph|nfs|fuse)
 	MAX_ATTRVAL_SIZE=65536
 	;;
 bcachefs)
diff --git a/common/config b/common/config
index 005fd50a..8203492d 100644
--- a/common/config
+++ b/common/config
@@ -305,6 +305,9 @@ _mount_opts()
 	9p)
 		export MOUNT_OPTIONS=$PLAN9_MOUNT_OPTIONS
 		;;
+	fuse)
+		export MOUNT_OPTIONS=$FUSE_MOUNT_OPTIONS
+		;;
 	xfs)
 		export MOUNT_OPTIONS=$XFS_MOUNT_OPTIONS
 		;;
@@ -363,6 +366,9 @@ _test_mount_opts()
 	9p)
 		export TEST_FS_MOUNT_OPTS=$PLAN9_MOUNT_OPTIONS
 		;;
+	fuse)
+		export TEST_FS_MOUNT_OPTS=$FUSE_MOUNT_OPTIONS
+		;;
 	cifs)
 		export TEST_FS_MOUNT_OPTS=$CIFS_MOUNT_OPTIONS
 		;;
@@ -501,8 +507,8 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	9p|tmpfs|virtiofs)
-		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
+	9p|fuse|tmpfs|virtiofs)
+		# 9p, fuse and virtiofs mount tags are just plain strings, so anything is allowed
 		# tmpfs doesn't use mount source, ignore
 		;;
 	overlay)
diff --git a/common/rc b/common/rc
index d4b1f21f..1ae0746a 100644
--- a/common/rc
+++ b/common/rc
@@ -127,6 +127,8 @@ case "$FSTYP" in
 	 ;;
     9p)
 	 ;;
+    fuse)
+	 ;;
     ceph)
 	 . ./common/ceph
 	 ;;
@@ -333,7 +335,7 @@ _try_scratch_mount()
 		_overlay_scratch_mount $*
 		return $?
 	fi
-	_mount -t $FSTYP `_scratch_mount_options $*`
+	_mount -t $FSTYP$FUSE_SUBTYP `_scratch_mount_options $*`
 }
 
 # mount scratch device with given options and _fail if mount fails
@@ -643,6 +645,9 @@ _test_mkfs()
     9p)
 	# do nothing for 9p
 	;;
+    fuse)
+    	# do nothing for fuse
+    	;;
     virtiofs)
 	# do nothing for virtiofs
 	;;
@@ -683,6 +688,9 @@ _mkfs_dev()
     9p)
 	# do nothing for 9p
 	;;
+    fuse)
+    	# do nothing for fuse
+    	;;
     virtiofs)
 	# do nothing for virtiofs
 	;;
@@ -750,7 +758,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1271,7 +1279,7 @@ _df_device()
 
     # Note that we use "==" here so awk doesn't try to interpret an NFS over
     # IPv6 server as a regular expression.
-    $DF_PROG 2>/dev/null | $AWK_PROG -v what=$1 '
+    $DF_PROG -a 2>/dev/null | $AWK_PROG -v what=$1 '
         ($1==what) && (NF==1) {
             v=$1
             getline
@@ -1514,14 +1522,15 @@ _check_mounted_on()
 	[ -n "$mount_rec" ] || return 1 # 1 = not mounted
 
 	# if it's mounted, make sure its on $mnt
-	if [ "$mount_rec" != "$dev $mnt" ]; then
+	# This check doesn't apply to FUSE since both mounts have the same device
+	if [[ "$FSTYP" != "fuse" && "$mount_rec" != "$dev $mnt" ]]; then
 		echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
 		echo "Already mounted result:"
 		echo $mount_rec
 		return 2 # 2 = mounted on wrong mnt
 	fi
 
-	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
+	if [ -n "$type" -a "`_fs_type $dev`" != "$type$FUSE_SUBTYP" ]; then
 		echo "$devname=$dev is mounted but not a type $type filesystem"
 		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
 		_df_device $dev
@@ -1545,7 +1554,7 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
-	9p|virtiofs)
+	9p|fuse|virtiofs)
 		if [ -z "$SCRATCH_DEV" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
 		fi
@@ -1701,7 +1710,7 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
-	9p|virtiofs)
+	9p|fuse|virtiofs)
 		if [ -z "$TEST_DEV" ]; then
 			_notrun "this test requires a valid \$TEST_DEV"
 		fi
@@ -2863,7 +2872,7 @@ _mount_or_remount_rw()
 
 	if [ $USE_REMOUNT -eq 0 ]; then
 		if [ "$FSTYP" != "overlay" ]; then
-			_mount -t $FSTYP $mount_opts $device $mountpoint
+			_mount -t $FSTYP$FUSE_SUBTYP $mount_opts $device $mountpoint
 		else
 			_overlay_mount $device $mountpoint
 		fi
@@ -3000,6 +3009,9 @@ _check_test_fs()
     9p)
 	# no way to check consistency for 9p
 	;;
+    fuse)
+    	# no way to check consistency for fuse
+    	;;
     virtiofs)
 	# no way to check consistency for virtiofs
 	;;
@@ -3061,6 +3073,9 @@ _check_scratch_fs()
     9p)
 	# no way to check consistency for 9p
 	;;
+    fuse)
+    	# no way to check consistency for fuse
+    	;;
     virtiofs)
 	# no way to check consistency for virtiofs
 	;;
-- 
2.30.1

