Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34837 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbbDCJmg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 3 Apr 2015 05:42:36 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 5A76E8EA30
	for <fstests@vger.kernel.org>; Fri,  3 Apr 2015 09:42:36 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/081: wait for lv to be settled before creating fs on it
Date: Fri,  3 Apr 2015 17:41:15 +0800
Message-Id: <1428054075-20780-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Call 'udevadm settle' or 'udevsettle' or 'sleep 1' to make sure new lv
is ready for use before making filesystem on it, depends on which
command is available on the system.

Also sleep 1 before removing the test vg, as the snapshot may block the
test vg from removal for a while.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/081 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/generic/081 b/tests/generic/081
index e242c4c..8e1828b 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -36,6 +36,9 @@ _cleanup()
 	rm -f $tmp.*
 	# lvm may have umounted it on I/O error, but in case it does not
 	$UMOUNT_PROG $mnt >/dev/null 2>&1
+	# fsync from xfs_io pins the snapshot in use for a while and blocks
+	# vgremove, sleep 1 to avoid such failure
+	sleep 1
 	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
 	$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
 }
@@ -62,11 +65,30 @@ snapname=snap_$seq
 mnt=$TEST_DIR/mnt_$seq
 mkdir -p $mnt
 
+# use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
+# newer systems have udevadm command but older systems like RHEL5 don't.
+# But if neither one is available, just set it to "sleep 1" to wait for lv to
+# be settled
+UDEV_SETTLE_PROG="`set_prog_path udevadm`"
+if [ "$UDEV_SETTLE_PROG" == "" ]; then
+	# try udevsettle command
+	UDEV_SETTLE_PROG="`set_prog_path udevsettle`"
+else
+	# udevadm is available, add 'settle' as subcommand
+	UDEV_SETTLE_PROG="$UDEV_SETTLE_PROG settle"
+fi
+# neither command is available, use sleep 1
+if [ "$UDEV_SETTLE_PROG" == "" ]; then
+	UDEV_SETTLE_PROG="sleep 1"
+fi
+
 # make sure there's enough disk space for 256M lv, test for 300M here in case
 # lvm uses some space for metadata
 _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
 $LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
+# wait for lv to be settled
+$UDEV_SETTLE_PROG >>$seqres.full 2>&1
 
 # _mkfs_dev exits the test on failure, this can make sure lv is created in
 # above vgcreate/lvcreate steps
-- 
1.8.3.1

