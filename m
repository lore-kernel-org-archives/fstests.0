Received: from aserp1040.oracle.com ([141.146.126.69]:31523 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968563AbdI0BEX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Sep 2017 21:04:23 -0400
Date: Tue, 26 Sep 2017 18:04:19 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] generic/45[34]: fix the xfs_scrub probe test
Message-ID: <20170927010419.GL5020@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

We changed the name of the xfs_scrub verb from 'test' to 'probe', so
fix xfstests to follow.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/453 |    2 +-
 tests/generic/454 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/453 b/tests/generic/453
index d8fb1bd..ff29736 100755
--- a/tests/generic/453
+++ b/tests/generic/453
@@ -148,7 +148,7 @@ check_xfs_scrub() {
 	fi
 
 	# Does the ioctl work?
-	if $XFS_IO_PROG -x -c "scrub test 0" $SCRATCH_MNT 2>&1 | \
+	if $XFS_IO_PROG -x -c "scrub probe 0" $SCRATCH_MNT 2>&1 | \
 	   grep -q "Inappropriate ioctl"; then
 		return 1
 	fi
diff --git a/tests/generic/454 b/tests/generic/454
index 385e6de..01279ee 100755
--- a/tests/generic/454
+++ b/tests/generic/454
@@ -144,7 +144,7 @@ check_xfs_scrub() {
 	fi
 
 	# Does the ioctl work?
-	if $XFS_IO_PROG -x -c "scrub test 0" $SCRATCH_MNT 2>&1 | \
+	if $XFS_IO_PROG -x -c "scrub probe 0" $SCRATCH_MNT 2>&1 | \
 	   grep -q "Inappropriate ioctl"; then
 		return 1
 	fi
