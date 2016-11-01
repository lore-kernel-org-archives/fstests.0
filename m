Received: from cn.fujitsu.com ([222.73.24.84]:63531 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1168462AbcKAL0w (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Nov 2016 07:26:52 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] generic: create and delete files repeatedly to exercise ENOSPC behaviour
Date: Tue,  1 Nov 2016 19:19:30 +0800
Message-Id: <1477999170-20026-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In btrfs, sometimes though the number of created files' consumed disk space
are not larger than fs's free space, we can still get some ENOSPC error, it
may be that btrfs does not try hard to reclaim disk space(I have sent kernel
patch to resolve this kind of enospc error. Note, this false enospc error
will not always happen even in kernel without my fixing patch).

Currently only in btrfs, I get this ENOSPC error, xfs and ext4 work well.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/generic/389     | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/389.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 81 insertions(+)
 create mode 100755 tests/generic/389
 create mode 100644 tests/generic/389.out

diff --git a/tests/generic/389 b/tests/generic/389
new file mode 100755
index 0000000..96bc12e
--- /dev/null
+++ b/tests/generic/389
@@ -0,0 +1,78 @@
+#! /bin/bash
+# FS QA Test 389
+#
+# Create and delete files repeatedly to exercise ENOSPC behaviour. 
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+RUN_TIME=$((600 * $TIME_FACTOR))
+fs_size=$((15 * 1024 * 1024 * 1024))
+_scratch_mkfs_sized $fs_size > $seqres.full 2>&1
+_scratch_mount > $seqres.full 2>&1
+
+testfile1=$SCRATCH_MNT/testfile1
+testfile2=$SCRATCH_MNT/testfile2
+filesize1=$(((fs_size * 80) / 100))
+filesize2=$(((fs_size * 5) / 100))
+
+do_test()
+{
+	while [ -f $SCRATCH_MNT/run ]; do
+		$XFS_IO_PROG -fc "pwrite 0 $filesize1" $testfile1 > /dev/null
+		$XFS_IO_PROG -fc "pwrite 0 $filesize2" $testfile2 > /dev/null
+		rm -f $testfile1 $testfile2 
+	done
+}
+
+echo "Silence is golden"
+touch $SCRATCH_MNT/run
+do_test &
+sleep $RUN_TIME
+rm -f $SCRATCH_MNT/run
+wait
+
+status=0
+exit
diff --git a/tests/generic/389.out b/tests/generic/389.out
new file mode 100644
index 0000000..e8c24bb
--- /dev/null
+++ b/tests/generic/389.out
@@ -0,0 +1,2 @@
+QA output created by 389
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index fc32cfd..b6d4013 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -391,3 +391,4 @@
 386 auto quick quota
 387 auto clone
 388 auto log metadata
+389 enospc
-- 
2.7.4



