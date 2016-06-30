Received: from cn.fujitsu.com ([222.73.24.84]:35095 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932065AbcF3I1h (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 04:27:37 -0400
Received: from localhost.localdomain (unknown [10.167.226.107])
	by cn.fujitsu.com (Postfix) with ESMTP id E667F4056401
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 16:27:26 +0800 (CST)
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH v2] geceric/362: check truncate can update file size correctly when truncate fails
Date: Thu, 30 Jun 2016 16:25:49 +0800
Message-Id: <20160630082549.27201-1-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <20160623082718.GF3226@eguan.usersys.redhat.com>
References: <20160623082718.GF3226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In btrfs, when truncate operation fails for enospc reason, file may still
have some disk blocks, but it will fail to update filesize accordingly.

Kernel commit c0d2f61 has fixed this bug for btrfs:
    btrfs: fix disk_i_size update bug when ftruncate() fails

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
v2: move this test to generic test and add comments why testcase
use reflink.
---
 tests/generic/362     | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/362.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 104 insertions(+)
 create mode 100755 tests/generic/362
 create mode 100644 tests/generic/362.out

diff --git a/tests/generic/362 b/tests/generic/362
new file mode 100755
index 0000000..ba6024f
--- /dev/null
+++ b/tests/generic/362
@@ -0,0 +1,101 @@
+#! /bin/bash
+# FS QA Test 362
+#
+# Test whether truncate can update file size correctly when truncate fails
+#
+# When truncate operation fails for enospc reason, file will still
+# have some disk blocks, but sometimes it will fail to update filesize
+# accordingly.
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
+_require_scratch_reflink
+
+_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+
+testfile="$SCRATCH_MNT/testfile"
+
+# fill this fs with some space, which will reduce test time.
+$XFS_IO_PROG -f -c "pwrite 0 168M" $SCRATCH_MNT/file.temp > /dev/null
+
+# because btrfs separates data and metadata, and this test needs
+# truncate(2) fails for metadata ENOSPC reason to have test, so
+# here we choose to use reflink to consume much metadata. In btrfs,
+# truncate(2) will call internal start_transaction() to reserve
+# metadata to do truncate job, if it couldn't reserve more,
+# truncate(2) fails for ENOSPC reason.
+#
+# here this 12GB file size is choosed deliberately, which would
+# consume much metadata space by using reflink and make truncate
+# it will fail for ENOSPC reason.
+extentsize=$((128 * 1024))
+filesize=$((12 * 1024 * 1024 * 1024))
+nr=$((filesize / extentsize))
+
+# write the initial extent for later reflink
+_pwrite_byte 0xcdcdcdcd 0 $extentsize $testfile > /dev/null
+
+for ((i = 1; i < $nr; i++)); do
+	_reflink_range $testfile 0 $testfile $(($i * $extentsize))\
+		$extentsize > /dev/null
+	if [ $? -ne 0 ]; then
+		break;
+	fi
+done
+
+$XFS_IO_PROG -f -c "truncate 0" $testfile > /dev/null 2>&1
+disk_usage=`du $testfile | $AWK_PROG '{print $1}'`
+new_filesize=`stat -c %s $testfile`
+if [ $disk_usage -gt 0 ] && [ $new_filesize -eq 0 ]; then
+	echo "after truncate, file size is 0, but file still owns disk blocks"
+	status=1
+	exit
+fi
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/generic/362.out b/tests/generic/362.out
new file mode 100644
index 0000000..0ff4090
--- /dev/null
+++ b/tests/generic/362.out
@@ -0,0 +1,2 @@
+QA output created by 362
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 7491282..b208f99 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -364,3 +364,4 @@
 359 auto quick clone
 360 auto quick metadata
 361 auto quick
+362 auto metadata clone
-- 
2.9.0



