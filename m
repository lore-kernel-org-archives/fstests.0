Received: from mx1.redhat.com ([209.132.183.28]:42511 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbcBKIvN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 03:51:13 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id A057519EF16
	for <fstests@vger.kernel.org>; Thu, 11 Feb 2016 08:51:13 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] xfs: new case for test default user/group quota
Date: Thu, 11 Feb 2016 16:51:07 +0800
Message-Id: <1455180667-7866-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, cmaiolino@redhat.com, eguan@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

When default quota is set, all different quota types inherits the
same default value, include group quota. So if a user quota limit
larger than the default user quota value, it will still be limited
by the group default quota value.

An upstream patch for this bug:

  xfs: Split default quota limits by quota type

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

Thanks for Eryu's suggestions on V1 patch. Please review this V2.
I have tested this case on old kernel with this bug and new
kernel with fixed patch.

Thanks,
Zorro

 tests/xfs/169     | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/169.out |  15 ++++++
 tests/xfs/group   |   1 +
 3 files changed, 156 insertions(+)
 create mode 100755 tests/xfs/169
 create mode 100644 tests/xfs/169.out

diff --git a/tests/xfs/169 b/tests/xfs/169
new file mode 100755
index 0000000..7191197
--- /dev/null
+++ b/tests/xfs/169
@@ -0,0 +1,140 @@
+#! /bin/bash
+# FS QA Test 169
+#
+# When default quota is set, all different quota types inherits the
+# same default value, include group quota. So if a user quota limit
+# larger than the default user quota value, it will still be limited
+# by the group default quota value.
+#
+# There's a patch from Upstream can fix this bug:
+#
+#    [PATCH] xfs: Split default quota limits by quota type V4
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+_supported_fs xfs
+_supported_os Linux
+_require_scratch
+_require_quota
+_require_user
+_require_group
+
+do_test()
+{
+	local qname=$1
+	local type
+	local rc=0
+
+	if [ "$qname" = "user" ];then
+		type="-u"
+		echo "=== user quota test ==="
+	elif [ "$qname" = "group" ];then
+		type="-g"
+		echo "=== group quota test ==="
+	else
+		echo "wrong quota type name - $qname"
+		return 1
+	fi
+
+	$XFS_QUOTA_PROG -x -c "limit bsoft=20M bhard=20M isoft=200 ihard=200 $type -d" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Can't set limit bsoft=20M bhard=20M isoft=200 ihard=200 $type -d to $SCRATCH_MNT"
+	DEF_BHARD=`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | awk '/^root / {print $4}'`
+	DEF_IHARD=`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | awk '/^root / {print $4}'`
+	echo "default $qname blocks limit is ${DEF_BHARD}K"
+	echo "default $qname inode limit is ${DEF_IHARD}"
+
+	xfs_quota -x -c "limit bsoft=40M bhard=40M isoft=400 ihard=400 $type fsgqa" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Can't set limit bsoft=40M bhard=40M isoft=400 ihard=400 $type fsgqa to $SCRATCH_MNT"
+	QA_BHARD=`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | awk '/^fsgqa / {print $4}'`
+	QA_IHARD=`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | awk '/^fsgqa / {print $4}'`
+	echo "fsgqa $qname blocks limit is ${QA_BHARD}K"
+	echo "fsgqa $qname inode limit is ${QA_IHARD}"
+
+	## blocks default quota test ##
+	_user_do "$XFS_IO_PROG -fc \"pwrite 0 30M\" -c \"fsync\" $SCRATCH_MNT/data" >>$seqres.full 2>&1
+	rc=$?
+	USED_B=`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | awk '/^fsgqa / {print $2}'`
+	echo "${USED_B}K data be written"
+
+	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
+
+	## inode default quota test ##
+	for ((i=0; i<300; i++));do
+		_user_do "echo -n > ${SCRATCH_MNT}/file${i}" >>$seqres.full 2>&1
+		[ $? -ne 0 ] && rc=1
+	done
+	sync
+
+	USED_I=`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | awk '/^fsgqa / {print $2}'`
+	echo "$USED_I inodes be created"
+
+	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
+
+	return $rc
+}
+
+### user default quota test ###
+_scratch_mkfs_xfs >/dev/null 2>&1
+PAGESIZE=`src/feature -s`
+_qmount_option "uquota,gquota,allocsize=$PAGESIZE"
+_qmount
+
+do_test user
+if [ $? -ne 0 ];then
+	echo "user default quota test fail"
+fi
+
+### group default quota test ###
+_scratch_unmount
+_scratch_mkfs_xfs >/dev/null 2>&1
+_qmount_option "gquota,uquota,allocsize=$PAGESIZE"
+_qmount
+
+do_test group
+if [ $? -ne 0 ];then
+	echo "group default quota test fail"
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/169.out b/tests/xfs/169.out
new file mode 100644
index 0000000..9cc75e5
--- /dev/null
+++ b/tests/xfs/169.out
@@ -0,0 +1,15 @@
+QA output created by 169
+=== user quota test ===
+default user blocks limit is 20480K
+default user inode limit is 200
+fsgqa user blocks limit is 40960K
+fsgqa user inode limit is 400
+30720K data be written
+300 inodes be created
+=== group quota test ===
+default group blocks limit is 20480K
+default group inode limit is 200
+fsgqa group blocks limit is 40960K
+fsgqa group inode limit is 400
+30720K data be written
+300 inodes be created
diff --git a/tests/xfs/group b/tests/xfs/group
index 2db3520..ffaca65 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -166,6 +166,7 @@
 166 rw metadata auto quick
 167 rw metadata auto stress
 168 dmapi
+169 auto quick quota
 170 rw filestreams auto quick
 171 rw filestreams
 172 rw filestreams
-- 
1.9.3

