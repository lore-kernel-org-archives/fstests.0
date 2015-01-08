Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59847 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbbAHSb4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 8 Jan 2015 13:31:56 -0500
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs/087: test power failure test using godown
Date: Thu,  8 Jan 2015 10:31:19 -0800
Message-Id: <1420741879-73691-2-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1420741879-73691-1-git-send-email-jaegeuk@kernel.org>
References: <1420741879-73691-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
List-ID: <fstests@vger.kernel.org>

This patch adds f2fs/087 to test power failure by using godown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tests/f2fs/087     | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/087.out | 21 +++++++++++++
 tests/f2fs/group   |  1 +
 3 files changed, 110 insertions(+)
 create mode 100644 tests/f2fs/087
 create mode 100644 tests/f2fs/087.out
 create mode 100644 tests/f2fs/group

diff --git a/tests/f2fs/087 b/tests/f2fs/087
new file mode 100644
index 0000000..9410b9f
--- /dev/null
+++ b/tests/f2fs/087
@@ -0,0 +1,88 @@
+#! /bin/bash
+# FS QA Test No. 087
+#
+# * use godown likewise xfs/087
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Jaegeuk Kim
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
+#
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
+trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs f2fs
+_supported_os Linux
+
+rm -f $seqres.full $tmp.*
+_require_scratch
+
+_run_fsstress()
+{
+	out=$SCRATCH_MNT/fsstress
+	count=$((5000*$i))
+	echo $count
+	param="-p 4 -z -f sync=1 -f write=30 -f rmdir=10 -f link=10 -f creat=10 -f mkdir=10 -f rename=30 -f stat=30 -f unlink=30 -f truncate=20"
+	echo "calling fsstress $param -m8 -n $count" >>$seqres.full
+	FSSTRESS_ARGS=`_scale_fsstress_args $param $FSSTRESS_AVOID -m 8 -n $count -d $out`
+	if ! $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full 2>&1
+	then
+		echo "fsstress failed"
+	fi
+}
+
+# mkfs the FS
+_scratch_mkfs >>$seqres.full 2>&1
+if [ $? -ne 0 ] ; then
+	echo "mkfs failed: $MKFS_OPTIONS"
+fi
+
+i=1
+LOOP=10
+for i in $(seq 1 ${LOOP}); do
+	echo "** mount" >>$seqres.full
+	if ! _scratch_mount >>$seqres.full 2>&1; then
+		echo "mount failed: $MOUNT_OPTIONS"
+	fi
+
+	_run_fsstress
+
+	echo "** godown" >>$seqres.full
+	src/godown -v -f $SCRATCH_MNT -s 1 >>$seqres.full
+
+	umount $SCRATCH_DEV >/dev/null 2>&1
+
+	if _check_scratch_fs; then
+		echo "filesystem is checked ok"
+	else
+		echo "filesystem is NOT ok"
+	fi
+done
+
+status=0
+exit
diff --git a/tests/f2fs/087.out b/tests/f2fs/087.out
new file mode 100644
index 0000000..14bb897
--- /dev/null
+++ b/tests/f2fs/087.out
@@ -0,0 +1,21 @@
+QA output created by 087
+5000
+filesystem is checked ok
+10000
+filesystem is checked ok
+15000
+filesystem is checked ok
+20000
+filesystem is checked ok
+25000
+filesystem is checked ok
+30000
+filesystem is checked ok
+35000
+filesystem is checked ok
+40000
+filesystem is checked ok
+45000
+filesystem is checked ok
+50000
+filesystem is checked ok
diff --git a/tests/f2fs/group b/tests/f2fs/group
new file mode 100644
index 0000000..dd069d3
--- /dev/null
+++ b/tests/f2fs/group
@@ -0,0 +1 @@
+087 auto stress
-- 
2.1.1

