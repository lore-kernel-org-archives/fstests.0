Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7376C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 08:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiEPI7f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiEPI73 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 04:59:29 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 249811C903
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 01:59:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B64AC5348AC
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 18:59:25 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqWZY-00CbZQ-2W
        for fstests@vger.kernel.org; Mon, 16 May 2022 18:59:24 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqWZY-005U4D-1C
        for fstests@vger.kernel.org;
        Mon, 16 May 2022 18:59:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/4] xfs/148: make test debuggable
Date:   Mon, 16 May 2022 18:59:20 +1000
Message-Id: <20220516085922.1306879-3-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516085922.1306879-1-david@fromorbit.com>
References: <20220516085922.1306879-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6282126e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=shh0ZNA0_UVB9JGXS7UA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Don't clean up image files - leave them laying around on the test
device so that when the test fails there's a corpse left behind to
post-mortem....

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/148 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/148 b/tests/xfs/148
index 9427aff0..8d50a642 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -16,7 +16,7 @@ _cleanup()
 	cd /
 	$UMOUNT_PROG $mntpt > /dev/null 2>&1
 	test -n "$loopdev" && _destroy_loop_device $loopdev > /dev/null 2>&1
-	rm -r -f $imgfile $mntpt $tmp.*
+	rm -r -f $tmp.*
 }
 
 # Import common functions.
@@ -38,6 +38,8 @@ nullstr="too_many_beans"
 slashstr="are_bad_for_you"
 test_names=("something" "$nullstr" "$slashstr" "another")
 
+rm -f $imgfile $imgfile.old
+
 # Format image file w/o crcs so we can sed the image file
 $XFS_IO_PROG -f -c 'truncate 40m' $imgfile
 loopdev=$(_create_loop_device $imgfile)
@@ -91,7 +93,6 @@ sed -b \
 	-i $imgfile
 test "$(md5sum < $imgfile)" != "$(md5sum < $imgfile.old)" ||
 	_fail "sed failed to change the image file?"
-rm -f $imgfile.old
 loopdev=$(_create_loop_device $imgfile)
 _mount $loopdev $mntpt
 
-- 
2.35.1

