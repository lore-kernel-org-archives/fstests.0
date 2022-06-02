Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71D2CCA473
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiFBAbe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiFBAbc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:31:32 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E773729B2C0
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:31:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D4DA85EC473
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 10:31:29 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkL-001b7W-3C
        for fstests@vger.kernel.org; Thu, 02 Jun 2022 10:31:29 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkL-00CBbY-2N
        for fstests@vger.kernel.org;
        Thu, 02 Jun 2022 10:31:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 7/8] xfs/167: adjust runtime with TIME_FACTOR
Date:   Thu,  2 Jun 2022 10:31:25 +1000
Message-Id: <20220602003126.2903779-8-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602003126.2903779-1-david@fromorbit.com>
References: <20220602003126.2903779-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=629804e1
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=sEeDiNUY4z0xlJLUWFwA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

xfs/167 takes between 6 and 10 minutes to run on my SSD based test
machines. It's running 50 loops of a unwritten extent conversion
test program whilst running a heavy fsstress workload in the
background. This does not need to run for 10 minutes on every auto
group regression test run. Shorten it to loop 5 * TIME_FACTOR
so that normal runtime drops to something sane but can still be
easily ramped up if soak/stress testing is being run.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/167 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/167 b/tests/xfs/167
index 5f985010..15bb1854 100755
--- a/tests/xfs/167
+++ b/tests/xfs/167
@@ -47,13 +47,11 @@ _require_fs_space $SCRATCH_MNT 10485760
 
 TEST_FILE=$SCRATCH_MNT/test_file
 TEST_PROG=$here/src/unwritten_sync
-LOOPS=50
+LOOPS=$((5 * $TIME_FACTOR))
 
 echo "*** test unwritten extent conversion under heavy I/O"
-
-workout
-
 rm -f $TEST_FILE
+workout
 $TEST_PROG $LOOPS $TEST_FILE
 
 echo "     *** test done"
-- 
2.35.1

