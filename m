Received: from mx1.redhat.com ([209.132.183.28]:34668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751485AbdIUIYb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Sep 2017 04:24:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C1D84ACBA
        for <fstests@vger.kernel.org>; Thu, 21 Sep 2017 08:24:31 +0000 (UTC)
Received: from dhcp-12-116.nay.redhat.com (dhcp-12-116.nay.redhat.com [10.66.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C51560621
        for <fstests@vger.kernel.org>; Thu, 21 Sep 2017 08:24:29 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic: test mount move semantics
Date: Thu, 21 Sep 2017 16:24:23 +0800
Message-Id: <20170921082423.22710-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This's a functional test case for mount --move operation, it verifies
below semantics:

  ---------------------------------------------------------------------------
  |         MOVE MOUNT OPERATION                                            |
  |**************************************************************************
  |source(A)->| shared       |       private  |       slave    | unbindable |
  | dest(B)  |               |                |                |            |
  |   |      |               |                |                |            |
  |   v      |               |                |                |            |
  |**************************************************************************
  |  shared  | shared        |     shared     | shared & slave |  invalid   |
  |          |               |                |                |            |
  |non-shared| shared        |      private   |      slave     | unbindable |
  ***************************************************************************
  NOTE: moving a mount residing under a shared mount is invalid.

This case uses fsstress to produce a little random load, to make
sure basic operations won't break the the moved mountpoints.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc             |   6 +
 tests/generic/461     | 192 ++++++++++++++++++++++++++
 tests/generic/461.out | 374 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |   1 +
 4 files changed, 573 insertions(+)
 create mode 100755 tests/generic/461
 create mode 100644 tests/generic/461.out

diff --git a/common/rc b/common/rc
index cd53a373..1e6ebe3b 100644
--- a/common/rc
+++ b/common/rc
@@ -200,6 +200,12 @@ _get_mount()
 
 	_mount $*
 	if [ $? -eq 0 ]; then
+		# mount --move operation updates the mountpoint, so remove
+		# the old one and insert the new one
+		if [[ "$*" =~ --move|-M ]]; then
+			MOUNTED_POINT_STACK=`echo $MOUNTED_POINT_STACK | \
+						cut -d\  -f2-`
+		fi
 		MOUNTED_POINT_STACK="$mnt_point $MOUNTED_POINT_STACK"
 	else
 		return 1
diff --git a/tests/generic/461 b/tests/generic/461
new file mode 100755
index 00000000..03134733
--- /dev/null
+++ b/tests/generic/461
@@ -0,0 +1,192 @@
+#! /bin/bash
+# FS QA Test 461
+#
+# Test mount shared subtrees, verify the move semantics:
+#
+# ---------------------------------------------------------------------------
+# |         MOVE MOUNT OPERATION                                            |
+# |**************************************************************************
+# |source(A)->| shared       |       private  |       slave    | unbindable |
+# | dest(B)  |               |                |                |            |
+# |   |      |               |                |                |            |
+# |   v      |               |                |                |            |
+# |**************************************************************************
+# |  shared  | shared        |     shared     | shared & slave |  invalid   |
+# |          |               |                |                |            |
+# |non-shared| shared        |      private   |      slave     | unbindable |
+# ***************************************************************************
+#   NOTE: moving a mount residing under a shared mount is invalid.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
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
+	_clear_mount_stack
+	# make sure there's no bug cause dentry isn't be freed
+	rm -rf $MNTHEAD
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch
+_require_local_device $SCRATCH_DEV
+
+fs_stress()
+{
+	local target=$1
+
+	$FSSTRESS_PROG -n 50 -p 3 -d $target >/dev/null
+	sync
+}
+
+# prepare some mountpoint dir
+SRCHEAD=$TEST_DIR/$seq-src
+DESHEAD=$TEST_DIR/$seq-des
+rm -rf $SRCHEAD $DESHEAD
+mkdir $SRCHEAD $DESHEAD 2>>$seqres.full
+mpA=$SRCHEAD/"$$"_mpA
+mpB=$SRCHEAD/"$$"_mpB
+mpC=$DESHEAD/"$$"_mpC
+mpD=$DESHEAD/"$$"_mpD
+
+find_mnt()
+{
+	echo "------"
+	findmnt -n -o TARGET,SOURCE $SCRATCH_DEV | \
+		sed -e "s;$mpA;mpA;g" \
+		    -e "s;$mpB;mpB;g" \
+		    -e "s;$mpC;mpC;g" \
+		    -e "s;$mpD;mpD;g" | \
+		_filter_spaces | _filter_testdir_and_scratch | sort
+	echo "======"
+}
+
+start_test()
+{
+	local type=$1
+
+	_scratch_mkfs >$seqres.full 2>&1
+
+	_get_mount -t $FSTYP $SCRATCH_DEV $SRCHEAD
+	$MOUNT_PROG --make-private $SRCHEAD
+
+	_get_mount -t $FSTYP $SCRATCH_DEV $DESHEAD
+	_get_mount --bind $DESHEAD $DESHEAD
+	$MOUNT_PROG --make-"${type}" $DESHEAD
+	mkdir $mpA $mpB $mpC $mpD
+}
+
+end_test()
+{
+	_clear_mount_stack
+	rm -rf $mpA $mpB $mpC $mpD
+}
+
+move_run()
+{
+	local source=$1
+	local dest=$2
+
+	start_test $dest
+
+	echo "move $source to $dest"
+	_get_mount -t $FSTYP $SCRATCH_DEV $mpA
+	mkdir -p $mpA/dir 2>/dev/null
+	$MOUNT_PROG --make-shared $mpA
+	_get_mount --bind $mpA $mpB
+	$MOUNT_PROG --make-"$source" $mpB
+	# maybe unbindable at here
+	_get_mount --move $mpB $mpC 2>/dev/null
+	if [ $? -ne 0 ]; then
+		find_mnt
+		end_test
+		return 0
+	fi
+
+	# check mpC before move it to mpD
+	for m in $mpA $mpC; do
+		_get_mount -t $FSTYP $SCRATCH_DEV $m/dir
+		fs_stress $m/dir
+		find_mnt
+		_put_mount
+	done
+
+	# mpC will be in different parent mount, test moveing from different
+	# parent mount, and moving a mount residing under a shared mount is
+	# invalid
+	_get_mount --move $mpC $mpD 2>/dev/null
+	if [ $? -ne 0 ]; then
+		find_mnt
+		end_test
+		return 0
+	fi
+	for m in $mpA $mpD; do
+		_get_mount -t $FSTYP $SCRATCH_DEV $m/dir
+		fs_stress $m/dir
+		find_mnt
+		_put_mount
+	done
+
+	end_test
+}
+
+move_test()
+{
+	#        source     dest
+	move_run shared     shared
+	move_run slave      shared
+	move_run private    shared
+	move_run unbindable shared
+
+	move_run shared     slave
+	move_run slave      slave
+	move_run private    slave
+	move_run unbindable slave
+
+	move_run shared     private
+	move_run slave      private
+	move_run private    private
+	move_run unbindable private
+}
+
+move_test
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/461.out b/tests/generic/461.out
new file mode 100644
index 00000000..8840e383
--- /dev/null
+++ b/tests/generic/461.out
@@ -0,0 +1,374 @@
+QA output created by 461
+move shared to shared
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+move slave to shared
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+move private to shared
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+move unbindable to shared
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+move shared to slave
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+move slave to slave
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+move private to slave
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+move unbindable to slave
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+move shared to private
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+move slave to private
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+move private to private
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+move unbindable to private
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-des SCRATCH_DEV
+TEST_DIR/461-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
diff --git a/tests/generic/group b/tests/generic/group
index f922b496..7482fd0c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -463,3 +463,4 @@
 458 auto quick clone
 459 auto dangerous
 460 auto quick rw
+461 auto quick mount
-- 
2.13.5

