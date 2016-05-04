Received: from mx1.redhat.com ([209.132.183.28]:47121 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757228AbcEDGzT (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 4 May 2016 02:55:19 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 728F8C05E174
	for <fstests@vger.kernel.org>; Wed,  4 May 2016 06:55:18 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH] overlay: test copy up by changing mode bits
Date: Wed,  4 May 2016 14:53:16 +0800
Message-Id: <1462344796-8172-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1461241438-24238-1-git-send-email-xzhou@redhat.com>
References: <1461241438-24238-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Changing file attr in overlayfs triggers copy up.
Test this by changing mode bits then check both mode
bits and copy up results.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

This patch depends on another patch i post on Apr 22:
  overlay: test basic whiteout
for the named number and tests/overlay/group .

 tests/overlay/004     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/004.out |  5 +++
 tests/overlay/group   |  1 +
 3 files changed, 103 insertions(+)
 create mode 100755 tests/overlay/004
 create mode 100644 tests/overlay/004.out

diff --git a/tests/overlay/004 b/tests/overlay/004
new file mode 100755
index 0000000..4075094
--- /dev/null
+++ b/tests/overlay/004
@@ -0,0 +1,97 @@
+#! /bin/bash
+# FS QA Test 004
+#
+# Test file copy up on overlayfs by changing mode bits.
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
+# Modify as appropriate.
+_supported_fs overlay
+_supported_os Linux
+_require_scratch
+_require_user
+
+# Remove all files from previous tests
+_scratch_mkfs
+
+# Create test file in lower dir
+lowerdir=${SCRATCH_DEV}/${OVERLAY_LOWER_DIR}
+upperdir=${SCRATCH_DEV}/${OVERLAY_UPPER_DIR}
+mkdir -p $lowerdir
+touch ${lowerdir}/attr_file1
+chmod 000 ${lowerdir}/attr_file1
+touch ${lowerdir}/attr_file2
+chmod 000 ${lowerdir}/attr_file2
+
+_scratch_mount
+
+# copy up by change mode bits and check.
+chmod a+x ${SCRATCH_MNT}/attr_file1 > /dev/null 2>&1
+chmod o-w ${SCRATCH_MNT}/attr_file1 > /dev/null 2>&1
+chmod g+w ${SCRATCH_MNT}/attr_file1 > /dev/null 2>&1
+chmod u-r ${SCRATCH_MNT}/attr_file1 > /dev/null 2>&1
+chmod a+X ${SCRATCH_MNT}/attr_file1 > /dev/null 2>&1
+chmod o-s ${SCRATCH_MNT}/attr_file1 > /dev/null 2>&1
+chmod g+t ${SCRATCH_MNT}/attr_file1 > /dev/null 2>&1
+chmod u-X ${SCRATCH_MNT}/attr_file1 > /dev/null 2>&1
+stat -c %a ${SCRATCH_MNT}/attr_file1
+
+# unprivileged user can't do this.
+_user_do "chmod a+x ${SCRATCH_MNT}/attr_file2 > /dev/null 2>&1"
+_user_do "chmod o-w ${SCRATCH_MNT}/attr_file2 > /dev/null 2>&1"
+_user_do "chmod g+w ${SCRATCH_MNT}/attr_file2 > /dev/null 2>&1"
+_user_do "chmod u-r ${SCRATCH_MNT}/attr_file2 > /dev/null 2>&1"
+_user_do "chmod a+X ${SCRATCH_MNT}/attr_file2 > /dev/null 2>&1"
+_user_do "chmod o-s ${SCRATCH_MNT}/attr_file2 > /dev/null 2>&1"
+_user_do "chmod g+t ${SCRATCH_MNT}/attr_file2 > /dev/null 2>&1"
+_user_do "chmod u-X ${SCRATCH_MNT}/attr_file2 > /dev/null 2>&1"
+stat -c %a ${SCRATCH_MNT}/attr_file2
+
+_scratch_unmount
+
+# check mode bits of the file that has been copied up, and
+# the file that should not have been copied up.
+stat -c %a ${upperdir}/attr_file1
+ls ${upperdir}/
+
+# success, all done
+status=0
+exit
diff --git a/tests/overlay/004.out b/tests/overlay/004.out
new file mode 100644
index 0000000..2429f38
--- /dev/null
+++ b/tests/overlay/004.out
@@ -0,0 +1,5 @@
+QA output created by 004
+31
+0
+31
+attr_file1
diff --git a/tests/overlay/group b/tests/overlay/group
index 9735f40..fcf6d63 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -6,3 +6,4 @@
 001 auto quick copyup
 002 auto quick metadata
 003 auto quick whiteout
+004 attr auto copyup quick
-- 
2.5.5

