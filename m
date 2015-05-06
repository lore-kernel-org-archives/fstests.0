Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49402 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbbEFH6Y (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 6 May 2015 03:58:24 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t467wONH026313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 6 May 2015 03:58:24 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] generic/081: wait for lv to be settled before creating fs on it
Date: Wed,  6 May 2015 15:58:20 +0800
Message-Id: <1430899100-480-1-git-send-email-eguan@redhat.com>
In-Reply-To: <20150506073251.GF1187@dhcp-13-216.nay.redhat.com>
References: <20150506073251.GF1187@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Call 'udevadm settle' or 'udevsettle' or 'sleep 1' to make sure new lv
is ready for use before making filesystem on it, depends on which
command is available on the system.

Also remove fsync from xfs_io, as it may block snapshot from removal for
a while and leaves SCRATCH_DEV used by lvm after test.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v2:
- move UDEV_SETTLE_PROG setup code to common/config
- remove fsync from xfs_io command
- update comments a bit about waiting for lv creation

 common/config     | 18 ++++++++++++++++++
 tests/generic/081 |  4 +++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 3732287..b7991ed 100644
--- a/common/config
+++ b/common/config
@@ -192,6 +192,24 @@ export DUMP_PROG="`set_prog_path dump`"
 export RESTORE_PROG="`set_prog_path restore`"
 export LVM_PROG="`set_prog_path lvm`"
 
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
+export UDEV_SETTLE_PROG
+
 # Generate a comparable xfsprogs version number in the form of
 # major * 10000 + minor * 100 + release
 #
diff --git a/tests/generic/081 b/tests/generic/081
index 5d38c11..70029d4 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -66,6 +66,8 @@ mkdir -p $mnt
 _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
 $LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
+# wait for lvcreation to fully complete
+$UDEV_SETTLE_PROG >>$seqres.full 2>&1
 
 # _mkfs_dev exits the test on failure, this can make sure lv is created in
 # above vgcreate/lvcreate steps
@@ -78,7 +80,7 @@ $LVM_PROG lvcreate -s -L 4M -n $snapname $vgname/$lvname >>$seqres.full 2>&1 ||
 _mount /dev/mapper/$vgname-$snapname $mnt
 
 # write 5M data to the snapshot
-$XFS_IO_PROG -fc "pwrite 0 5m" -c fsync $mnt/testfile >>$seqres.full 2>&1
+$XFS_IO_PROG -fc "pwrite 0 5m" $mnt/testfile >>$seqres.full 2>&1
 
 # _check_dmesg will check for WARNINGs/BUGs in dmesg
 status=0
-- 
2.1.0

