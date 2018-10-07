Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbeJGWEL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 7 Oct 2018 18:04:11 -0400
From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/3] generic: test i_flags recovery after power failure
Date: Sun,  7 Oct 2018 20:25:47 +0800
Message-Id: <20181007122548.21876-2-chao@kernel.org>
In-Reply-To: <20181007122548.21876-1-chao@kernel.org>
References: <20181007122548.21876-1-chao@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

From: Chao Yu <yuchao0@huawei.com>

After fsync, filesystem should guarantee inode metadata including
i_flags being persisted, so even after sudden power-cut, during
mount, we should recover i_flags fields correctly, in order to not
loss those meta info.

So adding this testcase to check whether generic filesystem can
guarantee that.

We only check below attribute modification which most filesystem
supports:
- no atime updates (A)
- secure deletion (s)
- synchronous updates (S)
- undeletable (u)

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- add missing _require_chattr
- use $CHATTR_PROG/$LSATTR_PROG
- add -f parameter for rm
- cleanup codes of traversing each parameter for chattr
 tests/generic/507     | 134 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/507.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 137 insertions(+)
 create mode 100755 tests/generic/507
 create mode 100644 tests/generic/507.out

diff --git a/tests/generic/507 b/tests/generic/507
new file mode 100755
index 00000000..7af8c5ef
--- /dev/null
+++ b/tests/generic/507
@@ -0,0 +1,134 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Huawei.  All Rights Reserved.
+#
+# FS QA Test 507
+#
+# This testcase is trying to test recovery flow of generic filesystem, w/ below
+# steps, once i_flags changes, after we fsync that file, we can expect that
+# i_flags can be recovered after sudden power-cuts.
+# 1. touch testfile;
+# 1.1 sync (optional)
+# 2. chattr +[AsSu] testfile
+# 3. xfs_io -f testfile -c "fsync";
+# 4. godown;
+# 5. umount;
+# 6. mount;
+# 7. check i_flags
+# 8. chattr -[AsSu] testfile
+# 9. xfs_io -f testfile -c "fsync";
+# 10. godown;
+# 11. umount;
+# 12. mount;
+# 13. check i_flags
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_command "$LSATTR_PROG" lasttr
+_require_command "$CHATTR_PROG" chattr
+_require_chattr AsSu
+
+_require_scratch
+_require_scratch_shutdown
+
+_scratch_mkfs >/dev/null 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+
+testfile=$SCRATCH_MNT/testfile
+opt="AsSu"
+
+do_check()
+{
+	attr=$1
+
+	_scratch_mount
+
+	touch $testfile
+
+	if [ "$2" == "sync" ]; then
+		echo "sync" >> $seqres.full
+		sync
+	fi
+
+	echo "Test chattr +$1" >> $seqres.full
+
+	# add attribute
+	$CHATTR_PROG +$attr $testfile
+
+	before=`$LSATTR_PROG $testfile`
+
+	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
+
+	_scratch_shutdown | tee -a $seqres.full
+	_scratch_cycle_mount
+
+	after=`$LSATTR_PROG $testfile`
+
+	# check inode's i_flags
+	if [ "$before" != "$after" ]; then
+		echo "Before: $before"
+		echo "After : $after"
+	fi
+	echo "Before: $before" >> $seqres.full
+	echo "After : $after" >> $seqres.full
+
+	echo "Test chattr -$1" >> $seqres.full
+
+	# delete attribute
+	$CHATTR_PROG -$attr $testfile
+
+	before=`$LSATTR_PROG $testfile`
+
+	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
+
+	_scratch_shutdown | tee -a $seqres.full
+	_scratch_cycle_mount
+
+	after=`$LSATTR_PROG $testfile`
+
+	# check inode's i_flags
+	if [ "$before" != "$after" ]; then
+		echo "Before: $before"
+		echo "After : $after"
+	fi
+	echo "Before: $before" >> $seqres.full
+	echo "After : $after" >> $seqres.full
+
+	rm -f $testfile
+	_scratch_unmount
+}
+
+echo "Silence is golden"
+
+opts="A s S u"
+for i in $opts; do
+	do_check $i
+	do_check $i sync
+done
+
+status=0
+exit
diff --git a/tests/generic/507.out b/tests/generic/507.out
new file mode 100644
index 00000000..3d8672f8
--- /dev/null
+++ b/tests/generic/507.out
@@ -0,0 +1,2 @@
+QA output created by 507
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index c7d42ff9..e94253dc 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -509,3 +509,4 @@
 504 auto quick locks
 505 shutdown auto quick metadata
 506 shutdown auto quick metadata quota
+507 shutdown auto quick metadata
-- 
2.18.0
