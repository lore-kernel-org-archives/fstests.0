Received: from mx1.redhat.com ([209.132.183.28]:35912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751162AbdHBQgP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Aug 2017 12:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BA1CC0587C8
        for <fstests@vger.kernel.org>; Wed,  2 Aug 2017 16:36:15 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-20.bos.redhat.com [10.18.41.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56CA87F551
        for <fstests@vger.kernel.org>; Wed,  2 Aug 2017 16:36:15 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH v2] tests/xfs: test for log recovery failure after tail overwrite
Date: Wed,  2 Aug 2017 12:36:13 -0400
Message-Id: <20170802163613.54987-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

XFS is susceptible to log recovery problems if the fs crashes under
certain circumstances. If the tail has been pinned for long enough
to the log to fill and the next batch of log buffer submissions
happen to fail, the filesystem shuts down having potentially
overwritten part of the range between the last good tail->head range
in the log. This causes log recovery to fail with crc mismatch or
invalid log record errors.

Add a test that uses XFS DEBUG mode error injection to force the
tail overwrite condition with a known bad (crc mismatch) log write
and tests that log recovery succeeds. Note that this problem is
currently only reproducible with larger (non-default) log buffer
sizes (i.e., '-o logbsize=256k') or smaller block sizes (1k).

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Note that this test depends on Darrick's xfstests error injection update
[1] and kernel support for the log item pinning error injection tag [2]
(pending merge).

[1] http://marc.info/?l=linux-xfs&m=150067469824365&w=2
[2] http://marc.info/?l=linux-xfs&m=149969328617344&w=2

v2:
- Use error injection framework rather than direct sysfs interface.
- Use fixed size fs for smaller log.
v1: http://marc.info/?l=fstests&m=149763158322254&w=2

 tests/xfs/999     | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |   2 +
 tests/xfs/group   |   1 +
 3 files changed, 119 insertions(+)
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

diff --git a/tests/xfs/999 b/tests/xfs/999
new file mode 100755
index 0000000..1e51e1b
--- /dev/null
+++ b/tests/xfs/999
@@ -0,0 +1,116 @@
+#! /bin/bash
+# FS QA Test No. 999
+#
+# Attempt to reproduce log recovery failure by writing corrupt log records over
+# the last good tail in the log. The tail is force pinned while a workload runs
+# the head as close as possible behind the tail. Once the head is pinned,
+# corrupted log records are written to the log and the filesystem shuts down.
+#
+# While log recovery should handle the corrupted log records, it has historical
+# problems dealing with the situation where the corrupted log records may have
+# overwritten the tail of the previous good record in the log. If this occurs,
+# log recovery may fail.
+#
+# This can be reproduced more reliably under non-default conditions such as with
+# the smallest supported FSB sizes and/or largest supported log buffer sizes and
+# counts (logbufs and logbsize mount options).
+#
+# Note that this test requires a DEBUG mode kernel.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc. All Rights Reserved.
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
+	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
+	[ -e /sys/fs/xfs/$sdev/errortag/log_item_pin ] &&
+		echo 0 > /sys/fs/xfs/$sdev/errortag/log_item_pin
+	wait > /dev/null 2>&1
+}
+
+rm -f $seqres.full
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/inject
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_xfs_io_error_injection log_item_pin
+_require_xfs_io_error_injection log_bad_crc
+_require_scratch
+_require_command "$KILLALL_PROG" killall
+
+echo "Silence is golden."
+
+sdev=$(_short_dev $SCRATCH_DEV)
+
+# use a small log fs
+_scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqres.full 2>&1 ||
+		_fail "mkfs failed"
+_scratch_mount || _fail "mount failed"
+
+# populate the fs with some data and cycle the mount to reset the log head/tail
+$FSSTRESS_PROG -d $SCRATCH_MNT -z -fcreat=1 -p 4 -n 100000 > /dev/null 2>&1
+_scratch_cycle_mount || _fail "mount failed"
+
+# Pin the tail and start a file removal workload. File removal tends to
+# reproduce the corruption more reliably.
+_scratch_inject_error log_item_pin 1
+
+rm -rf $SCRATCH_MNT/* > /dev/null 2>&1 &
+workpid=$!
+
+# wait for the head to stop pushing forward
+prevhead=-1
+head=`cat /sys/fs/xfs/$sdev/log/log_head_lsn`
+while [ "$head" != "$prevhead" ]; do
+	sleep 5
+	prevhead=$head
+	head=`cat /sys/fs/xfs/$sdev/log/log_head_lsn`
+done
+
+# Once the head is pinned behind the tail, enable log record corruption and
+# unpin the tail. All subsequent log buffer writes end up corrupted on-disk and
+# result in log I/O errors.
+_scratch_inject_error log_bad_crc 1
+_scratch_inject_error log_item_pin 0
+
+# wait for fs shutdown to kill the workload
+wait $workpid
+
+# cycle mount to test log recovery
+_scratch_cycle_mount
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/999.out b/tests/xfs/999.out
new file mode 100644
index 0000000..d254382
--- /dev/null
+++ b/tests/xfs/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden.
diff --git a/tests/xfs/group b/tests/xfs/group
index cf876a2..4e35ec1 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -418,3 +418,4 @@
 422 dangerous_scrub dangerous_online_repair
 423 dangerous_scrub
 424 auto quick db
+999 auto log
-- 
2.9.4

