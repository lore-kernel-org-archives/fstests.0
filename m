Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50335 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbaKFROZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 6 Nov 2014 12:14:25 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH] xfs/062: verify bulkstat finds all inodes
Date: Thu,  6 Nov 2014 12:14:22 -0500
Message-Id: <1415294062-1552-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

The bulkstat mechanism is used by xfsdump and other tools to index all
inodes allocated in a filesystem. Run some simple tests with varying
inode layouts and bulkstat batch sizes to verify bulkstat finds the
expected number of inodes.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Here's a test based on some of the review discussion for Dave's recent
bulkstat fixup. This doesn't reproduce problems in current code (perhaps
it can be enhanced to detect some of the original problems?), but it
detects some tricky regressions found during the development cycle and
only takes a few seconds to run.

Brian

 tests/xfs/062     | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/062.out |  17 +++++++++
 tests/xfs/group   |   1 +
 3 files changed, 128 insertions(+)
 create mode 100755 tests/xfs/062
 create mode 100644 tests/xfs/062.out

diff --git a/tests/xfs/062 b/tests/xfs/062
new file mode 100755
index 0000000..cc3782e
--- /dev/null
+++ b/tests/xfs/062
@@ -0,0 +1,110 @@
+#! /bin/bash
+# FS QA Test No. 062
+#
+# Use the bstat utility to verify bulkstat finds all inodes in a filesystem.
+# Test under various inode counts, inobt record layouts and bulkstat batch
+# sizes.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Red Hat, Inc.  All Rights Reserved.
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
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    cd /
+    rm -f $tmp.*
+}
+
+# print the number of inodes counted by bulkstat
+_bstat_count()
+{
+	batchsize=$1
+	./src/bstat $SCRATCH_MNT $batchsize | grep ino | wc -l
+}
+
+# print bulkstat counts using varied batch sizes
+_bstat_test()
+{
+	expect=`find $SCRATCH_MNT -print | wc -l`
+	echo "expect $expect"
+
+	_bstat_count 4096
+	_bstat_count 32
+	_bstat_count 1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+_require_scratch
+
+# real QA test starts here
+
+_supported_fs xfs
+_supported_os Linux
+
+rm -f $seqres.full
+
+DIRCOUNT=8
+INOCOUNT=$((2048 / DIRCOUNT))
+
+_scratch_mkfs "-d agcount=$DIRCOUNT" >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+# create a set of directories and fill each with a fixed number of files
+for dir in $(seq 1 $DIRCOUNT); do
+	mkdir -p $SCRATCH_MNT/$dir
+	for i in $(seq 1 $INOCOUNT); do
+		touch $SCRATCH_MNT/$dir/$i
+	done
+done
+_bstat_test
+
+# remove every other file from each dir
+for dir in $(seq 1 $DIRCOUNT); do
+	for i in $(seq 2 2 $INOCOUNT); do
+		rm -f $SCRATCH_MNT/$dir/$i
+	done
+done
+_bstat_test
+
+# remove the entire second half of files
+for dir in $(seq 1 $DIRCOUNT); do
+	for i in $(seq $((INOCOUNT / 2)) $INOCOUNT); do
+		rm -f $SCRATCH_MNT/$dir/$i
+	done
+done
+_bstat_test
+
+# remove all regular files
+for dir in $(seq 1 $DIRCOUNT); do
+	rm -f $SCRATCH_MNT/$dir/*
+done
+_bstat_test
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/062.out b/tests/xfs/062.out
new file mode 100644
index 0000000..fbc25b1
--- /dev/null
+++ b/tests/xfs/062.out
@@ -0,0 +1,17 @@
+QA output created by 062
+expect 2057
+2057
+2057
+2057
+expect 1033
+1033
+1033
+1033
+expect 521
+521
+521
+521
+expect 9
+9
+9
+9
diff --git a/tests/xfs/group b/tests/xfs/group
index 222942e..4b8e51a 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -58,6 +58,7 @@
 059 dump ioctl auto quick
 060 dump ioctl auto quick
 061 dump ioctl auto quick
+062 auto ioctl quick
 063 dump attr auto quick
 064 dump auto
 065 dump auto
-- 
1.8.3.1

