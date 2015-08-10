Received: from mx1.redhat.com ([209.132.183.28]:47697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbbHJNPr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 10 Aug 2015 09:15:47 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 321778F266
	for <fstests@vger.kernel.org>; Mon, 10 Aug 2015 13:15:47 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/074: double the data section size
Date: Mon, 10 Aug 2015 21:15:41 +0800
Message-Id: <1439212541-27554-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

When testing 512 block size xfs, xfs/074 fails as

   QA output created by 074
  +fallocate: No space left on device
   Silence is golden

That's because 40051712*512=20G < 30G.

Doubling the filesystem size makes the test on 512 block size xfs pass,
and test still fails on unpatched kernel.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/074 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/074 b/tests/xfs/074
index a571a34..e6d6787 100755
--- a/tests/xfs/074
+++ b/tests/xfs/074
@@ -62,7 +62,7 @@ mkdir -p $LOOP_MNT
 $XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE >> $seqres.full
 LOOP_DEV=`_create_loop_device $LOOP_FILE`
 
-_mkfs_dev -d size=40051712b,agcount=4 -l size=32m $LOOP_DEV
+_mkfs_dev -d size=80103424b,agcount=4 -l size=32m $LOOP_DEV
 _mount $LOOP_DEV $LOOP_MNT
 
 # Corrupt the BMBT by creating extents larger than MAXEXTLEN
-- 
2.4.3

