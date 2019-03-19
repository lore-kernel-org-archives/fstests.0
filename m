Received: from mail.cn.fujitsu.com ([183.91.158.132]:37997 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbfCSH3Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Mar 2019 03:29:16 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 35A144CD4477
        for <fstests@vger.kernel.org>; Tue, 19 Mar 2019 15:28:47 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/010: Accept the inconsistencies of sparse records
Date: Tue, 19 Mar 2019 15:28:53 +0800
Message-ID: <1552980533-2138-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

If sparse inode is enabled, running xfs/010 gets the following error:
-----------------------------------------------------
+invalid inode count, AGNO/INO, count 0 ninodes 64
 finobt record with no free inodes, AGNO/INO
+invalid inode count, AGNO/INO, count 0 ninodes 64
-----------------------------------------------------

We corrupt finobt records forcely, so it's reasonable for repair
to detect the inconsistencies of sparse records if sparse inode
is enabled.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/010 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/010 b/tests/xfs/010
index e220a65..69c019b 100755
--- a/tests/xfs/010
+++ b/tests/xfs/010
@@ -106,8 +106,10 @@ _scratch_unmount
 # corrupt some finobt records
 _corrupt_finobt_records $SCRATCH_DEV
 
-# repair should detect the inconsistencies
-_scratch_xfs_repair 2>&1 | _filter_repair
+# repair should detect the inconsistencies of finobt records
+# repair can also detect the inconsistencies of sparse records if
+# sparse inode is enabled, so accept both of outputs by filtering it.
+_scratch_xfs_repair 2>&1 | _filter_repair | sed -e '/invalid inode count, AGNO\/INO/d'
 _check_scratch_fs
 
 # nuke the finobt root, repair will have to regenerate from the inobt
-- 
1.8.3.1
