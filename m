Received: from szxga06-in.huawei.com ([45.249.212.32]:59200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727751AbfCELsA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 5 Mar 2019 06:48:00 -0500
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] generic: test i_mode recovery after power failure
Date: Tue, 5 Mar 2019 19:47:44 +0800
Message-ID: <20190305114744.129633-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, linux-f2fs-devel@lists.sourceforge.net, fdmanana@gmail.com, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

After fsync, filesystem should guarantee inode metadata including
permission info being persisted, so even after sudden power-cut,
during mount, we should recover i_mode fields correctly, in order
to not loss those meta info.

So adding this testcase to check whether generic filesystem can
guarantee that.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
change as Filipe suggested:
- use dmflakey to simulate power-cut for generic filesystem which
doesn't support godown ioctl interface.
- minor code style change.
 tests/generic/532     | 105 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/532.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 108 insertions(+)
 create mode 100755 tests/generic/532
 create mode 100644 tests/generic/532.out

diff --git a/tests/generic/532 b/tests/generic/532
new file mode 100755
index 000000000000..1c5dffcdc4f6
--- /dev/null
+++ b/tests/generic/532
@@ -0,0 +1,105 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Huawei.  All Rights Reserved.
+#
+# FS QA Test 532
+#
+# This testcase is trying to test recovery flow of generic filesystem,
+# w/ below steps, once i_mode changes, after we fsync that file, we can
+# expect that i_mode can be recovered after sudden power-cuts.
+# 1. touch testfile or mkdir testdir
+# 2. chmod 777 testfile/testdir
+# 3. sync
+# 4. chmod 755 testfile/testdir
+# 5. fsync testfile/testdir
+# 6. record last i_mode
+# 7. flakey drop
+# 8. remount
+# 9. check i_mode
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
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmflakey
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_dm_target flakey
+
+_scratch_mkfs >/dev/null 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+
+testfile=$SCRATCH_MNT/testfile
+testdir=$SCRATCH_MNT/testdir
+
+do_check()
+{
+	local target=$1
+	local is_dir=$2
+
+	_mount_flakey
+
+	if [ $is_dir = 1 ]; then
+		mkdir $target
+	else
+		touch $target
+	fi
+
+	echo "Test chmod $target" >> $seqres.full
+
+	chmod 777 $target
+	sync
+
+	chmod 755 $target
+	$XFS_IO_PROG $target -c "fsync"
+
+	local before=`stat -c %a $target`
+
+	_flakey_drop_and_remount
+
+	local after=`stat -c %a $target`
+
+	# check inode's i_mode
+	if [ "$before" != "$after" ]; then
+		echo "Before: $before"
+		echo "After : $after"
+	fi
+
+	if [ $is_dir = 1 ]; then
+		rmdir $target
+	else
+		rm -f $target
+	fi
+	_unmount_flakey
+}
+
+echo "Silence is golden"
+
+do_check $testfile 0
+do_check $testdir 1
+
+status=0
+exit
diff --git a/tests/generic/532.out b/tests/generic/532.out
new file mode 100644
index 000000000000..1f7d4677c3be
--- /dev/null
+++ b/tests/generic/532.out
@@ -0,0 +1,2 @@
+QA output created by 532
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 15227b6713f7..c19361667886 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -534,3 +534,4 @@
 529 auto quick attr
 530 auto quick unlink
 531 auto quick unlink
+532 shutdown auto quick metadata
-- 
2.18.0.rc1
