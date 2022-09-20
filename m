Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AE7C6FA8B
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 11:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiITLuv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiITLuu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 07:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286896E2CB
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 04:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A6161E41
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 11:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913D8C433D6;
        Tue, 20 Sep 2022 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663674648;
        bh=7P01kViLloP5KDk//+wrLonkGedcl1Wued56Wjxm96c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMarvxb5ydX2u79K3oKCmHOgwJNG6NGMtcYxT4i4ZgFymVvrjVtYGH9mdIUd7u+fI
         KhvVUIpRAUCwDCj5l/5ofaUvHXeJO71tNP0vqEPb2xG3sK2usR9JBuJqN5FLlrM+xr
         Ak3TrgBcdgQO91/A8bP5pTTxs/uXtFYSkQmuzo6EsS24dB3MENp/UWk5lAQemKTeSS
         cpSaxZYP5yvepZRF2O45EOliBJAsmi+U1qPR4PChi6fCOY2nWyUvOf618QUgkNV+oE
         RsvWGRugjesshg/AyCSmdhF8QUALFvCMlMnnNql4kp51PemI/a3BpOxi7/lMlAFVMM
         5euayet62vyeQ==
From:   Zorro Lang <zlang@kernel.org>
To:     brauner@kernel.org, fstests@vger.kernel.org
Cc:     sforshee@digitalocean.com, amir73il@gmail.com, hch@lst.de,
        cyphar@cyphar.com
Subject: [PATCH v4 2/2] generic: overlay group ownership changing test
Date:   Tue, 20 Sep 2022 19:50:35 +0800
Message-Id: <20220920115035.2472076-3-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220920115035.2472076-1-zlang@kernel.org>
References: <20220920115035.2472076-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

This's copied from generic/698, extend it to test overlayfs on top of
idmapped mounts specifically.

When group ownership is changed a caller whose fsuid owns the inode can
change the group of the inode to any group they are a member of. When
searching through the caller's groups we failed to use the gid mapped
according to the idmapped mount otherwise we fail to change ownership.
Add a test for this.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 tests/generic/699     | 163 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/699.out |  27 +++++++
 2 files changed, 190 insertions(+)
 create mode 100755 tests/generic/699
 create mode 100644 tests/generic/699.out

diff --git a/tests/generic/699 b/tests/generic/699
new file mode 100755
index 00000000..82e83644
--- /dev/null
+++ b/tests/generic/699
@@ -0,0 +1,163 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
+#
+# FS QA Test 698
+#
+# This's copied from generic/698, extend it to test overlayfs on top of idmapped
+# mounts specifically.
+#
+. ./common/preamble
+. ./common/overlay
+_begin_fstest auto quick perms attr idmapped mount
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $SCRATCH_MNT/target-mnt
+	$UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
+	$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
+	rm -r -f $tmp.*
+}
+
+# real QA test starts here
+_supported_fs ^overlay
+_require_extra_fs overlay
+_require_scratch
+_require_chown
+_require_idmapped_mounts
+_require_test_program "vfs/mount-idmapped"
+_require_user fsgqa2
+_require_group fsgqa2
+# Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
+_require_user fsgqa
+_require_group fsgqa
+
+user_foo=`id -u fsgqa`
+group_foo=`id -g fsgqa`
+user_bar=`id -u fsgqa2`
+group_bar=`id -g fsgqa2`
+
+setup_tree()
+{
+	mkdir -p $SCRATCH_MNT/source-mnt
+	chmod 0777 $SCRATCH_MNT/source-mnt
+	touch $SCRATCH_MNT/source-mnt/file1
+	chown 65534:65534 $SCRATCH_MNT
+	chown 65534:65534 $SCRATCH_MNT/source-mnt
+	chown 65534:65535 $SCRATCH_MNT/source-mnt/file1
+
+	mkdir -p $SCRATCH_MNT/target-mnt
+	chmod 0777 $SCRATCH_MNT/target-mnt
+}
+
+# Setup an idmapped mount where uid and gid 65534 are mapped to fsgqa and uid
+# and gid 65535 are mapped to fsgqa2.
+setup_idmapped_mnt()
+{
+	$here/src/vfs/mount-idmapped \
+		--map-mount=u:65534:$user_foo:1 \
+		--map-mount=g:65534:$group_foo:1 \
+		--map-mount=u:65535:$user_bar:1 \
+		--map-mount=g:65535:$group_bar:1 \
+		$SCRATCH_MNT/source-mnt $SCRATCH_MNT/target-mnt
+}
+
+# We've created a layout where fsgqa owns the target file but the group of the
+# target file is owned by another group. We now test that user fsgqa can change
+# the group ownership of the file to a group they control. In this case to the
+# fsgqa group.
+change_group_ownership()
+{
+	local path="$1"
+
+	stat -c '%U:%G' $path
+	_user_do "id -u --name; id -g --name; chgrp $group_foo $path"
+	stat -c '%U:%G' $path
+	_user_do "id -u --name; id -g --name; chgrp $group_bar $path > /dev/null 2>&1"
+	stat -c '%U:%G' $path
+}
+
+lower="$SCRATCH_MNT/target-mnt"
+upper="$SCRATCH_MNT/ovl-upper"
+work="$SCRATCH_MNT/ovl-work"
+merge="$SCRATCH_MNT/ovl-merge"
+
+reset_ownership()
+{
+	local path="$SCRATCH_MNT/source-mnt/file1"
+
+	echo ""
+	echo "reset ownership"
+	chown 65534:65534 $path
+	stat -c '%u:%g' $path
+	chown 65534:65535 $path
+	stat -c '%u:%g' $path
+}
+
+# Prepare overlayfs with metacopy turned off.
+setup_overlayfs_idmapped_lower_metacopy_off()
+{
+	mkdir -p $upper $work $merge
+	_overlay_mount_dirs $lower $upper $work \
+			    overlay $merge -ometacopy=off || \
+			    _notrun "overlayfs doesn't support idmappped layers"
+}
+
+# Prepare overlayfs with metacopy turned on.
+setup_overlayfs_idmapped_lower_metacopy_on()
+{
+	mkdir -p $upper $work $merge
+	_overlay_mount_dirs $lower $upper $work overlay $merge -ometacopy=on
+}
+
+reset_overlayfs()
+{
+	$UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
+	rm -rf $upper $work $merge
+}
+
+# Overlayfs can be mounted on top of idmapped layers. Make sure that the basic
+# test explained in the comment for change_group_ownership() passes with
+# overlayfs mounted on top of it.
+# This tests overlayfs with metacopy turned off, i.e., changing a file copies
+# up data and metadata.
+run_overlayfs_idmapped_lower_metacopy_off()
+{
+	echo ""
+	echo "overlayfs idmapped lower metacopy off"
+	change_group_ownership "$SCRATCH_MNT/ovl-merge/file1"
+	reset_overlayfs
+	reset_ownership
+}
+
+# Overlayfs can be mounted on top of idmapped layers. Make sure that the basic
+# test explained in the comment for change_group_ownership() passes with
+# overlayfs mounted on top of it.
+# This tests overlayfs with metacopy turned on, i.e., changing a file tries to
+# only copy up metadata.
+run_overlayfs_idmapped_lower_metacopy_on()
+{
+	echo ""
+	echo "overlayfs idmapped lower metacopy on"
+	change_group_ownership "$SCRATCH_MNT/ovl-merge/file1"
+	reset_overlayfs
+	reset_ownership
+}
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+_supports_filetype $SCRATCH_MNT || _notrun "overlayfs test requires d_type"
+
+setup_tree
+setup_idmapped_mnt
+setup_overlayfs_idmapped_lower_metacopy_off
+run_overlayfs_idmapped_lower_metacopy_off
+
+setup_overlayfs_idmapped_lower_metacopy_on
+run_overlayfs_idmapped_lower_metacopy_on
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/699.out b/tests/generic/699.out
new file mode 100644
index 00000000..e5786d8e
--- /dev/null
+++ b/tests/generic/699.out
@@ -0,0 +1,27 @@
+QA output created by 699
+
+overlayfs idmapped lower metacopy off
+fsgqa:fsgqa2
+fsgqa
+fsgqa
+fsgqa:fsgqa
+fsgqa
+fsgqa
+fsgqa:fsgqa
+
+reset ownership
+65534:65534
+65534:65535
+
+overlayfs idmapped lower metacopy on
+fsgqa:fsgqa2
+fsgqa
+fsgqa
+fsgqa:fsgqa
+fsgqa
+fsgqa
+fsgqa:fsgqa
+
+reset ownership
+65534:65534
+65534:65535
-- 
2.31.1

