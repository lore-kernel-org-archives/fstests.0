Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46896 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbbCTKR1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 06:17:27 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2KAHQcd014681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 06:17:27 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/9 RESEND] generic: test some mount/umount corner cases
Date: Fri, 20 Mar 2015 18:16:50 +0800
Message-Id: <1426846618-23413-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1426846618-23413-1-git-send-email-eguan@redhat.com>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

There're six test cases:
 - mount at a nonexistent mount point
 - mount a free loop device
 - mount with a wrong fs type
 - umount an symlink to device which is not mounted
 - umount a path with too long name
 - lazy umount a symlink

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/067     | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/067.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 146 insertions(+)
 create mode 100755 tests/generic/067
 create mode 100644 tests/generic/067.out

diff --git a/tests/generic/067 b/tests/generic/067
new file mode 100755
index 0000000..7a4840b
--- /dev/null
+++ b/tests/generic/067
@@ -0,0 +1,143 @@
+#! /bin/bash
+# FS QA Test No. 067
+#
+# Some random mount/umount corner case tests
+#
+# - mount at a nonexistent mount point
+# - mount a free loop device
+# - mount with a wrong fs type specified
+# - umount an symlink to device which is not mounted
+# - umount a path with too long name
+# - lazy umount a symlink
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
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch
+_require_loop
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+
+# kernel should not hang nor oops when mounting fs to nonexistent mount point
+mount_nonexistent_mnt()
+{
+	echo "# mount to nonexistent mount point" >>$seqres.full
+	rm -rf $TEST_DIR/nosuchdir
+	$MOUNT_PROG $SCRATCH_DEV $TEST_DIR/nosuchdir >>$seqres.full 2>&1
+}
+
+# fs driver should be able to handle mounting a free loop device gracefully
+# xfs ever hung, "ec53d1d xfs: don't block on buffer read errors" fixed it
+mount_free_loopdev()
+{
+	echo "# mount a free loop device" >>$seqres.full
+	loopdev=`losetup -f`
+	$MOUNT_PROG -t $FSTYP $loopdev $SCRATCH_MNT >>$seqres.full 2>&1
+}
+
+# mount with wrong fs type specified.
+# This should fail gracefully, no hang no oops are expected
+mount_wrong_fstype()
+{
+	local fs=ext4
+	if [ "$FSTYP" == "ext4" ]; then
+		fs=xfs
+	fi
+	echo "# mount with wrong fs type" >>$seqres.full
+	$MOUNT_PROG -t $fs $SCRATCH_DEV $SCRATCH_MNT >>$seqres.full 2>&1
+}
+
+# umount a symlink to device, which is not mounted.
+# This should fail gracefully, no hang no oops are expected
+umount_symlink_device()
+{
+	local symlink=$TEST_DIR/$seq.scratch_dev_symlink
+	rm -f $symlink
+	echo "# umount symlink to device, which is not mounted" >>$seqres.full
+	ln -s $SCRATCH_DEV $symlink
+	$UMOUNT_PROG $symlink >>$seqres.full 2>&1
+}
+
+# umount a path name that is 256 bytes long, this should fail gracefully,
+# and the following umount should not hang nor oops
+umount_toolong_name()
+{
+	local longname=$SCRATCH_MNT/`$PERL_PROG -e 'print "a"x256;'`
+
+	_scratch_mount 2>&1 | tee -a $seqres.full
+
+	echo "# umount a too-long name" >>$seqres.full
+	$UMOUNT_PROG $longname >>$seqres.full 2>&1
+	_scratch_unmount 2>&1 | tee -a $seqres.full
+}
+
+# lazy umount a symlink should not block following umount.
+# This is the test case described in https://lkml.org/lkml/2014/7/21/98
+lazy_umount_symlink()
+{
+	local symlink=$SCRATCH_MNT/$seq.testdir_symlink
+	echo "# lazy umount a symlink" >>$seqres.full
+	_scratch_mount 2>&1 | tee -a $seqres.full
+	mkdir -p $SCRATCH_MNT/testdir
+	rm -f $symlink
+	ln -s $SCRATCH_MNT/testdir $symlink
+
+	$UMOUNT_PROG -l $symlink >>$seqres.full 2>&1
+	# umount $SCRATCH_MNT should not be blocked
+	_scratch_unmount 2>&1 | tee -a $seqres.full
+}
+
+echo "Silence is golden"
+
+mount_nonexistent_mnt
+mount_free_loopdev
+mount_wrong_fstype
+
+umount_symlink_device
+umount_toolong_name
+lazy_umount_symlink
+
+status=0
+exit
diff --git a/tests/generic/067.out b/tests/generic/067.out
new file mode 100644
index 0000000..daa1545
--- /dev/null
+++ b/tests/generic/067.out
@@ -0,0 +1,2 @@
+QA output created by 067
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index d56d3ce..03ad7b8 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -69,6 +69,7 @@
 064 auto quick prealloc
 065 metadata auto quick
 066 metadata auto quick
+067 auto quick mount
 068 other auto freeze dangerous stress
 069 rw udf auto quick
 070 attr udf auto quick stress
-- 
2.1.0

