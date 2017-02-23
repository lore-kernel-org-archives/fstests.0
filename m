Received: from cn.fujitsu.com ([59.151.112.132]:4907 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750837AbdBWDgI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2017 22:36:08 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3] xfs/133,4: make sure xfs_db sets negative i_size
Date: Thu, 23 Feb 2017 11:35:30 +0800
Message-ID: <1487820930-18007-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170222104944.GX24562@eguan.usersys.redhat.com>
References: <20170222104944.GX24562@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) xfs/133 and xfs/134 work abnornamlly on RHEL6.8GA and RHEL6.9Beta
   because xfs_db fails to set negative i_size and reports "usage:
   write fieldname value".  The special argument "--" is only used to
   end option-scanning in getopt().  So we can run two xfs_db commands
   to set negative i_size regardless of the special argument "--" is
   needed or not.  getopt() has been produced by 'commit c9f5e3db22098
   ("xfs_db: Allow writes of corrupted data")'.

2) xfs/134 passes unexpectedly on RHEL6.8GA due to EINVAL, so we use
   touch command to create 512-aligned test file.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/133 | 12 +++++++++++-
 tests/xfs/134 | 19 +++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/tests/xfs/133 b/tests/xfs/133
index d756d2e..ff73a41 100755
--- a/tests/xfs/133
+++ b/tests/xfs/133
@@ -63,7 +63,17 @@ inum=$(stat -c "%i" $testdir/a)
 
 echo "Corrupt filesystem"
 _scratch_unmount
-_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -1' >> $seqres.full
+
+# run two xfs_db commands to set core.size regardless of the special argument "--"
+# is needed or not.
+_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -1' >> $seqres.full 2>&1
+_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -1' >> $seqres.full 2>&1
+
+# check core.size and _notrun if it's not set correctly
+i_size=`_scratch_xfs_db -c "inode ${inum}" -c "print core.size" | $AWK_PROG '{print $3}'`
+if [ $i_size -ne -1 ]; then
+	_notrun "Could not set i_size to -1 successfully, skip test."
+fi
 
 echo "Remount, try to append"
 _scratch_mount
diff --git a/tests/xfs/134 b/tests/xfs/134
index 09466cd..f064476 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -58,14 +58,25 @@ _scratch_mkfs  >> $seqres.full 2>&1
 _scratch_mount
 
 testdir=$SCRATCH_MNT
-echo m > $testdir/a
+# make sure the write offset is 512-aligned
+touch $testdir/a
 inum=$(stat -c "%i" $testdir/a)
 
 echo "Corrupt filesystem"
 _scratch_unmount
-# Set the file size to the highest multiple of 512 below
-# -1 so that we can perform a dio write.
-_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -512' >> $seqres.full
+
+# 1) Set the file size to the highest multiple of 512 below -1 so
+#    that we can perform a dio write.
+# 2) run two xfs_db commands to set core.size regardless of the special
+#    argument "--" is needed or not.
+_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -- -512' >> $seqres.full 2>&1
+_scratch_xfs_db -x -c "inode ${inum}" -c 'write core.size -512' >> $seqres.full 2>&1
+
+# check core.size and _notrun if it's not set correctly
+i_size=`_scratch_xfs_db -c "inode ${inum}" -c "print core.size" | $AWK_PROG '{print $3}'`
+if [ $i_size -ne -512 ]; then
+	_notrun "Could not set i_size to -512 successfully, skip test."
+fi
 
 echo "Remount, try to append"
 _scratch_mount
-- 
1.8.3.1



