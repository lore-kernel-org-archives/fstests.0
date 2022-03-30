Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE4DC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 10:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiC3K21 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbiC3K20 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 06:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6025FD6F
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 03:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C43826147F
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 10:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB3AC340EC;
        Wed, 30 Mar 2022 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648636000;
        bh=msDtSVDsswbkeFy2wOXhg33A+c9pGsIQ0VYqAEEZ7N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wc/EbxPckyk9PNva79wG6i1+Es+yCucbwoqVfV9whvOsLH5hIZNphg89kn1trrD5T
         H3S84zOSBY9mVksk92+lUXgllo2gFpiONjNpqM8hRH5QQqILyYilPO4AOF+STl/op1
         tVhCDd6fAhxUnbruKUP0hmZDIKMQqJKKy4QUN7hmGXsy07HKugVKybZY47zuvHH8cX
         lrV6KYz9EeoVryN/K5vwpiWKoGH4QeVEv9e0J+ENiP59prNiGtLYExKv8dzKGpMp+K
         LbGbN0iVYdBPdSY8qklpVXAeQdWvEebi4ZSWpr1QZra3pGMAbDXIhWtRRxHdsB4UaL
         aiWWEcgASeatQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>, Eryu Guan <guan@eryu.me>,
        fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH v2] common: allow to run all tests on idmapped mounts
Date:   Wed, 30 Mar 2022 12:24:08 +0200
Message-Id: <20220330102409.1290850-21-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330102409.1290850-1-brauner@kernel.org>
References: <20220330102409.1290850-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3978; h=from:subject; bh=msDtSVDsswbkeFy2wOXhg33A+c9pGsIQ0VYqAEEZ7N8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS56B+Mfxa/48zPvFM7LRa1mUhr60SwSF2/oZa6UXRW8aLv AuWHO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbC/43hf5DIY6vc6EtfMg5G2/6QzN o+0frd6o/VAv8/qJ7pv/pZJJfhD0fC7jerXpmEXNPtniFglMOklBWz8vntut8VQayhie/4OQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In addition to the generic and filesystem-specific idmapped mount
testsuites that already exist upstream today add simple infrastructure
so any test can be run on idmapped mounts simply by setting
IDMAPPED_MOUNTS=true in the config file or section. The main user for
now will be overlay to verify it works correctly on idmapped mounts.

Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <fstests@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 common/config  |  1 +
 common/overlay |  2 ++
 common/rc      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/common/config b/common/config
index 479e50d1..1033b890 100644
--- a/common/config
+++ b/common/config
@@ -647,6 +647,7 @@ _overlay_config_override()
 	# Set fsck options, use default if user not set directly.
 	export FSCK_OPTIONS="$OVERLAY_FSCK_OPTIONS"
 	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
+	export IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"
 }
 
 _overlay_config_restore()
diff --git a/common/overlay b/common/overlay
index 1ca37e29..fff67ba1 100644
--- a/common/overlay
+++ b/common/overlay
@@ -73,6 +73,7 @@ _overlay_base_mount()
 
 	if [ -z "$dev" -o -z "$mnt" ] || \
 		_check_mounted_on $devname $dev $mntname $mnt; then
+		_idmapped_mount $dev $mnt
 		# no base fs or already mounted
 		return 0
 	elif [ $? -ne 1 ]; then
@@ -81,6 +82,7 @@ _overlay_base_mount()
 	fi
 
 	_mount $* $dev $mnt
+	_idmapped_mount $dev $mnt
 }
 
 _overlay_base_test_mount()
diff --git a/common/rc b/common/rc
index faf54ef9..5090cbf8 100644
--- a/common/rc
+++ b/common/rc
@@ -334,6 +334,7 @@ _try_scratch_mount()
 		return $?
 	fi
 	_mount -t $FSTYP `_scratch_mount_options $*`
+	_idmapped_mount $SCRATCH_DEV $SCRATCH_MNT
 }
 
 # mount scratch device with given options and _fail if mount fails
@@ -444,6 +445,53 @@ _scratch_shutdown_handle()
 	fi
 }
 
+_move_mount()
+{
+	local mnt=$1
+	local tmp=$2
+
+	# Replace $mnt with $tmp. Use a temporary bind-mount because
+	# mount --move will fail with certain mount propagation layouts.
+	$UMOUNT_PROG $mnt || _fail "Failed to unmount $mnt"
+	_mount --bind $tmp $mnt || _fail "Failed to bind-mount $tmp to $mnt"
+	$UMOUNT_PROG $tmp || _fail "Failed to unmount $tmp"
+	rmdir $tmp
+}
+
+_idmapped_mount()
+{
+	[ "$IDMAPPED_MOUNTS" = "true" ] || return 0
+
+	local dev=$1
+	local mnt=$2
+	local status=0
+	local tmp=`mktemp -d`
+
+	local mount_rec=`findmnt -rncv -S $dev -o OPTIONS`
+	if [[ "$mount_rec" == *"idmapped"* ]]; then
+		return 0
+	fi
+
+	# We create an idmapped mount where {g,u}id 0 writes to disk as
+	# {g,u}id 10000000 and $(id -u fsgqa) + 10000000. We change ownership
+        # of $mnt so {g,u} id 0 can actually create objects in there.
+	chown 10000000:10000000 $mnt || return 1
+	$here/src/idmapped-mounts/mount-idmapped \
+		--map-mount b:10000000:0:100000000000 \
+		$mnt $tmp
+	if [ $? -ne 0 ]; then
+		rmdir $tmp
+		return 1
+	fi
+
+	# The next call ensures we don't end up stacking an idmapped mount on
+	# top of the original mount. Instead we fully replace the original
+	# mount with the idmapped mount. This will not just allow a clean mount
+        # layout it also makes unmount and remounting way simpler.
+	_move_mount $mnt $tmp
+	return $?
+}
+
 _test_mount()
 {
     if [ "$FSTYP" == "overlay" ]; then
@@ -452,6 +500,7 @@ _test_mount()
     fi
     _test_options mount
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _idmapped_mount $TEST_DEV $TEST_DIR
 }
 
 _test_unmount()
@@ -3007,6 +3056,7 @@ _mount_or_remount_rw()
 	if [ $USE_REMOUNT -eq 0 ]; then
 		if [ "$FSTYP" != "overlay" ]; then
 			_mount -t $FSTYP $mount_opts $device $mountpoint
+			_idmapped_mount $device $mountpoint
 		else
 			_overlay_mount $device $mountpoint
 		fi
-- 
2.32.0

