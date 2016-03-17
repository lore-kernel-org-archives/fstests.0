Received: from mx1.redhat.com ([209.132.183.28]:49514 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbcCQE1x (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 17 Mar 2016 00:27:53 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v3] xfs/073: ignore mkfs output
Date: Thu, 17 Mar 2016 12:27:45 +0800
Message-Id: <1458188865-14819-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

When testing xfs/073 with MKFS_OPTIONS="-m crc=1,finobt=1" set, it fails
due to extra warning about disabling finobt feature:

 +warning: finobt not supported without CRC support, disabled.

Because xfs/073 disables crc unconditionally and finobt can not be
enabled either.

Fix it by dumping mkfs output to $seqres.full and updating 073.out
accordingly.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

v3:
- just ignore mkfs output
v2:
- disable finobt explicitly, instead of filtering the warning

 tests/xfs/073     | 2 +-
 tests/xfs/073.out | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tests/xfs/073 b/tests/xfs/073
index e1335df..9e29223 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -138,7 +138,7 @@ _require_loop
 
 rm -f $seqres.full
 
-_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
+_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 >>$seqres.full 2>&1
 _scratch_mount 2>/dev/null || _fail "initial scratch mount failed"
 
 echo
diff --git a/tests/xfs/073.out b/tests/xfs/073.out
index 3f27467..5f36ebe 100644
--- a/tests/xfs/073.out
+++ b/tests/xfs/073.out
@@ -1,10 +1,4 @@
 QA output created by 073
-meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
-data     = bsize=XXX blocks=XXX, imaxpct=PCT
-         = sunit=XXX swidth=XXX, unwritten=X
-naming   =VERN bsize=XXX
-log      =LDEV bsize=XXX blocks=XXX
-realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 
 === populating scratch device
 1000+0 records in
-- 
2.5.0

