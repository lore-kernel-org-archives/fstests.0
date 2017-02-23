Received: from userp1040.oracle.com ([156.151.31.81]:26119 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdBWHxn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Feb 2017 02:53:43 -0500
Date: Wed, 22 Feb 2017 23:53:33 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] xfs/348: don't run a fuzzer in the auto group
Message-ID: <20170223075333.GB22332@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

xfs/348 can cause the kernel to crash by blowing the i_rwsem assert in
xfs_destroy_inode on the corrupted inode.  Since this is a fuzzer test
anyway (it calls xfs_db to break the scratch fs), move it to the fuzzers
group.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/group |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/group b/tests/xfs/group
index e2dfae2..e597326 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -337,7 +337,7 @@
 345 auto quick clone
 346 auto quick clone
 347 auto quick clone
-348 auto quick repair
+348 fuzzers repair
 349 dangerous_fuzzers scrub
 350 dangerous_fuzzers dangerous_scrub dangerous_repair
 351 dangerous_fuzzers dangerous_scrub dangerous_online_repair
