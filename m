Received: from mx1.redhat.com ([209.132.183.28]:39224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932719AbdDQHOb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Apr 2017 03:14:31 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v4 2/4] generic: test mmap io fom DAX to non-DAX
Date: Mon, 17 Apr 2017 15:14:13 +0800
Message-Id: <1492413255-11146-3-git-send-email-xzhou@redhat.com>
In-Reply-To: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
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
 common/rc             |  45 ++++++++++++++++++++
 tests/generic/423     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/423.out |   2 +
 tests/generic/group   |   1 +
 4 files changed, 161 insertions(+)
 create mode 100755 tests/generic/423
 create mode 100644 tests/generic/423.out

diff --git a/common/rc b/common/rc
index 78a2101..73ac79c 100644
--- a/common/rc
+++ b/common/rc
@@ -3151,6 +3151,51 @@ _require_chattr()
 	rm -f $TEST_DIR/syscalltest.out
 }
 
+# Require test/scratch device nvdimm and having specific
+# arttibute key/value we need.
+#
+# This is designed to get attr values of nvdimm persistent
+# memory device, by searching sysfs.
+#
+# Other non-nvdimm or non-persistent-memory devices would
+# fail this helper anyway.
+#
+# So, ONLY use this helper when you REALLY need nvdimm and
+# specific attr on it.
+#
+_require_pmem_key_value()
+{
+	local dev=${1#/dev/}
+	local key=$2
+	local value=$3
+	local region index keyfile dev_value
+
+	# find a filename string contains the region of dev, eg:
+	#  /sys/devices/platform/e820_pmem/ndbus0/region1/\
+	#  namespace1.0/block/pmem1
+	#
+	region=$(find /sys/ | grep $dev | grep region | head -1)
+	[ -z "$region" ] && \
+	  _notrun "requires persistent memory $dev $key $value"
+
+	# get region number index
+	index=$(expr $region : .*region)
+
+	# find the file for the key, eg:
+	#  /sys/devices/platform/e820_pmem/ndbus0/region1/\
+	#  namespace1.0/mode
+	#
+	keyfile=$(find /sys/ | grep region${region:$index:2} \
+	  | grep namespace | grep $key)
+	[ -z "$keyfile" ] && \
+	  _notrun "requires persistent memory $dev $key $value"
+
+	# get the value and test
+	dev_value=$(cat $keyfile)
+	[ "$dev_value" != "$value" ] && \
+	  _notrun "requires $dev $key $value"
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

