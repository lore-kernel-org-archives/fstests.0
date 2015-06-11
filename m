Received: from cn.fujitsu.com ([59.151.112.132]:52573 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751602AbbFKAwz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 10 Jun 2015 20:52:55 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5B0pKjN013384
	for <fstests@vger.kernel.org>; Thu, 11 Jun 2015 08:51:21 +0800
From: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
Subject: [PATCH] generic: busy loop of dd and rm test
Date: Thu, 11 Jun 2015 08:52:35 +0800
Message-ID: <1433983955-2591-1-git-send-email-wangyf-fnst@cn.fujitsu.com>
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
 tests/generic/326     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/326.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/326
 create mode 100644 tests/generic/326.out

diff --git a/tests/generic/326 b/tests/generic/326
new file mode 100755
index 0000000..1ab1ac3
--- /dev/null
+++ b/tests/generic/326
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test No. 326
+#
+# TEST busy loop of write and delete in a filesystem.
+# Sometimes writes will failed on NO_SPACE when disk almost full
+# in btrfs. It is long-term problem since very beginning for btrfs
+#
+# This issue was fixed by the following linux kernel patch
+#
+# btrfs: Fix no_space on dd and rm loop < from zhaolei@cn.fujitsu.com >
+#	btrfs: Fix NO_SPACE bug caused by delayed-iput
+#	btrfs: Support busy loop of write and delete
+#	btrfs: add WARN_ON() to check is space_info op current
+#	btrfs: Set relative data on clear btrfs_block_group_cache->pinned
+#	btrfs: Adjust commit-transaction condition to avoid NO_SPACE more
+#	btrfs: Fix tail space processing in find_free_dev_extent()
+#	btrfs: fix condition of commit transaction
+#	btrfs: wait for delayed iputs on no space
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
+dev_size=$((512 * 1024 * 1024))
+_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
+_scratch_mount
+file_size_m=$(($dev_size * 75 / 100 / 1024 / 1024))
+
+for ((i = 0; i < 10; i++)); do
+	echo "loop $i" >>$seqres.full
+
+	dd if=/dev/zero of="$SCRATCH_MNT"/file0 bs=1M count="$file_size_m" \
+	>>$seqres.full 2>&1 || _fail "dd failed"
+
+	rm -f "$SCRATCH_MNT"/file0 || _fail "rm failed"
+done
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/326.out b/tests/generic/326.out
new file mode 100644
index 0000000..4ac0db5
--- /dev/null
+++ b/tests/generic/326.out
@@ -0,0 +1,2 @@
+QA output created by 326
+Silence is golden
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

