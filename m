Received: from bombadil.infradead.org ([65.50.211.133]:50106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbdBCJ6y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2017 04:58:54 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] generic/408: check that destination timestamps are not updated on dedupe
Date: Fri,  3 Feb 2017 10:58:39 +0100
Message-Id: <20170203095839.8007-3-hch@lst.de>
In-Reply-To: <20170203095839.8007-1-hch@lst.de>
References: <20170203095839.8007-1-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de
---
 tests/generic/408     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/408.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 87 insertions(+)
 create mode 100644 tests/generic/408
 create mode 100644 tests/generic/408.out

diff --git a/tests/generic/408 b/tests/generic/408
new file mode 100644
index 00000000..26cfc35e
--- /dev/null
+++ b/tests/generic/408
@@ -0,0 +1,84 @@
+#! /bin/bash
+# FS QA Test No. 408
+#
+# Verify that mtime is not updated when deduping files.
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (c) 2017 Christoph Hellwig.  All Rights Reserved.
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
+status=0
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $sourcefile
+	rm -f $destfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. common/reflink
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_test
+_require_test_dedupe
+
+echo "Silence is golden."
+rm -f $seqres.full
+
+# pattern the files.
+sourcefile=$TEST_DIR/dedup_mtime_sourcefile
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c fsync $sourcefile >> $seqres.full
+
+destfile=$TEST_DIR/dedup_mtime_destfile
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c fsync $destfile >> $seqres.full
+
+# sample timestamps.
+mtime1=`stat -c %Y $destfile`
+ctime1=`stat -c %Z $destfile`
+echo "before dedup: $mtime1 $ctime1" >> $seqres.full
+
+# dedup to trigger timestamp change
+sleep 1
+_dedupe_range $sourcefile 0 $destfile 0 "4k" >> $seqres.full
+
+# sample and verify that timestamps have changed.
+mtime2=`stat -c %Y $destfile`
+ctime2=`stat -c %Z $destfile`
+echo "after dedup : $mtime2 $ctime2" >> $seqres.full
+
+if [ "$mtime1" != "$mtime2" ]; then
+	echo "mtime updated"
+	let status=$status+1
+fi
+if [ "$ctime1" != "$ctime2" ]; then
+	echo "ctime updated"
+	let status=$status+1
+fi
+
+exit
diff --git a/tests/generic/408.out b/tests/generic/408.out
new file mode 100644
index 00000000..29ec47a8
--- /dev/null
+++ b/tests/generic/408.out
@@ -0,0 +1,2 @@
+QA output created by 408
+Silence is golden.
diff --git a/tests/generic/group b/tests/generic/group
index 72d6b3cb..740ce45b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -410,3 +410,4 @@
 405 auto mkfs
 406 auto quick dangerous
 407 auto quick clone metadata
+408 auto quick clone dedupe metadata
-- 
2.11.0

