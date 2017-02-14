Received: from imap.thunk.org ([74.207.234.97]:36764 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdBNAzx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Feb 2017 19:55:53 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/4] generic: new case for test mount bind operation
Date: Mon, 13 Feb 2017 19:55:43 -0500
Message-Id: <20170214005545.29373-3-tytso@mit.edu>
In-Reply-To: <20170214005545.29373-1-tytso@mit.edu>
References: <20170214005545.29373-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Zorro Lang <zlang@redhat.com>

This case will do function test for mount bind operation, it will
verify below semantics:

---------------------------------------------------------------------------
|         BIND MOUNT OPERATION                                            |
|**************************************************************************
|source(A)->| shared       |       private  |       slave    | unbindable |
| dest(B)  |               |                |                |            |
|   |      |               |                |                |            |
|   v      |               |                |                |            |
|**************************************************************************
|  shared  | shared        |     shared     | shared & slave |  invalid   |
|          |               |                |                |            |
|non-shared| shared        |      private   |      slave     |  invalid   |
***************************************************************************

This case use fsstress to produce a little rand load, to sure basic
operations on the bind mountpoint won't cause hang or panic etc.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/409     | 182 +++++++++++++++++++++++++
 tests/generic/409.out | 365 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 548 insertions(+)
 create mode 100644 tests/generic/409
 create mode 100644 tests/generic/409.out

diff --git a/tests/generic/409 b/tests/generic/409
new file mode 100644
index 00000000..88bda6c5
--- /dev/null
+++ b/tests/generic/409
@@ -0,0 +1,182 @@
+#! /bin/bash
+# FS QA Test 409
+#
+# Test mount shared subtrees, verify the bind semantics:
+#
+# ---------------------------------------------------------------------------
+# |         BIND MOUNT OPERATION                                            |
+# |**************************************************************************
+# |source(A)->| shared       |       private  |       slave    | unbindable |
+# | dest(B)  |               |                |                |            |
+# |   |      |               |                |                |            |
+# |   v      |               |                |                |            |
+# |**************************************************************************
+# |  shared  | shared        |     shared     | shared & slave |  invalid   |
+# |          |               |                |                |            |
+# |non-shared| shared        |      private   |      slave     |  invalid   |
+# ***************************************************************************
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
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
+_require_scratch
+_require_test
+
+fs_stress()
+{
+	local target=$1
+
+	$FSSTRESS_PROG -z -n 50 -p 3 \
+		       -f creat=5 \
+		       -f mkdir=5 \
+		       -f link=2 \
+		       -f rename=1 \
+		       -f rmdir=2 \
+		       -f unlink=1 \
+		       -f symlink=1 \
+		       -f write=1 \
+		       -f read=1 \
+		       -f chown=1 \
+		       -f getdents=1 \
+		       -f fiemap=1 \
+		       -d $target >/dev/null
+	sync
+}
+
+# prepare some mountpoint dir
+MNTHEAD=$TEST_DIR/$seq
+mkdir $MNTHEAD 2>>$seqres.full
+mpA=$MNTHEAD/"$$"_mpA
+mpB=$MNTHEAD/"$$"_mpB
+mpC=$MNTHEAD/"$$"_mpC
+mpD=$MNTHEAD/"$$"_mpD
+
+find_mnt()
+{
+	echo "------"
+	findmnt -n -o TARGET,SOURCE $SCRATCH_DEV | \
+	    sed -e "s;$mpA;mpA;g" \
+		-e "s;$mpB;mpB;g" \
+		-e "s;$mpC;mpC;g" \
+		-e "s;$mpD;mpD;g" | \
+	    _filter_spaces | _filter_scratch | \
+	    _filter_test_dir | sort
+	echo "======"
+}
+
+start_test()
+{
+	local type=$1
+
+	_get_mount $SCRATCH_DEV $MNTHEAD
+	mount --make-"${type}" $MNTHEAD
+	rm -rf $mpA $mpB $mpC $mpD 2>/dev/null
+	mkdir $mpA $mpB $mpC $mpD
+        _scratch_mkfs >$seqres.full 2>&1
+}
+
+end_test()
+{
+	rm -rf $mpA $mpB $mpC $mpD 2>/dev/null
+	_clear_mount_stack
+}
+
+bind_run()
+{
+	local source=$1
+	local dest=$2
+
+	start_test $dest
+
+	echo "bind $source on $dest"
+	_get_mount $SCRATCH_DEV $mpA
+	mkdir -p $mpA/dir 2>/dev/null
+	mount --make-shared $mpA
+	_get_mount --bind $mpA $mpB
+	mount --make-"$source" $mpB
+	# maybe unbindable at here
+	_get_mount --bind $mpB $mpC 2>/dev/null
+	if [ $? -ne 0 ];then
+		find_mnt
+		end_test
+		return 0
+	fi
+	_get_mount --bind $mpC $mpD
+	for m in $mpA $mpB $mpC $mpD
+	do
+		_get_mount $SCRATCH_DEV $m/dir
+		fs_stress $m/dir
+		find_mnt
+		_put_mount
+	done
+
+	end_test
+}
+
+bind_test()
+{
+	local dest=$1
+
+        #        source     dest
+	bind_run shared     shared
+	bind_run slave      shared
+	bind_run private    shared
+	bind_run unbindable shared
+
+	bind_run shared     slave
+	bind_run slave      slave
+	bind_run private    slave
+	bind_run unbindable slave
+
+	bind_run shared     private
+	bind_run slave      private
+	bind_run private    private
+	bind_run unbindable private
+}
+
+bind_test
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/409.out b/tests/generic/409.out
new file mode 100644
index 00000000..91c8909f
--- /dev/null
+++ b/tests/generic/409.out
@@ -0,0 +1,365 @@
+QA output created by 409
+bind shared on shared
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind slave on shared
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind private on shared
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind unbindable on shared
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+bind shared on slave
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind slave on slave
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind private on slave
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind unbindable on slave
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+bind shared on private
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind slave on private
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind private on private
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+======
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+======
+bind unbindable on private
+------
+TEST_DIR/409 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
diff --git a/tests/generic/group b/tests/generic/group
index d0bc47de..910b3138 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -411,3 +411,4 @@
 406 auto quick dangerous
 407 auto quick clone metadata
 408 auto quick clone dedupe metadata
+409 auto quick mount
-- 
2.11.0.rc0.7.gbe5a750

