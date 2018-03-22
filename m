Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeCVVOe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Mar 2018 17:14:34 -0400
From: Shaohua Li <shli@kernel.org>
Subject: [PATCH V2] xfstests: add a simple cgroup2 writeback test
Date: Thu, 22 Mar 2018 14:13:23 -0700
Message-Id: <f58e67c9a4ec8cb4e0c4e96865e3a44aebaf46a2.1521752027.git.shli@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Kernel-team@fb.com, bfoster@redhat.com, Shaohua Li <shli@fb.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

If filesystem supports cgroup2 writeback, the writeback IO should belong
to the cgroup which writes the file. To verify this, we set a write
bandwidth limit for a cgroup using block-throttling, the writeback IO
should be throttled according to the write bandwidth.

Thanks Dave Chinner's idea to use syncfs to wait for writeback
completion.

Cc: Eryu Guan <eguan@redhat.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 common/cgroup2        | 15 +++++++++++
 common/rc             | 14 ++++++++--
 tests/generic/482     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/482.out |  3 +++
 tests/generic/group   |  1 +
 5 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 common/cgroup2
 create mode 100755 tests/generic/482
 create mode 100644 tests/generic/482.out

diff --git a/common/cgroup2 b/common/cgroup2
new file mode 100644
index 00000000..f89825e2
--- /dev/null
+++ b/common/cgroup2
@@ -0,0 +1,15 @@
+# cgroup2 specific common functions
+
+export CGROUP2_PATH="${CGROUP2_PATH:-/sys/fs/cgroup}"
+
+_require_cgroup2()
+{
+	if [ ! -f "${CGROUP2_PATH}/cgroup.subtree_control" ]; then
+		_notrun "Test requires cgroup2 enabled"
+	fi
+	if [[ ! $(cat ${CGROUP2_PATH}/cgroup.controllers) =~ $1 ]]; then
+		_notrun "Cgroup2 doesn't support $1 controller $1"
+	fi
+}
+
+/bin/true
diff --git a/common/rc b/common/rc
index 93176749..e93674f9 100644
--- a/common/rc
+++ b/common/rc
@@ -3613,14 +3613,24 @@ _short_dev()
 	echo `basename $(_real_dev $1)`
 }
 
-_sysfs_dev()
+#blk-throttling requires minor is 0
+_get_dev_devt()
 {
 	local _dev=`_real_dev $1`
 	local _maj=$(stat -c%t $_dev | tr [:lower:] [:upper:])
 	local _min=$(stat -c%T $_dev | tr [:lower:] [:upper:])
 	_maj=$(echo "ibase=16; $_maj" | bc)
 	_min=$(echo "ibase=16; $_min" | bc)
-	echo /sys/dev/block/$_maj:$_min
+	if [ $2 ]; then
+		echo $_maj:0
+	else
+		echo $_maj:$_min
+	fi
+}
+
+_sysfs_dev()
+{
+	echo /sys/dev/block/$(_get_dev_devt $1 false)
 }
 
 # Get the minimum block size of a file.  Usually this is the
diff --git a/tests/generic/482 b/tests/generic/482
new file mode 100755
index 00000000..1f3cbc97
--- /dev/null
+++ b/tests/generic/482
@@ -0,0 +1,73 @@
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
+	cd /
+	sync
+	rmdir $cgname
+}
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_cgroup2 io
+_require_xfs_io_command syncfs
+
+# Setup Filesystem
+_scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
+
+_scratch_mount || _fail "mount failed"
+
+test_speed()
+{
+	start=$(date +%s)
+	$XFS_IO_PROG -f -d -c "pwrite -b 1m 0 500m" "$SCRATCH_MNT/image" \
+		> /dev/null 2>&1
+	echo $(($(date +%s) - $start))
+}
+time=$(test_speed)
+
+if [ $time -gt 25 ]; then
+	_notrun "Disk is too slow, make sure disk can do 20MB/s at least"
+fi
+
+echo "Disk speed is ok, start throttled writeback test"
+
+echo +io > ${CGROUP2_PATH}/cgroup.subtree_control
+mkdir $cgname
+echo "$(_get_dev_devt $SCRATCH_DEV true) wbps=$((5*1024*1024))" > $cgname/io.max
+
+run_writeback()
+{
+    start=$(date +%s)
+    $XFS_IO_PROG -f -c "pwrite 0 500m" -c "syncfs" "$SCRATCH_MNT/image2" \
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
diff --git a/tests/generic/482.out b/tests/generic/482.out
new file mode 100644
index 00000000..4d1b40a8
--- /dev/null
+++ b/tests/generic/482.out
@@ -0,0 +1,3 @@
+QA output created by 482
+Disk speed is ok, start throttled writeback test
+Throttled writeback runtime is in range
diff --git a/tests/generic/group b/tests/generic/group
index e8676062..f707838c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -484,3 +484,4 @@
 479 auto quick metadata
 480 auto quick metadata
 481 auto quick log metadata
+482 auto cgroup writeback
-- 
2.14.1

