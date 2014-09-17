Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:42768 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753860AbaIQBmO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 16 Sep 2014 21:42:14 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XU4Fo-0003kb-Ai
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XU4Fo-0006OT-9g
	for fstests@vger.kernel.org; Wed, 17 Sep 2014 11:41:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 5/5] generic: add write vs fcollapse test
Date: Wed, 17 Sep 2014 11:41:53 +1000
Message-Id: <1410918113-23516-6-git-send-email-david@fromorbit.com>
In-Reply-To: <1410918113-23516-1-git-send-email-david@fromorbit.com>
References: <1410918113-23516-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test exposed a problem with XFS where it failed to write back a
partial page correctly during a fcollapse operation. This left a
stray dirty buffer on the page, and hence invalidation of the page
then failed of the fcollapse returned an EBUSY error.

Make this a generic test so that we can ensure that all filesystems
handle the case correctly. Test case originally worked out and
written by Brian Foster.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/031     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/031.out | 19 ++++++++++++++
 tests/generic/group   |  1 +
 3 files changed, 93 insertions(+)
 create mode 100644 tests/generic/031
 create mode 100644 tests/generic/031.out

diff --git a/tests/generic/031 b/tests/generic/031
new file mode 100644
index 0000000..7d615c0
--- /dev/null
+++ b/tests/generic/031
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test No. generic/031
+#
+# Test non-aligned writes against fcollapse to ensure that partial pages are
+# correctly written and aren't left behind causing invalidation or data
+# corruption issues.
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
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os IRIX Linux
+_require_scratch
+_require_xfs_io_command "fcollapse"
+
+testfile=$SCRATCH_MNT/testfile
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+$XFS_IO_PROG -f \
+	-c "pwrite 185332 55756" \
+	-c "fcollapse 28672 40960" \
+	-c "pwrite 133228 63394" \
+	-c "fcollapse 0 4096" \
+$testfile | _filter_xfs_io
+
+echo "==== Pre-Remount ==="
+hexdump -C $testfile
+_scratch_remount
+echo "==== Post-Remount =="
+hexdump -C $testfile
+
+status=0
+exit
+
diff --git a/tests/generic/031.out b/tests/generic/031.out
new file mode 100644
index 0000000..194bfa4
--- /dev/null
+++ b/tests/generic/031.out
@@ -0,0 +1,19 @@
+QA output created by 031
+wrote 55756/55756 bytes at offset 185332
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 63394/63394 bytes at offset 133228
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+==== Pre-Remount ===
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
+0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+*
+0002fdc0
+==== Post-Remount ==
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
+0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
+*
+0002fdc0
diff --git a/tests/generic/group b/tests/generic/group
index ba1c913..dd6db3b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -33,6 +33,7 @@
 028 auto quick
 029 auto quick rw
 030 auto quick rw
+031 auto quick prealloc rw
 053 acl repair auto quick
 062 attr udf auto quick
 068 other auto freeze dangerous stress
-- 
2.0.0

