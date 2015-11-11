Received: from cn.fujitsu.com ([59.151.112.132]:48310 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751265AbbKKJ70 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 11 Nov 2015 04:59:26 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id tAB9wgEb013179
	for <fstests@vger.kernel.org>; Wed, 11 Nov 2015 17:58:42 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH v2] fstests: Make generic/081 run in old version of lvm
Date: Wed, 11 Nov 2015 17:57:33 +0800
Message-ID: <0b5bab871522166ec55727e234c56004098dbc77.1447235833.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

generic/081 failed in RHEL 6.3:
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
 Add a condition to to check if current lvm support --yes option,
 Tested in above RHEL 6.3 platform.

Changelog v1->v2:
 Use yes pipe, suggested by: Eryu Guan <eguan@redhat.com>

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 tests/generic/081 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/generic/081 b/tests/generic/081
index 8334ec9..1970075 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -65,7 +65,11 @@ mkdir -p $mnt
 # lvm uses some space for metadata
 _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
-$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
+if $LVM_PROG lvcreate --yes --version >>$seqres.full 2>&1; then
+	$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
+else
+	yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
+fi
 # wait for lvcreation to fully complete
 $UDEV_SETTLE_PROG >>$seqres.full 2>&1
 
-- 
1.8.5.1

