Received: from mx1.redhat.com ([209.132.183.28]:39960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDHCae (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 7 Apr 2019 22:30:34 -0400
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH v3] common/rc: use _try_scratch_mount for scratch_remount
Date: Mon,  8 Apr 2019 10:30:29 +0800
Message-Id: <20190408023029.13135-1-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: smfrench@gmail.com, Xiaoli Feng <xifeng@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Xiaoli Feng <xifeng@redhat.com>

When call _scratch_remount for cifs , it always requires to input
password. This will make generic/306 generic/452 failed because
cifs remount failed.
---
 common/rc         | 2 +-
 tests/overlay/035 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 1c42515f..6c262e32 100644
--- a/common/rc
+++ b/common/rc
@@ -357,7 +357,7 @@ _scratch_remount()
     local opts="$1"
 
     if test -n "$opts"; then
-	mount -o "remount,$opts" $SCRATCH_MNT
+	_try_scratch_mount "-o remount,$opts"
     fi
 }
 
diff --git a/tests/overlay/035 b/tests/overlay/035
index f36c1e10..c0aae935 100755
--- a/tests/overlay/035
+++ b/tests/overlay/035
@@ -55,7 +55,7 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
 $MOUNT_PROG -t overlay -o"lowerdir=$lowerdir2:$lowerdir1" \
 			$OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
 touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
-_scratch_remount rw 2>&1 | _filter_ro_mount
+$MOUNT_PROG -o remount,rw $SCRATCH_MNT 2>&1 | _filter_ro_mount
 $UMOUNT_PROG $SCRATCH_MNT
 
 # Make workdir immutable to prevent workdir re-create on mount
-- 
2.18.1
