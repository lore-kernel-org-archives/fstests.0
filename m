Received: from mx1.redhat.com ([209.132.183.28]:59503 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbcFLH5l (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 12 Jun 2016 03:57:41 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E6023CEF6E
	for <fstests@vger.kernel.org>; Sun, 12 Jun 2016 07:57:40 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common/rc: ignore MKFS_OPTIONS in _scratch_mkfs_xfs_supported()
Date: Sun, 12 Jun 2016 15:57:09 +0800
Message-Id: <1465718229-19485-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

In recent mkfs updates in xfsprogs, commit 9090e187bc3e ("mkfs: add
respecification detection to generic parsing") added re-specification
detection to "-m" option, it causes several tests _notrun if
MKFS_OPTIONS has the same options as those being tested in
_scratch_mkfs_xfs_supported(), because they're specified multiple times.

	MKFS_OPTIONS="-m crc=0" ./check xfs/001
	xfs/001 3s ... [not run] mkfs.xfs doesn't have crc feature

Fix it by removing MKFS_OPTIONS when testing mkfs features in
_scratch_mkfs_xfs_supported(), only $mkfs_opts matters.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 51092a0..c7a7667 100644
--- a/common/rc
+++ b/common/rc
@@ -477,7 +477,7 @@ _scratch_mkfs_xfs_supported()
 
 	_scratch_options mkfs
 
-	$MKFS_XFS_PROG -N $MKFS_OPTIONS $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
+	$MKFS_XFS_PROG -N $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
 }
 
 _scratch_mkfs_xfs()
-- 
2.5.5

