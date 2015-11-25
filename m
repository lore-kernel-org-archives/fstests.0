Received: from mx1.redhat.com ([209.132.183.28]:47811 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbbKYUTw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Nov 2015 15:19:52 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 1/2] tests/xfs: test xfsprogs log formatting infrastructure
Date: Wed, 25 Nov 2015 15:19:49 -0500
Message-Id: <1448482790-44469-2-git-send-email-bfoster@redhat.com>
In-Reply-To: <1448482790-44469-1-git-send-email-bfoster@redhat.com>
References: <1448482790-44469-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

The xfsprogs libxfs layer implements its own log formatting code to
support utilities that might need to format the log, such as mkfs,
repair, metadump, etc. This code is fairly independent from kernel log
writing code. Therefore, add a test that reformats the log from
userspace with various supported log stripe unit alignments and verifies
that the end result is a correctly formatted log.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 common/rc         | 14 +++++++++++
 tests/xfs/376     | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/376.out |  6 +++++
 tests/xfs/group   |  1 +
 4 files changed, 92 insertions(+)
 create mode 100755 tests/xfs/376
 create mode 100644 tests/xfs/376.out

diff --git a/common/rc b/common/rc
index 4c2f42c..a2628d7 100644
--- a/common/rc
+++ b/common/rc
@@ -1654,6 +1654,20 @@ _require_xfs_io_command()
 		_notrun "xfs_io $command failed (old kernel/wrong fs?)"
 }
 
+# check that xfs_db supports a specific command
+_require_xfs_db_command()
+{
+	if [ $# -ne 1 ]
+	then
+		echo "Usage: _require_xfs_db_command command" 1>&2
+		exit 1
+	fi
+	command=$1
+
+	$XFS_DB_PROG -x -c "help" $SCRATCH_DEV | grep $command > /dev/null || \
+		_notrun "xfs_db $command support is missing"
+}
+
 # check that kernel and filesystem support direct I/O
 _require_odirect()
 {
diff --git a/tests/xfs/376 b/tests/xfs/376
new file mode 100755
index 0000000..e8cc15d
--- /dev/null
+++ b/tests/xfs/376
@@ -0,0 +1,71 @@
+#! /bin/bash
+# FS QA Test No. 376
+#
+# This test verifies that the xfsprogs log formatting infrastructure works
+# correctly for various log stripe unit values. The log is formatted with xfs_db
+# and verified with xfs_logprint.
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
+_require_xfs_db_command "logformat"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+# Reformat the log with various log stripe unit sizes and see if logprint dumps
+# any errors. Use a cycle value larger than 1 so the log is actually written
+# (the log is zeroed when cycle == 1).
+for i in 16 32 64 128 256; do
+	lsunit=$((i * 1024))
+	$XFS_DB_PROG -x -c "logformat -c 3 -s $lsunit" $SCRATCH_DEV | \
+		tee -a $seqres.full
+	# don't redirect error output so it causes test failure
+	$XFS_LOGPRINT_PROG $SCRATCH_DEV >> $seqres.full
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/376.out b/tests/xfs/376.out
new file mode 100644
index 0000000..b13a150
--- /dev/null
+++ b/tests/xfs/376.out
@@ -0,0 +1,6 @@
+QA output created by 376
+Formatting the log to cycle 3, stripe unit 16384 bytes.
+Formatting the log to cycle 3, stripe unit 32768 bytes.
+Formatting the log to cycle 3, stripe unit 65536 bytes.
+Formatting the log to cycle 3, stripe unit 131072 bytes.
+Formatting the log to cycle 3, stripe unit 262144 bytes.
diff --git a/tests/xfs/group b/tests/xfs/group
index 9884329..77b9994 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -226,3 +226,4 @@
 303 auto quick quota
 304 auto quick quota
 305 auto quota
+376 auto logprint quick v2log
-- 
2.1.0

