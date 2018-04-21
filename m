Received: from mail.cn.fujitsu.com ([183.91.158.132]:5536 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752809AbeDUDrQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Apr 2018 23:47:16 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 67FC34D0EFC7
        for <fstests@vger.kernel.org>; Sat, 21 Apr 2018 11:47:16 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/191: remove logarithm-based test
Date: Sat, 21 Apr 2018 11:36:22 +0800
Message-ID: <1524281782-18208-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Since commit 2cf637c in xfsprogs-dev, logarithm-based options
were removed, so it's unnecessary to test them.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/191-input-validation | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
index cff3efa..f3498a0 100755
--- a/tests/xfs/191-input-validation
+++ b/tests/xfs/191-input-validation
@@ -262,7 +262,6 @@ do_mkfs_fail -l version=0  $SCRATCH_DEV
 
 # naming section, should pass
 do_mkfs_pass -n size=65536 $SCRATCH_DEV
-do_mkfs_pass -n log=15 $SCRATCH_DEV
 do_mkfs_pass -n version=2 $SCRATCH_DEV
 do_mkfs_pass -n version=ci $SCRATCH_DEV
 do_mkfs_pass -n ftype=0 -m crc=0 $SCRATCH_DEV
@@ -309,7 +308,6 @@ do_mkfs_fail -r size=65536 $SCRATCH_DEV
 do_mkfs_pass -i size=256 -m crc=0 $SCRATCH_DEV
 do_mkfs_pass -i size=512 $SCRATCH_DEV
 do_mkfs_pass -i size=2048 $SCRATCH_DEV
-do_mkfs_pass -i log=10 $SCRATCH_DEV
 do_mkfs_pass -i perblock=2 $SCRATCH_DEV
 do_mkfs_pass -i maxpct=10 $SCRATCH_DEV
 do_mkfs_pass -i maxpct=100 $SCRATCH_DEV
-- 
1.8.3.1



