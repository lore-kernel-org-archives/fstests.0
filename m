Received: from mx2.suse.de ([195.135.220.15]:60203 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752325AbdKVMcU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Nov 2017 07:32:20 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0DD3AABB4
        for <fstests@vger.kernel.org>; Wed, 22 Nov 2017 12:32:19 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH 1/2] generic/470: Test RWF_NOWAIT
Date: Wed, 22 Nov 2017 06:32:14 -0600
Message-Id: <20171122123215.32292-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Tests the RWF_NOWAIT flag so the I/O returns immediately with -EAGAIN
on a new file since it requires block allocation.

It creates a file, syncs it, and overwrites the file with RWF_NOWAIT.
This should succeed.

Finally, read the contents to make sure the overwrite is successful.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 tests/generic/470     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/470.out |  9 +++++++
 tests/generic/group   |  1 +
 3 files changed, 83 insertions(+)
 create mode 100644 tests/generic/470
 create mode 100644 tests/generic/470.out

diff --git a/tests/generic/470 b/tests/generic/470
new file mode 100644
index 00000000..8a742258
--- /dev/null
+++ b/tests/generic/470
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test No. 470
+#
+# write() to a file opened with O_DIRECT with count > remaining
+# bytes. Result should be remaining bytes (to aligned bytes) instead
+# of ENOSPC error
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
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
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -rf $tmp.* $testdir1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/populate
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_os Linux
+_require_odirect
+_require_scratch
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount > /dev/null 2>&1
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+# Create a file with pwrite nowait (will fail with EAGAIN)
+xfs_io -f -d -c "pwrite -N -V 1 -b 128M 0 128M" $testdir/f1
+
+# Write the file without nowait
+xfs_io -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 128M 0 128M" $testdir/f1 | _filter_xfs_io
+
+time_taken=`xfs_io -d -c "pwrite -N -V 1 -b 64M 0 64M" $testdir/f1 | awk '/^64/ {print $5}'`
+if (( $(echo "$time_taken < 0.05" | bc -l) )); then
+	echo "RWF_NOWAIT time is within limits."
+else
+	echo "RWF_NOWAIT took $time_taken seconds"
+fi
+
+xfs_io -f -d -c "pread -v 0 2M" $testdir/f1 | _filter_xfs_io_unique
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/470.out b/tests/generic/470.out
new file mode 100644
index 00000000..73a210b4
--- /dev/null
+++ b/tests/generic/470.out
@@ -0,0 +1,9 @@
+QA output created by 470
+pwrite: Resource temporarily unavailable
+wrote 134217728/134217728 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+RWF_NOWAIT time is within limits.
+00000000:  cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  ................
+*
+read 2097152/2097152 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index 6c3bb03a..11ccfb01 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -472,3 +472,4 @@
 467 auto quick exportfs
 468 shutdown auto quick metadata
 469 auto quick
+470 auto quick
-- 
2.14.2

