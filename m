Received: from userp2130.oracle.com ([156.151.31.86]:60804 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbeEWPtL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 May 2018 11:49:11 -0400
Date: Wed, 23 May 2018 08:49:07 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] xfs/447: fix typo
Message-ID: <20180523154907.GM4910@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

Fix a trivial typo that keeps barfing up:
./tests/xfs/447: line 60: /dev_null: Read-only file system

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/447 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/447 b/tests/xfs/447
index 2f95afce..05b1b677 100755
--- a/tests/xfs/447
+++ b/tests/xfs/447
@@ -58,7 +58,7 @@ _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount
 
 $XFS_IO_PROG -fxc "pwrite 0 4k" -c fsync \
-		-c "shutdown" $SCRATCH_MNT/foo 2>&1 > /dev_null
+		-c "shutdown" $SCRATCH_MNT/foo 2>&1 > /dev/null
 
 _scratch_unmount
 
