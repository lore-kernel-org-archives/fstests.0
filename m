Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A252C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 07:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiEQHBU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 03:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbiEQHBT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 03:01:19 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1771512773
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 00:01:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6C98E5345EB
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 17:01:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqrCj-00Cy6y-6c
        for fstests@vger.kernel.org; Tue, 17 May 2022 17:01:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqrCj-005njp-5Q
        for fstests@vger.kernel.org;
        Tue, 17 May 2022 17:01:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 03/12] xfs/348: golden output is not correct
Date:   Tue, 17 May 2022 17:01:02 +1000
Message-Id: <20220517070111.1381936-4-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517070111.1381936-1-david@fromorbit.com>
References: <20220517070111.1381936-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6283483a
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=bLOITkrf0B9LOGp-q54A:9 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The output of xfs/348 encodes the observed behaviour at the time the
test was written, not the correct behaviour that should occur.
Recent improvements in verification checking in the upstream kernel
(1eb70f54c445 "xfs: validate inode fork size against fork format")
have resulted in the kernel having correct behaviour and now the
test fails. Fix the test output to reflect correct behaviour.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/348.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/348.out b/tests/xfs/348.out
index 0d407718..9130f42a 100644
--- a/tests/xfs/348.out
+++ b/tests/xfs/348.out
@@ -108,7 +108,7 @@ would have junked entry "DATA" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 stat: 'SCRATCH_MNT/test/DIR' is a directory
-stat: 'SCRATCH_MNT/test/DATA' is a directory
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
 stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
 stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
 stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
@@ -240,7 +240,7 @@ would have junked entry "DIR" in directory PARENT_INO
 would have junked entry "EMPTY" in directory PARENT_INO
 would have junked entry "FIFO" in directory PARENT_INO
 stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
-stat: 'SCRATCH_MNT/test/DATA' is a symbolic link
+stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
 stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
 stat: 'SCRATCH_MNT/test/SYMLINK' is a symbolic link
 stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
-- 
2.35.1

