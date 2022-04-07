Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3A6C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Apr 2022 11:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiDGLZv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Apr 2022 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244774AbiDGLZq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Apr 2022 07:25:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC022F3B2
        for <fstests@vger.kernel.org>; Thu,  7 Apr 2022 04:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A9CDB82731
        for <fstests@vger.kernel.org>; Thu,  7 Apr 2022 11:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708F3C385A0;
        Thu,  7 Apr 2022 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649330623;
        bh=NcVW91kom9isPLi64uIHTp/40atrcBpwkSVW6QdsWGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fkby8a8vMxvyftLTucgf51uqiwkmq6nJp5tfTAKP1qvbWWrsffp4O9UplqvRTK/fh
         U/HE3HNndgEOnvb7MX6RDRvL3/zefi+Tw1Cj8mSbX963y/ha8HZ51Pm+pQDQn4itMN
         H+G/brmoGkOwyeYQz/lA+MFQ91K9JCrArj9IKZRsn7iXAE+JDYayC1so+W9ttlt0Ap
         tcUvrJnKErLJd8T47/NMOH76ShrrxZPHfw8c/efhOIROZWZYnYNb0UpoJpr6/gQC/s
         nuwSzxnFOeHnIL5j6v7voZYXNxRpEgoH3K4pkykc2KFrkd5p7sD062T3PJ9yLvsn7m
         vLOOqcLoDfclA==
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
Subject: [PATCH v5] common: allow to run all tests on idmapped mounts
Date:   Thu,  7 Apr 2022 13:21:57 +0200
Message-Id: <20220407112157.1775081-21-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407112157.1775081-1-brauner@kernel.org>
References: <20220407112157.1775081-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7720; h=from:subject; bh=NcVW91kom9isPLi64uIHTp/40atrcBpwkSVW6QdsWGE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST5nfQLc20+Ybtk7cU+llMf0mbwnj0hYDj95s+/SsrynhwP 3bwfdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk8R5GhnPbrK/ocCzsjcsoZz10Iu TDsgXTHrkt6NgtnNp0ffp2uT8Mf2W+S7gf8Nt08ZNJc+fPjYdV/NZ/zmbIkfue0NJdtcvxPCMA
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

Note that the infrastructure is completely generic so every filesystem that
supports idmapped mounts can simply run all of their tests idmapped. But
note that not all ways to create a mount have been converted yet. That
includes e.g. _dmthin_mount and direct calls to _mount in various tests.

In addition, there will be corner-cases. For example, xfs doesn't allow
bulkstat on idmapped mounts because it is a filesystem wide operation,
i.e. you can retrieve information for any inode in the filesystem so the
operation cannot be scoped reasonably under a single mount. So xfstests
testing bulkstat will fail as it's blocked. Similar for some btrfs
ioctl()s.

While we could of course restrict this testmode to -overlay for which we
know things work correctly we should not do this. It would mean that
people won't start using it and so we won't see issues unless someone
sits down and goes through more than 1000 tests and figures out for each
individual one whether it needs to be skipped or not.

So instead allow this mode but for all filesystems so people can start
running and reporting failures and we can fix them up or block them as
we detect them.

Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: <fstests@vger.kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
unchanged

/* v3 */
- Amir Goldstein <amir73il@gmail.com>:
  - Add more detailed explanation about the current state and
    expectations of the newly added IDMAPPED_MOUNTS support.

/* v4 */
- Amir Goldstein <amir73il@gmail.com>:
  - Document new IDMAPPED_MOUNTS env variable in README and add an
    [idmapped] section to README.overlay.

/* v5 */
- Amir Goldstein <amir73il@gmail.com>:
  - Remove unneeded line in _overlay_config_restore.
---
 README         |  5 +++++
 README.overlay |  6 +++++-
 common/config  |  1 +
 common/overlay |  2 ++
 common/rc      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 9f01aa10..0f98035c 100644
--- a/README
+++ b/README
@@ -78,6 +78,11 @@ Preparing system for tests:
 	     - setenv TEST_LOGDEV "device for test-fs external log"
              - setenv TEST_RTDEV "device for test-fs realtime data"
              - if TEST_LOGDEV and/or TEST_RTDEV, these will always be used.
+             - set IDMAPPED_MOUNTS=true to run all tests on top of idmapped
+               mounts. While this option is supported for all filesystems
+               currently only -overlay is expected to run without issues. For
+               other filesystems additional patches and fixes to the test suite
+               might be needed.
              - if SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL
                environment variable set to "yes" will enable their use.
              - setenv DIFF_LENGTH "number of diff lines to print from a failed test",
diff --git a/README.overlay b/README.overlay
index 39e25ada..ec4671c3 100644
--- a/README.overlay
+++ b/README.overlay
@@ -31,7 +31,8 @@ partly supported with './check -overlay'. Only multi-section files that
 do not change FSTYP and MKFS_OPTIONS can be safely used with -overlay.
 
 For example, the following multi-section config file can be used to
-run overlay tests on the same base fs, but with different mount options:
+run overlay tests on the same base fs, but with different mount options, and on
+top of idmapped mounts:
 
  [xfs]
  TEST_DEV=/dev/sda5
@@ -46,6 +47,9 @@ run overlay tests on the same base fs, but with different mount options:
  OVERLAY_MOUNT_OPTIONS="-o redirect_dir=off"
  OVERLAY_FSCK_OPTIONS="-n -o redirect_dir=off"
 
+ [idmapped]
+ IDMAPPED_MOUNTS=true
+
 In the example above, MOUNT_OPTIONS will be used to mount the base scratch fs,
 TEST_FS_MOUNT_OPTS will be used to mount the base test fs,
 OVERLAY_MOUNT_OPTIONS will be used to mount both test and scratch overlay and
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

