Received: from mailhub.sw.ru ([195.214.232.25]:47541 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbcHOMWY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Aug 2016 08:22:24 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH] ext4/023: add regression test for ext4lazyinit_task deadlock V2
Date: Mon, 15 Aug 2016 16:22:07 +0400
Message-Id: <1471263727-25943-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

global ext4lazyinit task may deadlock on frozen under li_list_mtx lock.
Once that happen all mount/umount tasks also blocked.
Patch proposed: http://marc.info/?l=linux-ext4&m=146893382329138

changes since V1:
 - Fix coding style according to eguan's comments
 - Add deadlock timout, so test failure will not block other tests.


Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 tests/ext4/023     | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/023.out |  2 ++
 tests/ext4/group   |  1 +
 3 files changed, 98 insertions(+)
 create mode 100755 tests/ext4/023
 create mode 100644 tests/ext4/023.out

diff --git a/tests/ext4/023 b/tests/ext4/023
new file mode 100755
index 0000000..0f60490
--- /dev/null
+++ b/tests/ext4/023
@@ -0,0 +1,95 @@
+#! /bin/bash
+# FS QA Test No. ext4/023
+#
+# Regression test for deadlock in ext4lazyinit thread
+# Patch proposed: http://marc.info/?l=linux-ext4&m=146893382329138
+# TODO: Add commit ID
+#
+#
+#-----------------------------------------------------------------------
+# (c) Dmitry Monakhov
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#-----------------------------------------------------------------------
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+status=1
+_cleanup()
+{
+    # Failure cleanup
+    if [ $status -ne 0 ]; then
+	xfs_freeze -u $loop_mnt/1
+	$UMOUNT_PROG $loop_mnt/2
+    fi
+    
+    # Normal cleanup
+    $UMOUNT_PROG $loop_mnt/1
+    _destroy_loop_device $loop_dev1
+    _destroy_loop_device $loop_dev2
+    rm -rf $img_dir $loop_mnt
+    _scratch_unmount
+    cd /
+    #rm -f $tmp.*
+
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+_supported_os Linux
+_require_scratch
+_require_loop
+_require_freeze
+_require_xfs_io_command "falloc"
+
+rm -f $seqres.full
+echo "Silence is golden"
+
+img_dir=$SCRATCH_MNT/$seq.fs
+loop_mnt=$SCRATCH_MNT/$seq.mnt
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+mkdir -p $img_dir
+mkdir -p $loop_mnt/{1,2}
+
+$XFS_IO_PROG -fc "truncate 1G" $img_dir/1.img
+$XFS_IO_PROG -fc "truncate 1G" $img_dir/2.img
+loop_dev1=$(_create_loop_device $img_dir/1.img)
+loop_dev2=$(_create_loop_device $img_dir/2.img)
+
+# Use nodiscard mode in order to force lazy init mode
+$MKFS_EXT4_PROG -F -E nodiscard,lazy_itable_init=1 $loop_dev1 \
+    >> $seqres.full 2>&1
+$MKFS_EXT4_PROG -F -E nodiscard,lazy_itable_init=1 $loop_dev2 \
+    >> $seqres.full 2>&1
+
+# Freeze first fs and check that we may mount/umount second one.
+# If bug is not fixed mount/umount may deadlock
+_mount $loop_dev1 $loop_mnt/1
+xfs_freeze -f $loop_mnt/1
+for i in $(seq 0 5); do
+    timeout -s SIGKILL 10 $MOUNT_PROG $loop_dev2 $loop_mnt/2 || \
+	_fail "mount: deadlock detected. Fail"
+    sleep 1
+    timeout -s SIGKILL 10 $UMOUNT_PROG $loop_mnt/2 || \
+	_fail "umount: deadlock detected. Fail"
+    sleep 1
+done
+xfs_freeze -u $loop_mnt/1
+status=0
+exit
diff --git a/tests/ext4/023.out b/tests/ext4/023.out
new file mode 100644
index 0000000..5c4197b
--- /dev/null
+++ b/tests/ext4/023.out
@@ -0,0 +1,2 @@
+QA output created by 023
+Silence is golden
diff --git a/tests/ext4/group b/tests/ext4/group
index e0772ab..6ccc5e8 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -25,6 +25,7 @@
 020 auto quick ioctl rw
 021 auto quick
 022 auto quick attr dangerous
+023 auto quick
 271 auto rw quick
 301 aio auto ioctl rw stress
 302 aio auto ioctl rw stress
-- 
2.7.4

