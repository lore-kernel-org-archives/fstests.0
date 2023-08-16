Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DEFC001DE
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Aug 2023 00:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbjHPAwp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Aug 2023 20:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjHPAwS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Aug 2023 20:52:18 -0400
Received: from trager.us (trager.us [52.5.81.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4432117
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 17:52:16 -0700 (PDT)
Received: from [163.114.132.6] (helo=localhost)
        by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lee@trager.us>)
        id 1qW4lj-0008Ph-NM; Wed, 16 Aug 2023 00:52:15 +0000
From:   Lee Trager <lee@trager.us>
To:     fstests@vger.kernel.org
Cc:     Lee Trager <lee@trager.us>
Subject: [PATCH v4] fstests: Vertify dir permissions when creating a stub subvolume
Date:   Tue, 15 Aug 2023 17:51:57 -0700
Message-Id: <20230816005157.3703141-1-lee@trager.us>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

btrfs supports creating nesting subvolumes however snapshots are not
recurive. When a snapshot is taken of a volume which contains a subvolume
the subvolume is replaced with a stub subvolume which has the same name and
uses inode number 2. This test validates that the stub volume copies
permissions of the original volume.
Signed-off-by: Lee Trager <lee@trager.us>
---
v4:
- Removed extra blank line in common/rc
- Allowed caller to pass extra options to _require_unshare to check for
  support. -f -r -m -p -U have been supported by util-linux and busybox
  for awhile and are typical options.
- Moved _registry_cleanup to right after _begin_fstest.
- Added "cd /;rm -rf $tmp.*" from standard cleanup to 300 cleanup.
- Added rm -rf $test_dir before running test to ensure its in a clean state.
v3:
- Fixed whitepsace in 300.out due to find command not using './' before %P
v2:
- Migrated _require_unshare from overlay/020 into common_rc. Updated the error
  message as most Linux systems should have unshare from util-linux.
- Added note about why the test must be done in one subshell process.
- chown command now uses $qa_user:$qa_group instead of hard coded values.
common/rc           |  5 +++++
 tests/btrfs/300     | 49 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/300.out | 18 +++++++++++++++++
 tests/overlay/020   |  7 +------
 4 files changed, 73 insertions(+), 6 deletions(-)
 create mode 100755 tests/btrfs/300
 create mode 100644 tests/btrfs/300.out

diff --git a/common/rc b/common/rc
index 5c4429ed..18ea0f02 100644
--- a/common/rc
+++ b/common/rc
@@ -5224,6 +5224,11 @@ _soak_loop_running() {
 	return 0
 }
 
+_require_unshare() {
+	unshare -f -r -m -p -U $@ true &>/dev/null || \
+		_notrun "unshare: command not found, should be in util-linux"
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/btrfs/300 b/tests/btrfs/300
new file mode 100755
index 00000000..1e4dc7b1
--- /dev/null
+++ b/tests/btrfs/300
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 300
+#
+# Validate that snapshots taken while in a remapped namespace preserve
+# the permissions of the user.
+#
+. ./common/preamble
+_begin_fstest auto quick subvol snapshot
+_register_cleanup "cleanup"
+
+_supported_fs btrfs
+
+_require_test
+_require_user
+_require_group
+_require_unix_perm_checking
+_require_unshare
+
+test_dir="${TEST_DIR}/${seq}"
+cleanup() {
+	rm -rf $test_dir
+	cd /
+	rm -rf $tmp.*
+}
+
+rm -rf $test_dir
+mkdir $test_dir
+chown $qa_user:$qa_group $test_dir
+
+# _user_do executes each command as $qa_user in its own subshell. unshare
+# sets the namespace for the running shell. The test must run in one user
+# subshell to preserve the namespace over multiple commands.
+_user_do "
+cd ${test_dir};
+unshare --user --keep-caps --map-auto --map-root-user;
+$BTRFS_UTIL_PROG subvolume create subvol;
+touch subvol/{1,2,3};
+$BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
+touch subvol/subsubvol/{4,5,6};
+$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
+"
+
+find $test_dir/. -printf "%M %u %g ./%P\n"
+
+status=0
+exit
diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
new file mode 100644
index 00000000..6e94447e
--- /dev/null
+++ b/tests/btrfs/300.out
@@ -0,0 +1,18 @@
+QA output created by 300
+Create subvolume './subvol'
+Create subvolume 'subvol/subsubvol'
+Create a snapshot of 'subvol' in './snapshot'
+drwxr-xr-x fsgqa fsgqa ./
+drwxr-xr-x fsgqa fsgqa ./subvol
+-rw-r--r-- fsgqa fsgqa ./subvol/1
+-rw-r--r-- fsgqa fsgqa ./subvol/2
+-rw-r--r-- fsgqa fsgqa ./subvol/3
+drwxr-xr-x fsgqa fsgqa ./subvol/subsubvol
+-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/4
+-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/5
+-rw-r--r-- fsgqa fsgqa ./subvol/subsubvol/6
+drwxr-xr-x fsgqa fsgqa ./snapshot
+-rw-r--r-- fsgqa fsgqa ./snapshot/1
+-rw-r--r-- fsgqa fsgqa ./snapshot/2
+-rw-r--r-- fsgqa fsgqa ./snapshot/3
+drwxr-xr-x fsgqa fsgqa ./snapshot/subsubvol
diff --git a/tests/overlay/020 b/tests/overlay/020
index 98a33aec..9f82da34 100755
--- a/tests/overlay/020
+++ b/tests/overlay/020
@@ -16,18 +16,13 @@ _begin_fstest auto quick copyup perms
 
 # real QA test starts here
 
-require_unshare() {
-	unshare -f -r "$@" true &>/dev/null || \
-		_notrun "unshare $@: not supported"
-}
-
 # Modify as appropriate.
 _supported_fs overlay
 _fixed_by_kernel_commit 3fe6e52f0626 \
 	"ovl: override creds with the ones from the superblock mounter"
 
 _require_scratch
-require_unshare -m -p -U
+_require_unshare
 
 # Remove all files from previous tests
 _scratch_mkfs
-- 
2.34.1

