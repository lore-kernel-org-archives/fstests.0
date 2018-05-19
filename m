Received: from mail.cn.fujitsu.com ([183.91.158.132]:60032 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750713AbeESEn7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 19 May 2018 00:43:59 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 4022241B31E4
        for <fstests@vger.kernel.org>; Sat, 19 May 2018 12:43:53 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/132: umount scratch device after finishing test
Date: Sat, 19 May 2018 12:32:24 +0800
Message-ID: <1526704344-19615-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

xfs/132 and xfs/133 running together got the following error:
------------------------------------------------------------
...
xfs/132 1s ... 1s
xfs/133 1s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//xfs/133.out.bad)
...
QA output created by 133
-Format and mount
-Corrupt filesystem
-Remount, try to append
-Write did not succeed (ok).
+SCRATCH_DEV=/dev/sda11 is mounted but not on SCRATCH_MNT=common/config: - aborting
+Already mounted result:
+/dev/sda11 /mnt/xfstests/scratch
...
------------------------------------------------------------

xfs/132 led to XFS shutdown due to the corrupted inode, but it didn't rectify XFS
by umount scratch device.  Subsequent xfs/133 got a wrong canonical mount point
path(i.e. SCRATCH_MNT='common/config: SCRATCH_MNT (/mnt/xfstests/scratch) is not a
directory') for $SCRATCH_DEV when calling _canonicalize_mountpoint in common/config,
and finally led to the failure of _check_mounted_on.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/132 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/xfs/132 b/tests/xfs/132
index 6bb03e7..960096f 100755
--- a/tests/xfs/132
+++ b/tests/xfs/132
@@ -68,6 +68,8 @@ _scratch_mount
 # The corrupt inode should be tripped over during these initial file creates.
 touch $SCRATCH_MNT/file{0,1,2,3,4,5}{0,1,2,3,4,5} 2>&1 | _filter_scratch
 
+_scratch_unmount
+
 # success, all done
 status=0
 exit
-- 
1.8.3.1



