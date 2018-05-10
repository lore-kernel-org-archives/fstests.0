Received: from mail-pl0-f47.google.com ([209.85.160.47]:41220 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeEJGWB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 May 2018 02:22:01 -0400
Received: by mail-pl0-f47.google.com with SMTP id az12-v6so691043plb.8
        for <fstests@vger.kernel.org>; Wed, 09 May 2018 23:22:01 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] btrfs: test ENOSPC caused by many orphan items
Date: Wed,  9 May 2018 23:21:55 -0700
Message-Id: <f6e37bbc4505f578176232a48cde99a9a3b7bb70.1525932731.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Btrfs has a bug where we can prematurely ENOSPC if we have lots of
orphaned files, i.e., deleted files which are still open. Add a test
which repeatedly creates and deletes a file while keeping all of the
file descriptors open. This should succeed but doesn't on Btrfs without
the fix.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/generic/479     |  0
 tests/generic/487     | 65 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/487.out |  2 ++
 tests/generic/group   |  1 +
 4 files changed, 68 insertions(+)
 mode change 100644 => 100755 tests/generic/479
 create mode 100755 tests/generic/487
 create mode 100644 tests/generic/487.out

diff --git a/tests/generic/479 b/tests/generic/479
old mode 100644
new mode 100755
diff --git a/tests/generic/487 b/tests/generic/487
new file mode 100755
index 00000000..66379cf0
--- /dev/null
+++ b/tests/generic/487
@@ -0,0 +1,65 @@
+#! /bin/bash
+# FS QA Test 487
+#
+# Test having many file descriptors referring to deleted files open. Regression
+# test for patch "Btrfs: fix ENOSPC caused by orphan items reservations".
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Omar Sandoval.  All Rights Reserved.
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
+_require_scratch
+
+_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+
+test_file="$SCRATCH_MNT/$seq"
+
+(
+ulimit -n $((16 * 1024))
+# ~10000 files on a 1 GB filesystem should be no problem.
+for ((i = 1000; i < 10000; i++)); do
+	eval "exec $i<> \"$test_file\"" && rm "$test_file" || break
+done
+)
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/generic/487.out b/tests/generic/487.out
new file mode 100644
index 00000000..5f31fd97
--- /dev/null
+++ b/tests/generic/487.out
@@ -0,0 +1,2 @@
+QA output created by 487
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 505383f7..93581257 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -489,3 +489,4 @@
 484 auto quick
 485 auto quick insert
 486 auto quick attr
+487 auto quick
-- 
2.17.0

