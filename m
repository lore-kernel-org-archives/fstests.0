Received: from mx1.redhat.com ([209.132.183.28]:52140 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbbHRRfO (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 18 Aug 2015 13:35:14 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 4B4F3345B25
	for <fstests@vger.kernel.org>; Tue, 18 Aug 2015 17:35:13 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] xfs: use -f option for xfs_repair a fs image
Date: Wed, 19 Aug 2015 01:35:05 +0800
Message-Id: <1439919305-6128-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfs/020 need -f option, or it'll be fail on 4k sector device.

Add -f option for xfs/032 for safe and better.

There're some cases use _check_xfs_filesystem(), or others
function which call this function to check a regular file.
That's will fail when the regular file on a 4k sector device.
For example xfs/250.

So I change _check_xfs_filesystem(), add -f option to xfs_repair,
when the $device is a file.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc     | 7 ++++++-
 tests/xfs/020 | 2 +-
 tests/xfs/032 | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 70d2fa8..a607391 100644
--- a/common/rc
+++ b/common/rc
@@ -1841,7 +1841,12 @@ _check_xfs_filesystem()
     fi
 
     extra_mount_options=""
+    extra_options=""
     device=$1
+    if [ -f $device ];then
+       extra_options="-f"
+    fi
+
     if [ "$2" != "none" ]; then
 	extra_log_options="-l$2"
         extra_mount_options="-ologdev=$2"
@@ -1897,7 +1902,7 @@ _check_xfs_filesystem()
         ok=0
     fi
 
-    $XFS_REPAIR_PROG -n $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
+    $XFS_REPAIR_PROG -n $extra_options $extra_log_options $extra_rt_options $device >$tmp.repair 2>&1
     if [ $? -ne 0 ]
     then
         echo "_check_xfs_filesystem: filesystem on $device is inconsistent (r) (see $seqres.full)"
diff --git a/tests/xfs/020 b/tests/xfs/020
index dc305c1..120492d 100755
--- a/tests/xfs/020
+++ b/tests/xfs/020
@@ -55,7 +55,7 @@ fsfile=$TEST_DIR/fsfile.$seq
 rm -f $fsfile
 
 $MKFS_PROG -t xfs -d size=60t,file,name=$fsfile >/dev/null
-$XFS_REPAIR_PROG -o ag_stride=32 -t 1 $fsfile >/dev/null 2>&1
+$XFS_REPAIR_PROG -f -o ag_stride=32 -t 1 $fsfile >/dev/null 2>&1
 
 status=$?
 exit
diff --git a/tests/xfs/032 b/tests/xfs/032
index a3fb89f..063f272 100755
--- a/tests/xfs/032
+++ b/tests/xfs/032
@@ -69,7 +69,7 @@ while [ $SECTORSIZE -le $PAGESIZE ]; do
 		$XFS_COPY_PROG -d $SCRATCH_DEV $IMGFILE >> $seqres.full 2>&1 || \
 			_fail "Copy failed for Sector size $SECTORSIZE Block size $BLOCKSIZE"
 		# Must use "-n" to get exit code; without it xfs_repair always returns 0
-		$XFS_REPAIR_PROG -n $IMGFILE >> $seqres.full 2>&1 || \
+		$XFS_REPAIR_PROG -n -f $IMGFILE >> $seqres.full 2>&1 || \
 			_fail "Copy corrupted for Sector size $SECTORSIZE Block size $BLOCKSIZE"
 
 		BLOCKSIZE=$(($BLOCKSIZE * 2));
-- 
1.9.3

