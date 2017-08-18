Received: from userp1040.oracle.com ([156.151.31.81]:39593 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdHRUwg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Aug 2017 16:52:36 -0400
Date: Fri, 18 Aug 2017 13:52:28 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] common/fuzzy: fix fuzz verb scanning
Message-ID: <20170818205228.GC4794@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

As part of upstreaming, the xfs_db fuzz command change the help output
which breaks the fuzzers' ability to detect fuzz verbs.  Fix that.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/fuzzy |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/fuzzy b/common/fuzzy
index c9f7e90..7a4b03a 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -313,8 +313,8 @@ _scratch_xfs_list_fuzz_verbs() {
 		echo "${SCRATCH_XFS_LIST_FUZZ_VERBS}" | tr '[ ,]' '[\n\n]'
 		return;
 	fi
-	_scratch_xfs_db -x -c 'sb 0' -c 'fuzz' | grep '^Verbs:' | \
-		sed -e 's/[,.]//g' -e 's/Verbs: //g' -e 's/ /\n/g'
+	_scratch_xfs_db -x -c 'sb 0' -c 'fuzz' | grep '^Fuzz commands:' | \
+		sed -e 's/[,.]//g' -e 's/Fuzz commands: //g' -e 's/ /\n/g'
 }
 
 # Fuzz some of the fields of some piece of metadata
