Received: from mx1.redhat.com ([209.132.183.28]:16491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbbIQOeH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 17 Sep 2015 10:34:07 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 79034C0B2001
	for <fstests@vger.kernel.org>; Thu, 17 Sep 2015 14:34:07 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs/167: remove duplicated _require_fs_space
Date: Thu, 17 Sep 2015 22:34:00 +0800
Message-Id: <1442500440-1328-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Seems the same patch was applied twice,

6f55bbd xfs/167: need at least 10GB of scratch space to run
b50473c xfs/167: need at least 10GB of scratch space to run

and there're two _require_fs_space calls in the test, remove one.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/167 | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/xfs/167 b/tests/xfs/167
index 499cc1f..875bd31 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -68,12 +68,6 @@ _scratch_mount
 # errors.
 _require_fs_space $SCRATCH_MNT 10485760
 
-# fast devices can consume disk space at a rate of 1GB every 5s via the
-# background workload. With 50 test loops, at 1 second per loop, that means we
-# need at least 10GB of disk space to ensure this test will not fail with ENOSPC
-# errors.
-_require_fs_space $SCRATCH_MNT 10485760
-
 TEST_FILE=$SCRATCH_MNT/test_file
 TEST_PROG=$here/src/unwritten_sync
 LOOPS=50
-- 
2.4.3

