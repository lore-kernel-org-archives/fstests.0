Received: from mx1.redhat.com ([209.132.183.28]:60272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753333AbdDLOqt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Apr 2017 10:46:49 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v3 3/4] xfs: test per-inode DAX flag DAX to non-DAX
Date: Wed, 12 Apr 2017 22:46:19 +0800
Message-Id: <1492008380-29164-4-git-send-email-xzhou@redhat.com>
In-Reply-To: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
References: <20170412062608.y2u5og3xz2oly44b@XZHOUW.usersys.redhat.com>
 <1492008380-29164-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

This test is split from xfs/260, only do IO from DAX
to non-DAX.

Since DIO from DAX to non-DAX is only supported/doable
when device underneath has memory(struct page) backend.

By ndctl looking at SCRATCH_DEV, skip this test if it is
not in "memory mode".

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/xfs/288     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/288.out |   2 +
 tests/xfs/group   |   1 +
 3 files changed, 114 insertions(+)
 create mode 100755 tests/xfs/288
 create mode 100644 tests/xfs/288.out

diff --git a/tests/xfs/288 b/tests/xfs/288
new file mode 100755
index 0000000..d296a36
--- /dev/null
+++ b/tests/xfs/288
@@ -0,0 +1,111 @@
+#! /bin/bash
+# FS QA Test 288
+#
+# Test per-inode DAX flag by mmap direct/buffered IO.
+# Split from xfs/260, only do the DAX to non-DAX part.
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
+_supported_fs xfs
+_supported_os Linux
+_require_scratch_dax
+_require_test_program "feature"
+_require_test_program "t_mmap_dio"
+_require_xfs_io_command "chattr" "+/-x"
+_require_xfs_io_command "falloc"
+_require_pmem_key_value $SCRATCH_DEV "mode" "memory"
+
+prep_files()
+{
+	rm -f $SCRATCH_MNT/tf_{s,d}
+
+	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
+		$SCRATCH_MNT/tf_{s,d} >> $seqres.full 2>&1
+}
+
+t_dax_to_nondax()
+{
+	prep_files
+	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
+	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
+	src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+		$1 "dio dax to nondax"
+
+	prep_files
+	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
+	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
+	src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+		$1 "buffered dax to nondax"
+}
+
+do_tests()
+{
+	# less than page size
+	t_dax_to_nondax 1024
+	# page size
+	t_dax_to_nondax `src/feature -s`
+	# bigger sizes, for PMD faults
+	t_dax_to_nondax $((16 * 1024 * 1024))
+	t_dax_to_nondax $((64 * 1024 * 1024))
+}
+
+# make xfs 2Mb aligned for PMD fault testing
+_scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
+
+# mount with dax option
+_scratch_mount "-o dax"
+
+tsize=$((128 * 1024 * 1024))
+
+do_tests
+_scratch_unmount
+_check_scratch_fs
+
+# mount again without dax option
+export MOUNT_OPTIONS=""
+export TEST_FS_MOUNT_OPTS=""
+_scratch_mount
+do_tests
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/xfs/288.out b/tests/xfs/288.out
new file mode 100644
index 0000000..2958a5c
--- /dev/null
+++ b/tests/xfs/288.out
@@ -0,0 +1,2 @@
+QA output created by 288
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index 75769f9..736de3c 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -285,6 +285,7 @@
 285 dangerous_fuzzers dangerous_scrub
 286 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 287 auto dump quota quick
+288 auto quick
 290 auto rw prealloc quick ioctl zero
 291 auto repair
 292 auto mkfs quick
-- 
1.8.3.1

