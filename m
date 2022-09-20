Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF1ECAAD8
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 11:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiITLuu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiITLut (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 07:50:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92B474375
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 04:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 710EDB8285C
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 11:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8581BC433B5;
        Tue, 20 Sep 2022 11:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663674646;
        bh=2QMcO+p/LyW1MZAZS0Dx8hesT1Jpcnb7urwzXd+wwrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+AvLeUe8S1cRA1Vf5ZklNIyoD8HioyolG14Ql0IoibyWKbmFI2mgJyD/53KP54gO
         oBoO1XRMChlIgGzOBeyu6ZLloAOtfcuf/j2uZiyx1+3MhciTY+nE3W/zVMvvPMnVjc
         06VZVkRN8kDgnLqmPLLfZ5PMZkXM6TaxUrqYGZ31VcMbWIC4GQKxSxtBdIYPklzq/x
         A9vc1yEBOZoc9yvZbWVxSe8MhT8wFfWlwdQPg7qKYzygkfLZjNdTM4Ec2O05q9MsMl
         hOkRanaUMMJ8XaEMArPsCrs67ao3ku9XJQuJAaBH0kmT9O0Zuudxa1kKuUoBuipgBb
         0lcy4ZzX5RVhg==
From:   Zorro Lang <zlang@kernel.org>
To:     brauner@kernel.org, fstests@vger.kernel.org
Cc:     sforshee@digitalocean.com, amir73il@gmail.com, hch@lst.de,
        cyphar@cyphar.com
Subject: [PATCH v4 1/2] generic: basic group ownership changing test
Date:   Tue, 20 Sep 2022 19:50:34 +0800
Message-Id: <20220920115035.2472076-2-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220920115035.2472076-1-zlang@kernel.org>
References: <20220920115035.2472076-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

When group ownership is changed a caller whose fsuid owns the inode
can change the group of the inode to any group they are a member of.
When searching through the caller's groups we failed to use the gid
mapped according to the idmapped mount otherwise we fail to change
ownership. Add a test for this.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 tests/generic/698     | 117 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/698.out |  19 +++++++
 2 files changed, 136 insertions(+)
 create mode 100755 tests/generic/698
 create mode 100644 tests/generic/698.out

diff --git a/tests/generic/698 b/tests/generic/698
new file mode 100755
index 00000000..143490b2
--- /dev/null
+++ b/tests/generic/698
@@ -0,0 +1,117 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
+#
+# FS QA Test 698
+#
+# Test that users can changed group ownership of a file they own to a group
+# they are a member of.
+#
+# Regression test for commit:
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
+	$UMOUNT_PROG $SCRATCH_MNT 2>/dev/null
+	rm -r -f $tmp.*
+}
+
+# real QA test starts here
+_supported_fs generic
+_fixed_by_kernel_commit 168f91289340 \
+	"fs: account for group membership"
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
+run_base_test()
+{
+	mkdir -p $SCRATCH_MNT/source-mnt
+	chmod 0777 $SCRATCH_MNT/source-mnt
+	touch $SCRATCH_MNT/source-mnt/file1
+	chown $user_foo:$group_foo $SCRATCH_MNT
+	chown $user_foo:$group_foo $SCRATCH_MNT/source-mnt
+	chown $user_foo:$group_bar $SCRATCH_MNT/source-mnt/file1
+
+	echo ""
+	echo "base test"
+	change_group_ownership "$SCRATCH_MNT/source-mnt/file1"
+	rm -rf "$SCRATCH_MNT/source-mnt"
+}
+
+# Basic test as explained in the comment for change_group_ownership().
+run_idmapped_test()
+{
+	echo ""
+	echo "base idmapped test"
+	change_group_ownership "$SCRATCH_MNT/target-mnt/file1"
+}
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+run_base_test
+setup_tree
+setup_idmapped_mnt
+run_idmapped_test
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/698.out b/tests/generic/698.out
new file mode 100644
index 00000000..519234b5
--- /dev/null
+++ b/tests/generic/698.out
@@ -0,0 +1,19 @@
+QA output created by 698
+
+base test
+fsgqa:fsgqa2
+fsgqa
+fsgqa
+fsgqa:fsgqa
+fsgqa
+fsgqa
+fsgqa:fsgqa
+
+base idmapped test
+fsgqa:fsgqa2
+fsgqa
+fsgqa
+fsgqa:fsgqa
+fsgqa
+fsgqa
+fsgqa:fsgqa
-- 
2.31.1

