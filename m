Received: from mx1.redhat.com ([209.132.183.28]:49282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbdARFti (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Jan 2017 00:49:38 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC43831B322
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2017 05:48:49 +0000 (UTC)
From: bxue@redhat.com
Subject: [PATCH v1 2/2] generic/405: test mkfs against full thin provision device
Date: Wed, 18 Jan 2017 13:48:30 +0800
Message-Id: <1484718510-7433-2-git-send-email-bxue@redhat.com>
In-Reply-To: <1484718510-7433-1-git-send-email-bxue@redhat.com>
References: <1484718510-7433-1-git-send-email-bxue@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Boyang Xue <bxue@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Boyang Xue <bxue@redhat.com>

Create filesystem on a thin provision device. When the thin pool gets full,
it's expected mkfs return with error. It's reported mkfs returns 0 while
creating ext4 filesystems, with buffer I/O error in kernel message due to a bug.

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
 tests/generic/405     | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/405.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 74 insertions(+)
 create mode 100755 tests/generic/405
 create mode 100644 tests/generic/405.out

diff --git a/tests/generic/405 b/tests/generic/405
new file mode 100755
index 0000000..e64b429
--- /dev/null
+++ b/tests/generic/405
@@ -0,0 +1,71 @@
+#! /bin/bash
+# FS QA Test 405
+#
+# Test mkfs against full thin provision device
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
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+# $SCRATCH_DEV won't be directly created filesystem on, so fsck isn't required
+_require_scratch_nocheck
+_require_dm_target thin-pool
+
+_dmthin_init $BACKING_SIZE $VIRTUAL_SIZE
+# mkfs failure is expected
+$MKFS_PROG -t $FSTYP $DMTHIN_VOL_DEV >>$seqres.full 2>&1
+
+if [ $? -eq 0 ]; then
+	echo "'mkfs' returns 0, while non-zero value is expected. Test failed."
+	exit
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

