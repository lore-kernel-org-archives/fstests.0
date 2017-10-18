Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964939AbdJRFUx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Oct 2017 01:20:53 -0400
From: Shaohua Li <shli@kernel.org>
Subject: [PATCH] xfstests: add a simple cgroup2 writeback test
Date: Tue, 17 Oct 2017 22:20:49 -0700
Message-Id: <3d68f8b67b575bd82083db4111aa4c5b75be7830.1508303489.git.shli@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Kernel-team@fb.com, Dave Chinner <david@fromorbit.com>, Shaohua Li <shli@fb.com>
List-ID: <fstests@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

If filesystem supports cgroup2 writeback, the writeback IO should belong
to the cgroup which writes the file. To verify this, we set a write
bandwidth limit for a cgroup using block-throttling, the writeback IO
should be throttled according to the write bandwidth.

Thanks Dave Chinner's idea to use syncfs to wait for writeback
completion.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 common/cgroup2        | 18 +++++++++++++
 tests/generic/463     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/463.out |  3 +++
 tests/generic/group   |  1 +
 4 files changed, 97 insertions(+)
 create mode 100644 common/cgroup2
 create mode 100755 tests/generic/463
 create mode 100644 tests/generic/463.out

diff --git a/common/cgroup2 b/common/cgroup2
new file mode 100644
index 00000000..bf935fee
--- /dev/null
+++ b/common/cgroup2
@@ -0,0 +1,18 @@
+#!/bin/bash
+# cgroup2 specific common functions
+
+export CGROUP2_PATH="/sys/fs/cgroup"
+
+_require_cgroup2()
+{
+    if [ ! -f ${CGROUP2_PATH}/cgroup.subtree_control ]; then
+        _notrun "Test requires cgroup2 enabled"
+    fi
+}
+
+_get_scratch_dev_devt()
+{
+    ls -l $SCRATCH_DEV | awk '{printf("%s:%s", substr($5, 1, length($5)-1), 0)}'
+}
+
+/bin/true
diff --git a/tests/generic/463 b/tests/generic/463
new file mode 100755
index 00000000..620a14a4
--- /dev/null
+++ b/tests/generic/463
@@ -0,0 +1,75 @@
+#! /bin/bash
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/cgroup2
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+cgname=`mktemp -du ${CGROUP2_PATH}/test.XXXXXX`
+_cleanup()
+{
+    cd /
+    _scratch_unmount
+    sync
+    rmdir $cgname
+}
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_cgroup2
+
+# Setup Filesystem
+_scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
+
+_scratch_mount || _fail "mount failed"
+
+test_speed()
+{
+    start=$(date +%s)
+    $XFS_IO_PROG -f -d -c "pwrite -b 1m 0 500m" "$SCRATCH_MNT/image" \
+        > /dev/null 2>&1
+    echo $(($(date +%s) - $start))
+}
+time=$(test_speed)
+
+if [ $time -gt 25 ]; then
+    echo "Disk is too slow, make sure disk can do 20MB/s at least"
+    status=1
+    exit 1
+fi
+
+echo "Disk speed is ok, start throttled writeback test"
+
+echo +io > ${CGROUP2_PATH}/cgroup.subtree_control
+mkdir $cgname
+echo "$(_get_scratch_dev_devt) wbps=$((5*1024*1024))" > $cgname/io.max
+
+run_writeback()
+{
+    start=$(date +%s)
+    $XFS_IO_PROG -f -c "pwrite 0 500m" -c "syncfs" "$SCRATCH_MNT/image" \
+        > /dev/null 2>&1
+    echo $(($(date +%s) - $start))
+}
+time=$(
+echo $BASHPID > $cgname/cgroup.procs;
+run_writeback
+)
+_within_tolerance "Throttled writeback runtime" $time 100 10% -v
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/463.out b/tests/generic/463.out
new file mode 100644
index 00000000..c69f87c2
--- /dev/null
+++ b/tests/generic/463.out
@@ -0,0 +1,3 @@
+QA output created by 463
+Disk speed is ok, start throttled writeback test
+Throttled writeback runtime is in range
diff --git a/tests/generic/group b/tests/generic/group
index f2a6cdad..ea7b6956 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -465,3 +465,4 @@
 460 auto quick rw
 461 auto shutdown stress
 462 auto quick dax
+463 cgroup writeback test
-- 
2.11.0

