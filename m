Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:42333 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750718AbeBWFBt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Feb 2018 00:01:49 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1ep5Tt-0000eT-0o
        for fstests@vger.kernel.org; Fri, 23 Feb 2018 16:01:13 +1100
Received: from dave by discord.disaster.area with local (Exim 4.90_1)
        (envelope-from <david@fromorbit.com>)
        id 1ep5Ts-00014f-TN
        for fstests@vger.kernel.org; Fri, 23 Feb 2018 16:01:12 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] generic/47[23]: remove from auto/quick groups
Date: Fri, 23 Feb 2018 16:01:12 +1100
Message-Id: <20180223050112.4090-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

generic/472 is for changes that are not upstream and seem dead in
the water at the moment, so remove this test from the auto and quick
groups until it's been resolved upstream and the changes merged.

generic/473 really doesn't seme useful. FIEMAP is a debugging
interface, xfs_io is a debugging tool and so trying to make every
filesytem report exactly the same thing for a ranged query just
strikes me as the wrong thing to be doing. This fails on XFS, and
there's no apparent resolution to that in sight, so remove the test
from the auto and quick, too.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/group b/tests/generic/group
index b2ce7a66ce81..1e808865772f 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -474,8 +474,8 @@
 469 auto quick
 470 auto quick dax
 471 auto quick rw
-472 auto quick rw
-473 auto quick
+472 rw
+473 broken
 474 auto quick shutdown metadata
 475 shutdown auto log metadata
 476 auto rw
-- 
2.16.1

