Received: from mx1.redhat.com ([209.132.183.28]:49075 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753943AbdGJNe0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Jul 2017 09:34:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCB947DCC1
        for <fstests@vger.kernel.org>; Mon, 10 Jul 2017 13:34:25 +0000 (UTC)
Received: from eorzea.usersys.redhat.com (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FB6D7D4F7
        for <fstests@vger.kernel.org>; Mon, 10 Jul 2017 13:34:25 +0000 (UTC)
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: [WIP PATCH V2] Buffer resubmittion test
Date: Mon, 10 Jul 2017 15:34:18 +0200
Message-Id: <20170710133418.7083-1-cmaiolino@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

this is the 2nd version of this test case. I still keep the number as
999 to avoid conflicts while it's still WIP, next version should be ok
to make it into a real patch with the right number.

Reason of this patch is still to check if AIL items are being properly
resubmitted after an error during writeback from buffers containing AIL
items.

This V2 includes:

	- Better indentation
	- More comments
	- Add copyright
	- use $SCRATCH_MNT instead of local created mount point
	- redirect outputs to $seqres.full instead of dev/null

- It doesn't change sleep by wait, because AFAIK, wait requires the process
being waited to return. Fsfreeze here is expected to hang until the
underlying device is extended.

Let me know your thoughts.

cheers.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 tests/xfs/999     | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |   2 +
 tests/xfs/group   |   1 +
 3 files changed, 122 insertions(+)
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

diff --git a/tests/xfs/999 b/tests/xfs/999
new file mode 100755
index 0000000..b46f1cc
--- /dev/null
+++ b/tests/xfs/999
@@ -0,0 +1,119 @@
+#! /bin/bash
+# FS QA Test 999
+#
+# Test buffer resubmission after a failed writeback with to a full overcommited
+# dm-thin device.
+#
+# When a dm-thin device reaches its full capacity, but the virtual device still
+# shows available space, XFS loops indefinitely in xfsaild due items still in
+# AIL. The buffers containing such items couldn't be resubmitted because the
+# items were flush locked. Test the kernel fix and ensure the buffers are
+# properly resubmitted.
+#
+# This test will hang the filesystem when ran on an unpatched kernel
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
+	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
+	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
+	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_scratch_nocheck
+_require_dm_target thin-pool
+_require_command $LVM_PROG lvm
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+vgname=vg_$seq
+lvname=lv_$seq
+poolname=pool_$seq
+snapname=snap_$seq
+origpsize=100
+virtsize=200
+newpsize=200
+
+# Ensure we have enough disk space
+_scratch_mkfs_sized $((250 * 1024 * 1024)) >>$seqres.full 2>&1
+
+# Create a 100MB dm-thin POOL
+$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
+$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
+
+$LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y \
+		    --zero n -L $origpsize \
+		    --poolmetadatasize 4M $vgname >>$seqres.full 2>&1
+
+# Create a overprovisioned 200MB dm-thin virt. device
+$LVM_PROG lvcreate  --virtualsize $virtsize \
+		    -T $vgname/$poolname \
+		    -n $lvname >>$seqres.full 2>&1
+
+_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
+
+
+$LVM_PROG lvcreate  -k n -s $vgname/$lvname \
+		    -n $snapname >>$seqres.full 2>&1
+
+_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT
+
+# Consume all space available in the volume and freeze to ensure everything
+# required to make the fs consistent is flushed to disk.
+xfs_io -f -d -c 'pwrite -b 1m 0 120m' $SCRATCH_MNT/f1 >>$seqres.full 2>&1
+
+# This freeze will never complete until the dm-thin POOL device is extended.
+# This is expected, it is only used so xfsaild is triggered to flush AIL items.
+fsfreeze -f $SCRATCH_MNT &
+
+# Wait enough so xfsaild can run
+sleep 10
+
+# Make some extra space available so the freeze above can proceed
+lvextend -L $newpsize $vgname/$poolname >>$seqres.full 2>&1
+
+# Try to thaw the filesystem, and complete test if if succeed.
+# NOTE: This will hang on affected XFS filesystems.
+fsfreeze -u $SCRATCH_MNT
+echo "Test OK"
+
+status=0
+exit
diff --git a/tests/xfs/999.out b/tests/xfs/999.out
new file mode 100644
index 0000000..8c3c938
--- /dev/null
+++ b/tests/xfs/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Test OK
diff --git a/tests/xfs/group b/tests/xfs/group
index 792161a..2bde916 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -416,3 +416,4 @@
 416 dangerous_fuzzers dangerous_scrub dangerous_repair
 417 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 418 dangerous_fuzzers dangerous_scrub dangerous_repair
+999 dangerous
-- 
2.9.4

