Received: from mx1.redhat.com ([209.132.183.28]:43646 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbcCaGL4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 31 Mar 2016 02:11:56 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2] xfs/030: filter out repeated lines from .out files
Date: Thu, 31 Mar 2016 14:11:22 +0800
Message-Id: <1459404682-12282-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1459331861-15025-1-git-send-email-eguan@redhat.com>
References: <1459331861-15025-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, darrick.wong@oracle.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Commit 31f48569c353 ("xfs/030: fix output on newer filesystems") added
more lines to .out file to match the output from XFS with reflink
support, but it broke test on older XFS.

Dave explained the reason and pointed out the correct way to fix it, so
I just quote Dave's mail here:

"The problem here is that reflink triggers a change in the initial
population of the AGFL - from 4 blocks to 6 blocks, and so repair warns
6 times instead of 4. After filtering, that gives 6 indentical output
lines instead of 4.

Doing something as simple as collapsing repeated identical lines (e.g
filtering through uniq) will work for all filesystem formats and any
future changes that modify the initial AGFL population."

Suggested-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/030           | 2 +-
 tests/xfs/030.out.irix  | 3 ---
 tests/xfs/030.out.linux | 5 -----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/tests/xfs/030 b/tests/xfs/030
index 33c906c..5c99d9e 100755
--- a/tests/xfs/030
+++ b/tests/xfs/030
@@ -55,7 +55,7 @@ _check_ag()
 	for structure in 'sb 0' 'agf 0' 'agi 0' 'agfl 0'
 	do
 		echo "Corrupting $structure - setting bits to $1"
-		_check_repair $1 "$structure" |
+		_check_repair $1 "$structure" | uniq |
 			sed -e '/^error following ag 0 unlinked list$/d' \
 			    -e '/^bad agbno AGBNO for finobt/d' \
 			    -e '/^bad agbno AGBNO for rmapbt/d' \
diff --git a/tests/xfs/030.out.irix b/tests/xfs/030.out.irix
index 6378c73..56adfd0 100644
--- a/tests/xfs/030.out.irix
+++ b/tests/xfs/030.out.irix
@@ -263,9 +263,6 @@ Phase 1 - find and verify superblock...
 Phase 2 - zero log...
         - scan filesystem freespace and inode maps...
 bad agbno AGBNO in agfl, agno 0
-bad agbno AGBNO in agfl, agno 0
-bad agbno AGBNO in agfl, agno 0
-bad agbno AGBNO in agfl, agno 0
         - found root inode chunk
 Phase 3 - for each AG...
         - scan and clear agi unlinked lists...
diff --git a/tests/xfs/030.out.linux b/tests/xfs/030.out.linux
index 14b9b35..722cabf 100644
--- a/tests/xfs/030.out.linux
+++ b/tests/xfs/030.out.linux
@@ -228,11 +228,6 @@ Phase 2 - using <TYPEOF> log
         - zero log...
         - scan filesystem freespace and inode maps...
 bad agbno AGBNO in agfl, agno 0
-bad agbno AGBNO in agfl, agno 0
-bad agbno AGBNO in agfl, agno 0
-bad agbno AGBNO in agfl, agno 0
-bad agbno AGBNO in agfl, agno 0
-bad agbno AGBNO in agfl, agno 0
         - found root inode chunk
 Phase 3 - for each AG...
         - scan and clear agi unlinked lists...
-- 
2.5.5

