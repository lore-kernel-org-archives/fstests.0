Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40197 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbbDCHQr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 3 Apr 2015 03:16:47 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 53185B0424
	for <fstests@vger.kernel.org>; Fri,  3 Apr 2015 07:16:47 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2 1/4] generic: test quota handling on remount ro failure
Date: Fri,  3 Apr 2015 15:15:51 +0800
Message-Id: <1428045351-10446-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Remount ro should not turn qouta off unconditionally, even remount ro
failed, also kernel should not oops on the next succeeded remount ro.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- rebase and re-numbered to generic/082
- add comments to quotacheck and quotaon
- add comments to the first remount,ro with unknown option
- fail the test if the second remount,ro failed

 tests/generic/082     | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/082.out |  3 +++
 tests/generic/group   |  1 +
 3 files changed, 77 insertions(+)
 create mode 100755 tests/generic/082
 create mode 100644 tests/generic/082.out

diff --git a/tests/generic/082 b/tests/generic/082
new file mode 100755
index 0000000..ca77c25
--- /dev/null
+++ b/tests/generic/082
@@ -0,0 +1,73 @@
+#! /bin/bash
+# FS QA Test No. 082
+#
+# Test quota handling on remount ro failure
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
+. ./common/quota
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch
+_require_quota
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o usrquota,grpquota"
+
+# xfs doesn't need these setups and quotacheck even fails on xfs, so just
+# redirect the output to $seqres.full for debug purpose and ignore the results,
+# as we check the quota status later anyway.
+quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
+quotaon $SCRATCH_MNT >>$seqres.full 2>&1
+
+# first remount ro with a bad option, a failed remount ro should not disable
+# quota, but currently xfs doesn't fail in this case, the unknown option is
+# just ignored, but quota is still on. This may change in future, let's
+# re-consider the case then.
+_scratch_mount "-o remount,ro,nosuchopt" >>$seqres.full 2>&1
+quotaon -p $SCRATCH_MNT | _filter_scratch
+# second remount should succeed, no oops or hang expected
+_scratch_mount "-o remount,ro" || _fail "second remount,ro failed"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/082.out b/tests/generic/082.out
new file mode 100644
index 0000000..1acc7e4
--- /dev/null
+++ b/tests/generic/082.out
@@ -0,0 +1,3 @@
+QA output created by 082
+group quota on SCRATCH_MNT (SCRATCH_DEV) is on
+user quota on SCRATCH_MNT (SCRATCH_DEV) is on
diff --git a/tests/generic/group b/tests/generic/group
index 63b883c..4fe2189 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -84,6 +84,7 @@
 079 acl attr ioctl metadata auto quick
 080 auto quick
 081 auto quick
+082 auto quick
 083 rw auto enospc stress
 088 perms auto quick
 089 metadata auto
-- 
1.8.3.1

