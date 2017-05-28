Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbdE3Pa1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 May 2017 11:30:27 -0400
From: fdmanana@kernel.org
Subject: [PATCH] generic: test for hole punching beyond eof followed by buffered writes
Date: Sun, 28 May 2017 17:32:43 +0100
Message-Id: <20170528163243.32018-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Test that if we punch a hole in a file that goes beyond the file's size
and that if after we do some buffered write operations that cover
different parts of the hole, no warnings are emmitted in syslog/dmesg
and the file's content is correct after remounting the filesystem.

This test is motivated by a bug in btrfs that is manifested in kernel
4.12-rc1 onwards (the bug existed long time ago but was not so easy
to expose before 4.12-rc1). The btrfs patch that fixes the issue is
titled: "Btrfs: fix invalid extent maps due to hole punching".

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/438     | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/438.out | 15 +++++++++++
 tests/generic/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/generic/438
 create mode 100644 tests/generic/438.out

diff --git a/tests/generic/438 b/tests/generic/438
new file mode 100755
index 00000000..f1cbec7e
--- /dev/null
+++ b/tests/generic/438
@@ -0,0 +1,70 @@
+#! /bin/bash
+# FS QA Test No. generic/438
+#
+# Test that if we punch a hole in a file that goes beyond the file's size and
+# that if after we do some buffered write operations that cover different parts
+# of the hole, no warnings are emmitted in syslog/dmesg and the file's content
+# is correct after remounting the filesystem.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (C) 2017 SUSE Linux Products GmbH. All Rights Reserved.
+# Author: Filipe Manana <fdmanana@suse.com>
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
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch
+_require_xfs_io_command "fpunch"
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 100K" $SCRATCH_MNT/f | _filter_xfs_io
+$XFS_IO_PROG -c "fpunch 60K 90K" $SCRATCH_MNT/f
+$XFS_IO_PROG -c "pwrite -S 0xbb -b 100K 50K 100K" $SCRATCH_MNT/f | _filter_xfs_io
+$XFS_IO_PROG -c "pwrite -S 0xcc -b 50K 100K 50K" $SCRATCH_MNT/f | _filter_xfs_io
+
+_scratch_cycle_mount
+
+echo "File contents after remounting filesystem:"
+od -t x1 $SCRATCH_MNT/f
+
+status=0
+exit
diff --git a/tests/generic/438.out b/tests/generic/438.out
new file mode 100644
index 00000000..9712a872
--- /dev/null
+++ b/tests/generic/438.out
@@ -0,0 +1,15 @@
+QA output created by 438
+wrote 102400/102400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 102400/102400 bytes at offset 51200
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 51200/51200 bytes at offset 102400
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File contents after remounting filesystem:
+0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
+*
+0144000 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
+*
+0310000 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
+*
+0454000
diff --git a/tests/generic/group b/tests/generic/group
index 438c2990..34f176a9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -440,3 +440,4 @@
 435 auto encrypt
 436 auto quick rw
 437 auto quick
+438 auto quick punch
-- 
2.11.0

