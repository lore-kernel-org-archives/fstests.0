Received: from mx1.redhat.com ([209.132.183.28]:60810 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbcBKPGH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 10:06:07 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 3E69EC09FA8F
	for <fstests@vger.kernel.org>; Thu, 11 Feb 2016 15:06:07 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] xfs: new case for test default user/group quota
Date: Thu, 11 Feb 2016 23:05:55 +0800
Message-Id: <1455203155-28472-1-git-send-email-zlang@redhat.com>
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

>From suggestion of Eryu(eguan@redhat.com), I change code *return value*
check to *golden image* check in this V3.

Thanks,
Zorro

 tests/xfs/169     | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/169.out |  31 ++++++++++++++
 tests/xfs/group   |   1 +
 3 files changed, 152 insertions(+)
 create mode 100755 tests/xfs/169
 create mode 100644 tests/xfs/169.out

diff --git a/tests/xfs/169 b/tests/xfs/169
new file mode 100755
index 0000000..86824aa
--- /dev/null
+++ b/tests/xfs/169
@@ -0,0 +1,120 @@
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
+	$XFS_QUOTA_PROG -x -c "limit bsoft=20M bhard=20M isoft=200 ihard=200 $type -d" $SCRATCH_MNT
+	$XFS_QUOTA_PROG -x -c "limit bsoft=40M bhard=40M isoft=400 ihard=400 $type fsgqa" $SCRATCH_MNT
+	echo "$qname blocks and inode limit"
+	$XFS_QUOTA_PROG -x -c "report $type -N -bi" $SCRATCH_MNT
+
+	## blocks default quota test ##
+	_user_do "$XFS_IO_PROG -f -c \"pwrite 0 30M\" -c \"fsync\" $SCRATCH_MNT/data" | _filter_xfs_io
+	echo "$qname blocks quota after write 30M data"
+	$XFS_QUOTA_PROG -x -c "report $type -N -b" $SCRATCH_MNT
+
+	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
+
+	## inode default quota test ##
+	for ((i=0; i<300; i++));do
+		_user_do "echo -n > ${SCRATCH_MNT}/file${i}"
+	done
+	sync
+
+	echo "$qname inode quota after create 300 inodes"
+	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT
+
+	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
+}
+
+### user default quota test ###
+_scratch_mkfs_xfs >/dev/null 2>&1
+PAGESIZE=`src/feature -s`
+_qmount_option "uquota,gquota,allocsize=$PAGESIZE"
+_qmount
+
+do_test user
+
+### group default quota test ###
+_scratch_unmount
+_scratch_mkfs_xfs >/dev/null 2>&1
+_qmount_option "gquota,uquota,allocsize=$PAGESIZE"
+_qmount
+
+do_test group
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/169.out b/tests/xfs/169.out
new file mode 100644
index 0000000..0fa7af6
--- /dev/null
+++ b/tests/xfs/169.out
@@ -0,0 +1,31 @@
+QA output created by 169
+=== user quota test ===
+user blocks and inode limit
+root                0      20480      20480     00 [--------]          3        200        200     00 [--------]
+fsgqa               0      40960      40960     00 [--------]          0        400        400     00 [--------]
+
+wrote 31457280/31457280 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+user blocks quota after write 30M data
+root                0      20480      20480     00 [--------]
+fsgqa           30720      40960      40960     00 [--------]
+
+user inode quota after create 300 inodes
+root                3        200        200     00 [--------]
+fsgqa             300        400        400     00 [--------]
+
+=== group quota test ===
+group blocks and inode limit
+root                0      20480      20480     00 [--------]          3        200        200     00 [--------]
+fsgqa               0      40960      40960     00 [--------]          0        400        400     00 [--------]
+
+wrote 31457280/31457280 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+group blocks quota after write 30M data
+root                0      20480      20480     00 [--------]
+fsgqa           30720      40960      40960     00 [--------]
+
+group inode quota after create 300 inodes
+root                3        200        200     00 [--------]
+fsgqa             300        400        400     00 [--------]
+
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

