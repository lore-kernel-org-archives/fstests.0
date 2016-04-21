Received: from mx1.redhat.com ([209.132.183.28]:47014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbcDUMYk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Apr 2016 08:24:40 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59DEF811A7
	for <fstests@vger.kernel.org>; Thu, 21 Apr 2016 12:24:39 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH] overlay: test basic whiteout
Date: Thu, 21 Apr 2016 20:23:58 +0800
Message-Id: <1461241438-24238-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Overlayfs whiteout can be visible if underlying xfs was created
with ftype=0. Kernel commit
	45aebea (ovl: Ensure upper filesystem supports d_type)
prevents mounting overlayfs like this since v4.6-rc1. No harm to
keep this test as a sanity check.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/overlay/003     | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/003.out |  2 ++
 tests/overlay/group   |  1 +
 3 files changed, 81 insertions(+)
 create mode 100755 tests/overlay/003
 create mode 100644 tests/overlay/003.out

diff --git a/tests/overlay/003 b/tests/overlay/003
new file mode 100755
index 0000000..2401075
--- /dev/null
+++ b/tests/overlay/003
@@ -0,0 +1,78 @@
+#! /bin/bash
+# FS QA Test 003
+#
+# Test overlayfs whiteout.
+#
+# Overlayfs whiteout can be visible if underlying xfs was created
+# with ftype=0. Kernel commit
+#	45aebea (ovl: Ensure upper filesystem supports d_type)
+# prevents mounting overlayfs like this since v4.6-rc1. No harm to
+# keep this test as a sanity check.
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
+# Create test file in lower dir
+lowerdir=${SCRATCH_DEV}/${OVERLAY_LOWER_DIR}
+mkdir -p $lowerdir
+touch ${lowerdir}/test_file
+
+_scratch_mount
+
+# whiteout file in overlay mount
+rm -f ${SCRATCH_MNT}/test_file
+# it should not be listed
+ls -l ${SCRATCH_MNT}/test_file 2>&1 | awk -F: '{print $NF}'
+
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/003.out b/tests/overlay/003.out
new file mode 100644
index 0000000..83bafee
--- /dev/null
+++ b/tests/overlay/003.out
@@ -0,0 +1,2 @@
+QA output created by 003
+ No such file or directory
diff --git a/tests/overlay/group b/tests/overlay/group
index 84d164e..f671c67 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -5,3 +5,4 @@
 #
 001 auto quick copyup
 002 auto quick metadata
+003 auto quick
-- 
2.5.5

