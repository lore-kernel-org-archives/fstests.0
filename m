Received: from mx1.redhat.com ([209.132.183.28]:46316 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbbGTRYz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 20 Jul 2015 13:24:55 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 4474D3679F5
	for <fstests@vger.kernel.org>; Mon, 20 Jul 2015 17:24:55 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-76.bos.redhat.com [10.18.41.76])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6KHOsAG013919
	for <fstests@vger.kernel.org>; Mon, 20 Jul 2015 13:24:55 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH] tests/xfs: test log recovery checksum with different log buf sizes
Date: Mon, 20 Jul 2015 13:24:53 -0400
Message-Id: <1437413093-28812-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

XFS had a bug which lead to spurious checksum failures during
verification of log records during recovery. This occurred when the
filesystem was mounted for recovery with a different log buffer size
(via the 'logbsize=...' mount option from when the filesystem crashed.

Create a regression test that dirties the log using one particular log
buffer size, shuts down the fs and attempts recovery using a larger log
buffer size.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Note that this test currently fails on XFS. I'll be posting a kernel fix
shortly...

Brian

 tests/xfs/077     | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/077.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 91 insertions(+)
 create mode 100755 tests/xfs/077
 create mode 100644 tests/xfs/077.out

diff --git a/tests/xfs/077 b/tests/xfs/077
new file mode 100755
index 0000000..8d442e6
--- /dev/null
+++ b/tests/xfs/077
@@ -0,0 +1,88 @@
+#! /bin/bash
+# FS QA Test No. 077
+#
+# Regression test for a bug in the log record checksum mechanism of XFS. Log
+# records are checksummed during recovery and a warning or mount failure occurs
+# on checksum verification failure. XFS had a bug where the checksum mechanism
+# verified different parts of a record depending on the current log buffer size.
+# This caused spurious checksum failures when a filesystem is recovered using a
+# different log buffer size from when the filesystem crashed.
+#
+# Test that log recovery succeeds with a different log buffer size from when the
+# filesystem crashed.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat, Inc. All Rights Reserved.
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
+	killall -9 fsstress > /dev/null 2>&1
+	wait > /dev/null 2>&1
+}
+
+rm -f $seqres.full
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/log
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_v2log
+
+echo "Silence is golden."
+
+dmesg -c > /dev/null
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount "-o logbsize=32k"
+
+# Run a workload to dirty the log, wait a bit and shutdown the fs.
+$FSSTRESS_PROG -d $SCRATCH_MNT -p 4 -n 99999999 >> $seqres.full 2>&1 &
+sleep 10
+./src/godown -f $SCRATCH_MNT
+wait
+
+# Remount with a different log buffer size. Going from 32k to 64k increases the
+# log record extended header count, as the log record header can only handle 32k
+# of space.
+_scratch_unmount
+_scratch_mount "-o logbsize=64k"
+
+# The mount may not fail on v4 filesystems. Check for CRC mismatch warning
+# messages to detect failure in this case.
+dmesg -c | grep XFS | grep CRC
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/077.out b/tests/xfs/077.out
new file mode 100644
index 0000000..cbd2333
--- /dev/null
+++ b/tests/xfs/077.out
@@ -0,0 +1,2 @@
+QA output created by 077
+Silence is golden.
diff --git a/tests/xfs/group b/tests/xfs/group
index 848a1bd..744393a 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -71,6 +71,7 @@
 071 rw auto
 072 rw auto prealloc quick
 073 copy auto
+077 auto log quick
 078 growfs auto quick
 080 rw ioctl
 081 deprecated # log logprint quota
-- 
2.1.0

