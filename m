Received: from imap.thunk.org ([74.207.234.97]:36768 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751514AbdBNAzx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Feb 2017 19:55:53 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/4] generic: new case for test mount shared subtrees state transition
Date: Mon, 13 Feb 2017 19:55:44 -0500
Message-Id: <20170214005545.29373-4-tytso@mit.edu>
In-Reply-To: <20170214005545.29373-1-tytso@mit.edu>
References: <20170214005545.29373-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Zorro Lang <zlang@redhat.com>

This case will do function test for mount --make-* operations, it will
verify below state transition:

------------------------------------------------------------------------
|             |make-shared |  make-slave  | make-private |make-unbindab|
--------------|------------|--------------|--------------|-------------|
|shared       |shared      |*slave/private|   private    | unbindable  |
|             |            |              |              |             |
|-------------|------------|--------------|--------------|-------------|
|slave        |shared      |    **slave   |    private   | unbindable  |
|             |and slave   |              |              |             |
|-------------|------------|--------------|--------------|-------------|
|shared       |shared      |    slave     |    private   | unbindable  |
|and slave    |and slave   |              |              |             |
|-------------|------------|--------------|--------------|-------------|
|private      |shared      |  **private   |    private   | unbindable  |
|-------------|------------|--------------|--------------|-------------|
|unbindable   |shared      |**unbindable  |    private   | unbindable  |
------------------------------------------------------------------------

This case use fsstress to produce a little rand load, to sure basic
operations on the mountpoints won't cause hang or panic etc.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/410     | 215 +++++++++++++
 tests/generic/410.out | 813 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 1029 insertions(+)
 create mode 100644 tests/generic/410
 create mode 100644 tests/generic/410.out

diff --git a/tests/generic/410 b/tests/generic/410
new file mode 100644
index 00000000..055a0543
--- /dev/null
+++ b/tests/generic/410
@@ -0,0 +1,215 @@
+#! /bin/bash
+# FS QA Test 410
+#
+# Test mount shared subtrees, verify the state transition when use:
+#   --make-shared
+#   --make-slave
+#   --make-private
+#   --make-unbindable
+#
+# ------------------------------------------------------------------------
+# |             |make-shared |  make-slave  | make-private |make-unbindab|
+# --------------|------------|--------------|--------------|-------------|
+# |shared       |shared      |*slave/private|   private    | unbindable  |
+# |             |            |              |              |             |
+# |-------------|------------|--------------|--------------|-------------|
+# |slave        |shared      |    **slave   |    private   | unbindable  |
+# |             |and slave   |              |              |             |
+# |-------------|------------|--------------|--------------|-------------|
+# |shared       |shared      |    slave     |    private   | unbindable  |
+# |and slave    |and slave   |              |              |             |
+# |-------------|------------|--------------|--------------|-------------|
+# |private      |shared      |  **private   |    private   | unbindable  |
+# |-------------|------------|--------------|--------------|-------------|
+# |unbindable   |shared      |**unbindable  |    private   | unbindable  |
+# ------------------------------------------------------------------------
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
+
+find_mnt()
+{
+	echo "------"
+	findmnt -n -o TARGET,SOURCE $SCRATCH_DEV | \
+	    sed -e "s;$mpA;mpA;g" \
+		-e "s;$mpB;mpB;g" \
+		-e "s;$mpC;mpC;g" | \
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
+	rm -rf $mpA $mpB $mpC 2>/dev/null
+	mkdir $mpA $mpB $mpC
+        _scratch_mkfs >$seqres.full 2>&1
+}
+
+end_test()
+{
+	rm -rf $mpA $mpB $mpC 2>/dev/null
+	_clear_mount_stack
+}
+
+run()
+{
+	# command include make-shared/slave/private/unbindable
+	local cmd=$1
+	# orginal status include shared/slave/shared&slave/private/unbindable
+	local orgs="$2"
+
+	# bind anything on un-shared dest will keep the source type
+	# So use un-shared dest at here
+	start_test private
+
+	echo "make-$cmd a $orgs mount"
+	_get_mount $SCRATCH_DEV $mpA
+	mkdir -p $mpA/dir 2>/dev/null
+	mount --make-shared $mpA
+
+	# prepare the original status on mpB
+	_get_mount --bind $mpA $mpB
+	# shared&slave status need to do make-slave then make-shared
+	# two operations.
+	for t in $orgs
+	do
+		mount --make-"$t" $mpB
+	done
+
+	# "before" for prepare and check original status
+	# "after" for check the impact of make-$cmd command
+	for i in before after
+	do
+		echo "$i make-$cmd run on $orgs"
+		# maybe unbindable at here
+		_get_mount --bind $mpB $mpC 2>/dev/null
+		if [ $? -ne 0 ];then
+			find_mnt
+		else
+			for m in $mpA $mpB $mpC
+			do
+				_get_mount $SCRATCH_DEV $m/dir
+				fs_stress $m/dir
+				find_mnt
+				_put_mount
+			done
+			_put_mount # umount C
+		fi
+		if [ "$i" = "before" ];then
+			mount --make-"${cmd}" $mpB
+		fi
+	done
+
+	end_test
+}
+
+do_test()
+{
+    #   operation  original_status
+    run shared     shared
+    run shared     slave
+    run shared     "slave shared"
+    run shared     private
+    run shared     unbindable
+
+    run slave      shared
+    run slave      slave
+    run slave      "slave shared"
+    run slave      private
+    run slave      unbindable
+
+    run private    shared
+    run private    slave
+    run private    "slave shared"
+    run private    private
+    run private    unbindable
+
+    run unbindable shared
+    run unbindable slave
+    run unbindable "slave shared"
+    run unbindable private
+    run unbindable unbindable
+}
+
+do_test
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/410.out b/tests/generic/410.out
new file mode 100644
index 00000000..3579fd30
--- /dev/null
+++ b/tests/generic/410.out
@@ -0,0 +1,813 @@
+QA output created by 410
+make-shared a shared mount
+before make-shared run on shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-shared run on shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-shared a slave mount
+before make-shared run on slave
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-shared run on slave
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-shared a slave shared mount
+before make-shared run on slave shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-shared run on slave shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-shared a private mount
+before make-shared run on private
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-shared run on private
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-shared a unbindable mount
+before make-shared run on unbindable
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+after make-shared run on unbindable
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-slave a shared mount
+before make-slave run on shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-slave run on shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-slave a slave mount
+before make-slave run on slave
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-slave run on slave
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-slave a slave shared mount
+before make-slave run on slave shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-slave run on slave shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-slave a private mount
+before make-slave run on private
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-slave run on private
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-slave a unbindable mount
+before make-slave run on unbindable
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+after make-slave run on unbindable
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+make-private a shared mount
+before make-private run on shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-private run on shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-private a slave mount
+before make-private run on slave
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-private run on slave
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-private a slave shared mount
+before make-private run on slave shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-private run on slave shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-private a private mount
+before make-private run on private
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-private run on private
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-private a unbindable mount
+before make-private run on unbindable
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+after make-private run on unbindable
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+make-unbindable a shared mount
+before make-unbindable run on shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-unbindable run on shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+make-unbindable a slave mount
+before make-unbindable run on slave
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-unbindable run on slave
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+make-unbindable a slave shared mount
+before make-unbindable run on slave shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-unbindable run on slave shared
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+make-unbindable a private mount
+before make-unbindable run on private
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+======
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+======
+after make-unbindable run on private
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+make-unbindable a unbindable mount
+before make-unbindable run on unbindable
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
+after make-unbindable run on unbindable
+------
+TEST_DIR/410 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+======
diff --git a/tests/generic/group b/tests/generic/group
index 910b3138..0f9e3b35 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -412,3 +412,4 @@
 407 auto quick clone metadata
 408 auto quick clone dedupe metadata
 409 auto quick mount
+410 auto quick mount
-- 
2.11.0.rc0.7.gbe5a750

