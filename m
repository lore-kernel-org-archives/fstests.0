Received: from mx1.redhat.com ([209.132.183.28]:41244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752757AbdGLSbN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Jul 2017 14:31:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BF2C4DD49
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2017 18:31:13 +0000 (UTC)
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: [PATCH] xfs/424: test xfs_db to ensure sector size taken into account with new type
Date: Wed, 12 Jul 2017 13:31:12 -0500
Message-Id: <20170712183112.5255-1-billodo@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

xfs_db should take sector size into account when setting type.
If sector size ignored, a false crc error can occur due to
the new size not being picked up when type gets set. This test
checks for that false crc error.

Signed-off-by: Bill O'Donnell <billodo@redhat.com>
---
 tests/xfs/424     | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/424.out |  5 ++++
 tests/xfs/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100755 tests/xfs/424
 create mode 100644 tests/xfs/424.out

diff --git a/tests/xfs/424 b/tests/xfs/424
new file mode 100755
index 00000000..12945678
--- /dev/null
+++ b/tests/xfs/424
@@ -0,0 +1,72 @@
+#! /bin/bash
+# FS QA Test 424
+#
+# xfs_db should take sector size into account when setting type.
+# If sector size ignored, a false crc error can occur due to
+# the new size not being picked up when type is set. This test
+# checks for that false crc error.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
+_scratch_unmount >> $seqres.full 2>&1
+
+# for different sector sizes, ensure no CRC errors are falsely reported
+$MKFS_PROG -t xfs -f -s size=512 $SCRATCH_DEV > /dev/null
+$XFS_DB_PROG -c "agi 0" -c "daddr" -c "daddr 42" -c "daddr 2" -c "type agi" $SCRATCH_DEV
+
+$MKFS_PROG -t xfs -f -s size=1024 $SCRATCH_DEV > /dev/null
+$XFS_DB_PROG -c "agi 0" -c "daddr" -c "daddr 42" -c "daddr 4" -c "type agi" $SCRATCH_DEV
+
+$MKFS_PROG -t xfs -f -s size=2048 $SCRATCH_DEV > /dev/null
+$XFS_DB_PROG -c "agi 0" -c "daddr" -c "daddr 42" -c "daddr 8" -c "type agi" $SCRATCH_DEV
+
+$MKFS_PROG -t xfs -f -s size=4096 $SCRATCH_DEV > /dev/null
+$XFS_DB_PROG -c "agi 0" -c "daddr" -c "daddr 42" -c "daddr 16" -c "type agi" $SCRATCH_DEV
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/424.out b/tests/xfs/424.out
new file mode 100644
index 00000000..ff12d9d0
--- /dev/null
+++ b/tests/xfs/424.out
@@ -0,0 +1,5 @@
+QA output created by 424
+current daddr is 2
+current daddr is 4
+current daddr is 8
+current daddr is 16
diff --git a/tests/xfs/group b/tests/xfs/group
index ffdb0615..75c8280c 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -421,3 +421,4 @@
 421 auto quick clone dedupe
 422 dangerous_scrub dangerous_online_repair
 423 dangerous_scrub
+424 auto quick db
-- 
2.13.0

