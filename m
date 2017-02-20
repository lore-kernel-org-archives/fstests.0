Received: from cn.fujitsu.com ([59.151.112.132]:18860 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750920AbdBTJi6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Feb 2017 04:38:58 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/133,4: make sure xfs_db sets negative i_size && add strict check for dd
Date: Mon, 20 Feb 2017 17:37:45 +0800
Message-ID: <1487583465-17572-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170220023646.GG24562@eguan.usersys.redhat.com>
References: <20170220023646.GG24562@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) xfs/133 and xfs/134 work abnornamlly on RHEL6.8GA and RHEL6.9Beta
   because xfs_db fails to set i_size to -1 or -512 and reports "usage:
   write fieldname value".  The special argument "--" is only used to
   end option-scanning in getopt().  So we should add "--" for write
   command in xfs_db when -c option is supported by write command.
   getopt() has been produced by 'commit c9f5e3db22098 ("xfs_db: Allow
   writes of corrupted data")'.

2) When xfs_db fails to set a negative i_size due to unknown error, we can
   skip these cases which don't trigger the kernel bug.

3) xfs/134 passes unexpectedly on RHEL7.3GA due to no space left on device,
   So we can add strict check.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/133 | 20 ++++++++++++++++++--
 tests/xfs/134 | 23 +++++++++++++++++++----
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/tests/xfs/133 b/tests/xfs/133
index d756d2e..0d7587e 100755
--- a/tests/xfs/133
+++ b/tests/xfs/133
@@ -63,11 +63,27 @@ inum=$(stat -c "%i" $testdir/a)
 
 echo "Corrupt filesystem"
 _scratch_unmount
-_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -1' >> $seqres.full
+
+# 1) we should add "--" for write command in xfs_db when -c option is
+#    supported by write command.
+# 2) check whether xfs_db succeeds to set i_size to -1 or not
+_scratch_xfs_db -x -c "help" | grep -q "write \[-c\]"
+if [ $? -eq 0 ]; then
+	_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -1' >> $seqres.full 2>&1 || \
+	_notrun "Could not set i_size to -1 successfully, skip test."
+else
+	_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -1' >> $seqres.full 2>&1 || \
+	_notrun "Could not set i_size to -1 successfully, skip test."
+fi
 
 echo "Remount, try to append"
 _scratch_mount
-dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
+
+# dd may fail unexpectedly(eg. no space left on device), So we add strict check.
+dd_out=$(dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=append conv=notrunc 2>&1)
+echo $dd_out | grep -q "Structure needs cleaning" && echo "Write did not succeed (ok)."
+echo $dd_out >> $seqres.full
+
 sync
 
 # success, all done
diff --git a/tests/xfs/134 b/tests/xfs/134
index 09466cd..d6d2dec 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -63,13 +63,28 @@ inum=$(stat -c "%i" $testdir/a)
 
 echo "Corrupt filesystem"
 _scratch_unmount
-# Set the file size to the highest multiple of 512 below
-# -1 so that we can perform a dio write.
-_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -512' >> $seqres.full
+
+# 1) Set the file size to the highest multiple of 512 below -1 so
+#    that we can perform a dio write.
+# 2) we should add "--" for write command in xfs_db when -c option is
+#    supported by write command.
+# 3) check whether xfs_db succeeds to set i_size to -512 or not
+_scratch_xfs_db -x -c "help" | grep -q "write \[-c\]"
+if [ $? -eq 0 ]; then
+	_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -512' >> $seqres.full 2>&1 || \
+	_notrun "Could not set i_size to -512 successfully, skip test."
+else
+	_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -512' >> $seqres.full 2>&1 || \
+	_notrun "Could not set i_size to -512 successfully, skip test."
+fi
 
 echo "Remount, try to append"
 _scratch_mount
-dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=direct,append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
+
+# dd may fail unexpectedly(eg. no space left on device), So we add strict check.
+dd_out=$(dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=direct,append conv=notrunc 2>&1)
+echo $dd_out | grep -q "Structure needs cleaning" && echo "Write did not succeed (ok)."
+echo $dd_out >> $seqres.full
 sync
 
 # success, all done
-- 
1.8.3.1



