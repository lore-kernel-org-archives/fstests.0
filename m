Received: from bombadil.infradead.org ([65.50.211.133]:44601 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbdBBQ16 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Feb 2017 11:27:58 -0500
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1cZKEn-0007gE-Tl
        for fstests@vger.kernel.org; Thu, 02 Feb 2017 16:27:58 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] generic/407: check that destination timestamps are updated on clone
Date: Thu,  2 Feb 2017 17:27:55 +0100
Message-Id: <20170202162755.21101-1-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/407     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/407.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/generic/407
 create mode 100644 tests/generic/407.out

diff --git a/tests/generic/407 b/tests/generic/407
new file mode 100755
index 00000000..94d8af5f
--- /dev/null
+++ b/tests/generic/407
@@ -0,0 +1,85 @@
+#! /bin/bash
+# FS QA Test No. 407
+#
+# Verify that mtime is updated when cloning files
+#
+#-----------------------------------------------------------------------
+#
+# Copyright (c) 2014 Christoph Hellwig.  All Rights Reserved.
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
+status=0
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
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
+_require_cp_reflink
+_require_test
+
+echo "Silence is golden."
+rm -f $seqres.full
+
+# pattern the file.
+sourcefile=$TEST_DIR/clone_mtime_sourcefile
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c fsync $sourcefile >> $seqres.full
+
+destfile=$TEST_DIR/clone_mtime_destfile
+touch $destfile >> $seqres.full
+
+# sample timestamps.
+mtime1=`stat -c %Y $destfile`
+ctime1=`stat -c %Z $destfile`
+echo "before clone: $mtime1 $ctime1" >> $seqres.full
+
+# clone to trigger timestamp change
+sleep 2
+$XFS_IO_PROG -c "reflink $sourcefile " $destfile >> $seqres.full
+
+# sample and verify that timestamps have changed.
+mtime2=`stat -c %Y $destfile`
+ctime2=`stat -c %Z $destfile`
+echo "after clone : $mtime2 $ctime2" >> $seqres.full
+
+if [ "$mtime1" == "$mtime2" ]; then
+	echo "mtime not updated"
+	let status=$status+1
+fi
+if [ "$ctime1" == "$ctime2" ]; then
+	echo "ctime not updated"
+	let status=$status+1
+fi
+
+exit
diff --git a/tests/generic/407.out b/tests/generic/407.out
new file mode 100644
index 00000000..e29fe156
--- /dev/null
+++ b/tests/generic/407.out
@@ -0,0 +1,2 @@
+QA output created by 407
+Silence is golden.
diff --git a/tests/generic/group b/tests/generic/group
index 159d691b..72d6b3cb 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -409,3 +409,4 @@
 404 auto quick insert
 405 auto mkfs
 406 auto quick dangerous
+407 auto quick clone metadata
-- 
2.11.0

