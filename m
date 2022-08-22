Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31376C00140
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Aug 2022 00:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiHVAts (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Aug 2022 20:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiHVAtr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Aug 2022 20:49:47 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA8815FFA
        for <fstests@vger.kernel.org>; Sun, 21 Aug 2022 17:49:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 196A031A6D859;
        Mon, 22 Aug 2022 08:49:41 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1661129382; bh=IZQHJz0tudZimxBKrJrpdlj7NPlf4aPidrQpOtJTEXE=;
        h=From:To:Cc:Subject:Date;
        b=md3Jn1qOCP9WGc/ktJIkHvrusLpdlTPGjKuQ4Rp7CmWx877Miki5ZXEMlK1IML9rZ
         9EYLcpklnkN9TIkFYN13MyFjCGbF+dOsTgL7OdzmfwMEqhllKj8cEOOCxVPUXrz/03
         XiLStH7IxMooYhxK4/vpTQqd4VMMjN5KhauFuxpg=
From:   bingjingc <bingjingc@synology.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.orgto
Cc:     fdmanana@kernel.org, bingjingc@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH v2] fstests: btrfs: test incremental send for changed reference paths
Date:   Mon, 22 Aug 2022 08:49:32 +0800
Message-Id: <20220822004932.1280053-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Normally btrfs stores file paths in an array of ref items. However, items
for the same parent directory can not exceed the size of a leaf. So btrfs
also store the rest of them in extended ref items alternatively.

In this test, it creates a large number of links under a directory causing
the file paths stored in these two ways to be the parent snapshot. And it
deletes and recreates just an amount of them that can be stored within an
array of ref items to be the send snapshot. Test that an incremental send
operation correctly issues link/unlink operations only against new/deleted
paths, or the receive operation will fail due to a link on an existed path.

This currently fails on btrfs but is fixed by a kernel patch with the
commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
existing file paths")

Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 tests/btrfs/272     | 97 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/272.out |  3 ++
 2 files changed, 100 insertions(+)
 create mode 100755 tests/btrfs/272
 create mode 100644 tests/btrfs/272.out

diff --git a/tests/btrfs/272 b/tests/btrfs/272
new file mode 100755
index 00000000..e1986de9
--- /dev/null
+++ b/tests/btrfs/272
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 BingJing Chang.
+#
+# FS QA Test No. btrfs/272
+#
+# Regression test for btrfs incremental send issue where a link instruction
+# is sent against an existing path, causing btrfs receive to fail.
+#
+# This issue is fixed by the following linux kernel btrfs patch:
+#
+#   commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
+#   existing file paths")
+#
+. ./common/preamble
+_begin_fstest auto quick send
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -fr $send_files_dir
+	rm -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_require_test
+_require_scratch
+_require_fssum
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+# Create a file and 2000 hard links to the same inode
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
+touch $SCRATCH_MNT/vol/foo
+for i in {1..2000}; do
+	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
+done
+
+# Create a snapshot for a full send operation
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
+_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
+
+# Remove 2000 hard links and re-create the last 1000 links
+for i in {1..2000}; do
+	rm $SCRATCH_MNT/vol/$i
+done
+for i in {1001..2000}; do
+	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
+done
+
+# Create another snapshot for an incremental send operation
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
+_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+		     $SCRATCH_MNT/snap2
+
+$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
+$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
+	-x $SCRATCH_MNT/snap2/snap1 $SCRATCH_MNT/snap2
+
+# Recreate the filesystem by receiving both send streams and verify we get
+# the same content that the original filesystem had.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Add the first snapshot to the new filesystem by applying the first send
+# stream.
+_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+
+# The incremental receive operation below used to fail with the following
+# error:
+#
+#    ERROR: link 1238 -> foo failed: File exists
+#
+# This is because the path "1238" was stored as an extended ref item in the
+# original snapshot but as a normal ref item in the next snapshot. The send
+# operation cannot handle the duplicated paths, which are stored in
+# different ways, well, so it decides to issue a link operation for the
+# existing path. This results in the receiver to fail with the above error.
+_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
+
+status=0
+exit
diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
new file mode 100644
index 00000000..b009b87a
--- /dev/null
+++ b/tests/btrfs/272.out
@@ -0,0 +1,3 @@
+QA output created by 272
+OK
+OK
-- 
2.37.1

