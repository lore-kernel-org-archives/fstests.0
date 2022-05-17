Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3BC43217
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 07:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiEQHCV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 03:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiEQHB3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 03:01:29 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC55A255BD
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 00:01:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 311B910E69CE
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 17:01:18 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqrCj-00Cy70-7Y
        for fstests@vger.kernel.org; Tue, 17 May 2022 17:01:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqrCj-005njt-6R
        for fstests@vger.kernel.org;
        Tue, 17 May 2022 17:01:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 04/12] fstests: fix group list generation for whacky test names
Date:   Tue, 17 May 2022 17:01:03 +1000
Message-Id: <20220517070111.1381936-5-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517070111.1381936-1-david@fromorbit.com>
References: <20220517070111.1381936-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6283483e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=_vxGkCWramiWRfEBLmYA:9
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

Use the regexes for matching test names defined in common/test_names
rather than trying to open code it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tools/mkgroupfile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/mkgroupfile b/tools/mkgroupfile
index 24435898..414cb538 100755
--- a/tools/mkgroupfile
+++ b/tools/mkgroupfile
@@ -19,6 +19,8 @@ if [ ! -x ../../check ]; then
 	exit 1
 fi
 
+. ../../common/test_names
+
 cleanup()
 {
 	rm -f $new_groups.check
@@ -60,7 +62,8 @@ ENDL
 
 	# Aggregate the groups each test belongs to for the group file
 	grep -I -R "^_begin_fstest" $test_dir/ | \
-		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
+		sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
+		>> $new_groups
 
 	# Create the list of unique groups for existence checking
 	grep -I -R "^_begin_fstest" $test_dir/ | \
-- 
2.35.1

