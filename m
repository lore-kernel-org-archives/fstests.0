Received: from mx1.redhat.com ([209.132.183.28]:57330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbbLIRKe (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 9 Dec 2015 12:10:34 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id F17F367C5F
	for <fstests@vger.kernel.org>; Wed,  9 Dec 2015 17:10:33 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 2/2] xfs/135: test user and group quota names beginning with digits
Date: Thu, 10 Dec 2015 01:10:26 +0800
Message-Id: <1449681026-4469-2-git-send-email-zlang@redhat.com>
In-Reply-To: <1449681026-4469-1-git-send-email-zlang@redhat.com>
References: <1449681026-4469-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, sandeen@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

There's a known bug of xfsprogs, when a user or group name beinning
with digits, xfs_quota can't create 'limit' for it.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 README            |  1 +
 common/rc         | 10 +++++--
 tests/xfs/135     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/135.out |  1 +
 tests/xfs/group   |  1 +
 5 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100755 tests/xfs/135
 create mode 100644 tests/xfs/135.out

diff --git a/README b/README
index f8a878c..a824c10 100644
--- a/README
+++ b/README
@@ -12,6 +12,7 @@ Building Linux:
 	- run make
 	- run make install
 	- create fsgqa test user ("sudo useradd fsgqa")
+	- create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
 	
 Building IRIX:
 	- cd into the xfstests directory 
diff --git a/common/rc b/common/rc
index 4c2f42c..abb457e 100644
--- a/common/rc
+++ b/common/rc
@@ -1575,22 +1575,28 @@ _cat_group()
 	cat /etc/group
 }
 
-# check for the fsgqa user on the machine
+# check for a user on the machine, fsgqa as default
 #
 _require_user()
 {
     qa_user=fsgqa
+    if [ -n "$1" ];then
+        qa_user=$1
+    fi
     _cat_passwd | grep -q $qa_user
     [ "$?" == "0" ] || _notrun "$qa_user user not defined."
     echo /bin/true | su $qa_user
     [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
 }
 
-# check for the fsgqa group on the machine
+# check for a group on the machine, fsgqa as default
 #
 _require_group()
 {
     qa_group=fsgqa
+    if [ -n "$1" ];then
+        qa_group=$1
+    fi
     _cat_group | grep -q $qa_group
     [ "$?" == "0" ] || _notrun "$qa_group user not defined."
 }
diff --git a/tests/xfs/135 b/tests/xfs/135
new file mode 100755
index 0000000..6003895
--- /dev/null
+++ b/tests/xfs/135
@@ -0,0 +1,83 @@
+#! /bin/bash
+# FS QA Test 135
+#
+# Test xfs_quota when user or names beginning with digits.
+# For example, create a 'limit' for a user or group named
+# '12345678-abcd', then query this user and group.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_quota
+
+# need user and group named 123456-fsgqa
+_require_user 123456-fsgqa
+_require_group 123456-fsgqa
+
+_scratch_mkfs_xfs >/dev/null 2>&1
+_qmount_option "uquota,gquota"
+_qmount
+
+# user test
+xfs_quota -x -c "limit -u bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT >>$seqres.full 2>&1
+[ $? -ne 0 ] && _fail "Create limit for user 123456-fsgqa Failed"
+xfs_quota -x -c "quota -u -v 123456-fsgqa" $SCRATCH_MNT 2>>$seqres.full | grep -qw 123456-fsgqa
+[ $? -ne 0 ] && _fail "Query user 123456-fsgqa Failed"
+xfs_quota -x -c "report -u" $SCRATCH_MNT 2>>$seqres.full | grep -qw 123456-fsgqa
+[ $? -ne 0 ] && _fail "Report user 123456-fsgqa Failed"
+
+# group test
+xfs_quota -x -c "limit -g bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT >>$seqres.full 2>&1
+[ $? -ne 0 ] && _fail "Create limit for group 123456-fsgqa Failed"
+xfs_quota -x -c "quota -g -v 123456-fsgqa" $SCRATCH_MNT 2>>$seqres.full | grep -qw 123456-fsgqa
+[ $? -ne 0 ] && _fail "Query group 123456-fsgqa Failed"
+xfs_quota -x -c "report -u" $SCRATCH_MNT 2>>$seqres.full | grep -qw 123456-fsgqa
+[ $? -ne 0 ] && _fail "Report group 123456-fsgqa Failed"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/135.out b/tests/xfs/135.out
new file mode 100644
index 0000000..21b1bb7
--- /dev/null
+++ b/tests/xfs/135.out
@@ -0,0 +1 @@
+QA output created by 135
diff --git a/tests/xfs/group b/tests/xfs/group
index bae09de..9623a97 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -132,6 +132,7 @@
 132 auto quick clone
 133 auto quick quota
 134 quota auto quick
+135 auto quick quota
 136 attr2
 142 dmapi
 143 dmapi
-- 
1.9.3

