Received: from mail-pl0-f46.google.com ([209.85.160.46]:32793 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeEPQ5L (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 May 2018 12:57:11 -0400
Received: by mail-pl0-f46.google.com with SMTP id n10-v6so776626plp.0
        for <fstests@vger.kernel.org>; Wed, 16 May 2018 09:57:10 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH 3/4] generic: add test for truncate/fpunch of an active swapfile
Date: Wed, 16 May 2018 09:56:59 -0700
Message-Id: <010b6acf3614654416718713fdcccab192a2be4e.1526489529.git.osandov@fb.com>
In-Reply-To: <cover.1526489529.git.osandov@fb.com>
References: <cover.1526489529.git.osandov@fb.com>
In-Reply-To: <cover.1526489529.git.osandov@fb.com>
References: <cover.1526489529.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <darrick.wong@oracle.com>, Eryu Guan <guaneryu@gmail.com>, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

These should not be allowed.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/generic/489     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/489.out |  8 +++++
 tests/generic/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/generic/489
 create mode 100644 tests/generic/489.out

diff --git a/tests/generic/489 b/tests/generic/489
new file mode 100755
index 00000000..a38f7dcb
--- /dev/null
+++ b/tests/generic/489
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FS QA Test 489
+#
+# Test truncation/hole punching of an active swapfile.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Facebook.  All Rights Reserved.
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
+. ./common/rc
+. ./common/filter
+
+rm -f $seqres.full
+
+_supported_fs generic
+_supported_os Linux
+_require_scratch_swapfile
+_require_xfs_io_command "fpunch"
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+blocks=160
+blksz=65536
+
+echo "Initialize file"
+touch "$testdir/file1"
+chmod 0600 "$testdir/file1"
+chattr +C "$testdir/file1" >/dev/null 2>&1
+_pwrite_byte 0x61 0 $((blocks * blksz)) $testdir/file1 >> $seqres.full
+mkswap -U 27376b42-ff65-42ca-919f-6c9b62292a5c $testdir/file1 >> $seqres.full
+swapon $testdir/file1
+
+echo "Try to truncate"
+$XFS_IO_PROG -c "truncate $blksz" $testdir/file1
+
+echo "Try to punch hole"
+$XFS_IO_PROG -c "fpunch $blksz $((2 * blksz))" $testdir/file1
+
+echo "Tear it down"
+swapoff $testdir/file1
+
+status=0
+exit
diff --git a/tests/generic/489.out b/tests/generic/489.out
new file mode 100644
index 00000000..e2ebc530
--- /dev/null
+++ b/tests/generic/489.out
@@ -0,0 +1,8 @@
+QA output created by 489
+Format and mount
+Initialize file
+Try to truncate
+ftruncate: Text file busy
+Try to punch hole
+fallocate: Text file busy
+Tear it down
diff --git a/tests/generic/group b/tests/generic/group
index 6266213e..daba9073 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -491,3 +491,4 @@
 486 auto quick attr
 487 auto quick
 488 auto quick
+489 auto quick
-- 
2.17.0

