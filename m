Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2D4CCA478
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiFBAbf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiFBAbc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:31:32 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F359929B2D3
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:31:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1EA5D5EC476
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 10:31:30 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkL-001b7S-10
        for fstests@vger.kernel.org; Thu, 02 Jun 2022 10:31:29 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkL-00CBbL-03
        for fstests@vger.kernel.org;
        Thu, 02 Jun 2022 10:31:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 5/8] xfs/538: fix fsstress scaling
Date:   Thu,  2 Jun 2022 10:31:23 +1000
Message-Id: <20220602003126.2903779-6-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602003126.2903779-1-david@fromorbit.com>
References: <20220602003126.2903779-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=629804e2
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=Qw95BkSvUeI-LC7-d4YA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

_scale_fsstress_args() does time/load scaling of parameters. Doing
it also in the test causes exponential scaling instead of linear
scaling as the time/load parameters are meant to do.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/538     | 36 +++++++++++++++++-------------------
 tests/xfs/538.out |  3 +--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/tests/xfs/538 b/tests/xfs/538
index e0102f48..2b5e97e5 100755
--- a/tests/xfs/538
+++ b/tests/xfs/538
@@ -47,25 +47,23 @@ done
 echo "Inject bmap_alloc_minlen_extent error tag"
 _scratch_inject_error bmap_alloc_minlen_extent 1
 
-echo "Scale fsstress args"
-args=$(_scale_fsstress_args -p $((LOAD_FACTOR * 75)) -n $((TIME_FACTOR * 1000)))
-
-echo "Execute fsstress in background"
-$FSSTRESS_PROG -d $SCRATCH_MNT $args \
-		 -f bulkstat=0 \
-		 -f bulkstat1=0 \
-		 -f fiemap=0 \
-		 -f getattr=0 \
-		 -f getdents=0 \
-		 -f getfattr=0 \
-		 -f listfattr=0 \
-		 -f mread=0 \
-		 -f read=0 \
-		 -f readlink=0 \
-		 -f readv=0 \
-		 -f stat=0 \
-		 -f aread=0 \
-		 -f dread=0 > /dev/null 2>&1
+echo "Execute fsstress"
+$FSSTRESS_PROG -d $SCRATCH_MNT \
+		$(_scale_fsstress_args -p 75 -n 1000) \
+		-f bulkstat=0 \
+		-f bulkstat1=0 \
+		-f fiemap=0 \
+		-f getattr=0 \
+		-f getdents=0 \
+		-f getfattr=0 \
+		-f listfattr=0 \
+		-f mread=0 \
+		-f read=0 \
+		-f readlink=0 \
+		-f readv=0 \
+		-f stat=0 \
+		-f aread=0 \
+		-f dread=0 > /dev/null 2>&1
 
 # success, all done
 status=0
diff --git a/tests/xfs/538.out b/tests/xfs/538.out
index 85932c82..97ebc314 100644
--- a/tests/xfs/538.out
+++ b/tests/xfs/538.out
@@ -3,5 +3,4 @@ Format and mount fs
 Consume free space
 Create fragmented filesystem
 Inject bmap_alloc_minlen_extent error tag
-Scale fsstress args
-Execute fsstress in background
+Execute fsstress
-- 
2.35.1

