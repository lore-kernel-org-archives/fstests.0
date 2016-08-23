Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60107 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753934AbcHWRwR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Aug 2016 13:52:17 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u7NHjErb006991
        for <fstests@vger.kernel.org>; Tue, 23 Aug 2016 10:52:17 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 250tnw0f3t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Tue, 23 Aug 2016 10:52:17 -0700
From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] btrfs/131: send test for rename+recycled ino
Date: Tue, 23 Aug 2016 13:51:58 -0400
Message-ID: <1471974718-1430-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is a test for a problem I hit with send/receive.  If you mount with -o
inode_cache it is possible to recycle inode numbers, and btrfs assumes that when
you have a recycled inode number that it's parent directory won't be needing a
rename, but this is not the case.  Without the patch to fix this problem this
test will panic the box if ASSERT() is turned on, otherwise it'll simply fail
the fssum.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 tests/btrfs/131     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/131.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 94 insertions(+)
 create mode 100644 tests/btrfs/131
 create mode 100644 tests/btrfs/131.out

diff --git a/tests/btrfs/131 b/tests/btrfs/131
new file mode 100644
index 0000000..596adc1
--- /dev/null
+++ b/tests/btrfs/131
@@ -0,0 +1,91 @@
+#! /bin/bash
+# FS QA Test 131
+#
+# Make sure btrfs handles send/receive of a file that has been destroyed and
+# recreated with a recycled inode number and a renamed parent directory.  This
+# is a test for a fix based on the patch
+# 
+# Btrfs: handle pending renames with recycled inodes properly
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Facebook. All Rights Reserved.
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
+tmp=`mktemp -d`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	rm -fr $tmp
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_fssum
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount "-o inode_cache"
+
+_run_btrfs_util_prog subvolume create $SCRATCH_MNT/base
+mkdir $SCRATCH_MNT/base/b
+mkdir $SCRATCH_MNT/base/a
+mv $SCRATCH_MNT/base/b $SCRATCH_MNT/base/a
+
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/base \
+	$SCRATCH_MNT/snap1
+_run_btrfs_util_prog send $SCRATCH_MNT/snap1 -f $tmp/1.snap
+
+mv $SCRATCH_MNT/base/a $SCRATCH_MNT/base/c
+rmdir $SCRATCH_MNT/base/c/b
+
+# We need to sync to make sure the inode number is recycled
+sync
+mkdir $SCRATCH_MNT/base/c/b
+
+_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/base $SCRATCH_MNT/snap2
+run_check $FSSUM_PROG -A -f -w $tmp/fssum $SCRATCH_MNT/snap2
+
+_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2 -f $tmp/2.snap
+
+_scratch_unmount
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/1.snap
+_run_btrfs_util_prog receive $SCRATCH_MNT -f $tmp/2.snap
+run_check $FSSUM_PROG -r $tmp/fssum $SCRATCH_MNT/snap2
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/131.out b/tests/btrfs/131.out
new file mode 100644
index 0000000..d118ca9
--- /dev/null
+++ b/tests/btrfs/131.out
@@ -0,0 +1,2 @@
+QA output created by 131
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 6b29c05..933fe10 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -133,3 +133,4 @@
 128 auto quick send
 129 auto quick send
 130 auto clone send
+131 auto quick send
-- 
1.8.3.1

