Received: from cn.fujitsu.com ([59.151.112.132]:37488 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754543AbdBVJdg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2017 04:33:36 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] xfs/133,4: make sure xfs_db sets negative i_size
Date: Wed, 22 Feb 2017 17:31:40 +0800
Message-ID: <1487755900-6083-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1487583465-17572-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1487583465-17572-1-git-send-email-yangx.jy@cn.fujitsu.com>
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

2) When xfs_db fails to set a negative i_size due to unknown error, we
   can skip these cases which don't trigger the kernel bug.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/133 | 13 ++++++++++++-
 tests/xfs/134 | 17 ++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/133 b/tests/xfs/133
index d756d2e..91b3b9b 100755
--- a/tests/xfs/133
+++ b/tests/xfs/133
@@ -63,7 +63,18 @@ inum=$(stat -c "%i" $testdir/a)
 
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
diff --git a/tests/xfs/134 b/tests/xfs/134
index 09466cd..788f8e9 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -63,9 +63,20 @@ inum=$(stat -c "%i" $testdir/a)
 
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
-- 
1.8.3.1



