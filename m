Received: from mx1.redhat.com ([209.132.183.28]:59603 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbcGEJaf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 5 Jul 2016 05:30:35 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14EDC63152
	for <fstests@vger.kernel.org>; Tue,  5 Jul 2016 09:30:35 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v5 2/2] xfs: configurable behavior on errors at unmount time
Date: Tue,  5 Jul 2016 17:30:24 +0800
Message-Id: <1467711024-12702-2-git-send-email-zlang@redhat.com>
In-Reply-To: <1467711024-12702-1-git-send-email-zlang@redhat.com>
References: <1467711024-12702-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

XFS used to retry forever on non-critical errors, and unmount could
hang in such case. Commit e6b3bb78962e ("xfs: add "fail at unmount"
error handling configuration") introduced an error configuration
option in sysfs(fail_at_unmount) and made this behavior configurable.

Now test this "fail_at_unmount" behavior to make sure XFS doesn't
retry forever on error at unmount time, if configured so. Also
introduced new helpers to require/set/get sysfs attributes.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

This's the 5th revision, besides various small fixes, there're 2 major
changes:
  1) Add some metadata workloads as Dave suggested.
  2) remove --nolockfs option when loading dmerror error table

The first change takes use of fsstress to generate metadata workloads,
but no block-allocation operations, because some uncompleted allocation
I/Os maybe cause XFS shutdown as below:

  [  285.255988] Buffer I/O error on dev dm-4, logical block 61521799, async page read
  [  285.690260] XFS (dm-4): metadata I/O error: block 0x2c06810 ("xfs_trans_read_buf_map") error 5 numblks 8
  [  285.690911] XFS (dm-4): Internal error xfs_trans_cancel at line 990 of file fs/xfs/xfs_trans.c.  Caller xfs_free_eofblocks+0x1fd/0x260 [xfs]
  [  285.691568] CPU: 0 PID: 3531 Comm: umount Not tainted 3.10.0-456.el7.x86_64 #1
  [  285.691570] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
  [  285.691572]  ffff88005a0222b8 000000004c7521c1 ffff88005aca3cb8 ffffffff8167e370
  [  285.691575]  ffff88005aca3cd0 ffffffffa018891b ffffffffa01830cd ffff88005aca3cf8
  [  285.691577]  ffffffffa01a4a2d 00000000fffffffb ffff880059dce200 ffff880035b68000
  [  285.691580] Call Trace:
  [  285.691587]  [<ffffffff8167e370>] dump_stack+0x19/0x1b
  [  285.691605]  [<ffffffffa018891b>] xfs_error_report+0x3b/0x40 [xfs]
  [  285.691621]  [<ffffffffa01830cd>] ? xfs_free_eofblocks+0x1fd/0x260 [xfs]
  [  285.691640]  [<ffffffffa01a4a2d>] xfs_trans_cancel+0xbd/0xe0 [xfs]
  [  285.691655]  [<ffffffffa01830cd>] xfs_free_eofblocks+0x1fd/0x260 [xfs]
  [  285.691672]  [<ffffffffa019a0b3>] xfs_inactive+0xf3/0x130 [xfs]
  [  285.691688]  [<ffffffffa019f796>] xfs_fs_evict_inode+0xa6/0xe0 [xfs]
  [  285.691693]  [<ffffffff81212e57>] evict+0xa7/0x170
  [  285.691696]  [<ffffffff81212f5e>] dispose_list+0x3e/0x50
  [  285.691699]  [<ffffffff81213bb4>] evict_inodes+0x114/0x140
  [  285.691702]  [<ffffffff811f9648>] generic_shutdown_super+0x48/0xf0
  [  285.691704]  [<ffffffff811f9ab7>] kill_block_super+0x27/0x70
  [  285.691707]  [<ffffffff811f9df9>] deactivate_locked_super+0x49/0x60
  [  285.691709]  [<ffffffff811fa3f6>] deactivate_super+0x46/0x60
  [  285.691712]  [<ffffffff812175d5>] mntput_no_expire+0xc5/0x120
  [  285.691714]  [<ffffffff81218710>] SyS_umount+0xa0/0x3b0
  [  285.691717]  [<ffffffff8168e949>] system_call_fastpath+0x16/0x1b
  [  285.691721] XFS (dm-4): xfs_do_force_shutdown(0x8) called from line 991 of file fs/xfs/xfs_trans.c.  Return address = 0xffffffffa01a4a46
  [  285.691725] XFS (dm-4): Corruption of in-memory data detected.  Shutting down filesystem
  [  285.693299] XFS (dm-4): Please umount the filesystem and rectify the problem(s)
  [  285.860046] XFS (dm-4): Unmounting Filesystem
  [  285.860059] XFS (dm-4): xfs_log_force: error -5 returned.
  [  285.860545] XFS (dm-4): xfs_log_force: error -5 returned.
  [  286.022557] XFS (dm-4): Mounting V5 Filesystem
  [  286.147575] XFS (dm-4): Starting recovery (logdev: internal)
  [  286.158899] XFS (dm-4): Ending recovery (logdev: internal)
  [  286.162794] XFS (dm-4): Unmounting Filesystem
  [  288.243764] XFS (dm-2): Unmounting Filesystem

The second change is important, "--nolockfs" option of 'dmsetup suspend'
makes unmount not hang even with fail_at_unmount setting to 0, so we can't
prove the behavior is correct in the fail_at_unmount=1 case either. If
with "--nolockfs", XFS will shutdown as below:

  [77987.165728] Buffer I/O error on dev dm-4, logical block 61521798, async page read
  [77987.167216] Buffer I/O error on dev dm-4, logical block 61521799, async page read
  [77987.174913] XFS (dm-4): Unmounting Filesystem
  [77987.174954] XFS (dm-4): metadata I/O error: block 0x1d56022 ("xlog_iodone") error 5 numblks 64
  [77987.175849] XFS (dm-4): xfs_do_force_shutdown(0x2) called from line 1203 of file fs/xfs/xfs_log.c.  Return address = 0xffffffffa01a7e70
  [77987.175855] XFS (dm-4): Log I/O Error Detected.  Shutting down filesystem
  [77987.176376] XFS (dm-4): Please umount the filesystem and rectify the problem(s)
  [77987.177267] XFS (dm-4): Unable to update superblock counters. Freespace may not be correct on next mount.
  [77987.177269] XFS (dm-4): xfs_log_force: error -5 returned.

That's not what we want either. So I did above two changes.

Thanks,
Zorro Lang

 common/rc         |  67 +++++++++++++++++++++++++++++++
 tests/xfs/006     | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/006.out |   7 ++++
 tests/xfs/group   |   1 +
 4 files changed, 191 insertions(+)
 create mode 100755 tests/xfs/006
 create mode 100644 tests/xfs/006.out

diff --git a/common/rc b/common/rc
index 883bd7b..f2d9a0b 100644
--- a/common/rc
+++ b/common/rc
@@ -3566,6 +3566,73 @@ run_fsx()
 	fi
 }
 
+# Test for the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
+#
+# Only one argument is needed:
+#  - attr: path name under /sys/fs/$FSTYP/DEV
+#
+# Usage example:
+#   _require_fs_sysfs error/fail_at_unmount
+_require_fs_sysfs()
+{
+	local attr=$1
+	local dname=$(_short_dev $TEST_DEV)
+
+	if [ -z "$attr" -o -z "$dname" ];then
+		_fail "Usage: _require_fs_sysfs <sysfs_attr_path>"
+	fi
+
+	if [ ! -e /sys/fs/${FSTYP}/${dname}/${attr} ];then
+		_notrun "/sys/fs/${FSTYP}/${dname}/${attr}: No such file or directory"
+	fi
+}
+
+# Write "content" into /sys/fs/$FSTYP/$DEV/$ATTR
+#
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#  - content: the content of $attr
+#
+# Usage example:
+#   _set_fs_sysfs_attr /dev/mapper/scratch-dev error/fail_at_unmount 0
+_set_fs_sysfs_attr()
+{
+	local dev=$1
+	shift
+	local attr=$1
+	shift
+	local content="$*"
+
+	if [ ! -b "$dev" -o -z "$attr" -o -z "$content" ];then
+		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
+	fi
+
+	local dname=$(_short_dev $dev)
+	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
+}
+
+# Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
+#
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#
+# Usage example:
+#   _get_fs_sysfs_attr /dev/mapper/scratch-dev error/fail_at_unmount
+_get_fs_sysfs_attr()
+{
+	local dev=$1
+	local attr=$2
+
+	if [ ! -b "$dev" -o -z "$attr" ];then
+		_fail "Usage: _get_fs_sysfs_attr <mounted_device> <attr>"
+	fi
+
+	local dname=$(_short_dev $dev)
+	cat /sys/fs/${FSTYP}/${dname}/${attr}
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/xfs/006 b/tests/xfs/006
new file mode 100755
index 0000000..8910026
--- /dev/null
+++ b/tests/xfs/006
@@ -0,0 +1,116 @@
+#! /bin/bash
+# FS QA Test 006
+#
+# Test xfs' "fail at unmount" error handling configuration. Stop
+# XFS from retrying to writeback forever at unmount.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+_require_fs_sysfs error/fail_at_unmount
+
+_scratch_mkfs > $seqres.full 2>&1
+_dmerror_init
+_dmerror_mount
+
+# Enable fail_at_unmount, so XFS stops retrying on errors at unmount
+# time. _fail the test if we fail to set it to 1, because the test
+# probably will hang in such case and block subsequent tests.
+_set_fs_sysfs_attr $DMERROR_DEV error/fail_at_unmount 1
+attr=`_get_fs_sysfs_attr $DMERROR_DEV error/fail_at_unmount`
+if [ "$attr" != "1" ]; then
+	_fail "Failed to set error/fail_at_unmount: $attr"
+fi
+
+# Make sure all will be configured to retry forever by default, except
+# for ENODEV, which is an unrecoverable error, so it will be configured
+# to not retry on error by default.
+for e in default EIO ENOSPC; do
+	_set_fs_sysfs_attr $DMERROR_DEV \
+			   error/metadata/${e}/max_retries -1
+	echo -n "error/metadata/${e}/max_retries="
+	_get_fs_sysfs_attr $DMERROR_DEV error/metadata/${e}/max_retries
+
+	_set_fs_sysfs_attr $DMERROR_DEV \
+			   error/metadata/${e}/retry_timeout_seconds 0
+	echo -n "error/metadata/${e}/retry_timeout_seconds="
+	_get_fs_sysfs_attr $DMERROR_DEV \
+			   error/metadata/${e}/retry_timeout_seconds
+done
+
+# start a metadata-intensive workload, but no data allocation operation.
+# Because uncompleted new space allocation I/Os may cause XFS to shutdown
+# after loading error table.
+$FSSTRESS_PROG -z -n 5000 -p 10 \
+	       -f creat=10 \
+	       -f resvsp=1 \
+	       -f truncate=1 \
+	       -f punch=1 \
+	       -f chown=5 \
+	       -f mkdir=5 \
+	       -f rmdir=1 \
+	       -f mknod=1 \
+	       -f unlink=1 \
+	       -f symlink=1 \
+	       -f rename=1 \
+	       -d $SCRATCH_MNT/fsstress >> $seqres.full 2>&1
+
+# Loading error table without "--nolockfs" option. Because "--nolockfs"
+# won't freeze fs, then some running I/Os may cause XFS to shutdown
+# prematurely. That's not what we want to test.
+_dmerror_load_error_table lockfs
+_dmerror_unmount
+
+# Mount again to replay log after loading working table, so we have a
+# consistent XFS after test.
+_dmerror_load_working_table
+_dmerror_mount
+_dmerror_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/006.out b/tests/xfs/006.out
new file mode 100644
index 0000000..393f411
--- /dev/null
+++ b/tests/xfs/006.out
@@ -0,0 +1,7 @@
+QA output created by 006
+error/metadata/default/max_retries=-1
+error/metadata/default/retry_timeout_seconds=0
+error/metadata/EIO/max_retries=-1
+error/metadata/EIO/retry_timeout_seconds=0
+error/metadata/ENOSPC/max_retries=-1
+error/metadata/ENOSPC/retry_timeout_seconds=0
diff --git a/tests/xfs/group b/tests/xfs/group
index 5a35a76..8e8ffd7 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -4,6 +4,7 @@
 004 db auto quick
 005 auto quick
 007 auto quota quick
+006 auto quick mount
 008 rw ioctl auto quick
 009 rw ioctl auto prealloc quick
 010 auto quick repair
-- 
2.5.5

