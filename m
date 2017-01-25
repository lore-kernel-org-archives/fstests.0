Received: from aserp1040.oracle.com ([141.146.126.69]:28665 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbdAYWOs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Jan 2017 17:14:48 -0500
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH v2] fstests: generic: splitted large dio write could trigger assertion on btrfs
Date: Wed, 25 Jan 2017 14:13:57 -0800
Message-Id: <1485382437-19867-1-git-send-email-bo.li.liu@oracle.com>
In-Reply-To: <1484259726-3561-1-git-send-email-bo.li.liu@oracle.com>
References: <1484259726-3561-1-git-send-email-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On btrfs, if a large dio write (>=128MB) got splitted, the outstanding_extents
assertion would complain.  Note that CONFIG_BTRFS_ASSERT is required.

Regression test for
  Btrfs: adjust outstanding_extents counter properly when dio write is split

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
v2: Rebase and change to only use _require_fs_space

 tests/generic/406     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/406.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 77 insertions(+)
 create mode 100755 tests/generic/406
 create mode 100644 tests/generic/406.out

diff --git a/tests/generic/406 b/tests/generic/406
new file mode 100755
index 0000000..88ab0da
--- /dev/null
+++ b/tests/generic/406
@@ -0,0 +1,74 @@
+#! /bin/bash
+# FS QA Test generic/406
+#
+# If a larger dio write (size >= 128M) got splitted, the assertion in endio
+# would complain (CONFIG_BTRFS_ASSERT is required).
+#
+# Regression test for
+#   Btrfs: adjust outstanding_extents counter properly when dio write is split
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
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
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_odirect
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+# 2G / 1K
+blocksize=$(( (128 + 1) * 2 * 1024 * 1024))
+fsblock=$(( (128 + 1) * 2 * 1024))
+_require_fs_space $SCRATCH_MNT $fsblock
+
+echo "Silence is golden"
+
+$XFS_IO_PROG -f -d -c "pwrite -b ${blocksize} 0 ${blocksize}" $SCRATCH_MNT/testfile.$seq >> $seqres.full 2>&1
+
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/406.out b/tests/generic/406.out
new file mode 100644
index 0000000..eaf210d
--- /dev/null
+++ b/tests/generic/406.out
@@ -0,0 +1,2 @@
+QA output created by 406
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 5621906..159d691 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -408,3 +408,4 @@
 403 auto quick attr
 404 auto quick insert
 405 auto mkfs
+406 auto quick dangerous
-- 
2.5.0

