Received: from szxga07-in.huawei.com ([45.249.212.35]:58356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbfAVDUe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 22:20:34 -0500
From: zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 2/6] squashfs: add mount test
Date: Tue, 22 Jan 2019 11:24:04 +0800
Message-ID: <20190122032408.91336-3-zhengbin13@huawei.com>
In-Reply-To: <20190122032408.91336-1-zhengbin13@huawei.com>
References: <20190122032408.91336-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, guaneryu@gmail.com, fstests@vger.kernel.org
Cc: houtao1@huawei.com, zhaohongjiang@huawei.com, zhengbin13@huawei.com
List-ID: <fstests@vger.kernel.org>

This patch add mount test which is modified from generic/067.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 tests/readonly/001      | 97 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/readonly/001.out  |  2 +
 tests/readonly/Makefile | 20 ++++++++++
 tests/readonly/group    |  6 +++
 4 files changed, 125 insertions(+)
 create mode 100755 tests/readonly/001
 create mode 100644 tests/readonly/001.out
 create mode 100644 tests/readonly/Makefile
 create mode 100644 tests/readonly/group

diff --git a/tests/readonly/001 b/tests/readonly/001
new file mode 100755
index 00000000..164722d2
--- /dev/null
+++ b/tests/readonly/001
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 001. Modifed from generic/067.
+#
+# Some random mount/umount corner case tests
+#
+# - mount at a nonexistent mount point
+# - mount a free loop device
+# - mount with a wrong fs type specified
+# - umount an symlink to device which is not mounted
+# - umount a path with too long name
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_loop
+
+rm -f $seqres.full
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+
+# kernel should not hang nor oops when mounting fs to nonexistent mount point
+mount_nonexistent_mnt()
+{
+	echo "# mount to nonexistent mount point" >>$seqres.full
+	rm -rf $SCRATCH_DEV/nosuchdir
+	$MOUNT_PROG -t $FSTYP $SCRATCH_COMPRESS_FILE $SCRATCH_DEV/nosuchdir >>$seqres.full 2>&1
+}
+
+# fs driver should be able to handle mounting a free loop device gracefully
+# xfs ever hung, "ec53d1d xfs: don't block on buffer read errors" fixed it
+mount_free_loopdev()
+{
+	echo "# mount a free loop device" >>$seqres.full
+	loopdev=`losetup -f`
+	$MOUNT_PROG -t $FSTYP $loopdev $SCRATCH_MNT >>$seqres.full 2>&1
+}
+
+# mount with wrong fs type specified.
+# This should fail gracefully, no hang no oops are expected
+mount_wrong_fstype()
+{
+	local fs=ext4
+	echo "# mount with wrong fs type" >>$seqres.full
+	$MOUNT_PROG -t $fs $SCRATCH_COMPRESS_FILE $SCRATCH_MNT >>$seqres.full 2>&1
+}
+
+# umount a symlink to device, which is not mounted.
+# This should fail gracefully, no hang no oops are expected
+umount_symlink_device()
+{
+	local symlink=$SCRATCH_DEV/$seq.scratch_dev_symlink
+	rm -f $symlink
+	echo "# umount symlink to device, which is not mounted" >>$seqres.full
+	ln -s $SCRATCH_COMPRESS_FILE $symlink
+	$UMOUNT_PROG $symlink >>$seqres.full 2>&1
+	rm -f $symlink
+}
+
+# umount a path name that is 256 bytes long, this should fail gracefully,
+# and the following umount should not hang nor oops
+umount_toolong_name()
+{
+	local longname=$SCRATCH_MNT/`$PERL_PROG -e 'print "a"x256;'`
+
+	_scratch_mount 2>&1 | tee -a $seqres.full
+
+	echo "# umount a too-long name" >>$seqres.full
+	$UMOUNT_PROG $longname >>$seqres.full 2>&1
+	_scratch_unmount 2>&1 | tee -a $seqres.full
+}
+
+mount_nonexistent_mnt
+mount_free_loopdev
+mount_wrong_fstype
+
+umount_symlink_device
+umount_toolong_name
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/readonly/001.out b/tests/readonly/001.out
new file mode 100644
index 00000000..88678b8e
--- /dev/null
+++ b/tests/readonly/001.out
@@ -0,0 +1,2 @@
+QA output created by 001
+Silence is golden
diff --git a/tests/readonly/Makefile b/tests/readonly/Makefile
new file mode 100644
index 00000000..b9a2b641
--- /dev/null
+++ b/tests/readonly/Makefile
@@ -0,0 +1,20 @@
+#
+# Copyright (c) 2019 Huawei.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+READONLY_DIR = readonly
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(READONLY_DIR)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
diff --git a/tests/readonly/group b/tests/readonly/group
new file mode 100644
index 00000000..dc21c93d
--- /dev/null
+++ b/tests/readonly/group
@@ -0,0 +1,6 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
+001 auto
--
2.16.2.dirty
