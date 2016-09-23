Received: from cn.fujitsu.com ([222.73.24.84]:17279 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S932633AbcIWDRY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Sep 2016 23:17:24 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH v3] generic: check whether we can truncate heavily reflinked file
Date: Fri, 23 Sep 2016 11:12:07 +0800
Message-Id: <20160923031207.30977-1-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <57E38D6D.90007@cn.fujitsu.com>
References: <57E38D6D.90007@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In btrfs, there is a bug about btrfs' truncate codes, it'll leak
some fs space as the truncate operation proceeds. If this truncate
operation is very large, later metadata request in this truncate
operation may fail for enospc error. I also have sent a kernel
patch fot btrfs to fix this issue.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
V3: Reduce test run time according to Eryu's suggestions.
---
 tests/generic/379     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/379.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 85 insertions(+)
 create mode 100755 tests/generic/379
 create mode 100644 tests/generic/379.out

diff --git a/tests/generic/379 b/tests/generic/379
new file mode 100755
index 0000000..9337f24
--- /dev/null
+++ b/tests/generic/379
@@ -0,0 +1,82 @@
+#! /bin/bash
+# FS QA Test 379
+#
+# Create a heavily reflinked file, then check whether we can truncate
+# it correctly.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
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
+. ./common/reflink
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_scratch_reflink
+
+_scratch_mkfs_sized $((32 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+dummyfile=$SCRATCH_MNT/dummyfile
+blocksize=$((128 * 1024))
+
+# create a dummy file, which is used to occupy some fs space first.
+_pwrite_byte 0xcdcdcdcd 0 $((1 * 1024 * 1024)) $dummyfile > /dev/null
+_pwrite_byte 0xcdcdcdcd 0 $blocksize  $testfile > /dev/null
+
+echo "Silence is golden"
+for ((i = 0; i < 16384; i++)); do
+	_reflink_range $testfile 0 $testfile $(($i * $blocksize)) \
+		$blocksize > /dev/null 2>&1
+done
+
+# consume all remaining free space
+dd if=/dev/zero of=$SCRATCH_MNT/space >/dev/null 2>&1
+sync
+
+# fs is almost full now and fs internal operations may need some free space,
+# for example, in btrfs, transaction will need to reserve space first, so here
+# free 1MB space.
+rm -rf $dummyfile
+$XFS_IO_PROG -f -c "truncate 0" $testfile
+
+status=0
+exit
diff --git a/tests/generic/379.out b/tests/generic/379.out
new file mode 100644
index 0000000..ec12148
--- /dev/null
+++ b/tests/generic/379.out
@@ -0,0 +1,2 @@
+QA output created by 379
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index a602b01..73fce91 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -381,3 +381,4 @@
 376 auto quick metadata
 377 attr auto quick metadata
 378 auto quick metadata
+379 auto clone
-- 
2.9.0



