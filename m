Received: from mx1.redhat.com ([209.132.183.28]:57798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932579AbbGVIWa (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 22 Jul 2015 04:22:30 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id BD64C2F8101
	for <fstests@vger.kernel.org>; Wed, 22 Jul 2015 08:22:30 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/078: omit -m crc=0 mkfs option if mkfs.xfs has no meta support
Date: Wed, 22 Jul 2015 16:22:16 +0800
Message-Id: <1437553336-30408-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

This basically does the same as in commit

90a3bfc xfs: be compatible with older mkfs.xfs which has no v5 support

which left xfs/078 behind.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/078 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/078 b/tests/xfs/078
index 32436f7..0d6eb55 100755
--- a/tests/xfs/078
+++ b/tests/xfs/078
@@ -87,7 +87,11 @@ _grow_loop()
 	echo
 
 	echo "*** mkfs loop file (size=$original)"
-	$MKFS_XFS_PROG -m crc=0 -b size=$bsize -d $dparam \
+	mkfs_crc_opts="-m crc=0"
+	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
+		mkfs_crc_opts=""
+	fi
+	$MKFS_XFS_PROG $mkfs_crc_opts -b size=$bsize -d $dparam \
 		| _filter_mkfs 2>/dev/null
 
 	echo "*** extend loop file"
-- 
2.4.3

