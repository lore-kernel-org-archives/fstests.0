Received: from mail.kernel.org ([198.145.29.99]:50502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbeJDL0k (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Oct 2018 07:26:40 -0400
From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] generic: test project id recovery after power failure
Date: Thu,  4 Oct 2018 12:35:00 +0800
Message-Id: <20181004043502.15005-1-chao@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

From: Chao Yu <yuchao0@huawei.com>

After fsync, filesystem should guarantee inode metadata including
project id being persisted, so even after sudden power-cut, during
mount, we should recover project_id fields correctly, in order to
not loss those meta info.

So adding this testcase to check whether generic filesystem can
guarantee that.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 tests/generic/506     | 97 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/506.out |  2 +
 tests/generic/group   |  1 +
 3 files changed, 100 insertions(+)
 create mode 100644 tests/generic/506
 create mode 100644 tests/generic/506.out

diff --git a/tests/generic/506 b/tests/generic/506
new file mode 100644
index 00000000..ca035a91
--- /dev/null
+++ b/tests/generic/506
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Huawei.  All Rights Reserved.
+#
+# FS QA Test 506
+#
+# This testcase is trying to test recovery flow of generic filesystem, w/ below
+# steps, once project id changes, after we fsync that file, we can expect that
+# project id can be recovered after sudden power-cuts.
+# 1. touch testfile;
+# 1.1 sync (optional)
+# 2. chattr -p 100 testfile;
+# 3. xfs_io -f testfile -c "fsync";
+# 4. godown;
+# 5. umount;
+# 6. mount;
+# 7. check project id
+#
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
+. ./common/quota
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_test_lsattr
+_require_command "$CHATTR_PROG" chattr
+
+_require_prjquota $SCRATCH_DEV
+_require_scratch
+_require_scratch_shutdown
+
+_scratch_mkfs >/dev/null 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+
+testfile=$SCRATCH_MNT/testfile
+
+do_check()
+{
+	_scratch_mount
+
+	touch $testfile
+
+	if [ "$1" == "sync" ]; then
+		sync
+	fi
+
+	chattr -p 100 $testfile
+
+	before=`lsattr -p $testfile`
+
+	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
+
+	_scratch_shutdown | tee -a $seqres.full
+	_scratch_cycle_mount
+
+	after=`lsattr -p $testfile`
+
+	# check inode's uid/gid
+	if [ "$before" != "$after" ]; then
+		echo "Before: $before"
+		echo "After : $after"
+	fi
+	echo "Before: $before" >> $seqres.full
+	echo "After : $after" >> $seqres.full
+
+	rm $testfile
+	_scratch_unmount
+}
+
+echo "Silence is golden"
+
+do_check
+do_check sync
+
+status=0
+exit
diff --git a/tests/generic/506.out b/tests/generic/506.out
new file mode 100644
index 00000000..cb46b201
--- /dev/null
+++ b/tests/generic/506.out
@@ -0,0 +1,2 @@
+QA output created by 506
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 4da0e188..c7d42ff9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -508,3 +508,4 @@
 503 auto quick dax punch collapse zero
 504 auto quick locks
 505 shutdown auto quick metadata
+506 shutdown auto quick metadata quota
-- 
2.18.0
