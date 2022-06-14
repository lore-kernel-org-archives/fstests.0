Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A65C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jun 2022 10:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiFNK5h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiFNK5I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2022 06:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF833CA58
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 03:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B65D61243
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 10:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A9DC3411B;
        Tue, 14 Jun 2022 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655204225;
        bh=ebIxST7iBPRkafVnc7YaBxjaTW+kZF38/sYuFxxNrZg=;
        h=From:To:Cc:Subject:Date:From;
        b=VRPmbFeQ1xZBP0fGM1RUKD3XBVzI2hSoXepdaip0zR3DlwIt+OyjUClTzOS2UqP1Q
         v8Q0R0CcrmtRMHYXtoTM1/ddBlRw7UMod1UEvRn42NdH7KhlfknDSc2TE5qHLHeve5
         uqSLgnk2PHtwH4GFcfuTxOymQCZI63tBVkgR6dAzVlicyCWVXwuG+DaTV3A4gRSDk8
         w94i/v6KOpy+o2kgHF1GWwv8SVSLq8DC15evvxPot/cvL0r+M09YKZBfH2Hay8vH18
         ICdGZzMfSkcwnJIp/UxOIiPxaw4Bm38oI8U5qhrb0Z88vCKil8qZb2KNmbdU9Hb71W
         7Z2g7gX4w72fA==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2] generic/692: test group ownership change
Date:   Tue, 14 Jun 2022 12:56:56 +0200
Message-Id: <20220614105657.2287718-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6806; h=from:subject; bh=ebIxST7iBPRkafVnc7YaBxjaTW+kZF38/sYuFxxNrZg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSStyCzdqshyqWfJCYsPojIXd/CzX+Dl0X6xv+dQee4k72/M /1XvdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk+kGG/zW3ru7lOuNqsOcS6/QXs1 g1O1aVLvyZtvc/v9HOXRNEA64yMjxKrdhl1mqU3zvto72wm3SsrsIa5hzGeI496pqXNjbNZwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When group ownership is changed a caller whose fsuid owns the inode can
change the group of the inode to any group they are a member of. When
searching through the caller's groups we failed to use the gid mapped
according to the idmapped mount otherwise we fail to change ownership.
Add a test for this.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: <fstests@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
/* v2 */
- Zorro Lang <zlang@redhat.com>:
  - various minor fixes

- Christian Brauner (Microsoft) <brauner@kernel.org>:
  - Expand test to also cover overlayfs on top of idmapped mounts.
---
 tests/generic/692     | 181 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/692.out |  31 ++++++++
 2 files changed, 212 insertions(+)
 create mode 100755 tests/generic/692
 create mode 100644 tests/generic/692.out

diff --git a/tests/generic/692 b/tests/generic/692
new file mode 100755
index 00000000..9c982c8a
--- /dev/null
+++ b/tests/generic/692
@@ -0,0 +1,181 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
+#
+# FS QA Test 692
+#
+# Test that users can changed group ownership of a file they own to a group
+# they are a member of.
+#
+# Regression test for commit:
+#
+# 168f91289340 ("fs: account for group membership")
+#
+. ./common/preamble
+_begin_fstest auto quick perms attr idmapped mount
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $SCRATCH_MNT/target-mnt 2>/dev/null
+	$UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
+	$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
+	rm -r -f $tmp.*
+}
+
+# real QA test starts here
+_supported_fs ^overlay
+_require_extra_fs overlay
+_supports_filetype $SCRATCH_MNT || _notrun "overlayfs test requires d_type"
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
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+uqid=`id -u fsgqa`
+gqid=`id -g fsgqa`
+uqid2=`id -u fsgqa2`
+gqid2=`id -g fsgqa2`
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
+		--map-mount=u:65534:$uqid:1 \
+		--map-mount=g:65534:$gqid:1 \
+		--map-mount=u:65535:$uqid2:1 \
+		--map-mount=g:65535:$gqid2:1 \
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
+	_user_do "id -u --name; id -g --name; chgrp $gqid $path"
+	stat -c '%U:%G' $path
+}
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
+# Basic test as explained in the comment for change_group_ownership().
+run_base_test()
+{
+	echo ""
+	echo "base idmapped test"
+	change_group_ownership "$SCRATCH_MNT/target-mnt/file1"
+	reset_ownership
+}
+
+lower="$SCRATCH_MNT/target-mnt"
+upper="$SCRATCH_MNT/ovl-upper"
+work="$SCRATCH_MNT/ovl-work"
+merge="$SCRATCH_MNT/ovl-merge"
+
+# Prepare overlayfs with metacopy turned off.
+setup_overlayfs_idmapped_lower_metacopy_off()
+{
+	mkdir $upper
+	mkdir $work
+	mkdir $merge
+
+	mount -t overlay overlay -o "lowerdir=$lower,upperdir=$upper,workdir=$work,metacopy=off" $merge || _notrun "overlayfs test doesn't support idmappped layers" 
+}
+
+# Prepare overlayfs with metacopy turned on.
+setup_overlayfs_idmapped_lower_metacopy_on()
+{
+	mkdir $upper
+	mkdir $work
+	mkdir $merge
+
+	mount -t overlay overlay -o "lowerdir=$lower,upperdir=$upper,workdir=$work,metacopy=on" $merge
+}
+
+reset_overlayfs()
+{
+	rm -rf $upper
+	rm -rf $work
+	$UMOUNT_PROG $SCRATCH_MNT/ovl-merge 2>/dev/null
+	rm -rf $merge
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
+setup_tree
+setup_idmapped_mnt
+run_base_test
+
+setup_overlayfs_idmapped_lower_metacopy_off
+run_overlayfs_idmapped_lower_metacopy_off
+
+setup_overlayfs_idmapped_lower_metacopy_on
+run_overlayfs_idmapped_lower_metacopy_on
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/692.out b/tests/generic/692.out
new file mode 100644
index 00000000..bda8400e
--- /dev/null
+++ b/tests/generic/692.out
@@ -0,0 +1,31 @@
+QA output created by 692
+
+base idmapped test
+fsgqa:fsgqa2
+fsgqa
+fsgqa
+fsgqa:fsgqa
+
+reset ownership
+65534:65534
+65534:65535
+
+overlayfs idmapped lower metacopy off
+fsgqa:fsgqa2
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
+
+reset ownership
+65534:65534
+65534:65535

base-commit: 568ac9fffeb6afec03e5d6c9936617232fd7fc6d
-- 
2.34.1

