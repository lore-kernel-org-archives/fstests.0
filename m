Received: from mx1.redhat.com ([209.132.183.28]:50063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932281AbcETOAc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 May 2016 10:00:32 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3B48C04D2FA
	for <fstests@vger.kernel.org>; Fri, 20 May 2016 14:00:31 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 4/4] generic/355: new case test two vfsmount no peers
Date: Fri, 20 May 2016 22:00:14 +0800
Message-Id: <1463752814-3049-4-git-send-email-zlang@redhat.com>
In-Reply-To: <1463752814-3049-1-git-send-email-zlang@redhat.com>
References: <1463752814-3049-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

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
---
 tests/generic/355     | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/355.out |  12 +++++
 tests/generic/group   |   1 +
 3 files changed, 159 insertions(+)
 create mode 100755 tests/generic/355
 create mode 100644 tests/generic/355.out

diff --git a/tests/generic/355 b/tests/generic/355
new file mode 100755
index 0000000..7317d04
--- /dev/null
+++ b/tests/generic/355
@@ -0,0 +1,146 @@
+#! /bin/bash
+# FS QA Test 355
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
diff --git a/tests/generic/355.out b/tests/generic/355.out
new file mode 100644
index 0000000..af781f3
--- /dev/null
+++ b/tests/generic/355.out
@@ -0,0 +1,12 @@
+QA output created by 355
+------
+TEST_DIR/355 SCRATCH_DEV
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
index 245cb84..a67f7fb 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -357,3 +357,4 @@
 352 auto quick
 353 auto quick mount
 354 auto quick mount
+355 auto quick mount
-- 
2.5.5

