Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45213 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbcDVIMd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 22 Apr 2016 04:12:33 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CBFEC074100
	for <fstests@vger.kernel.org>; Fri, 22 Apr 2016 08:12:32 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 1/2] overlay: test basic whiteout
Date: Fri, 22 Apr 2016 16:11:54 +0800
Message-Id: <1461312715-14197-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <20160421125732.GF4675@eguan.usersys.redhat.com>
References: <20160421125732.GF4675@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Once a while, overlayfs whiteout can be visible if upper fs
does not support d_type(ftype/filetype). Test as a sanity
check on whiteout of regular files, links, dirs, devices
and pipes.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/003     | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/003.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100755 tests/overlay/003
 create mode 100644 tests/overlay/003.out

diff --git a/tests/overlay/003 b/tests/overlay/003
new file mode 100755
index 0000000..fbc242a
--- /dev/null
+++ b/tests/overlay/003
@@ -0,0 +1,98 @@
+#! /bin/bash
+# FS QA Test 003
+#
+# Test overlayfs basic whiteout.
+#
+# Overlayfs whiteout can be visible if underlying upper fs does not
+# support d_type. Kernel commit
+#	45aebea (ovl: Ensure upper filesystem supports d_type)
+# prevents mounting overlayfs like this since v4.6-rc1.
+# No harm to keep this test as a sanity check.
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
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+# Create test files dirs in lower dir
+lowerdir=${SCRATCH_DEV}/${OVERLAY_LOWER_DIR}
+mkdir -p $lowerdir
+
+touch ${lowerdir}/test_file
+ln -s ${lowerdir}/test_file ${lowerdir}/test_softlink_file
+ln ${lowerdir}/test_file ${lowerdir}/test_hardlink_file
+
+mkdir -p ${lowerdir}/test_dir
+ln -s ${lowerdir}/test_dir ${lowerdir}/test_softlink_dir
+
+mknod ${lowerdir}/test_cdev c 2 3
+ln -s ${lowerdir}/test_cdev ${lowerdir}/test_softlink_cdev
+ln ${lowerdir}/test_cdev ${lowerdir}/test_hardlink_cdev
+
+mknod ${lowerdir}/test_bdev b 2 4
+ln -s ${lowerdir}/test_bdev ${lowerdir}/test_softlink_bdev
+ln ${lowerdir}/test_bdev ${lowerdir}/test_hardlink_bdev
+
+mknod ${lowerdir}/test_pipe p
+ln -s ${lowerdir}/test_pipe ${lowerdir}/test_softlink_pipe
+ln ${lowerdir}/test_pipe ${lowerdir}/test_hardlink_pipe
+
+_scratch_mount
+
+# whiteout all files in overlay mountpoint
+rm -rf ${SCRATCH_MNT}/*
+# nothing should be listed
+ls ${SCRATCH_MNT}/
+
+_scratch_unmount
+
+rm -rf $lowerdir
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/003.out b/tests/overlay/003.out
new file mode 100644
index 0000000..6895fc8
--- /dev/null
+++ b/tests/overlay/003.out
@@ -0,0 +1,2 @@
+QA output created by 003
+Silence is golden
diff --git a/tests/overlay/group b/tests/overlay/group
index 84d164e..9735f40 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -5,3 +5,4 @@
 #
 001 auto quick copyup
 002 auto quick metadata
+003 auto quick whiteout
-- 
2.5.5

