Received: from mx1.redhat.com ([209.132.183.28]:54761 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933290AbbHLDqI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 11 Aug 2015 23:46:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 5D38E8EA23
	for <fstests@vger.kernel.org>; Wed, 12 Aug 2015 03:46:08 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] xfs/074: specify filesystem size in terms of size not block count
Date: Wed, 12 Aug 2015 11:45:45 +0800
Message-Id: <1439351145-2117-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

When testing 512 block size xfs, xfs/074 fails as

   QA output created by 074
  +fallocate: No space left on device
   Silence is golden

That's because 40051712*512=20G < 30G.

And quote from Dave:

  That was sized to give AGs of a specific size, which originally
  contributed to the problem being exposed. You should change the block
  count specification to a size specification so the filesysetm being
  made on 4k block size filesystems remains unchanged.

  size    = 40051712b
          = 40051712 * 4096
          = 164,051,812,352
          = 156452m

So set the filesystem size to 156452m explicitly.

Suggested-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/074 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/074 b/tests/xfs/074
index a571a34..9f24512 100755
--- a/tests/xfs/074
+++ b/tests/xfs/074
@@ -62,7 +62,7 @@ mkdir -p $LOOP_MNT
 $XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE >> $seqres.full
 LOOP_DEV=`_create_loop_device $LOOP_FILE`
 
-_mkfs_dev -d size=40051712b,agcount=4 -l size=32m $LOOP_DEV
+_mkfs_dev -d size=156452m,agcount=4 -l size=32m $LOOP_DEV
 _mount $LOOP_DEV $LOOP_MNT
 
 # Corrupt the BMBT by creating extents larger than MAXEXTLEN
-- 
2.4.3

