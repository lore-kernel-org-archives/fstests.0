Received: from [183.91.158.132] ([183.91.158.132]:32871 "EHLO
        heian.cn.fujitsu.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752370AbdHCMF2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Aug 2017 08:05:28 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id D43A14724E4F
        for <fstests@vger.kernel.org>; Thu,  3 Aug 2017 20:05:19 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/424: add check for crc and finobt
Date: Thu, 3 Aug 2017 20:05:14 +0800
Message-ID: <1501761914-16445-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) When crc is not supported or disabled, this case could not indicate
   any expected error.  Running all tests without crc makes no sense.

2) When finobt is disabled, xfs_db fails to get current address of
   free_root, as below:
   xfs_db -c "agi" -c "addr free_root" -c "daddr" /dev/sda11
   Metadata CRC error detected at xfs_inobt block 0x0/0x1000
   ...
   Running related tests without finobt makes no sense.

We add check to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/xfs/424 | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/424 b/tests/xfs/424
index 0a1eef9..165c390 100755
--- a/tests/xfs/424
+++ b/tests/xfs/424
@@ -55,9 +55,15 @@ rm -f $seqres.full
 _supported_os Linux
 _supported_fs xfs
 _require_scratch
+_require_xfs_mkfs_crc
 
 echo "Silence is golden."
 
+crc_finobt_enabled="crc=1,finobt=0"
+
+[ _scratch_mkfs_xfs_supported -m crc=1,finobt=1 >/dev/null 2>&1 ] && \
+	crc_finobt_enabled="crc=1,finobt=1"
+
 # real QA test starts here
 
 # for different sector sizes, ensure no CRC errors are falsely reported.
@@ -77,7 +83,7 @@ while [ $sec_sz -le 4096 ]; do
 done
 
 for SECTOR_SIZE in $sector_sizes; do
-	$MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
+	$MKFS_XFS_PROG -f -m "$crc_finobt_enabled" -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
 
 	for TYPE in agf agi agfl sb; do
 		DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | filter_dbval`
@@ -96,9 +102,11 @@ for SECTOR_SIZE in $sector_sizes; do
 	DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" |
 		filter_dbval`
 	_scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
-	DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
-		filter_dbval`
-	_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
+	if [[ "$crc_finobt_enabled" =~ 'finobt=1' ]]; then
+		DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
+			filter_dbval`
+		_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
+	fi
 
 	_scratch_xfs_db -c "daddr $DADDR" -c "type text"
 	_scratch_xfs_db -c "daddr $DADDR" -c "type data"
-- 
1.8.3.1



