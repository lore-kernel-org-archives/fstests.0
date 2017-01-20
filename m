Received: from mx1.redhat.com ([209.132.183.28]:54832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbdATGYl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 20 Jan 2017 01:24:41 -0500
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v4 2/2] generic: test mmap io through DAX and non-DAX
Date: Fri, 20 Jan 2017 14:15:50 +0800
Message-Id: <1484892950-25178-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1484892950-25178-1-git-send-email-xzhou@redhat.com>
References: <1484878888-11483-1-git-send-email-xzhou@redhat.com>
 <1484892950-25178-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: jmoyer@redhat.com, ross.zwisler@linux.intel.com, eguan@redhat.com, linux-nvdimm@ml01.01.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
do some IO between them. In this case we use mmap
and dio/buffered IO read/write test programme.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/generic/405     | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/405.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 122 insertions(+)
 create mode 100755 tests/generic/405
 create mode 100644 tests/generic/405.out

diff --git a/tests/generic/405 b/tests/generic/405
new file mode 100755
index 0000000..31d8df5
--- /dev/null
+++ b/tests/generic/405
@@ -0,0 +1,119 @@
+#! /bin/bash
+# FS QA Test 405
+#
+# mmap direct/buffered io between DAX and non-DAX mountpoints.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
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
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch_dax
+_require_test_program "feature"
+_require_test_program "t_mmap_dio"
+
+# $1 mmap read/write size
+t_mmap_dio_dax()
+{
+	# both dax
+	# with O_DIRECT first
+	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
+	# again with buffered IO
+	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+		$1 "buffered both dax"
+
+	# from non dax to dax
+	src/t_mmap_dio $TEST_DIR/tf_s \
+		$SCRATCH_MNT/tf_d $1 "dio nondax to dax"
+	src/t_mmap_dio -b $TEST_DIR/tf_s \
+		$SCRATCH_MNT/tf_d $1 "buffered nondax to dax"
+
+	# from dax to non dax
+	src/t_mmap_dio $SCRATCH_MNT/tf_s \
+		$TEST_DIR/tf_d $1 "dio dax to nondax"
+	src/t_mmap_dio -b $SCRATCH_MNT/tf_s \
+		$TEST_DIR/tf_d $1 "buffered dax to nondax"
+
+	# both non dax
+	src/t_mmap_dio $TEST_DIR/tf_{s,d} $1 "dio both nondax"
+	src/t_mmap_dio -b $TEST_DIR/tf_{s,d} \
+		$1 "buffered both nondax"
+}
+
+do_tests()
+{
+	# less than page size
+	t_mmap_dio_dax 1024
+	# page size
+	t_mmap_dio_dax `src/feature -s`
+	# bigger sizes, for PMD faults
+	t_mmap_dio_dax 16777216
+	t_mmap_dio_dax 67108864
+}
+
+_scratch_mkfs > /dev/null 2>&1
+
+# mount SCRATCH_DEV with dax option, TEST_DEV not
+export MOUNT_OPTIONS=""
+export TEST_FS_MOUNT_OPTS=""
+_test_cycle_mount
+_fs_options $TEST_DEV | grep -qw "dax" && \
+	_notrun "we need $TEST_DEV mount without dax"
+_scratch_mount "-o dax"
+
+psize=`src/feature -s`
+tsize=$((1024 * 1024 * 1024))
+
+$XFS_IO_PROG -f -c "pwrite -W -b $psize 0 $tsize" \
+	$SCRATCH_MNT/tf_s >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -W -b $psize 0 $tsize" \
+	$SCRATCH_MNT/tf_d >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -W -b $psize 0 $tsize" \
+	$TEST_DIR/tf_s >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -W -b $psize 0 $tsize" \
+	$TEST_DIR/tf_d >> $seqres.full 2>&1
+
+do_tests
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/405.out b/tests/generic/405.out
new file mode 100644
index 0000000..bae761d
--- /dev/null
+++ b/tests/generic/405.out
@@ -0,0 +1,2 @@
+QA output created by 405
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 6fc9c3d..a1be466 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -407,3 +407,4 @@
 402 auto quick rw
 403 auto quick attr
 404 auto quick insert
+405 auto quick
-- 
1.8.3.1

