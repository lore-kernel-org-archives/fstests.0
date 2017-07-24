Received: from mx1.redhat.com ([209.132.183.28]:36262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753556AbdGXPH4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Jul 2017 11:07:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD772356F9
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2017 15:07:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-13.rdu2.redhat.com [10.10.125.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60A0387FA3
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2017 15:07:53 +0000 (UTC)
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: [PATCH v6] xfs/424: test xfs_db to ensure type size taken into account with new type
Date: Mon, 24 Jul 2017 10:07:49 -0500
Message-Id: <20170724150749.6909-1-billodo@redhat.com>
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
v5: Cleanup tabs/spaces and whitespace. Rename local function filter_dbval().
    Remove unneeded _scratch_unmount. Add "Silence is golden" output.
v6: use supported sector sizes from _min_dio_alignment

 tests/xfs/424     | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/424.out |   2 +
 tests/xfs/group   |   1 +
 3 files changed, 112 insertions(+)
 create mode 100755 tests/xfs/424
 create mode 100644 tests/xfs/424.out

diff --git a/tests/xfs/424 b/tests/xfs/424
new file mode 100755
index 00000000..0a1eef98
--- /dev/null
+++ b/tests/xfs/424
@@ -0,0 +1,109 @@
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
+filter_dbval()
+{
+	awk '{ print $4 }'
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
+echo "Silence is golden."
+
+# real QA test starts here
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
+sec_sz=`_min_dio_alignment $SCRATCH_DEV`
+while [ $sec_sz -le 4096 ]; do
+	sector_sizes="$sector_sizes $sec_sz"
+	sec_sz=$((sec_sz * 2))
+done
+
+for SECTOR_SIZE in $sector_sizes; do
+	$MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
+
+	for TYPE in agf agi agfl sb; do
+		DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | filter_dbval`
+		_scratch_xfs_db -c "daddr $DADDR" -c "type $TYPE"
+	done
+
+	DADDR=`_scratch_xfs_db -c "sb" -c "addr rootino" -c "daddr" |
+		filter_dbval`
+	_scratch_xfs_db -c "daddr $DADDR" -c "type inode"
+	DADDR=`_scratch_xfs_db -c "agf" -c "addr bnoroot" -c "daddr" |
+		filter_dbval`
+	_scratch_xfs_db -c "daddr $DADDR" -c "type bnobt"
+	DADDR=`_scratch_xfs_db -c "agf" -c "addr cntroot" -c "daddr" |
+		filter_dbval`
+	_scratch_xfs_db -c "daddr $DADDR" -c "type cntbt"
+	DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" |
+		filter_dbval`
+	_scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
+	DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
+		filter_dbval`
+	_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
+
+	_scratch_xfs_db -c "daddr $DADDR" -c "type text"
+	_scratch_xfs_db -c "daddr $DADDR" -c "type data"
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/424.out b/tests/xfs/424.out
new file mode 100644
index 00000000..ca196cd9
--- /dev/null
+++ b/tests/xfs/424.out
@@ -0,0 +1,2 @@
+QA output created by 424
+Silence is golden.
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

