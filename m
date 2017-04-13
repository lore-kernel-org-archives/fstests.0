Received: from userp1040.oracle.com ([156.151.31.81]:40662 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbdDMPkS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Apr 2017 11:40:18 -0400
Date: Thu, 13 Apr 2017 08:39:43 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] xfs/348: update error message when transmogrifying symlink
 into directory
Message-ID: <20170413153942.GA5083@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
List-ID: <fstests@vger.kernel.org>

We introduced the inline directory verifier in 4.11 to prevent the
system from trying to use corrupt inline directories.  This has the
effect of changing the error message in one step of the i_mode fuzz
tester, so update the test accordingly.

Note that prior to the existence of the verifier, this test would
occasionally result in memory corruption that did not become evident
until later.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/348.out |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/348.out b/tests/xfs/348.out
index 805d530..f4a7a71 100644
--- a/tests/xfs/348.out
+++ b/tests/xfs/348.out
@@ -110,7 +110,7 @@ would have junked entry "FIFO" in directory PARENT_INO
 stat: 'SCRATCH_MNT/test/DIR' is a directory
 stat: 'SCRATCH_MNT/test/DATA' is a directory
 stat: cannot stat 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
-stat: 'SCRATCH_MNT/test/SYMLINK' is a directory
+stat: cannot stat 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
 stat: cannot stat 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
 stat: cannot stat 'SCRATCH_MNT/test/BLKDEV': Structure needs cleaning
 stat: cannot stat 'SCRATCH_MNT/test/FIFO': Structure needs cleaning
