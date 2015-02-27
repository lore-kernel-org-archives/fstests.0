Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46497 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbbB0Lb2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Feb 2015 06:31:28 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1RBVST7022110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 27 Feb 2015 06:31:28 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/5] generic: test quota handling on remount ro failure
Date: Fri, 27 Feb 2015 19:30:22 +0800
Message-Id: <1425036625-23361-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1425036625-23361-1-git-send-email-eguan@redhat.com>
References: <1425036625-23361-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Remount ro should not turn qouta off unconditionally, even remount ro
failed, also kernel should not oops on the next succeeded remount ro.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/071     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/071.out |  3 +++
 tests/generic/group   |  1 +
 3 files changed, 73 insertions(+)
 create mode 100755 tests/generic/071
 create mode 100644 tests/generic/071.out

diff --git a/tests/generic/071 b/tests/generic/071
new file mode 100755
index 0000000..0af8abe
--- /dev/null
+++ b/tests/generic/071
@@ -0,0 +1,69 @@
+#! /bin/bash
+# FS QA Test No. 071
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
diff --git a/tests/generic/071.out b/tests/generic/071.out
new file mode 100644
index 0000000..afea4f9
--- /dev/null
+++ b/tests/generic/071.out
@@ -0,0 +1,3 @@
+QA output created by 071
+group quota on SCRATCH_MNT (SCRATCH_DEV) is on
+user quota on SCRATCH_MNT (SCRATCH_DEV) is on
diff --git a/tests/generic/group b/tests/generic/group
index 33b0b82..f41cc3b 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -73,6 +73,7 @@
 068 other auto freeze dangerous stress
 069 rw udf auto quick
 070 attr udf auto quick stress
+071 auto quick quota
 074 rw udf auto
 075 rw udf auto quick
 076 metadata rw udf auto quick stress
-- 
1.8.3.1

