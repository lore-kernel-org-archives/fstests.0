Received: from mx1.redhat.com ([209.132.183.28]:59420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751642AbdARJ1d (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jan 2017 04:27:33 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com [10.5.11.28])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F3778EB3F
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2017 09:27:34 +0000 (UTC)
From: bxue@redhat.com
Subject: [PATCH v2 2/2] generic/405: test mkfs against thin provision device
Date: Wed, 18 Jan 2017 17:27:24 +0800
Message-Id: <1484731644-7453-2-git-send-email-bxue@redhat.com>
In-Reply-To: <1484731644-7453-1-git-send-email-bxue@redhat.com>
References: <1484731644-7453-1-git-send-email-bxue@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Boyang Xue <bxue@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Boyang Xue <bxue@redhat.com>

Test mkfs against thin provision device, which has very small backing size and
 very big virtual size. mkfs should return error when it hits EIO.

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
 tests/generic/405     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/405.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 76 insertions(+)
 create mode 100755 tests/generic/405
 create mode 100644 tests/generic/405.out

diff --git a/tests/generic/405 b/tests/generic/405
new file mode 100755
index 0000000..01eb5ff
--- /dev/null
+++ b/tests/generic/405
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test 405
+#
+# Test mkfs against thin provision device, which has very small backing size,
+# mkfs should return error when it hits EIO.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
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
+# Initialize dmthin device with very small backing size & very big virtual
+# size, with the hope that mkfs hit EIO at mkfs time
+BACKING_SIZE=$((1 * 1024 * 1024 / 512))			# 1M
+VIRTUAL_SIZE=$((1 * 1024 * 1024 * 1024 * 1024 / 512))	# 1T
+
+_cleanup()
+{
+	_dmthin_cleanup
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmthin
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+# $SCRATCH_DEV won't be directly created filesystem on, so fsck isn't required
+_require_scratch_nocheck
+_require_dm_target thin-pool
+
+_dmthin_init $BACKING_SIZE $VIRTUAL_SIZE
+
+# try mkfs on dmthin device, expect mkfs failure if 1M isn't big enough to hold
+# all the metadata. But if mkfs returns success, we expect the filesystem is
+# consistent, make sure it doesn't currupt silently.
+$MKFS_PROG -t $FSTYP $DMTHIN_VOL_DEV >>$seqres.full 2>&1
+if [ $? -eq 0 ]; then
+	_dmthin_check_fs
+fi
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/405.out b/tests/generic/405.out
new file mode 100644
index 0000000..bae761d
--- /dev/null
+++ b/tests/generic/405.out
@@ -0,0 +1,2 @@
+QA output created by 405
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 6fc9c3d..5621906 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -407,3 +407,4 @@
 402 auto quick rw
 403 auto quick attr
 404 auto quick insert
+405 auto mkfs
-- 
1.8.3.1

