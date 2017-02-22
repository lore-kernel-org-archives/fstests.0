Received: from cn.fujitsu.com ([59.151.112.132]:41526 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754345AbdBVIRZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2017 03:17:25 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] shared/005,7: fix making sure debugfs sets negative i_size
Date: Wed, 22 Feb 2017 16:17:03 +0800
Message-ID: <1487751423-2310-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170222065347.GW24562@eguan.usersys.redhat.com>
References: <20170222065347.GW24562@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

If the kernel bug has been fixed, stat command fails to get i_size
and reports "Structure needs cleaning".  So we use debugfs -R "stat"
instead of stat command to make sure debugfs sets negative i_size.
These cases have been broken by commit 0e13e40b247a1 ("shared/005,7:
make sure debugfs sets negative i_size").

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/shared/005 | 9 +++------
 tests/shared/007 | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/tests/shared/005 b/tests/shared/005
index 76c551c..de7b84f 100755
--- a/tests/shared/005
+++ b/tests/shared/005
@@ -65,15 +65,12 @@ echo "Corrupt filesystem"
 _scratch_unmount
 $DEBUGFS_PROG -w -R "sif /a size -1" $SCRATCH_DEV >> $seqres.full 2>&1
 
-echo "Remount, try to append"
-_scratch_mount
-
 # check whether debugfs succeeds to set i_size to -1 or not
-i_size=$(stat -c "%s" $testdir/a)
-if [ $i_size -ne -1 ]; then
+$DEBUGFS_PROG -R "stat /a" $SCRATCH_DEV 2>&1 | grep -q "Size: 18446744073709551615" || \
 	_notrun "Could not set i_size to -1 successfully, skip test."
-fi
 
+echo "Remount, try to append"
+_scratch_mount
 dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
 sync
 
diff --git a/tests/shared/007 b/tests/shared/007
index 77636f4..785f19f 100755
--- a/tests/shared/007
+++ b/tests/shared/007
@@ -67,15 +67,12 @@ _scratch_unmount
 # -1 so that we can perform a dio write.
 $DEBUGFS_PROG -w -R "sif /a size 0xFFFFFFFFFFFFFE00" $SCRATCH_DEV >> $seqres.full 2>&1
 
-echo "Remount, try to append"
-_scratch_mount
-
 # check whether debugfs succeeds to set i_size to -512 or not
-i_size=$(stat -c "%s" $testdir/a)
-if [ $i_size -ne -512 ]; then
+$DEBUGFS_PROG -R "stat /a" $SCRATCH_DEV 2>&1 | grep -q "Size: 18446744073709551104" || \
 	_notrun "Could not set i_size to -512 successfully, skip test."
-fi
 
+echo "Remount, try to append"
+_scratch_mount
 dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=direct,append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
 sync
 
-- 
1.8.3.1



