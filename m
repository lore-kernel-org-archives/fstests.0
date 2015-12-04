Received: from mail.kernel.org ([198.145.29.136]:53999 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbbLDWPz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 17:15:55 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs/001: introduce a testcaes for -ENOSPC with inline operation
Date: Fri,  4 Dec 2015 14:15:45 -0800
Message-Id: <1449267345-79400-3-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
References: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch introduces f2fs/001 to test -ENOSPC when inline operation was
activated.

Inline_data feature is described in:
  http://lwn.net/Articles/573408/

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/f2fs/001     | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/001.out | 21 +++++++++++++
 tests/f2fs/group   |  6 ++++
 3 files changed, 113 insertions(+)
 create mode 100755 tests/f2fs/001
 create mode 100644 tests/f2fs/001.out
 create mode 100644 tests/f2fs/group

diff --git a/tests/f2fs/001 b/tests/f2fs/001
new file mode 100755
index 0000000..9c4425a
--- /dev/null
+++ b/tests/f2fs/001
@@ -0,0 +1,86 @@
+#! /bin/bash
+# FS QA Test No. f2fs/001
+#
+# Test inline_data behaviors when filesystem is full.
+#
+# The inline_data feature was introduced in ext4 and f2fs as follows.
+#  ext4 : http://lwn.net/Articles/468678/
+#  f2fs : http://lwn.net/Articles/573408/
+#
+# The basic idea is embedding small-sized file's data into relatively large
+# inode space.
+# In ext4, up to 132 bytes of data can be stored in 256 bytes-sized inode.
+# In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Jaegeuk Kim.  All Rights Reserved.
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
+    cd /
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+_supported_fs f2fs
+_supported_os Linux
+_require_scratch
+
+testfile=$SCRATCH_MNT/testfile
+dummyfile=$SCRATCH_MNT/dummyfile
+
+# build 4GB filesystem
+_scratch_mkfs_sized $((4 * 1024 * 1024 * 1024)) > /dev/null 2>&1
+_scratch_mount
+
+echo "==== create small file ===="
+$XFS_IO_PROG -t -f -c "pwrite -S 0x58 0 40" $testfile | _filter_xfs_io
+
+# -ENOSPC should be triggered
+echo "==== Fullfill the partition ===="
+$XFS_IO_PROG -t -f -c "falloc 0 5g" $dummyfile | _filter_xfs_io
+
+# -ENOSPC should be triggered without any panic
+echo "==== change i_size & write data ===="
+$XFS_IO_PROG							\
+	-c "truncate 96"					\
+	-c "pwrite -S 0x58 8192 4096"				\
+$testfile | _filter_xfs_io
+
+echo "==== check data contents ===="
+hexdump -C $testfile
+_scratch_remount
+hexdump -C $testfile
+
+rm $testfile
+rm $dummyfile
+
+status=0
+exit
diff --git a/tests/f2fs/001.out b/tests/f2fs/001.out
new file mode 100644
index 0000000..593f82a
--- /dev/null
+++ b/tests/f2fs/001.out
@@ -0,0 +1,21 @@
+QA output created by 001
+==== create small file ====
+wrote 40/40 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== Fullfill the partition ====
+fallocate: No space left on device
+==== change i_size & write data ====
+pwrite64: No space left on device
+==== check data contents ====
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+00000020  58 58 58 58 58 58 58 58  00 00 00 00 00 00 00 00  |XXXXXXXX........|
+00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000060
+00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
+*
+00000020  58 58 58 58 58 58 58 58  00 00 00 00 00 00 00 00  |XXXXXXXX........|
+00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000060
diff --git a/tests/f2fs/group b/tests/f2fs/group
new file mode 100644
index 0000000..daba9a3
--- /dev/null
+++ b/tests/f2fs/group
@@ -0,0 +1,6 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
+001 auto quick rw
-- 
2.4.9 (Apple Git-60)

