Received: from mail-pl1-f193.google.com ([209.85.214.193]:35278 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfIRLtZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Sep 2019 07:49:25 -0400
From: kaixuxia <xiakaixu1987@gmail.com>
Subject: [PATCH v3 2/2] xfs: test the deadlock between the AGI and AGF with
 RENAME_WHITEOUT
Message-ID: <db6c5d87-5a47-75bd-4d24-a135e6bcd783@gmail.com>
Date: Wed, 18 Sep 2019 19:49:22 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, newtongao@tencent.com, jasperwang@tencent.com
List-ID: <fstests@vger.kernel.org>

There is ABBA deadlock bug between the AGI and AGF when performing
rename() with RENAME_WHITEOUT flag, and add this testcase to make
sure the rename() call works well.

Signed-off-by: kaixuxia <kaixuxia@tencent.com>
---
 tests/xfs/512     | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/512.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 99 insertions(+)
 create mode 100755 tests/xfs/512
 create mode 100644 tests/xfs/512.out

diff --git a/tests/xfs/512 b/tests/xfs/512
new file mode 100755
index 0000000..a2089f0
--- /dev/null
+++ b/tests/xfs/512
@@ -0,0 +1,96 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Tencent.  All Rights Reserved.
+#
+# FS QA Test 512
+#
+# Test the ABBA deadlock case between the AGI and AGF When performing
+# rename operation with RENAME_WHITEOUT flag.
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
+. ./common/renameat2
+
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+# single AG will cause default xfs_repair to fail. This test need a
+# single AG fs, so ignore the check.
+_require_scratch_nocheck
+_requires_renameat2 whiteout
+
+filter_enospc() {
+	sed -e '/^.*No space left on device.*/d'
+}
+
+create_file()
+{
+	local target_dir=$1
+	local files_count=$2
+
+	for i in $(seq 1 $files_count); do
+		echo > $target_dir/f$i >/dev/null 2>&1 | filter_enospc
+	done
+}
+
+rename_whiteout()
+{
+	local target_dir=$1
+	local files_count=$2
+
+	# a long filename could increase the possibility that target_dp
+	# allocate new blocks(acquire the AGF lock) to store the filename
+	longnamepre=`$PERL_PROG -e 'print "a"x200;'`
+
+	# now try to do rename with RENAME_WHITEOUT flag
+	for i in $(seq 1 $files_count); do
+		src/renameat2 -w $SCRATCH_MNT/f$i $target_dir/$longnamepre$i >/dev/null 2>&1
+	done
+}
+
+_scratch_mkfs_xfs -d agcount=1 >> $seqres.full 2>&1 ||
+	_fail "mkfs failed"
+_scratch_mount
+
+# set the rename and create file counts
+file_count=50000
+
+# create the necessary directory for create and rename operations
+createdir=$SCRATCH_MNT/createdir
+mkdir $createdir
+renamedir=$SCRATCH_MNT/renamedir
+mkdir $renamedir
+
+# create many small files for the rename with RENAME_WHITEOUT
+create_file $SCRATCH_MNT $file_count
+
+# try to create files at the same time to hit the deadlock
+rename_whiteout $renamedir $file_count &
+create_file $createdir $file_count &
+
+wait
+echo Silence is golden
+
+# Failure comes in the form of a deadlock.
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/512.out b/tests/xfs/512.out
new file mode 100644
index 0000000..0aabdef
--- /dev/null
+++ b/tests/xfs/512.out
@@ -0,0 +1,2 @@
+QA output created by 512
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index a7ad300..ed250d6 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -509,3 +509,4 @@
 509 auto ioctl
 510 auto ioctl quick
 511 auto quick quota
+512 auto rename
-- 
1.8.3.1

-- 
kaixuxia
