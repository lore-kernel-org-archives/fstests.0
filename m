Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806AbbFBEqb (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 2 Jun 2015 00:46:31 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 5E2FF2BB392
	for <fstests@vger.kernel.org>; Tue,  2 Jun 2015 04:46:31 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs: test rw remount on norecovery ro mount
Date: Tue,  2 Jun 2015 12:45:46 +0800
Message-Id: <1433220346-27511-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Commit bbe051c841d5 ("xfs: disallow ro->rw remount on norecovery mount")
disabled rw remount on norecovery ro mount, this test makes sure the
behavior is correct.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/074     | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/074.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 64 insertions(+)
 create mode 100755 tests/xfs/074
 create mode 100644 tests/xfs/074.out

diff --git a/tests/xfs/074 b/tests/xfs/074
new file mode 100755
index 0000000..9f8ae4e
--- /dev/null
+++ b/tests/xfs/074
@@ -0,0 +1,61 @@
+#! /bin/bash
+# FS QA Test 074
+#
+# Commit bbe051c8 disallows ro->rw remount on norecovery mount
+# This test makes sure the behavior is correct.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
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
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+
+echo "Silence is golden"
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >$seqres.full
+
+# first ro mount with norecovery
+_scratch_mount "-o ro,norecovery" >>$seqres.full 2>&1 \
+	|| _fail "First ro mount failed"
+# make sure a following remount,rw fails
+_scratch_mount "-o remount,rw" >>$seqres.full 2>&1 \
+	&& _fail "Second rw remount succeeded"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/074.out b/tests/xfs/074.out
new file mode 100644
index 0000000..380f065
--- /dev/null
+++ b/tests/xfs/074.out
@@ -0,0 +1,2 @@
+QA output created by 074
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index 848a1bd..2488cea 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -71,6 +71,7 @@
 071 rw auto
 072 rw auto prealloc quick
 073 copy auto
+074 auto quick mount
 078 growfs auto quick
 080 rw ioctl
 081 deprecated # log logprint quota
-- 
2.4.1

