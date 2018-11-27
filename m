Received: from mail.cn.fujitsu.com ([183.91.158.132]:59531 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727684AbeK0RcC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Nov 2018 12:32:02 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/111: Filter a "Structure needs cleaning" error from xfs_fsr
Date: Tue, 27 Nov 2018 13:56:15 +0800
Message-ID: <1543298175-5405-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

on upstream kernel, running xfs/111 got the following error:
-------------------------------------------------
+xfs_fsr: xfs_bulkstat: Structure needs cleaning
-------------------------------------------------

Since kernel commit 29cad0b, we don't convert a -EFSCORRUPTED error
to -EINVAL in xfs_imap_to_bp() if we are doing an untrusted lookup.
So xfs_bulkstat() called by xfs_fsr command fails and returns
EFSCORRUPTED.  We think it is reasonable for xfs_fsr to report
EFSCORRUPTED because some inodes are actually corrupted.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/111 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/111 b/tests/xfs/111
index 2ef69f0..2bcf002 100755
--- a/tests/xfs/111
+++ b/tests/xfs/111
@@ -58,7 +58,8 @@ _try_scratch_mount || _fail "Couldn't mount after itrash"
 
 echo Attempting bulkstat
 #src/bstat -q $SCRATCH_MNT
-$XFS_FSR_PROG $SCRATCH_MNT | _filter_scratch
+#Since kernel commit 29cad0b, xfs_fsr reports a "Structure needs cleaning" error
+$XFS_FSR_PROG $SCRATCH_MNT | _filter_scratch | grep -v "Structure needs cleaning"
 
 # Fix up intentional corruption so test can pass
 _scratch_unmount
-- 
1.8.3.1
