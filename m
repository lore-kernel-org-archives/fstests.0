Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E0C4332B
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Feb 2021 12:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2016364DDB
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Feb 2021 12:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhBBMfB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Feb 2021 07:35:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12102 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhBBMeu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Feb 2021 07:34:50 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVPNM203Jz162hZ;
        Tue,  2 Feb 2021 20:32:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Tue, 2 Feb 2021
 20:33:59 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>, <tytso@mit.edu>, <yangerkun@huawei.com>
CC:     <zlang@redhat.com>, <sunke32@huawei.com>
Subject: [xfstests PATCH v3] ext4: Add a test for rename with RENAME_WHITEOUT
Date:   Tue, 2 Feb 2021 20:39:56 +0800
Message-ID: <20210202123956.3146761-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Fill the disk space, try to create some files and rename a file, mount
again, list directory contents and triggers some errors. It is a
regression test for kernel commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for
rename with RENAME_WHITEOUT")

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
v3: use _check_dmesg_for() and modify the group.
---
 tests/ext4/048     | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/048.out |  3 +++
 tests/ext4/group   |  1 +
 3 files changed, 82 insertions(+)
 create mode 100755 tests/ext4/048
 create mode 100644 tests/ext4/048.out

diff --git a/tests/ext4/048 b/tests/ext4/048
new file mode 100755
index 00000000..b8e3ddee
--- /dev/null
+++ b/tests/ext4/048
@@ -0,0 +1,78 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 HUAWEI.  All Rights Reserved.
+#
+# FS QA Test 048
+#
+# This is a regression test for kernel patch:
+# commit 6b4b8e6b4ad8 ("ext4: ext4: fix bug for rename with RENAME_WHITEOUT")
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_scratch
+_require_xfs_io_command "falloc"
+
+dmesg -c > /dev/null
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT
+cd ${testdir}
+
+mkdir test
+$XFS_IO_PROG -f -c "falloc 0 128M" img >> $seqres.full
+$MKFS_EXT4_PROG  img > /dev/null 2>&1
+$MOUNT_PROG img test
+
+# fill the disk space
+dd if=/dev/zero of=test/foo bs=1M count=128 > /dev/null 2>&1
+
+# create 1000 files, not all the files will be created successfully
+mkdir test/dir
+cd test/dir
+for ((i = 0; i < 1000; i++))
+do
+	touch file$i > /dev/null 2>&1
+done
+
+# try to rename, but now no space left on device
+$here/src/renameat2 -w $testdir/test/dir/file1 $testdir/test/dir/dst_file
+
+cd $testdir
+$UMOUNT_PROG test
+$MOUNT_PROG img test
+ls -l test/dir/file1 > /dev/null 2>&1
+$UMOUNT_PROG test
+
+# Did we get the kernel warning?
+warn_str='deleted inode referenced'
+_check_dmesg_for "${warn_str}" || echo "Good! dmesg do not show \"${warn_str}\"."
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/048.out b/tests/ext4/048.out
new file mode 100644
index 00000000..db7ac373
--- /dev/null
+++ b/tests/ext4/048.out
@@ -0,0 +1,3 @@
+QA output created by 048
+No space left on device
+Good! dmesg do not show "deleted inode referenced".
diff --git a/tests/ext4/group b/tests/ext4/group
index ceda2ba6..22a00f91 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -50,6 +50,7 @@
 045 auto dir
 046 auto prealloc quick
 047 auto quick dax
+048 auto rename quick
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.13.6

