Received: from mx1.redhat.com ([209.132.183.28]:54471 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbcEIESu (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 9 May 2016 00:18:50 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65B6B486D6
	for <fstests@vger.kernel.org>; Mon,  9 May 2016 04:18:49 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH] overlay: test memleak in copy up error handling path
Date: Mon,  9 May 2016 12:12:37 +0800
Message-Id: <1462767157-26966-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1461241438-24238-1-git-send-email-xzhou@redhat.com>
References: <1461241438-24238-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

This memleak may trigger panic when unmount the underlying fs.
Kernel commit ab79efab0 fixed this issue.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

This patch depends on another patch i post on Apr 22:
  overlay: test basic whiteout
for the named number and tests/overlay/group .

 tests/overlay/005     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/005.out |   2 +
 tests/overlay/group   |   1 +
 3 files changed, 114 insertions(+)
 create mode 100755 tests/overlay/005
 create mode 100644 tests/overlay/005.out

diff --git a/tests/overlay/005 b/tests/overlay/005
new file mode 100755
index 0000000..a61ef45
--- /dev/null
+++ b/tests/overlay/005
@@ -0,0 +1,111 @@
+#! /bin/bash
+# FS QA Test 005
+#
+# Memleak in overlayfs copy up error handling path may trigger panic
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
+# backup old scrach dev and mnt
+OLD_SCRATCH_DEV=$SCRATCH_DEV
+OLD_SCRATCH_MNT=$SCRATCH_MNT
+
+# setup loop image fs for overlayfs
+fs_img=${SCRATCH_MNT}/${seq}.$$.img
+$XFS_IO_PROG -f -c "truncate 5120m" $fs_img >>$seqres.full 2>&1
+loop_dev=`_create_loop_device $fs_img`
+mkfs.xfs -f -n ftype=1 $loop_dev >>$seqres.full 2>&1
+
+# mount underlying xfs
+mkdir -p ${SCRATCH_MNT}/xfsmnt
+_mount $loop_dev ${SCRATCH_MNT}/xfsmnt
+
+# prepare dirs and set new SCRATCH_MNT/_DEV
+mkdir -p ${SCRATCH_MNT}/xfsmnt/schmnt
+mkdir -p ${SCRATCH_MNT}/xfsmnt/schdev
+export SCRATCH_MNT=${SCRATCH_MNT}/xfsmnt/schmnt
+export SCRATCH_DEV=${SCRATCH_MNT}/xfsmnt/schdev
+
+# make newly overlayfs
+_scratch_mkfs
+
+# Create test file in lower dir
+lowerdir=${SCRATCH_DEV}/${OVERLAY_LOWER_DIR}
+mkdir -p $lowerdir
+$XFS_IO_PROG -f -c "truncate 2048m"  ${lowerdir}/test_file >>$seqres.full 2>&1
+
+# mount new overlayfs
+_scratch_mount
+
+# the open call triggers copy up and it will take some time
+src/writemod $SCRATCH_MNT/test_file >>$seqres.full 2>&1 &
+pid=$!
+
+# 3 seconds till cancel it
+sleep 3
+kill -2 $pid 2>/dev/null
+wait $pid 2>/dev/null
+pid=""
+
+# unmount overlayfs
+_scratch_unmount
+
+# restore old values and cleanup
+export SCRATCH_MNT=$OLD_SCRATCH_MNT
+export SCRATCH_DEV=$OLD_SCRATCH_DEV
+
+# unmount undelying xfs, this tiggers a panic if mem leak happens
+umount -d ${SCRATCH_MNT}/xfsmnt
+rm -f $fs_img
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
index fcf6d63..bc2474e 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -7,3 +7,4 @@
 002 auto quick metadata
 003 auto quick whiteout
 004 attr auto copyup quick
+005 auto copyup dangerous quick
-- 
2.5.5

