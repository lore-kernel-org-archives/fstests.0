Received: from mx2.suse.de ([195.135.220.15]:52070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751059AbdI0TKN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Sep 2017 15:10:13 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52BDDAE7B
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2017 19:10:12 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH 2/2] generic/462: Partial direct write test
Date: Wed, 27 Sep 2017 14:10:03 -0500
Message-Id: <20170927191003.10099-2-rgoldwyn@suse.de>
In-Reply-To: <20170927191003.10099-1-rgoldwyn@suse.de>
References: <20170927191003.10099-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Getting an error midway through a direct write would return an error
and the error-code is returned in the write() call. However, partial
data is over-written during the call.

This tests simulates the ENOSPC error to check for partial direct
write consistency.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 tests/generic/462     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/462.out |  9 ++++++
 tests/generic/group   |  1 +
 3 files changed, 100 insertions(+)
 create mode 100755 tests/generic/462
 create mode 100644 tests/generic/462.out

diff --git a/tests/generic/462 b/tests/generic/462
new file mode 100755
index 00000000..c6c5e7fc
--- /dev/null
+++ b/tests/generic/462
@@ -0,0 +1,90 @@
+#! /bin/bash
+# FS QA Test No. 461
+#
+# write() to a file opened with O_DIRECT with count > remaining
+# bytes. Result should be remaining bytes (to aligned bytes) instead
+# of ENOSPC error
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015, Oracle and/or its affiliates.  All Rights Reserved.
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
+
+rm -f $seqres.full
+
+echo "Reformat with 320M size"
+umount $SCRATCH_MNT
+sz_bytes=$((320 * 1024 * 1024))
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+testdir=$SCRATCH_MNT/test-$seq
+rm -rf $testdir
+mkdir $testdir
+sync
+
+#Almost fill the filesystem
+echo "Almost fill the filesystem"
+for i in `seq 1 5`; do
+    $XFS_IO_PROG -f -c "pwrite 0 40M" $testdir/file-$i > /dev/null
+done
+
+# Create a file using direct I/O which succeeds only partially
+$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128M -V 1 0 128M" $testdir/partial > /dev/null 2>&1
+partial_size=`stat $testdir/partial | grep "Size" | tr -s " " | cut -f 3 -d " "`
+if [ $partial_size -gt 0 ]; then
+	echo "File partial size is greater than zero."
+else
+	echo "File partial size is zero"
+fi
+
+# re-write the file again with default pattern using one single buffer
+write_size=`src/pwritev2 -d -V 1 -b 128M $testdir/partial | grep ret | cut -f 4 -d " "`
+if [ $write_size -gt 0 ]; then
+	echo "pwritev2() wrote more than zero bytes."
+else
+	echo "pwritev2() returned $write_size"
+fi
+
+# read the partial file to check if data written is correct
+$XFS_IO_PROG -d -c "pread 0 4k -v" $testdir/partial | _filter_xfs_io_unique 
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/462.out b/tests/generic/462.out
new file mode 100644
index 00000000..117a64b0
--- /dev/null
+++ b/tests/generic/462.out
@@ -0,0 +1,9 @@
+QA output created by 462
+Reformat with 320M size
+Almost fill the filesystem
+File partial size is greater than zero.
+pwritev2() wrote more than zero bytes.
+00000000:  cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  ................
+*
+read 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index 6352064a..f6da2805 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -464,3 +464,4 @@
 459 auto dangerous
 460 auto quick rw
 461 auto quick rw
+462 auto quick rw
-- 
2.14.1

