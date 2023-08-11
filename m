Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE6C04A94
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Aug 2023 01:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjHKBiH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHKBiG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Aug 2023 21:38:06 -0400
X-Greylist: delayed 1350 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 18:38:05 PDT
Received: from trager.us (trager.us [52.5.81.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69392694
        for <fstests@vger.kernel.org>; Thu, 10 Aug 2023 18:38:05 -0700 (PDT)
Received: from [163.114.132.6] (helo=localhost)
        by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lee@trager.us>)
        id 1qUGkY-0006Rc-Rs; Fri, 11 Aug 2023 01:15:35 +0000
From:   Lee Trager <lee@trager.us>
To:     fstests@vger.kernel.org
Cc:     Lee Trager <lee@trager.us>
Subject: [PATCH] btrfs: Vertify dir permissions when creating a stub subvolume
Date:   Thu, 10 Aug 2023 18:15:19 -0700
Message-Id: <20230811011519.1811259-1-lee@trager.us>
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
 tests/btrfs/300     | 42 ++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/300.out | 18 ++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100755 tests/btrfs/300
 create mode 100644 tests/btrfs/300.out

diff --git a/tests/btrfs/300 b/tests/btrfs/300
new file mode 100755
index 00000000..3a34f8c0
--- /dev/null
+++ b/tests/btrfs/300
@@ -0,0 +1,42 @@
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
+
+_supported_fs btrfs
+
+_require_test
+_require_user
+_require_group
+_require_unix_perm_checking
+_register_cleanup "cleanup"
+
+test_dir="${TEST_DIR}/$(basename $0)"
+cleanup() {
+    [ -d "$test_dir" ] && rm -rf $test_dir
+}
+
+mkdir $test_dir
+chown fsgqa:fsgqa $test_dir
+
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
+find $test_dir -printf "%M %u %g %P\n"
+
+status=0
+exit
diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
new file mode 100644
index 00000000..33b5fb44
--- /dev/null
+++ b/tests/btrfs/300.out
@@ -0,0 +1,18 @@
+QA output created by 300
+Create subvolume './subvol'
+Create subvolume 'subvol/subsubvol'
+Create a snapshot of 'subvol' in './snapshot'
+drwxr-xr-x fsgqa fsgqa 
+drwxr-xr-x fsgqa fsgqa subvol
+-rw-r--r-- fsgqa fsgqa subvol/1
+-rw-r--r-- fsgqa fsgqa subvol/2
+-rw-r--r-- fsgqa fsgqa subvol/3
+drwxr-xr-x fsgqa fsgqa subvol/subsubvol
+-rw-r--r-- fsgqa fsgqa subvol/subsubvol/4
+-rw-r--r-- fsgqa fsgqa subvol/subsubvol/5
+-rw-r--r-- fsgqa fsgqa subvol/subsubvol/6
+drwxr-xr-x fsgqa fsgqa snapshot
+-rw-r--r-- fsgqa fsgqa snapshot/1
+-rw-r--r-- fsgqa fsgqa snapshot/2
+-rw-r--r-- fsgqa fsgqa snapshot/3
+drwxr-xr-x fsgqa fsgqa snapshot/subsubvol
-- 
2.34.1

