Received: from mx1.redhat.com ([209.132.183.28]:43640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbcE2E2v (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 29 May 2016 00:28:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C10FED7A67
	for <fstests@vger.kernel.org>; Sun, 29 May 2016 04:28:50 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3 2/2] xfs/006: new case to test xfs fail_at_unmount error handling
Date: Sun, 29 May 2016 12:28:41 +0800
Message-Id: <1464496121-6380-2-git-send-email-zlang@redhat.com>
In-Reply-To: <1464496121-6380-1-git-send-email-zlang@redhat.com>
References: <1464496121-6380-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

XFS bring in a new configuration under /sys/fs/xfs/error, named
fail_at_unmount. It's used to stop unmount retrying forever when
it hit IO error.

This case try to unmount an faulty dm device, and to sure unmount
won't retry forever if fail_at_unmount=1.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

Nothing changed in this V3. Due to I modify [PATCH v3 1/2], so I think
if I send this 2/2 patch with 1/2 together, maybe easy to review and
merge? :)

Thanks,
Zorro

 tests/xfs/006     | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/006.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 84 insertions(+)
 create mode 100755 tests/xfs/006
 create mode 100644 tests/xfs/006.out

diff --git a/tests/xfs/006 b/tests/xfs/006
new file mode 100755
index 0000000..c134b1c
--- /dev/null
+++ b/tests/xfs/006
@@ -0,0 +1,81 @@
+#! /bin/bash
+# FS QA Test 006
+#
+# Test xfs' "fail at unmount" error handling configuration. Stop
+# XFS retrying to writeback forever when unmount.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 YOUR NAME HERE.  All Rights Reserved.
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
+	_dmerror_cleanup
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmerror
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+_require_dm_target error
+_require_scratch
+
+_scratch_mkfs > $seqres.full 2>&1
+_require_fs_sys_fs $SCRATCH_DEV error/fail_at_unmount
+
+# The device is still a linear device at here
+_dmerror_init
+_dmerror_mount
+
+# Enable fail_at_unmount
+_set_fs_sys_fs_param $DMERROR_DEV error/fail_at_unmount 1
+
+# make some IO at here. If these data still not writeback from
+# journal to data, it will hit writeback error after load error
+# tabel in next step.
+_pwrite_byte 0x61 0 100M $SCRATCH_MNT/file >/dev/null
+_dmerror_load_error_table
+
+# Even above data already all writeback, umount will cause XFS
+# try to writeback something to root inode. It still can trigger
+# umount fail.
+_dmerror_unmount
+
+echo "Silence is golden"
+_dmerror_cleanup
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/006.out b/tests/xfs/006.out
new file mode 100644
index 0000000..675c1b7
--- /dev/null
+++ b/tests/xfs/006.out
@@ -0,0 +1,2 @@
+QA output created by 006
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index f4c6816..39169ea 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -4,6 +4,7 @@
 004 db auto quick
 005 auto quick
 007 auto quota quick
+006 auto quick unmount
 008 rw ioctl auto quick
 009 rw ioctl auto prealloc quick
 010 auto quick repair
-- 
2.5.5

