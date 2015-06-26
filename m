Received: from cn.fujitsu.com ([59.151.112.132]:50609 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751539AbbFZFW4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 26 Jun 2015 01:22:56 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5Q5LG5Y028991
	for <fstests@vger.kernel.org>; Fri, 26 Jun 2015 13:21:16 +0800
From: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
Subject: [PATCH v2] generic: busy loop of dd and rm test
Date: Fri, 26 Jun 2015 13:22:38 +0800
Message-ID: <1435296158-11198-1-git-send-email-wangyf-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

generic/326 is a case about testing whether writing failed on
NO_SPACE in a busy loop of write and delete when disk almost full.
It is a long-term problem since very beginning in btrfs, and has been
fixed by patchset titled "btrfs: Fix no_space on dd and rm loop" from
zhaolei@cn.fujitsu.com.

Signed-off-by: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
---
v1->v2:
-add the 'tmp=/tmp/$$'
-use xfs_io to replace dd and _fail
-modify the description of case

 tests/generic/326     | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/326.out | 21 +++++++++++++++++
 tests/generic/group   |  1 +
 3 files changed, 87 insertions(+)
 create mode 100755 tests/generic/326
 create mode 100644 tests/generic/326.out

diff --git a/tests/generic/326 b/tests/generic/326
new file mode 100755
index 0000000..426762f
--- /dev/null
+++ b/tests/generic/326
@@ -0,0 +1,65 @@
+#! /bin/bash
+# FS QA Test No. 326
+#
+# TEST busy loop of write and delete in a filesystem.
+# Sometimes writes will failed on NO_SPACE when disk almost full
+# in btrfs. It is long-term problem since very beginning for btrfs
+#
+# This issue was fixed by the patchset named:
+#
+# btrfs: Fix no_space on dd and rm loop < from zhaolei@cn.fujitsu.com >
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Fujitsu.  All Rights Reserved.
+# Author: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
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
+tmp=/tmp/$$
+status=1
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_need_to_be_root
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+rm -f $seqres.full
+
+dev_size=$((512 * 1024 * 1024))     # 512MB filesystem
+_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
+_scratch_mount
+
+for ((i = 0; i < 10; i++)); do
+	echo "loop $i" >>$seqres.full
+
+	$XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file | \
+_filter_xfs_io | _filter_scratch
+
+	rm -f "$SCRATCH_MNT"/file
+done
+
+status=0
+exit
diff --git a/tests/generic/326.out b/tests/generic/326.out
new file mode 100644
index 0000000..770f354
--- /dev/null
+++ b/tests/generic/326.out
@@ -0,0 +1,21 @@
+QA output created by 326
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 419430400/419430400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index 0c8964c..393a2cb 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -194,3 +194,4 @@
 323 auto aio stress
 324 auto fsr quick
 325 auto quick data log
+326 auto
-- 
1.9.1

