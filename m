Received: from mx1.redhat.com ([209.132.183.28]:50957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbbLIRKa (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 9 Dec 2015 12:10:30 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 9FB761136F4
	for <fstests@vger.kernel.org>; Wed,  9 Dec 2015 17:10:30 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 1/2] xfs/133: test project quota name beginning with digits
Date: Thu, 10 Dec 2015 01:10:25 +0800
Message-Id: <1449681026-4469-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, sandeen@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

There's a known bug of xfsprogs, when a project name beinning with
digits, it can't be found by run xfs_quota 'quota -p -v ...' command.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/133     | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/133.out |   1 +
 tests/xfs/group   |   1 +
 3 files changed, 103 insertions(+)
 create mode 100755 tests/xfs/133
 create mode 100644 tests/xfs/133.out

diff --git a/tests/xfs/133 b/tests/xfs/133
new file mode 100755
index 0000000..330221f
--- /dev/null
+++ b/tests/xfs/133
@@ -0,0 +1,101 @@
+#! /bin/bash
+# FS QA Test 133
+#
+# Test xfs_quota when project names beginning with digits.
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
+qa_user=""
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_xfs_quota
+
+_scratch_mkfs_xfs >/dev/null 2>&1
+
+do_project_test()
+{
+	local qa_project=123456-project
+	local dir=$SCRATCH_MNT/project
+
+	mkdir $dir 2>/dev/null
+
+	#project quota files
+	cat >$tmp.projects <<EOF
+10:$dir
+EOF
+
+	cat >$tmp.projid <<EOF
+$qa_project:10
+EOF
+
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "project -s $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Initalize project=$qa_project Failed"
+
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "limit -p bsoft=100m bhard=200m $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Create limit for project=$qa_project Failed"
+
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "quota -p -v $qa_project" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
+	[ $? -ne 0 ] && _fail "Query project=$qa_project Failed"
+
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "report -p" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
+	[ $? -ne 0 ] && _fail "Report project=$qa_project Failed"
+
+	return 0
+}
+
+# Test project
+_qmount_option "uquota,pquota"
+_qmount
+_require_prjquota $SCRATCH_DEV
+do_project_test
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/133.out b/tests/xfs/133.out
new file mode 100644
index 0000000..189cb69
--- /dev/null
+++ b/tests/xfs/133.out
@@ -0,0 +1 @@
+QA output created by 133
diff --git a/tests/xfs/group b/tests/xfs/group
index 9884329..bae09de 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -130,6 +130,7 @@
 130 fuzzers
 131 auto quick clone
 132 auto quick clone
+133 auto quick quota
 134 quota auto quick
 136 attr2
 142 dmapi
-- 
1.9.3

