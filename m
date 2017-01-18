Received: from mx1.redhat.com ([209.132.183.28]:45846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdARDHo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 17 Jan 2017 22:07:44 -0500
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 4/4] generic: test mmap dio through DAX and non-DAX
Date: Wed, 18 Jan 2017 11:07:06 +0800
Message-Id: <1484708826-23529-5-git-send-email-xzhou@redhat.com>
In-Reply-To: <1484708826-23529-1-git-send-email-xzhou@redhat.com>
References: <1484708826-23529-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-nvdimm@ml01.01.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/generic/405     | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/405.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 103 insertions(+)
 create mode 100755 tests/generic/405
 create mode 100644 tests/generic/405.out

diff --git a/tests/generic/405 b/tests/generic/405
new file mode 100755
index 0000000..3717937
--- /dev/null
+++ b/tests/generic/405
@@ -0,0 +1,100 @@
+#! /bin/bash
+# FS QA Test 405
+#
+# mmap dio between DAX and non-DAX mountpoints.
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
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs ext4
+_supported_os Linux
+_require_test
+_require_scratch_dax
+_require_test_program "feature"
+
+# $1 mmap read/write size
+_dax_flag_mmap_dio()
+{
+	# both dax
+	src/t_mmap_dio $SCRATCH_MNT/tf_s $SCRATCH_MNT/tf_d $1
+
+	# from non dax to dax
+	src/t_mmap_dio $TEST_DIR/tf_s $SCRATCH_MNT/tf_d $1
+
+	# from dax to non dax
+	src/t_mmap_dio $SCRATCH_MNT/tf_s $TEST_DIR/tf_d $1
+
+	# both non dax
+	src/t_mmap_dio $TEST_DIR/tf_s $TEST_DIR/tf_d $1
+}
+
+_do_tests()
+{
+	# less than page size
+	_dax_flag_mmap_dio 1024
+	# page size
+	_dax_flag_mmap_dio `src/feature -s`
+	# bigger sizes, for PMD faults
+	_dax_flag_mmap_dio 16777216
+	_dax_flag_mmap_dio 67108864
+}
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+# SCRATCH_DEV mount with dax option
+_scratch_mount "-o dax" >> $seqres.full 2>&1 || \
+	_fail "mount -o dax failed"
+
+dd if=/dev/zero of=$SCRATCH_MNT/tf_s bs=4k count=256k > /dev/null 2>&1
+dd if=/dev/zero of=$SCRATCH_MNT/tf_d bs=4k count=256k > /dev/null 2>&1
+dd if=/dev/zero of=$TEST_DIR/tf_s bs=4k count=256k > /dev/null 2>&1
+dd if=/dev/zero of=$TEST_DIR/tf_d bs=4k count=256k > /dev/null 2>&1
+
+_do_tests
+_test_unmount
+_scratch_unmount
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

