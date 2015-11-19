Received: from cn.fujitsu.com ([59.151.112.132]:24061 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757362AbbKSIkB (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 19 Nov 2015 03:40:01 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id tAJ8dEkx013743
	for <fstests@vger.kernel.org>; Thu, 19 Nov 2015 16:39:14 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH v4] fstests: Make generic/081 and 108 run in old version of lvm
Date: Thu, 19 Nov 2015 16:38:08 +0800
Message-ID: <988846ee74aa4045c43465d954d05a385f02f683.1447922281.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

generic/081 and 108 fails in RHEL 6.3, like:
 # ./check generic/081
 FSTYP         -- btrfs
 PLATFORM      -- Linux/x86_64 kerneldev 4.2.0-rc5_HEAD_d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754_+
 MKFS_OPTIONS  -- /dev/vdd
 MOUNT_OPTIONS -- /dev/vdd /var/ltf/tester/scratch_mnt

 generic/081
 [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//generic/081.out.bad)
    --- tests/generic/081.out   2015-07-13 17:07:03.000000000 +0800
    +++ /var/lib/xfstests/results//generic/081.out.bad  2015-10-28 12:20:49.000000000 +0800
    @@ -1,2 +1,3 @@
     QA output created by 081
     Silence is golden
    +ERROR: checking status of /dev/mapper/vg_081-base_081: No such file or directory
 Ran: generic/081
 Failures: generic/081
 Failed 1 of 1 tests

Reason:
 Command of "lvm lvcreate --yes" failed because lvm in RHEL 6.3
 don't support '--yes' option.

 RHEL 6.3(without --yes option):
 # lvm version
   LVM version:     2.02.95(2)-RHEL6 (2012-05-16)
   Library version: 1.02.74-RHEL6 (2012-05-16)
   Driver version:  4.32.0
 # lvm lvcreate --yes --version
 lvcreate: unrecognized option '--yes'
   Error during parsing of command line.
 # echo $?
 3
 #

 RHEL 7.1(with --yes option):
 # lvm version
   LVM version:     2.02.115(2)-RHEL7 (2015-01-28)
   Library version: 1.02.93-RHEL7 (2015-01-28)
   Driver version:  4.33.0
 # lvm lvcreate --yes --version
   LVM version:     2.02.115(2)-RHEL7 (2015-01-28)
   Library version: 1.02.93-RHEL7 (2015-01-28)
   Driver version:  4.33.0
 # echo $?
 0
 #

 Fedora release 20(with --yes option):
 (Support --yes like RHEL 7.1, omit logs)
 lvm version: 2.02.106(2) (2014-04-10)

Fix:
 Use yes pipe instead '--yes' option for lvm, to make the command
 support both new and old version of lvm.

Changelog v3->v4:
 1: Update description of "Fix:" in patch comment.
    suggested by: Eryu Guan <eguan@redhat.com>
 2: Add fix of generic/108
    suggested by: Eryu Guan <eguan@redhat.com>
 3: Add comment of why using yes pipe in code.

Changelog v2->v3:
 Use unique way for old and new version of lvm, suggested-by:
 Dave Chinner <david@fromorbit.com>

Changelog v1->v2:
 Use yes pipe, suggested by: Eryu Guan <eguan@redhat.com>

Suggested-by: Dave Chinner <david@fromorbit.com>
Suggested-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 tests/generic/081 | 4 +++-
 tests/generic/108 | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/generic/081 b/tests/generic/081
index 8334ec9..11755d4 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -65,7 +65,9 @@ mkdir -p $mnt
 # lvm uses some space for metadata
 _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
-$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
+# We use yes pipe instead of 'lvcreate --yes' because old version of lvm
+# (like 2.02.95 in RHEL6) don't support --yes option
+yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
 # wait for lvcreation to fully complete
 $UDEV_SETTLE_PROG >>$seqres.full 2>&1
 
diff --git a/tests/generic/108 b/tests/generic/108
index ff3d3e6..cc8d703 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -72,7 +72,9 @@ echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
 # create striped volume with 4MB stripe size
 $LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
-$LVM_PROG lvcreate --yes -i 2 -I 4m -l 100%FREE -n $lvname $vgname \
+# We use yes pipe instead of 'lvcreate --yes' because old version of lvm
+# (like 2.02.95 in RHEL6) don't support --yes option
+yes | $LVM_PROG lvcreate -i 2 -I 4m -l 100%FREE -n $lvname $vgname \
 	>>$seqres.full 2>&1
 # wait for lv creation to fully complete
 $UDEV_SETTLE_PROG >>$seqres.full 2>&1
-- 
1.8.5.1

