Received: from mx1.redhat.com ([209.132.183.28]:56341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbcBITcJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 14:32:09 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 1B193E1B7B
	for <fstests@vger.kernel.org>; Tue,  9 Feb 2016 19:32:09 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/169: new case for test default quota lower than specific quota
Date: Wed, 10 Feb 2016 03:32:02 +0800
Message-Id: <1455046322-9887-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, cmaiolino@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

There's a bug for xfs_quota. After mount with uquota,gquota, If
set the user/group default quota lower than specific user/group
quota, the specific quota can't work well.

This bug have an upstream patch:
  xfs: Split default quota limits by quota type

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/169     | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/169.out |   5 ++
 tests/xfs/group   |   1 +
 3 files changed, 157 insertions(+)
 create mode 100755 tests/xfs/169
 create mode 100644 tests/xfs/169.out

diff --git a/tests/xfs/169 b/tests/xfs/169
new file mode 100755
index 0000000..11f33e7
--- /dev/null
+++ b/tests/xfs/169
@@ -0,0 +1,151 @@
+#! /bin/bash
+# FS QA Test 169
+#
+# This case for a bug about xfs default quota, after mount with
+# uquota,gquota, if the default quota lower than specific quota,
+# the specific quota can't work.
+
+# An upstream patch for fix this bug:
+#
+#   [PATCH] xfs: Split default quota limits by quota type V4
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 YOUR NAME HERE.  All Rights Reserved.
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
+_require_user fsgqa
+_require_group fsgqa
+
+do_test()
+{
+	local qname=$1
+	local type
+	local rc=0
+
+	if [ "$qname" = "user" ]
+	then
+		type="-u"
+	elif [ "$qname" = "group" ]
+	then
+		type="-g"
+	else
+		_fail "wrong quota type name - $qname"
+	fi
+
+	xfs_quota -x -c "limit bsoft=20M bhard=20M isoft=200 ihard=200 $type -d" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Can't set limit bsoft=20M bhard=20M isoft=200 ihard=200 $type -d to $SCRATCH_MNT"
+	DEF_BHARD=`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | awk '/^root / {print $4}'`
+	DEF_IHARD=`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | awk '/^root / {print $4}'`
+
+	xfs_quota -x -c "limit bsoft=40M bhard=40M isoft=400 ihard=400 $type fsgqa" $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -ne 0 ] && _fail "Can't set limit bsoft=40M bhard=40M isoft=400 ihard=400 $type fsgqa to $SCRATCH_MNT"
+	QA_BHARD=`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | awk '/^fsgqa / {print $4}'`
+	QA_IHARD=`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | awk '/^fsgqa / {print $4}'`
+
+	if [ "$QA_BHARD" = "$DEF_BHARD" -o "$QA_IHARD" = "$DEF_IHARD" ]
+	then
+		_fail "Fail to set specific quota to fsgqa"
+	fi
+
+	## blocks default quota test ##
+	sudo -u fsgqa -s dd if=/dev/zero of=${SCRATCH_MNT}/data bs=1M count=30 >>$seqres.full 2>&1
+	sync
+
+	USED_B=`xfs_quota -x -c "report $type -N -b" $SCRATCH_MNT | awk '/^fsgqa / {print $2}'`
+	if [ $USED_B -gt $DEF_BHARD -a $USED_B -le $QA_BHARD ]
+	then
+		echo "$qname blocks quota test pass"
+	else
+		rc=1
+		echo "$qname blocks quota test fail"
+	fi
+
+	rm -f ${SCRATCH_MNT}/data >/dev/null 2>&1
+
+	## inode default quota test ##
+	for ((i=0; i<300; i++))
+	do
+		sudo -u fsgqa -s touch ${SCRATCH_MNT}/file${i} >>$seqres.full 2>&1
+	done
+	sync
+
+	USED_I=`xfs_quota -x -c "report $type -N -i" $SCRATCH_MNT | awk '/^fsgqa / {print $2}'`
+	if [ $USED_I -gt $DEF_IHARD -a $USED_I -le $QA_IHARD ]
+	then
+		echo "$qname inode quota test pass"
+	else
+		rc=1
+		echo "$qname inode quota test fail"
+	fi
+
+	rm -f ${SCRATCH_MNT}/file* >/dev/null 2>&1
+
+	return $rc
+}
+
+### user default quota test ###
+_scratch_mkfs_xfs >/dev/null 2>&1
+PAGESIZE=`src/feature -s`
+_qmount_option "uquota,gquota,allocsize=$PAGESIZE"
+_qmount
+chmod ugo+rwx $SCRATCH_MNT
+
+do_test user || exit
+
+### group default quota test ###
+umount $SCRATCH_MNT
+_scratch_mkfs_xfs >/dev/null 2>&1
+_qmount_option "gquota,uquota,allocsize=$PAGESIZE"
+_qmount
+chmod ugo+rwx $SCRATCH_MNT
+
+do_test group || exit
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/169.out b/tests/xfs/169.out
new file mode 100644
index 0000000..0d81280
--- /dev/null
+++ b/tests/xfs/169.out
@@ -0,0 +1,5 @@
+QA output created by 169
+user blocks quota test pass
+user inode quota test pass
+group blocks quota test pass
+group inode quota test pass
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

