Received: from imap.thunk.org ([74.207.234.97]:36766 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751507AbdBNAzx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Feb 2017 19:55:53 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/4] generic: new case test two vfsmount no peers
Date: Mon, 13 Feb 2017 19:55:45 -0500
Message-Id: <20170214005545.29373-5-tytso@mit.edu>
In-Reply-To: <20170214005545.29373-1-tytso@mit.edu>
References: <20170214005545.29373-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Zorro Lang <zlang@redhat.com>

This test cover linux commit 7ae8fd0, when mnt_group_id=0, it means
this mount no peers. But this bug treat two zero mnt_group_id as
peers. And it cause a crash by dereference a NULL address.

As below, the crash will happen when mount fs on "B/mnt1/mnt2":

           shared            New FS           shared
     -----------------------[A/mnt1]----------------------
    |                           |                         |
    |                bind       |    bind                 |
[C/mnt1]--[slave C]<------[shared A]------>[slave B]--[B/mnt1]
                                                          |
                                                          |
                                                    [B/mnt1/mnt2]
                                                       (New FS)

Signed-off-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/411     | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/411.out |  12 +++++
 tests/generic/group   |   1 +
 3 files changed, 160 insertions(+)
 create mode 100644 tests/generic/411
 create mode 100644 tests/generic/411.out

diff --git a/tests/generic/411 b/tests/generic/411
new file mode 100644
index 00000000..b3e65eac
--- /dev/null
+++ b/tests/generic/411
@@ -0,0 +1,147 @@
+#! /bin/bash
+# FS QA Test 411
+#
+# This test cover linux commit 7ae8fd0, kernel two mnt_group_id == 0
+# (no peer)vfsmount as peers. It case kernel dereference a NULL
+# address.
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
+	$FSSTRESS_PROG -z -n 500 -p 5 \
+		       -f creat=5 \
+		       -f mkdir=5 \
+		       -f dwrite=1 \
+		       -f dread=1 \
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
+#
+#            shared            New FS           shared
+#      -----------------------[A/mnt1]----------------------
+#     |                           |                         |
+#     |                bind       |    bind                 |       New FS
+# [C/mnt1]--[slave C]<------[shared A]------>[slave B]--[B/mnt1]--[B/mnt1/mnt2]
+#
+crash_test()
+{
+    start_test shared
+
+    _get_mount $SCRATCH_DEV $mpA
+    mkdir $mpA/mnt1
+    mount --make-shared $mpA
+    _get_mount --bind $mpA $mpB
+    _get_mount --bind $mpA $mpC
+    mount --make-slave $mpB
+    mount --make-slave $mpC
+    _get_mount $SCRATCH_DEV $mpA/mnt1
+    mkdir $mpA/mnt1/mnt2
+
+    _get_mount $SCRATCH_DEV $mpB/mnt1/mnt2
+    find_mnt
+    fs_stress $mpB/mnt1/mnt2
+
+    end_test
+    echo "crash test passed"
+}
+
+crash_test
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/411.out b/tests/generic/411.out
new file mode 100644
index 00000000..16dadaf2
--- /dev/null
+++ b/tests/generic/411.out
@@ -0,0 +1,12 @@
+QA output created by 411
+------
+TEST_DIR/411 SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/mnt1 SCRATCH_DEV
+mpB SCRATCH_DEV
+mpB/mnt1 SCRATCH_DEV
+mpB/mnt1/mnt2 SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/mnt1 SCRATCH_DEV
+======
+crash test passed
diff --git a/tests/generic/group b/tests/generic/group
index 0f9e3b35..fcb4b062 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -413,3 +413,4 @@
 408 auto quick clone dedupe metadata
 409 auto quick mount
 410 auto quick mount
+411 auto quick mount
-- 
2.11.0.rc0.7.gbe5a750

