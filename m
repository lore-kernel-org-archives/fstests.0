Received: from [183.91.158.132] ([183.91.158.132]:51556 "EHLO
        heian.cn.fujitsu.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751274AbdHDHJB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Aug 2017 03:09:01 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] xfs/424: add check for finobt && update comments
Date: Fri, 4 Aug 2017 15:08:45 +0800
Message-ID: <1501830525-779-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <829dce2e-162c-4ad7-98e9-1a8a9ecb102b@sandeen.net>
References: <829dce2e-162c-4ad7-98e9-1a8a9ecb102b@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: sandeen@sandeen.net
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) This test can check if setting types causes error regardless of
   supporting crc, so we can update existed comments about it.  We
   also add new comments about known issues triggered in this test.

2) When finobt is disabled, xfs_db fails to get current address of
   free_root, as below:
   xfs_db -c "agi" -c "addr free_root" -c "daddr" /dev/sda11
   Metadata CRC error detected at xfs_inobt block 0x0/0x1000
   ...
   Running related tests without finobt makes no sense, so we add
   check for finobt.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/424 | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tests/xfs/424 b/tests/xfs/424
index 0a1eef9..41180d8 100755
--- a/tests/xfs/424
+++ b/tests/xfs/424
@@ -1,11 +1,19 @@
 #! /bin/bash
 # FS QA Test 424
 #
-# xfs_db should take type size into account when setting type.
-# If type size isn't updated whenever type is set, a false crc
-# error can occur due to the stale size. This test checks for
-# that false crc error.
+# This case checks if setting type causes error.
 #
+# On crc filesystems, xfs_db doesn't take sector size into account
+# when setting type, and this can result in an errant crc.
+# This issue has been fixed in xfsprogs-dev:
+# '55f224b ("xfs_db: update buffer size when new type is set")'
+#
+# On crc filesystems, when setting the type to "inode" the verifier
+# validates multiple inodes in the current fs block, so setting the
+# buffer size to that of just one inode is not sufficient and it'll
+# emit spurious verifier errors for all but the first.
+# This issue has been fixed in xfsprogs-dev:
+# '533d1d2 ("xfs_db: properly set inode type")'
 #-----------------------------------------------------------------------
 # Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
 #
@@ -77,7 +85,9 @@ while [ $sec_sz -le 4096 ]; do
 done
 
 for SECTOR_SIZE in $sector_sizes; do
-	$MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
+	finobt_enabled=0
+	$MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV | \
+		grep -q 'finobt=1' && finobt_enabled=1
 
 	for TYPE in agf agi agfl sb; do
 		DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | filter_dbval`
@@ -96,9 +106,11 @@ for SECTOR_SIZE in $sector_sizes; do
 	DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" |
 		filter_dbval`
 	_scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
-	DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
-		filter_dbval`
-	_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
+	if [ $finobt_enabled -eq 1 ]; then
+		DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
+			filter_dbval`
+		_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
+	fi
 
 	_scratch_xfs_db -c "daddr $DADDR" -c "type text"
 	_scratch_xfs_db -c "daddr $DADDR" -c "type data"
-- 
1.8.3.1



