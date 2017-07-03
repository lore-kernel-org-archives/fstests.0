Received: from mx1.redhat.com ([209.132.183.28]:54968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752233AbdGCPcH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 3 Jul 2017 11:32:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9849986647
        for <fstests@vger.kernel.org>; Mon,  3 Jul 2017 15:32:06 +0000 (UTC)
Received: from eorzea.usersys.redhat.com (unknown [10.43.17.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51086E524
        for <fstests@vger.kernel.org>; Mon,  3 Jul 2017 15:32:05 +0000 (UTC)
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH] xfs test: Buffer resubmittion test
Date: Mon,  3 Jul 2017 17:32:00 +0200
Message-Id: <20170703153200.14423-1-cmaiolino@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

this is the xfstests case for the buffer resubmition failures with
dm-thin I'm working on.

I used test 999 to avoid the need of changing the test number between
revisions. I don't write a xfstest for a while, so I am not sure if the
test is ok as it is.

It is doing its job though :) Passing with a kernel using my last
patches for the problem (although they still need revision), and hanging
up when the test is executed with a kernel without my patches, so be
careful to try it.

Thoughts?

Cheers

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 tests/xfs/999     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |   2 ++
 tests/xfs/group   |   1 +
 3 files changed, 105 insertions(+)
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

diff --git a/tests/xfs/999 b/tests/xfs/999
new file mode 100755
index 0000000..5ae8b74
--- /dev/null
+++ b/tests/xfs/999
@@ -0,0 +1,102 @@
+#! /bin/bash
+# FS QA Test 999
+#
+# Test buffer resubmission after a failed writeback with to a full overcommited
+# dm-thin device. 
+#
+# This test will hang the filesystem when ran on an unpatched kernel
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 YOUR NAME HERE.  All Rights Reserved.
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
+	$UMOUNT_PROG $mnt >/dev/null 2>&1
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
+mnt=$SCRATCH_DIR/mnt_$seq
+mkdir -p $mnt
+
+#Ensure we have enough disk space
+_scratch_mkfs_sized $((250 * 1024 * 1024)) >>$seqres.full 2>&1
+
+$LVM_PROG pvcreate -f $SCRATCH_DEV >/dev/null 2>&1
+$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >/dev/null 2>&1
+
+$LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y --zero n \
+-L $origpsize --poolmetadatasize 4M $vgname >/dev/null 2>&1
+
+$LVM_PROG lvcreate  --virtualsize $virtsize -T $vgname/$poolname \
+-n $lvname >/dev/null 2>&1
+
+_mkfs_dev /dev/mapper/$vgname-$lvname >/dev/null 2>&1
+
+$LVM_PROG lvcreate  -k n -s $vgname/$lvname -n $snapname >/dev/null 2>&1
+
+_mount /dev/mapper/$vgname-$snapname $mnt
+
+xfs_io -f -d -c 'pwrite -b 1m 0 120m' $mnt/f1 >/dev/null 2>&1
+
+fsfreeze -f $mnt &
+
+#Wait fsfreeze to its job
+sleep 10
+
+lvextend -L $newpsize $vgname/$poolname >/dev/null 2>&1
+
+fsfreeze -u $mnt
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

