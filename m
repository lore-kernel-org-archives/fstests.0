Received: from mx1.redhat.com ([209.132.183.28]:52094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753057AbdHOMzq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Aug 2017 08:55:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D467C2D1EDF
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2017 12:55:45 +0000 (UTC)
Received: from hades.localdomain.com (unknown [10.43.17.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48EAC505DE
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2017 12:55:45 +0000 (UTC)
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH] xfs: Test infinite loop while searching for a free inode slot
Date: Tue, 15 Aug 2017 14:55:41 +0200
Message-Id: <20170815125541.12243-1-cmaiolino@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Tests the search algorithm for a free inode slot in a specific AG, done
in xfs_dialloc_ag_inobt().

When finobt is not used, and agi->freecount is not 0, XFS will scan the AG inode
tree looking for a free inode slot, but if agi->freecount is corrupted,
and there is no free slot at all, it will end up in an infinite loop.

This test checks for the infinite loop fix.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 tests/xfs/057     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/057.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 83 insertions(+)
 create mode 100755 tests/xfs/057
 create mode 100644 tests/xfs/057.out

diff --git a/tests/xfs/057 b/tests/xfs/057
new file mode 100755
index 00000000..446ea1eb
--- /dev/null
+++ b/tests/xfs/057
@@ -0,0 +1,80 @@
+#! /bin/bash
+# FS QA Test 057
+#
+# Check if the filesystem will lockup when trying to allocate a new inode in
+# an AG with no free inodes but with a corrupted agi->freecount showing free inodes. 
+#
+# At the end of the test, the scratch device will purposely be in a corrupted
+# state, so there is no need for checking that.
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
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+#_require_scratch
+_require_scratch_nocheck
+
+_scratch_mkfs_xfs -mfinobt=0 >/dev/null 2>&1 \
+	|| _notrun "Failed to initialize filesystem."
+_scratch_mount >/dev/null 2>&1
+
+# At the end of filesystem's initialization, AG 0 will still have 61 free
+# inodes in the agi->freecount, create 61 extra dummy files to fill it up
+for i in `seq 1 61`; do
+	touch $SCRATCH_MNT/dummy_file$1
+done
+
+_scratch_unmount
+
+# agi->freecount is 0 here, corrupt it to show extra free inodes
+$XFS_DB_PROG -x -c "agi 0" -c "write -d freecount 10" $SCRATCH_DEV >/dev/null 2>&1
+
+_scratch_mount >/dev/null 2>&1
+
+# Lock up a buggy kernel
+touch $SCRATCH_MNT/lockupfile
+
+# If we reach this point, the filesystem is fixed
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/xfs/057.out b/tests/xfs/057.out
new file mode 100644
index 00000000..185023c7
--- /dev/null
+++ b/tests/xfs/057.out
@@ -0,0 +1,2 @@
+QA output created by 057
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index cf876a29..3ca8e75a 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -54,6 +54,7 @@
 054 auto quick
 055 dump ioctl remote tape
 056 dump ioctl auto quick
+057 dangerous
 059 dump ioctl auto quick
 060 dump ioctl auto quick
 061 dump ioctl auto quick
-- 
2.13.5

