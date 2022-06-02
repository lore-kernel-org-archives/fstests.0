Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D30C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiFBAbg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiFBAbd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:31:33 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C40729B2D0
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:31:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3F5BB10E6FEE
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 10:31:30 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkL-001b7U-2K
        for fstests@vger.kernel.org; Thu, 02 Jun 2022 10:31:29 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkL-00CBbT-13
        for fstests@vger.kernel.org;
        Thu, 02 Jun 2022 10:31:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 6/8] xfs/070: filter the bad sb magic number error
Date:   Thu,  2 Jun 2022 10:31:24 +1000
Message-Id: <20220602003126.2903779-7-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602003126.2903779-1-david@fromorbit.com>
References: <20220602003126.2903779-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=629804e2
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=WSQDyuQb4SG-2VYXhFAA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Lastest XFS kernel makes the superblock bad magic number error
message more meaningful, and that's being picked up by xfsprogs in
very short order. And, of course, the error is output by xfs_repair,
too, and it's been captured in the golden output of a test. Fix it
by filtering the output back down to the old message.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/repair | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/repair b/common/repair
index 5a957f4e..463ef9db 100644
--- a/common/repair
+++ b/common/repair
@@ -90,6 +90,7 @@ s/(superblock) (\d+)/\1 AGNO/;
 s/(AG \#)(\d+)/\1AGNO/;
 s/(reset bad sb for ag) (\d+)/\1 AGNO/;
 s/(unknown block state, ag )(\d+)(, blocks? )(\d+)/\1AGNO\3AGBNO/;
+s/^Superblock has (bad magic number) 0x.*/\1/;
 /^Note - quota info will be regenerated on next quota mount.$/ && next;
 	print;'
 }
-- 
2.35.1

