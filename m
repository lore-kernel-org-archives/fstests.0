Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CAFC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 08:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiEPI7d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 04:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiEPI73 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 04:59:29 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24A411C904
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 01:59:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B4A845348A8
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 18:59:25 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqWZY-00CbZP-1G
        for fstests@vger.kernel.org; Mon, 16 May 2022 18:59:24 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqWZY-005U49-0P
        for fstests@vger.kernel.org;
        Mon, 16 May 2022 18:59:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/4] fstests: fix group list generation for whacky test names
Date:   Mon, 16 May 2022 18:59:19 +1000
Message-Id: <20220516085922.1306879-2-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516085922.1306879-1-david@fromorbit.com>
References: <20220516085922.1306879-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6282126e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=-d-PVJR42_HGuCqAdrkA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Darrick noticed that tests/xfs/191-input-validation didn't get
generated properly. Fix the regex to handle this.

$ grep -I -R "^_begin_fstest" tests/xfs | \
  sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
$
$ grep -I -R "^_begin_fstest" tests/xfs | \
  sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
191 auto quick mkfs realtime
$

Long term, we should rename that test to '191' and rip out all that
unused and unnecessary complexity for matching ascii test names
because we just don't use it. Numbers for tests are still working
just fine.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tools/mkgroupfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkgroupfile b/tools/mkgroupfile
index 24435898..958d4e2f 100755
--- a/tools/mkgroupfile
+++ b/tools/mkgroupfile
@@ -60,7 +60,7 @@ ENDL
 
 	# Aggregate the groups each test belongs to for the group file
 	grep -I -R "^_begin_fstest" $test_dir/ | \
-		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
+		sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/' >> $new_groups
 
 	# Create the list of unique groups for existence checking
 	grep -I -R "^_begin_fstest" $test_dir/ | \
-- 
2.35.1

