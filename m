Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbbCTKR3 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 06:17:29 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2KAHTKn016320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 06:17:29 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/9 RESEND] generic: test quota handling on remount ro failure
Date: Fri, 20 Mar 2015 18:16:51 +0800
Message-Id: <1426846618-23413-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1426846618-23413-1-git-send-email-eguan@redhat.com>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Remount ro should not turn qouta off unconditionally, even remount ro
failed, also kernel should not oops on the next succeeded remount ro.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/072     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/072.out |  3 +++
 tests/generic/group   |  1 +
 3 files changed, 73 insertions(+)
 create mode 100755 tests/generic/072
 create mode 100644 tests/generic/072.out

diff --git a/tests/generic/072 b/tests/generic/072
new file mode 100755
index 0000000..ef40822
--- /dev/null
+++ b/tests/generic/072
@@ -0,0 +1,69 @@
+#! /bin/bash
+# FS QA Test No. 072
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
+
+# Modify as appropriate.
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
+quotacheck -ug $SCRATCH_MNT >/dev/null 2>&1
+quotaon $SCRATCH_MNT >/dev/null 2>&1
+
+# first remount ro with a bad option, a failed remount ro should not disable quota
+_scratch_mount "-o remount,ro,nosuchopt" >>$seqres.full 2>&1
+quotaon -p $SCRATCH_MNT | _filter_scratch
+# second remount should succeed, no oops or hang expected
+_scratch_mount "-o remount,ro"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/072.out b/tests/generic/072.out
new file mode 100644
index 0000000..ff0e180
--- /dev/null
+++ b/tests/generic/072.out
@@ -0,0 +1,3 @@
+QA output created by 072
+group quota on SCRATCH_MNT (SCRATCH_DEV) is on
+user quota on SCRATCH_MNT (SCRATCH_DEV) is on
diff --git a/tests/generic/group b/tests/generic/group
index 03ad7b8..c0210d2 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -74,6 +74,7 @@
 069 rw udf auto quick
 070 attr udf auto quick stress
 071 auto quick prealloc
+072 auto quick quota
 074 rw udf auto
 075 rw udf auto quick
 076 metadata rw udf auto quick stress
-- 
2.1.0

