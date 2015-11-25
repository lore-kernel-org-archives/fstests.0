Received: from mx1.redhat.com ([209.132.183.28]:51307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbbKYUTw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Nov 2015 15:19:52 -0500
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH 2/2] tests/xfs: verify invalid metadata LSN detection
Date: Wed, 25 Nov 2015 15:19:50 -0500
Message-Id: <1448482790-44469-3-git-send-email-bfoster@redhat.com>
In-Reply-To: <1448482790-44469-1-git-send-email-bfoster@redhat.com>
References: <1448482790-44469-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

XFS v5 superblock fs' use metadata LSN tracking to determine when an
on-disk structure was last written to disk. This is used to ensure log
recovery operates correctly after an unclean shutdown. To work
correctly, the on-disk metadata LSNs must always remain behind the
current LSN with respect to the log.

Historically, xfs_repair had a problem where it incorrectly formats the
log to an LSN that is potentially behind existing metadata LSNs. As
such, xfs_repair and the kernel have been updated to prevent, detect and
recover from the problem. Add a test that intentionally formats the log
incorrectly and verifies that the fs fails to mount and that xfs_repair
detects the invalid metadata LSNs.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 tests/xfs/377     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/377.out |  3 ++
 tests/xfs/group   |  1 +
 3 files changed, 94 insertions(+)
 create mode 100755 tests/xfs/377
 create mode 100644 tests/xfs/377.out

diff --git a/tests/xfs/377 b/tests/xfs/377
new file mode 100755
index 0000000..c8211b8
--- /dev/null
+++ b/tests/xfs/377
@@ -0,0 +1,90 @@
+#! /bin/bash
+# FS QA Test No. 377
+#
+# XFS v5 supers carry an LSN in various on-disk structures to track when
+# associated metadata was last written to disk. These metadata LSNs must always
+# be behind the current LSN as dictated by the log to ensure log recovery
+# correctness after a potential crash. This test uses xfs_db to intentionally
+# put the current LSN behind metadata LSNs and verifies that the kernel and
+# xfs_repair detect the problem.
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
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_xfs_crc
+_require_xfs_db_command "logformat"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+# push the log cycle ahead so we have room to move it backwards later
+$XFS_DB_PROG -x -c "logformat -c 3" $SCRATCH_DEV >> $seqres.full 2>&1
+
+# do some work on the fs to update metadata LSNs
+_scratch_mount
+$FSSTRESS_PROG -d $SCRATCH_MNT -n 999 -p 4 -w >> $seqres.full 2>&1
+_scratch_unmount
+
+# Reformat to the current cycle and try to mount. This fails in most cases
+# because the sb LSN is ahead of the current LSN. If it doesn't fail, push the
+# cycle back further and try again.
+$XFS_DB_PROG -x -c "logformat" $SCRATCH_DEV >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+if [ $? != 0 ]; then
+	echo mount failure detected
+else
+	_scratch_unmount
+	$XFS_DB_PROG -x -c "logformat -c 2" $SCRATCH_DEV >> $seqres.full 2>&1
+	_scratch_mount >> $seqres.full 2>&1 || echo mount failure detected
+fi
+
+# verify that repair detects invalid LSNs as well
+$XFS_REPAIR_PROG -n $SCRATCH_DEV >> $seqres.full 2>&1 || \
+	echo repair failure detected
+
+# repair for real so the post-test check can verify repair fixed things up
+$XFS_REPAIR_PROG $SCRATCH_DEV >> $seqres.full 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/377.out b/tests/xfs/377.out
new file mode 100644
index 0000000..d49b5f2
--- /dev/null
+++ b/tests/xfs/377.out
@@ -0,0 +1,3 @@
+QA output created by 377
+mount failure detected
+repair failure detected
diff --git a/tests/xfs/group b/tests/xfs/group
index 77b9994..d8c32c7 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -227,3 +227,4 @@
 304 auto quick quota
 305 auto quota
 376 auto logprint quick v2log
+377 auto metadata v2log
-- 
2.1.0

