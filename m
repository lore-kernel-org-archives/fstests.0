Received: from mx2.suse.de ([195.135.220.15]:51144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932988AbdLGQAx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Dec 2017 11:00:53 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH v4 2/3] generic/470: Test RWF_NOWAIT
Date: Thu,  7 Dec 2017 10:00:43 -0600
Message-Id: <20171207160044.8913-2-rgoldwyn@suse.de>
In-Reply-To: <20171207160044.8913-1-rgoldwyn@suse.de>
References: <20171207160044.8913-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Tests the RWF_NOWAIT flag so the I/O returns immediately with -EAGAIN
on a new file since it requires block allocation.

It creates a file, syncs it, and overwrites the file with RWF_NOWAIT.
This should succeed.

Finally, read the contents to make sure the overwrite is successful.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Changes since v3:
 - Better comment with respect to time taken to perform I/O

---
 tests/generic/470     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/470.out | 13 +++++++++
 tests/generic/group   |  1 +
 3 files changed, 89 insertions(+)
 create mode 100755 tests/generic/470
 create mode 100644 tests/generic/470.out

diff --git a/tests/generic/470 b/tests/generic/470
new file mode 100755
index 00000000..27342c3d
--- /dev/null
+++ b/tests/generic/470
@@ -0,0 +1,75 @@
+#! /bin/bash
+# FS QA Test No. 470
+#
+# write a file with RWF_NOWAIT and it would fail because there are no
+# blocks allocated. Create a file with direct I/O and re-write it
+# using RWF_NOWAIT. I/O should finish within 50 microsecods since
+# block allocations are already performed.
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
+_require_test
+_require_xfs_io_command pwrite -N
+
+# Remove reminiscence of previously run tests
+testdir=$TEST_DIR/$seq
+if [ -e $testdir ]; then
+	rm -Rf $testdir
+fi
+
+mkdir $testdir
+
+# Create a file with pwrite nowait (will fail with EAGAIN)
+$XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
+
+# Write the file without nowait
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 1M 0 8M" $testdir/f1 | _filter_xfs_io
+
+time_taken=`$XFS_IO_PROG -d -c "pwrite -S 0xbb -N -V 1 -b 1M 2M 1M" $testdir/f1 | awk '/^1/ {print $5}'`
+
+# RWF_NOWAIT should finish within a short period of time so we are choosing
+# a conservative value of 50 ms. Anything longer means it is waiting
+# for something in the kernel which would be a fail.
+if (( $(echo "$time_taken < 0.05" | bc -l) )); then
+	echo "RWF_NOWAIT time is within limits."
+else
+	echo "RWF_NOWAIT took $time_taken seconds"
+fi
+
+$XFS_IO_PROG -c "pread -v 0 8M" $testdir/f1 | _filter_xfs_io_unique
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/470.out b/tests/generic/470.out
new file mode 100644
index 00000000..e46622cb
--- /dev/null
+++ b/tests/generic/470.out
@@ -0,0 +1,13 @@
+QA output created by 470
+pwrite: Resource temporarily unavailable
+wrote 8388608/8388608 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+RWF_NOWAIT time is within limits.
+00000000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+*
+00200000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
+*
+00300000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
+*
+read 8388608/8388608 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index 6c3bb03a..cf8529ea 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -472,3 +472,4 @@
 467 auto quick exportfs
 468 shutdown auto quick metadata
 469 auto quick
+470 auto quick rw
-- 
2.14.2

