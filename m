Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbeGLFQt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Jul 2018 01:16:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F5FA14B38E
        for <fstests@vger.kernel.org>; Thu, 12 Jul 2018 05:08:58 +0000 (UTC)
Received: from dhcp-12-245.nay.redhat.com (dhcp-12-245.nay.redhat.com [10.66.12.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAD5D16874
        for <fstests@vger.kernel.org>; Thu, 12 Jul 2018 05:08:57 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] generic: test dm-thin running out of data space vs concurrent discard
Date: Thu, 12 Jul 2018 13:08:50 +0800
Message-Id: <20180712050850.7464-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If a user constructs a test that loops repeatedly over below steps
on dm-thin, block allocation can fail due to discards not having
completed yet (Fixed by a685557 dm thin: handle running out of data
space vs concurrent discard):
1) fill thin device via filesystem file
2) remove file
3) fstrim

And this maybe cause a deadlock (fast device likes ramdisk can help
a lot) when racing a fstrim with a filesystem (XFS) shutdown. (Fixed
by 8c81dd46ef3c Force log to disk before reading the AGF during a
fstrim)

This case can reproduce both two bugs if they're not fixed. If only
the dm-thin bug is fixed, then the test will pass. If only the fs
bug is fixed, then the test will fail. If both of bugs aren't fixed,
the test will hang.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V3 did below changes (by Eryu's reviewing):
1) filter the output message of _scratch_mkfs
2) increase the BACKING_SIZE from 50M to 128M (due to mkfs.btrfs
   fails on a 50M device.)

Thanks,
Zorro

 tests/generic/999     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 94 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..21e0bc0d
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,91 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 999
+#
+# Race test running out of data space with concurrent discard operation on
+# dm-thin.
+#
+# If a user constructs a test that loops repeatedly over below steps on
+# dm-thin, block allocation can fail due to discards not having completed
+# yet (Fixed by a685557 dm thin: handle running out of data space vs
+# concurrent discard):
+# 1) fill thin device via filesystem file
+# 2) remove file
+# 3) fstrim
+#
+# And this maybe cause a deadlock when racing a fstrim with a filesystem
+# (XFS) shutdown. (Fixed by 8c81dd46ef3c Force log to disk before reading
+# the AGF during a fstrim)
+#
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
+	_dmthin_cleanup
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/dmthin
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch_nocheck
+_require_dm_target thin-pool
+
+# Require underlying device support discard
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+_require_batched_discard $SCRATCH_MNT
+_scratch_unmount
+
+# Create a thin pool and a *slightly smaller* thin volume, it's helpful
+# to reproduce the bug
+BACKING_SIZE=$((128 * 1024 * 1024 / 512))	# 128M
+VIRTUAL_SIZE=$((BACKING_SIZE + 1024))		# 128M + 1k
+CLUSTER_SIZE=$((64 * 1024 / 512))		# 64K
+
+_dmthin_init $BACKING_SIZE $VIRTUAL_SIZE $CLUSTER_SIZE 0
+_dmthin_set_fail
+_mkfs_dev $DMTHIN_VOL_DEV
+_dmthin_mount
+
+# There're two bugs at here, one is dm-thin bug, the other is filesystem
+# (XFS especially) bug. The dm-thin bug can't handle running out of data
+# space with concurrent discard well. Then the dm-thin bug cause fs unmount
+# hang when racing a fstrim with a filesystem shutdown.
+#
+# If both of two bugs haven't been fixed, below test maybe cause deadlock.
+# Else if the fs bug has been fixed, but the dm-thin bug hasn't. below test
+# will cause the test fail (no deadlock).
+# Else the test will pass.
+for ((i=0; i<20; i++)); do
+	$XFS_IO_PROG -f -c "pwrite -b 64k 0 256M" \
+		$SCRATCH_MNT/testfile &>/dev/null
+	rm -f $SCRATCH_MNT/testfile
+	$FSTRIM_PROG $SCRATCH_MNT
+done
+
+_dmthin_check_fs
+_dmthin_cleanup
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..3b276ca8
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 83a6fdab..26f731f0 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -501,3 +501,4 @@
 496 auto quick swap
 497 auto quick swap collapse
 498 auto quick log
+999 auto thin trim
-- 
2.14.4

