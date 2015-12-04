Received: from mx1.redhat.com ([209.132.183.28]:48083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320AbbLDQBF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 11:01:05 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 18E85C0A146C
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 16:01:05 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/133: add quota name beginning with digits test
Date: Sat,  5 Dec 2015 00:00:57 +0800
Message-Id: <1449244857-19283-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, sandeen@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

There're two bugs on xfsprogs:
1. when a project name beinning with digits, it can't be found
by run xfs_quota 'quota -p -v ...' command, but 'report' command
can find it.

2. When user or group names beginning with digits, we can't
create 'limit' for them, and can't find them either(likes above).

This case will create user, group and project names which beginning
with digits, then create limit for them, and query them.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

This case need a test user, that doesn't like user 'fsqa', fsqa is a
common user for xfstests, but this case need a special and temporary
user and group. So I create and clean them in this case.

But this's the first time a xfstests case add test user/group by itself,
so please help to review, if this's appropriate?

Thanks,
Zorro

 tests/xfs/133     | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/133.out |   1 +
 tests/xfs/group   |   1 +
 3 files changed, 165 insertions(+)
 create mode 100755 tests/xfs/133
 create mode 100644 tests/xfs/133.out

diff --git a/tests/xfs/133 b/tests/xfs/133
new file mode 100755
index 0000000..71edda6
--- /dev/null
+++ b/tests/xfs/133
@@ -0,0 +1,163 @@
+#! /bin/bash
+# FS QA Test 133
+#
+# Test xfs_quota when user/group/project names beginning with digits.
+#
+# For example, create a 'limit' for '12345678-abcd' user/group/
+# project name. Then query if this 'limit' be created successfully.
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
+
+	if [ -n "$qa_user" ];then
+		# clean test user and group
+		_cat_passwd | grep -qw "$qa_user"
+		if [ $? -eq 0 ];then
+			userdel -r $qa_user >>$seqres.full 2>&1
+		fi
+		_cat_group | grep -qw "$qa_user"
+		if [ $? -eq 0 ];then
+			groupdel $qa_user >>$seqres.full 2>&1
+		fi
+	fi
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
+do_user_group_test()
+{
+	local prefix=123456
+
+	# Search an unused name for test user and group
+	for ((; prefix<99999999; prefix++));do
+		_cat_passwd | grep -qw ${prefix}-fsqa
+		if [ $? -ne 0 ];then
+			_cat_group | grep -qw ${prefix}-fsqa
+			if [ $? -ne 0 ];then
+				qa_user=${prefix}-fsqa
+				break
+			fi
+		fi
+	done
+	if [ -z "$qa_user" ];then
+		_notrun "Can't find a suitable user or group name"
+	fi
+
+	groupadd $qa_user >>$seqres.full 2>&1 || _fail "groupadd $qa_user Failed"
+	useradd -g $qa_user $qa_user >>$seqres.full 2>&1 || _fail "useradd $qa_user Failed"
+
+	# user test
+	xfs_quota -x -c "limit -u bsoft=100m bhard=200m $qa_user" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Create limit for user=$qa_user Failed"
+	xfs_quota -x -c "quota -u -v $qa_user" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_user
+	[ $? -ne 0 ] && _fail "Query user=$qa_user Failed"
+	xfs_quota -x -c "report -u" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_user
+	[ $? -ne 0 ] && _fail "Report user=$qa_user Failed"
+
+	# group test
+	xfs_quota -x -c "limit -g bsoft=100m bhard=200m $qa_user" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Create limit for group=$qa_user Failed"
+	xfs_quota -x -c "quota -g -v $qa_user" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_user
+	[ $? -ne 0 ] && _fail "Query group=$qa_user Failed"
+	xfs_quota -x -c "report -u" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_user
+	[ $? -ne 0 ] && _fail "Report group=$qa_user Failed"
+
+
+	return 0
+}
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
+	xfs_quota -D $tmp.projects -P $tmp.projid -x \
+		-c "project -s $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Initalize project=$qa_project Failed"
+
+	xfs_quota -D $tmp.projects -P $tmp.projid -x \
+		-c "limit -p bsoft=100m bhard=200m $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Create limit for project=$qa_project Failed"
+
+	xfs_quota -D $tmp.projects -P $tmp.projid -x \
+		-c "quota -p -v $qa_project" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
+	[ $? -ne 0 ] && _fail "Query project=$qa_project Failed"
+
+	xfs_quota -D $tmp.projects -P $tmp.projid -x \
+		-c "report -p" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
+	[ $? -ne 0 ] && _fail "Report project=$qa_project Failed"
+
+	return 0
+}
+
+# Test user and group
+_qmount_option "uquota,gquota"
+_qmount
+do_user_group_test
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

