Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:43476 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752857AbcK3E7O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Nov 2016 23:59:14 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1cBwz6-0003RD-Nq
        for fstests@vger.kernel.org; Wed, 30 Nov 2016 15:59:08 +1100
Received: from dave by discord.disaster.area with local (Exim 4.88)
        (envelope-from <david@fromorbit.com>)
        id 1cBwz6-0003xq-MW
        for fstests@vger.kernel.org; Wed, 30 Nov 2016 15:59:08 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] generic/095: add iomap_dio_rw() to the dmesg filter
Date: Wed, 30 Nov 2016 15:59:08 +1100
Message-Id: <20161130045908.15200-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Oops, we did it again - we moved the XFS dio code warning to a new
function with the iomap direct IO rework.  Update the filter to pick
up the new warning location.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/095 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/095 b/tests/generic/095
index 474825bdf8d6..991baefaecdf 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -128,10 +128,12 @@ filter_xfs_dmesg()
 	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
 	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
 	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
+	local warn4="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
 	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
 	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
 	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
-	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#"
+	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
+	    -e "s#$warn4#Intentional warnings in iomap_dio_rw#"
 }
 
 # umount before checking dmesg in case umount triggers any WARNING or Oops
-- 
2.10.2

