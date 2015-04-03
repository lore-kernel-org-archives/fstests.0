Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbDCHSn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 3 Apr 2015 03:18:43 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 3721CA0B5B
	for <fstests@vger.kernel.org>; Fri,  3 Apr 2015 07:18:43 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v3 4/4] generic: test fs freeze/unfreeze and mount/umount race
Date: Fri,  3 Apr 2015 15:18:34 +0800
Message-Id: <1428045514-10811-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1428045351-10446-1-git-send-email-eguan@redhat.com>
References: <1428045351-10446-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Exercise fs freeze/unfreeze and mount/umount race, which could lead to
use-after-free oops.

This commit fixed the issue:
1494583 fix get_active_super()/umount() race

This test case is based on a script from Monakhov Dmitriy.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v3:
- rebase and re-numbered to generic/085
- add more comments to explain why results of suspend/resume, mount/umount are ignored

v2:
- add comments to explain dmsetup is used not xfs_freeze to freeze filesystem
- detect failures in setup phase, so test exits not continus with errors

 tests/generic/085     | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/085.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 109 insertions(+)
 create mode 100755 tests/generic/085
 create mode 100644 tests/generic/085.out

diff --git a/tests/generic/085 b/tests/generic/085
new file mode 100755
index 0000000..8398752
--- /dev/null
+++ b/tests/generic/085
@@ -0,0 +1,106 @@
+#! /bin/bash
+# FS QA Test No. 085
+#
+# Exercise fs freeze/unfreeze and mount/umount race, which could lead to
+# use-after-free oops.
+#
+# This commit fixed the issue:
+# 1494583 fix get_active_super()/umount() race
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
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
+	cleanup_dmdev
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_block_device $SCRATCH_DEV
+_require_command $DMSETUP_PROG
+_require_freeze
+
+setup_dmdev()
+{
+	table="0 $size_in_sector linear $SCRATCH_DEV 0"
+	$DMSETUP_PROG create $node --table "$table" >>$seqres.full 2>&1 && \
+	$DMSETUP_PROG mknodes >/dev/null 2>&1
+	return $?
+}
+
+cleanup_dmdev()
+{
+	# in case it's still suspended and/or mounted
+	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
+	$UMOUNT_PROG $lvdev >/dev/null 2>&1
+
+	$DMSETUP_PROG remove $node >>$seqres.full 2>&1
+	$DMSETUP_PROG mknodes >/dev/null 2>&1
+}
+
+rm -f $seqres.full
+echo "Silence is golden"
+
+size=$((256 * 1024 * 1024))
+size_in_sector=$((size / 512))
+_scratch_mkfs_sized $size >>$seqres.full 2>&1
+
+node=$seq-test
+lvdev=/dev/mapper/$node
+setup_dmdev || _fail "setup dm device failed"
+
+# take use of dmsetup suspend to freeze the fs.
+# xfs_freeze/fsfreeze cannot be used in this test, because it can possibly
+# freeze the root fs of the host when SCRATCH_MNT is not mounted
+#
+# And the results of the racing commands (suspend/resume, mount/umount) are not
+# important, as long as they're racing with each other. So just throw away the
+# outputs and ignore the results.
+for ((i=0; i<100; i++)); do
+	$DMSETUP_PROG suspend $lvdev >/dev/null 2>&1
+	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
+done &
+pid=$!
+for ((i=0; i<100; i++)); do
+	$MOUNT_PROG $lvdev $SCRATCH_MNT >/dev/null 2>&1
+	$UMOUNT_PROG $lvdev >/dev/null 2>&1
+done &
+pid="$pid $!"
+
+wait $pid
+
+status=0
+exit
diff --git a/tests/generic/085.out b/tests/generic/085.out
new file mode 100644
index 0000000..76aef1a
--- /dev/null
+++ b/tests/generic/085.out
@@ -0,0 +1,2 @@
+QA output created by 085
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 5cbc1fe..a96b901 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -87,6 +87,7 @@
 082 auto quick
 083 rw auto enospc stress
 084 auto metadata quick
+085 auto freeze mount
 088 perms auto quick
 089 metadata auto
 091 rw auto quick
-- 
1.8.3.1

