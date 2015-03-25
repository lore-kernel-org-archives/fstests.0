Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:34648 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752266AbbCYC0W (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Mar 2015 22:26:22 -0400
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH v3] fstests: add test for truncate/collapse range race
Date: Wed, 25 Mar 2015 10:19:04 +0800
Message-ID: <1427249944-13739-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <alpine.LFD.2.00.1503241555240.2541@localhost.localdomain>
References: <alpine.LFD.2.00.1503241555240.2541@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, lczerner@redhat.com, eguan@redhat.com, gux.fnst@cn.fujitsu.com, Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

This case tests truncate/collapse range race. If the race occurs, it
will trigger a BUG_ON(). And this kernel patch has fixed this race:
    23fffa9 fs: move falloc collapse range check into the filesystem methods

Changelog v2->v3:
  Fix the space issue and do test in $TEST_DIR directly.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/067     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/067.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 72 insertions(+)
 create mode 100755 tests/generic/067
 create mode 100644 tests/generic/067.out

diff --git a/tests/generic/067 b/tests/generic/067
new file mode 100755
index 0000000..fa717ee
--- /dev/null
+++ b/tests/generic/067
@@ -0,0 +1,69 @@
+#! /bin/bash
+# FS QA Test No. 067
+#
+# Test truncate/collapse range race.
+# And this test is also a regression test for kernel commit 23fffa9,
+#    fs: move falloc collapse range check into the filesystem methods
+# If the race occurs, it will trigger a BUG_ON().
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Fujitsu.  All Rights Reserved.
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
+
+_cleanup()
+{
+	rm -f $tmp.*
+}
+
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_os Linux
+_supported_fs generic
+_require_xfs_io_command "fcollapse"
+
+testfile=$TEST_DIR/testfile.$seq
+NCPUS=`$here/src/feature -o`
+OUTER_LOOPS=$((10 * $NCPUS * $LOAD_FACTOR))
+INNER_LOOPS=$((50 * $NCPUS * $LOAD_FACTOR))
+# fcollapse/truncate continuously and simultaneously a same file
+for ((i=1; i <= OUTER_LOOPS; i++)); do
+	for ((i=1; i <= INNER_LOOPS; i++)); do
+		$XFS_IO_PROG -f -c 'truncate 100k' \
+			-c 'fcollapse 0 16k' $testfile > /dev/null 2>&1
+	done &
+	for ((i=1; i <= INNER_LOOPS; i++)); do
+		$XFS_IO_PROG -f -c 'truncate 0' $testfile > /dev/null 2>&1
+	done &
+done
+wait
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/067.out b/tests/generic/067.out
new file mode 100644
index 0000000..daa1545
--- /dev/null
+++ b/tests/generic/067.out
@@ -0,0 +1,2 @@
+QA output created by 067
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index d56d3ce..b2f0680 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -69,6 +69,7 @@
 064 auto quick prealloc
 065 metadata auto quick
 066 metadata auto quick
+067 auto metadata stress
 068 other auto freeze dangerous stress
 069 rw udf auto quick
 070 attr udf auto quick stress
-- 
1.8.3.1

