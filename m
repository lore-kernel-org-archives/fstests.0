Received: from userp2120.oracle.com ([156.151.31.85]:42652 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJIGPC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Oct 2018 02:15:02 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] fstests: btrfs verify hardening agaist duplicate fsid
Date: Tue,  9 Oct 2018 02:14:52 +0800
Message-Id: <1539022492-3449-1-git-send-email-anand.jain@oracle.com>
In-Reply-To: <1538383475-2532-1-git-send-email-anand.jain@oracle.com>
References: <1538383475-2532-1-git-send-email-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We have a known bug in btrfs, that we let the device path be changed
after the device has been mounted. So using this loop hole the new
copied device would appears as if its mounted immediately after its
been copied. So this test case reproduces this issue.

For example:

Initially.. /dev/mmcblk0p4 is mounted as /

lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
mmcblk0     179:0    0 29.2G  0 disk
|-mmcblk0p4 179:4    0    4G  0 part /
|-mmcblk0p2 179:2    0  500M  0 part /boot
|-mmcblk0p3 179:3    0  256M  0 part [SWAP]
`-mmcblk0p1 179:1    0  256M  0 part /boot/efi

btrfs fi show
Label: none  uuid: 07892354-ddaa-4443-90ea-f76a06accaba
    Total devices 1 FS bytes used 1.40GiB
    devid    1 size 4.00GiB used 3.00GiB path /dev/mmcblk0p4

Copy mmcblk0 to sda
dd if=/dev/mmcblk0 of=/dev/sda

And immediately after the copy completes the change in the device
superblock is notified which the automount scans using
btrfs device scan and the new device sda becomes the mounted root
device.

lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    1 14.9G  0 disk
|-sda4        8:4    1    4G  0 part /
|-sda2        8:2    1  500M  0 part
|-sda3        8:3    1  256M  0 part
`-sda1        8:1    1  256M  0 part
mmcblk0     179:0    0 29.2G  0 disk
|-mmcblk0p4 179:4    0    4G  0 part
|-mmcblk0p2 179:2    0  500M  0 part /boot
|-mmcblk0p3 179:3    0  256M  0 part [SWAP]
`-mmcblk0p1 179:1    0  256M  0 part /boot/efi
btrfs fi show /
Label: none  uuid: 07892354-ddaa-4443-90ea-f76a06accaba
    Total devices 1 FS bytes used 1.40GiB
    devid    1 size 4.00GiB used 3.00GiB path /dev/sda4

The bug is quite nasty that you can't either unmount /dev/sda4 or
/dev/mmcblk0p4. And the problem does not get solved until you take
the sda out of the system on to another system to change its fsid using
the 'btrfstune -u' command.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/173     | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/173.out |  6 ++++
 tests/btrfs/group   |  1 +
 3 files changed, 95 insertions(+)
 create mode 100755 tests/btrfs/173
 create mode 100644 tests/btrfs/173.out

diff --git a/tests/btrfs/173 b/tests/btrfs/173
new file mode 100755
index 000000000000..b466ae921e19
--- /dev/null
+++ b/tests/btrfs/173
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 Oracle. All Rights Reserved.
+#
+# FS QA Test 173
+#
+# Fuzzy test for FS image duplication.
+#  Could be fixed by
+#    [patch] btrfs: harden agaist duplicate fsid
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
+mnt=$TEST_DIR/$seq.mnt
+_cleanup()
+{
+	rm -rf $mnt > /dev/null 2>&1
+	cd /
+	rm -f $tmp.*
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
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+
+dev_foo=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+dev_bar=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+
+echo dev_foo=$dev_foo >> $seqres.full
+echo dev_bar=$dev_bar >> $seqres.full
+echo | tee -a $seqres.full
+
+rm -rf $mnt > /dev/null 2>&1
+mkdir $mnt
+_mkfs_dev $dev_foo
+_mount $dev_foo $mnt
+
+check_btrfs_mount()
+{
+	local x=$(findmnt $mnt | grep -v TARGET | awk '{print $2}')
+	[[ $x == $dev_foo ]] && echo DEV_FOO
+	[[ $x == $dev_bar ]] && echo DEV_BAR
+}
+
+echo MNT $(check_btrfs_mount)
+
+for sb_bytenr in 65536 67108864
+do
+	echo -n "dd status=none if=$dev_foo of=$dev_bar bs=1 "\
+		"seek=$sb_bytenr skip=$sb_bytenr count=4096" >> $seqres.full
+	dd status=none if=$dev_foo of=$dev_bar bs=1 seek=$sb_bytenr \
+				skip=$sb_bytenr count=4096 >> $seqres.full 2>&1
+	echo ..:$? >> $seqres.full
+done
+
+#Original device is mounted, scan of its clone should fail
+$BTRFS_UTIL_PROG device scan $dev_bar >> $seqres.full 2>&1
+echo btrfs device scan dev_bar ...:$?| tee -a $seqres.full
+
+echo MNT $(check_btrfs_mount)
+
+#Original device scan should be successful
+$BTRFS_UTIL_PROG device scan $dev_foo >> $seqres.full 2>&1
+echo btrfs device scan dev_foo ...:$?| tee -a $seqres.full
+
+umount $mnt > /dev/null 2>&1
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/173.out b/tests/btrfs/173.out
new file mode 100644
index 000000000000..3c7e3fb4e3f7
--- /dev/null
+++ b/tests/btrfs/173.out
@@ -0,0 +1,6 @@
+QA output created by 173
+
+MNT DEV_FOO
+btrfs device scan dev_bar ...:1
+MNT DEV_FOO
+btrfs device scan dev_foo ...:0
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 45782565c3b7..b2f1393f3e97 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -175,3 +175,4 @@
 170 auto quick snapshot
 171 auto quick qgroup
 172 auto quick punch
+173 volume
-- 
1.8.3.1
