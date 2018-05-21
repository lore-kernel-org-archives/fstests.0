Received: from userp2130.oracle.com ([156.151.31.86]:54422 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeEUQGv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 May 2018 12:06:51 -0400
Date: Mon, 21 May 2018 09:06:48 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] xfs/132: unmount scratch fs after test
Message-ID: <20180521160648.GI4910@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

If this test runs successfully, it'll leave a shutdown scratch fs
behind.  The test framework doesn't unmount the fs for us (because we
told it not to check the fs) so the test framework tries to "test -d
$SCRATCH_MNT" and blows up on the IO error it receives from the dead fs.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/132 |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/132 b/tests/xfs/132
index 6bb03e79..3fa695a7 100755
--- a/tests/xfs/132
+++ b/tests/xfs/132
@@ -67,6 +67,7 @@ _scratch_mount
 
 # The corrupt inode should be tripped over during these initial file creates.
 touch $SCRATCH_MNT/file{0,1,2,3,4,5}{0,1,2,3,4,5} 2>&1 | _filter_scratch
+_scratch_unmount
 
 # success, all done
 status=0
