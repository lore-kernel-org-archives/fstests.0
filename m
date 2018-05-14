Received: from mail-wm0-f65.google.com ([74.125.82.65]:36080 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbeENFse (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 May 2018 01:48:34 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 3/3] generic: test first read with freeze right after mount
Date: Mon, 14 May 2018 08:49:51 +0300
Message-Id: <1526276991-23897-4-git-send-email-amir73il@gmail.com>
In-Reply-To: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
References: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

With ext4, this leads to freeze proection bypass WARN_ON in
ext4_journal_check_start.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/488     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/488.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100755 tests/generic/488
 create mode 100644 tests/generic/488.out

diff --git a/tests/generic/488 b/tests/generic/488
new file mode 100755
index 0000000..02cf489
--- /dev/null
+++ b/tests/generic/488
@@ -0,0 +1,75 @@
+#! /bin/bash
+# FS QA Test No. 488
+#
+# Test first read with freeze right after mount.
+#
+# With ext4, this leads to freeze proection bypass WARN_ON in
+# ext4_journal_check_start.
+#
+#-----------------------------------------------------------------------
+# Copyright (C) 2018 CTERA Networks. All Rights Reserved.
+# Author: Amir Goldstein <amir73il@gmail.com>
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
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_freeze
+_require_command "$TIMEOUT_PROG" "timeout"
+
+rm -f $seqres.full
+
+testfile=$SCRATCH_MNT/foo
+
+# Create a filesystem with a file
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+echo "frozen" > $testfile
+
+# Mount filesystem "noatime" and freeze right after mount -
+# reads should not block
+_scratch_cycle_mount "noatime"
+xfs_freeze -f $SCRATCH_MNT
+
+# Read file while filesystem is frozen should succeed
+# without blocking
+$TIMEOUT_PROG -s KILL 1s cat $testfile
+
+xfs_freeze -u $SCRATCH_MNT
+
+status=0
+exit
diff --git a/tests/generic/488.out b/tests/generic/488.out
new file mode 100644
index 0000000..0907d7c
--- /dev/null
+++ b/tests/generic/488.out
@@ -0,0 +1,2 @@
+QA output created by 488
+frozen
diff --git a/tests/generic/group b/tests/generic/group
index dc637c9..ec993f7 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -490,3 +490,4 @@
 485 auto quick insert
 486 auto quick attr
 487 auto quick
+488 auto quick freeze mount
-- 
2.7.4

