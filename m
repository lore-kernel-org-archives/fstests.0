Received: from userp2120.oracle.com ([156.151.31.85]:56756 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeEUQHv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 May 2018 12:07:51 -0400
Date: Mon, 21 May 2018 09:07:34 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] generic/475: fix confusing comment
Message-ID: <20180521160734.GJ4910@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: zlang@redhat.com, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

The comment about the dmerror switcheroo is hard to understand and
wrong.  Fix both problems by rewriting it.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/475 |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/generic/475 b/tests/generic/475
index e31f1251..45072278 100755
--- a/tests/generic/475
+++ b/tests/generic/475
@@ -73,9 +73,11 @@ for i in $(seq 1 $((50 * TIME_FACTOR)) ); do
 	# recovery
 	sleep $((RANDOM % 3))
 
-	# Loading error table without "--nolockfs" option. Because "--nolockfs"
-	# won't freeze fs, then some running I/Os may cause XFS to shutdown
-	# prematurely. That's not what we want to test.
+	# This test aims to simulate sudden disk failure, which means that we
+	# do not want to quiesce the filesystem or otherwise give it a chance
+	# to flush its logs.  Therefore we want to call dmsetup with the
+	# --nolockfs parameter; to make this happen we must call the load
+	# error table helper *without* 'lockfs'.
 	_dmerror_load_error_table
 
 	ps -e | grep fsstress > /dev/null 2>&1
