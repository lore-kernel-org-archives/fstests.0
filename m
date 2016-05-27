Received: from mx1.redhat.com ([209.132.183.28]:39272 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906AbcE0GN0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 May 2016 02:13:26 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F1ECC097259
	for <fstests@vger.kernel.org>; Fri, 27 May 2016 06:13:25 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v3] overlay: test memleak in copy-up error handling path
Date: Fri, 27 May 2016 14:13:00 +0800
Message-Id: <1464329580-23709-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

This memleak leads to panic when unmount the underlying fs.
Kernel commit ab79efab0 fixed this issue.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

Diff to v1:
	set up underlying fs in $SCRATCH_DEV instead of $SCRATCH_MNT
	xfs_io open test_file instead of src/writemod
	use little upper dir to trigger ENOSP failure instead of kill
	clean up in cleanup
Diff to v2:
	call _scratch_mkfs before test
	make lower stuff naming more clear
	remove dangerous group

 tests/overlay/005     | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/005.out |   2 +
 tests/overlay/group   |   1 +
 3 files changed, 118 insertions(+)
 create mode 100755 tests/overlay/005
 create mode 100644 tests/overlay/005.out

diff --git a/tests/overlay/005 b/tests/overlay/005
new file mode 100755
index 0000000..495e7b5
--- /dev/null
+++ b/tests/overlay/005
@@ -0,0 +1,115 @@
+#! /bin/bash
+# FS QA Test 005
+#
+# Memleak in overlayfs copy-up error handling path leads to panic
+# when unmount the underlying fs.
+# Kernel commit ab79efab0 fixed this issue.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat Inc. All Rights Reserved.
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
+	_destroy_loop_device $fs_loop_dev
+	_destroy_loop_device $upper_loop_dev
+	rm -f $lower_img
+	rm -f $upper_img
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
+_supported_fs overlay
+_supported_os Linux
+_require_scratch
+_require_loop
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+# setup loop images fs for overlayfs
+lower_img=${SCRATCH_DEV}/${seq}.$$.img
+$XFS_IO_PROG -f -c "truncate 120m" $lower_img >>$seqres.full 2>&1
+fs_loop_dev=`_create_loop_device $lower_img`
+$MKFS_XFS_PROG -f -n ftype=1 $fs_loop_dev >>$seqres.full 2>&1
+
+# only 20m for upper dir
+upper_img=${SCRATCH_DEV}/$$.${seq}.img
+$XFS_IO_PROG -f -c "truncate 20m" $upper_img >>$seqres.full 2>&1
+upper_loop_dev=`_create_loop_device $upper_img`
+$MKFS_XFS_PROG -f -n ftype=1 $upper_loop_dev >>$seqres.full 2>&1
+
+# mount underlying xfs
+mkdir -p ${SCRATCH_DEV}/lowermnt
+mkdir -p ${SCRATCH_DEV}/uppermnt
+$MOUNT_PROG $fs_loop_dev ${SCRATCH_DEV}/lowermnt
+$MOUNT_PROG $upper_loop_dev ${SCRATCH_DEV}/uppermnt
+
+# prepare dirs
+mkdir -p ${SCRATCH_DEV}/lowermnt/lower
+mkdir -p ${SCRATCH_DEV}/uppermnt/upper
+mkdir -p ${SCRATCH_DEV}/uppermnt/work
+
+lowerd=${SCRATCH_DEV}/lowermnt/lower
+upperd=${SCRATCH_DEV}/uppermnt/upper
+workd=${SCRATCH_DEV}/uppermnt/work
+
+# Create test file in lower dir, with too big a size for
+# upper dir to copy up.
+$XFS_IO_PROG -f -c "truncate 48m" ${lowerd}/test_file \
+	>>$seqres.full 2>&1
+
+# mount new overlayfs
+$MOUNT_PROG -t overlay $SELINUX_MOUNT_OPTIONS \
+	    -o lowerdir=$lowerd -o upperdir=$upperd \
+	    -o workdir=$workd \
+	    $SCRATCH_DEV $SCRATCH_MNT
+
+# the open call triggers copy-up and it will fail ENOSPC
+$XFS_IO_PROG -f -c "o" ${SCRATCH_MNT}/test_file \
+	>>$seqres.full 2>&1
+
+# unmount overlayfs
+$UMOUNT_PROG $SCRATCH_MNT
+
+# unmount undelying xfs, this tiggers panic if memleak happens
+$UMOUNT_PROG ${SCRATCH_DEV}/uppermnt
+$UMOUNT_PROG ${SCRATCH_DEV}/lowermnt
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/overlay/005.out b/tests/overlay/005.out
new file mode 100644
index 0000000..a5027f1
--- /dev/null
+++ b/tests/overlay/005.out
@@ -0,0 +1,2 @@
+QA output created by 005
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index fcf6d63..d8fc597 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -7,3 +7,4 @@
 002 auto quick metadata
 003 auto quick whiteout
 004 attr auto copyup quick
+005 auto copyup quick
-- 
2.5.5

