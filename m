Received: from mailhub.sw.ru ([195.214.232.25]:42569 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014AbcGSMkh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 Jul 2016 08:40:37 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH] ext4/022: add regression test for ext4lazyinit_task deadlock
Date: Tue, 19 Jul 2016 16:23:25 +0400
Message-Id: <1468931005-774-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

global ext4lazyinit task may deadlock on frozen under li_list_mtx lock.
Once that happen all mount/umount tasks also blocked.
Patch pended.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 tests/ext4/022     | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/022.out |  2 ++
 tests/ext4/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/ext4/022
 create mode 100644 tests/ext4/022.out

diff --git a/tests/ext4/022 b/tests/ext4/022
new file mode 100755
index 0000000..1b9a33c
--- /dev/null
+++ b/tests/ext4/022
@@ -0,0 +1,83 @@
+#! /bin/bash
+# FS QA Test No. ext4/022
+#
+# Regression test for:
+# [TODO:ADD_COMMIT] ext4: improve ext4lazyinit scalability
+# Check ext4lazyinit deadlock
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Fujitsu.  All Rights Reserved.
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
+    umount $loop_mnt/1
+    _destroy_loop_device $loop_dev1
+    _destroy_loop_device $loop_dev2
+    if [ $status -eq 0 ]; then
+	rm -rf $img_dir $loop_mnt
+    fi
+    _scratch_unmount
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
+
+rm -f $seqres.full
+echo "Silence is golden"
+
+img_dir=$SCRATCH_MNT/$seq.fs
+loop_mnt=$SCRATCH_MNT/$seq.mnt
+_scratch_mkfs_xfs >> $seqres.full 2>&1
+_scratch_mount
+mkdir -p $img_dir
+mkdir -p $loop_mnt/{1,2}
+truncate -s 5G $img_dir/1.img
+truncate -s 5G $img_dir/2.img
+
+loop_dev1=$(_create_loop_device $img_dir/1.img)
+loop_dev2=$(_create_loop_device $img_dir/2.img)
+
+# Use nodiscard mode in order to force lazy init mode
+$MKFS_EXT4_PROG -F -E nodiscard,lazy_itable_init=1 $loop_dev1 \
+    >> $seqres.full 2>&1
+$MKFS_EXT4_PROG -F -E nodiscard,lazy_itable_init=1 $loop_dev2 \
+    >> $seqres.full 2>&1
+
+_mount $loop_dev1 $loop_mnt/1
+xfs_freeze -f $loop_mnt/1
+#If bug is not fixed any mount/umount will be blocked
+for i in $(seq 0 5)
+do
+    _mount $loop_dev2 $loop_mnt/2
+    sleep 1
+    umount $loop_mnt/2
+    sleep 1
+done
+xfs_freeze -u $loop_mnt/1
+status=0
+exit
diff --git a/tests/ext4/022.out b/tests/ext4/022.out
new file mode 100644
index 0000000..394c6a7
--- /dev/null
+++ b/tests/ext4/022.out
@@ -0,0 +1,2 @@
+QA output created by 022
+Silence is golden
diff --git a/tests/ext4/group b/tests/ext4/group
index bbdbe1d..f9d00b1 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -24,6 +24,7 @@
 019 fuzzers
 020 auto quick ioctl rw
 021 auto quick
+022 auto quick
 271 auto rw quick
 301 aio auto ioctl rw stress
 302 aio auto ioctl rw stress
-- 
1.8.3.1

