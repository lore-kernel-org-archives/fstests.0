Received: from mx1.redhat.com ([209.132.183.28]:56756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754291AbdDLOqv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Apr 2017 10:46:51 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v3 2/4] generic: test mmap io fom DAX to non-DAX
Date: Wed, 12 Apr 2017 22:46:18 +0800
Message-Id: <1492008380-29164-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
References: <20170412062608.y2u5og3xz2oly44b@XZHOUW.usersys.redhat.com>
 <1492008380-29164-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
do mmap DIO from DAX to non-DAX.

This test is split from generic/413. Since DIO from DAX
to non-DAX is only supported/doable when device underneath
has memory(struct page) backend.

By ndctl looking at SCRATCH_DEV, skip this test if it is
not in "memory mode".

Adding helper to check pmem device status, which requires new
PROGs ndctl to tweaking pmem devices and jq to parse ndctl's
JSON format outputs.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 common/config         |   2 +
 common/rc             |  41 ++++++++++++++++++
 tests/generic/423     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/423.out |   2 +
 tests/generic/group   |   1 +
 5 files changed, 159 insertions(+)
 create mode 100755 tests/generic/423
 create mode 100644 tests/generic/423.out

diff --git a/common/config b/common/config
index 59041a3..dfdcb8e 100644
--- a/common/config
+++ b/common/config
@@ -212,6 +212,8 @@ export XZ_PROG="`set_prog_path xz`"
 export FLOCK_PROG="`set_prog_path flock`"
 export LDD_PROG="`set_prog_path ldd`"
 export TIMEOUT_PROG="`set_prog_path timeout`"
+export NDCTL_PROG="`set_prog_path ndctl`"
+export JQ_PROG="`set_prog_path jq`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/common/rc b/common/rc
index 78a2101..35b8f6a 100644
--- a/common/rc
+++ b/common/rc
@@ -3151,6 +3151,47 @@ _require_chattr()
 	rm -f $TEST_DIR/syscalltest.out
 }
 
+# Looking up pmem devices' arttributes in
+# `ndctl list` output like this:
+#  {
+#    "dev":"namespace2.0",
+#    "mode":"raw",
+#    "size":8589934592,
+#    "blockdev":"pmem2"
+#  },
+_ndctl_get_pmem_key_value()
+{
+	local dev=$1
+	local key=$2
+
+	$NDCTL_PROG list | \
+	  $JQ_PROG -r ".[] | \
+	  select(.blockdev == \"${dev#/dev/}\") | .$key"
+}
+
+# Require pmem device having specific arttibute key/value
+# we need.
+_require_pmem_key_value()
+{
+	local dev=$1
+	local key=$2
+	local value=$3
+
+	[[ ! "${dev#/dev/}" =~ pmem ]] && \
+	  _notrun "this test requires pmem device"
+
+	# if pmem devices are setup by memmap, just run
+	grep -q memmap /proc/cmdline && return
+
+	# pmem devices from NFIT
+	_require_command "$NDCTL_PROG" "ndctl"
+	_require_command "$JQ_PROG" "jq"
+	# get dev specific attr
+	dev_value=$(_ndctl_get_pmem_key_value $dev $key)
+	[ "$dev_value" != "$value" ] && \
+	  _notrun "this test requires $dev $value $key"
+}
+
 _get_total_inode()
 {
 	if [ -z "$1" ]; then
diff --git a/tests/generic/423 b/tests/generic/423
new file mode 100755
index 0000000..73c0b53
--- /dev/null
+++ b/tests/generic/423
@@ -0,0 +1,113 @@
+#! /bin/bash
+# FS QA Test 423
+#
+# mmap direct/buffered io from DAX to non-DAX mountpoints.
+# Split from generic/413, only do the DAX to non-DAX part.
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
+_require_xfs_io_command "falloc"
+_require_pmem_key_value $SCRATCH_DEV "mode" "memory"
+
+prep_files()
+{
+	rm -f $SCRATCH_MNT/tf_{s,d}
+	rm -f $TEST_DIR/tf_{s,d}
+
+	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
+		$SCRATCH_MNT/tf_{s,d} >> $seqres.full 2>&1
+	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
+		$TEST_DIR/tf_{s,d} >> $seqres.full 2>&1
+}
+
+t_dax_to_nondax()
+{
+	prep_files
+	src/t_mmap_dio $SCRATCH_MNT/tf_s \
+		$TEST_DIR/tf_d $1 "dio dax to nondax"
+
+	prep_files
+	src/t_mmap_dio -b $SCRATCH_MNT/tf_s \
+		$TEST_DIR/tf_d $1 "buffered dax to nondax"
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
+# make fs 2Mb aligned for PMD fault testing
+mkfs_opts=""
+if [ "$FSTYP" == "ext4" ]; then
+	mkfs_opts="-E stride=512,stripe_width=1"
+elif [ "$FSTYP" == "xfs" ]; then
+	mkfs_opts="-d su=2m,sw=1"
+fi
+_scratch_mkfs "$mkfs_opts" > /dev/null 2>&1
+
+# mount SCRATCH_DEV with dax option, TEST_DEV not
+export MOUNT_OPTIONS=""
+export TEST_FS_MOUNT_OPTS=""
+_test_cycle_mount
+_fs_options $TEST_DEV | grep -qw "dax" && \
+	_notrun "we need $TEST_DEV mount without dax"
+_scratch_mount "-o dax"
+
+tsize=$((128 * 1024 * 1024))
+
+do_tests
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/423.out b/tests/generic/423.out
new file mode 100644
index 0000000..22c4029
--- /dev/null
+++ b/tests/generic/423.out
@@ -0,0 +1,2 @@
+QA output created by 423
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index d747385..52553fa 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -425,3 +425,4 @@
 420 auto quick punch
 421 auto quick encrypt dangerous
 422 auto quick
+423 auto quick
-- 
1.8.3.1

