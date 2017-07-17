Received: from mx1.redhat.com ([209.132.183.28]:40490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbdGQWJu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Jul 2017 18:09:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E0D97CE13
        for <fstests@vger.kernel.org>; Mon, 17 Jul 2017 22:09:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-87.rdu2.redhat.com [10.10.120.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0891A5DD6A
        for <fstests@vger.kernel.org>; Mon, 17 Jul 2017 22:09:49 +0000 (UTC)
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: [PATCH v4] xfs/424: test xfs_db to ensure type size taken into account with new type
Date: Mon, 17 Jul 2017 17:09:49 -0500
Message-Id: <20170717220949.4253-1-billodo@redhat.com>
In-Reply-To: <20170712183112.5255-1-billodo@redhat.com>
References: <20170712183112.5255-1-billodo@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfs_db should take type size into account when setting type.
If type size isn't updated whenever type is set, a false crc
error can occur due to the stale size. This test checks for
that false crc error.

Signed-off-by: Bill O'Donnell <billodo@redhat.com>
---
v2: Clarify commit message and test comments. Add a few more test cases.
v3: Add more test cases. Use _scratch_xfs_db instead of $XFS_DB_PROG to
    accomodate fses with external logs. Remove superfluous daddr and type
    commands.
v4: Skip select tests and make a corresponding note in the comments. Add
    test for type inode (note: depends on pending xfsprogs patch
    xfs_db: properly set inode type).

 tests/xfs/424     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/424.out |  1 +
 tests/xfs/group   |  1 +
 3 files changed, 99 insertions(+)
 create mode 100755 tests/xfs/424
 create mode 100644 tests/xfs/424.out

diff --git a/tests/xfs/424 b/tests/xfs/424
new file mode 100755
index 00000000..cfce18e1
--- /dev/null
+++ b/tests/xfs/424
@@ -0,0 +1,97 @@
+#! /bin/bash
+# FS QA Test 424
+#
+# xfs_db should take type size into account when setting type.
+# If type size isn't updated whenever type is set, a false crc
+# error can occur due to the stale size. This test checks for
+# that false crc error.
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
+_filter_dbval()
+{
+    awk '{ print $4 }'
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate
+_supported_os Linux
+_supported_fs xfs
+_require_scratch
+
+# real QA test starts here
+_scratch_unmount >> $seqres.full 2>&1
+
+# for different sector sizes, ensure no CRC errors are falsely reported.
+
+# Supported types include: agf, agfl, agi, attr3, bmapbta,
+# bmapbtd, bnobt, cntbt, data, dir3, dqblk, inobt, inodata,
+# inode, log, rtbitmap, rtsummary, sb, symlink, text, finobt.
+# For various sector sizes, test some types that involve type size.
+#
+# NOTE: skip attr3, bmapbta, bmapbtd, dir3, dqblk, inodata, symlink
+# rtbitmap, rtsummary, log
+#
+for SECTOR_SIZE in 512 1024 2048 4096; do
+    $MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
+
+    for TYPE in agf agi agfl sb; do
+	DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | _filter_dbval`
+	_scratch_xfs_db -c "daddr $DADDR" -c "type $TYPE"
+    done
+
+    DADDR=`_scratch_xfs_db -c "sb" -c "addr rootino" -c "daddr" | _filter_dbval`
+    _scratch_xfs_db -c "daddr $DADDR" -c "type inode"
+    DADDR=`_scratch_xfs_db -c "agf" -c "addr bnoroot" -c "daddr" | _filter_dbval`
+    _scratch_xfs_db -c "daddr $DADDR" -c "type bnobt"
+    DADDR=`_scratch_xfs_db -c "agf" -c "addr cntroot" -c "daddr" | _filter_dbval`
+    _scratch_xfs_db -c "daddr $DADDR" -c "type cntbt"
+    DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" | _filter_dbval`
+    _scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
+    DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" | _filter_dbval`
+    _scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
+
+    _scratch_xfs_db -c "daddr $DADDR" -c "type text"
+    _scratch_xfs_db -c "daddr $DADDR" -c "type data"
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/424.out b/tests/xfs/424.out
new file mode 100644
index 00000000..d879a949
--- /dev/null
+++ b/tests/xfs/424.out
@@ -0,0 +1 @@
+QA output created by 424
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
2.13.3

