Received: from mx1.redhat.com ([209.132.183.28]:52885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbbJ3Ddt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 29 Oct 2015 23:33:49 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id C38038E371
	for <fstests@vger.kernel.org>; Fri, 30 Oct 2015 03:33:49 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH] generic/312: fix dev_blocks calculation
Date: Fri, 30 Oct 2015 11:33:22 +0800
Message-Id: <1446176002-6496-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

By adding -w option to grep.

Current calculation fails when there are many same type of devices
with the testing device, eg sda1 sda2 ... sda10, sda11, sda12 ..
$(grep sda1 /proc/partitions) gets multiple numbers.

Hit this when testing on CONFIG_BLOCK_DEV_RAM devices:

export TEST_DEV=/dev/ram0
export TEST_DIR=/daxmnt
export SCRATCH_DEV=/dev/ram1
export SCRATCH_MNT=/daxsch

FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 hp-dl385g7-01 4.3.0-rc6
MKFS_OPTIONS  -- /dev/ram1
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:nfs_t:s0 /dev/ram1 /daxsch

generic/312	 - output mismatch (see /root/xfstests/results//generic/312.out.bad)
    --- tests/generic/312.out	2015-10-29 16:39:54.592790608 +0800
    +++ /root/xfstests/results//generic/312.out.bad	2015-10-30 11:14:39.543212734 +0800
    @@ -1,2 +1,3 @@
     QA output created by 312
    +./tests/generic/312: line 56: [: too many arguments
     Silence is golden
    ...

Adding some debug options, we got this in 312.out.bad:

QA output created by 312
++ /usr/bin/awk '{print $3}'
+++ _short_dev /dev/ram1
+++++ _real_dev /dev/ram1
+++++ local _dev=/dev/ram1
+++++ '[' -b /dev/ram1 ']'
+++++ '[' -L /dev/ram1 ']'
+++++ echo /dev/ram1
++++ basename /dev/ram1
+++ echo ram1
++ grep ram1 /proc/partitions
+ dev_blocks='10485760
10485760
10485760
10485760
10485760
10485760
10485760'
+ set +x
./tests/generic/312: line 58: [: too many arguments

$ grep ram1 /proc/partitions
   1        1   10485760 ram1
   1       10   10485760 ram10
   1       11   10485760 ram11
   1       12   10485760 ram12
   1       13   10485760 ram13
   1       14   10485760 ram14
   1       15   10485760 ram15
$ grep -w ram1 /proc/partitions
   1        1   10485760 ram1

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 tests/generic/312 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/312 b/tests/generic/312
index b035978..b570814 100755
--- a/tests/generic/312
+++ b/tests/generic/312
@@ -52,7 +52,7 @@ _require_scratch
 # 5G in byte
 fssize=$((2**30 * 5))
 required_blocks=$(($fssize / 1024))
-dev_blocks=$(grep $(_short_dev $SCRATCH_DEV) /proc/partitions | $AWK_PROG '{print $3}')
+dev_blocks=$(grep -w $(_short_dev $SCRATCH_DEV) /proc/partitions | $AWK_PROG '{print $3}')
 if [ $required_blocks -gt $dev_blocks ];then
 	_notrun "this test requires \$SCRATCH_DEV has ${fssize}B space"
 fi
-- 
2.4.3

