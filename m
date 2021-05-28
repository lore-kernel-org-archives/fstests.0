Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85FDC47087
	for <linux-fstests@archiver.kernel.org>; Fri, 28 May 2021 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B8A6128B
	for <linux-fstests@archiver.kernel.org>; Fri, 28 May 2021 09:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhE1Jml (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 May 2021 05:42:41 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:48336 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232012AbhE1Jmk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 May 2021 05:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1622194864; i=@fujitsu.com;
        bh=pjlao9T2SNlwU5R1tw7SnaMbP9hMrnwDQAtcBbQ30+4=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=YIrdFMWpQqNjLCcoW7mLlC5MI16xLhogbeN+xi7ATpy52SZnOxhkqIEOkVeZPwk5m
         EQbs6K6maYMfWjI81sNaD6406d/l0sqBmp21rhv3q3TsXNdUnNJPL3+ZUBzqxDUhbs
         FBj9lyu6ut21RmnmZoGVKC9Xyoxgr9BnaIx+iMwQBdOVXrshADcpuqhXgINrH+1Swr
         2xkqhv82YDd33ux922d155VJuJ5H1SA1Bdf7406H6TyfwYdXJf0L7WlI0p7BaPHH3T
         Aj7diZHU91v0YiZmlG3Xz8D+IpN59vuO8GfeM2uWENTU8cguwmt/QGsID85z5qh7cK
         /3y2g6gfQreuA==
Received: from [100.112.193.63] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id B5/90-28327-0BAB0B06; Fri, 28 May 2021 09:41:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRWlGSWpSXmKPExsViZ8MxVXfDrg0
  JBp3P2C1Ot+xld2D0+LxJLoAxijUzLym/IoE1Y8qaDtaCFewVkx6+Y25gnMnWxcjFISTQySRx
  afkrRghnD6PE/lcXgTKcHGwCmhLPOhcwg9giArIS/2esZgKxmQXUJZZP+gVmCws4SKy9/YQFx
  GYRUJW4/3kSO4jNK+AhcWj5FLC4hICCxJSH75kh4oISJ2dC1DMLSEgcfPGCGaJGUeJSxzdGCL
  tCYsaMbWwTGHlnIWmZhaRlASPTKkbzpKLM9IyS3MTMHF1DAwNdQ0MjXUNLU10TM73EKt1EvdR
  S3fLU4hJdQ73E8mK94src5JwUvbzUkk2MwOBKKTist4NxwpsPeocYJTmYlER5J+isTxDiS8pP
  qcxILM6ILyrNSS0+xCjDwaEkwXt054YEIcGi1PTUirTMHGCgw6QlOHiURHjFQNK8xQWJucWZ6
  RCpU4zGHJevz1vEzLF57tJFzEIsefl5qVLivFdBSgVASjNK8+AGwSLwEqOslDAvIwMDgxBPQW
  pRbmYJqvwrRnEORiVh3h87gKbwZOaVwO17BXQKE9ApQonrQE4pSURISTUwGS8sjVjQLLH00f0
  8DvMfN6oZN3dcl7tyNfO714e4BHGfzZND7f9kzLn7R56F69jkX4fvreiU8WS0ZNrcP1HXyUWR
  943JptU/N5h0H5Y8dO7lMs+JJ1a9yPAL/LLma820c5/nVJ4/43IrUkWgc8ruLxGL54t3fvLs2
  vaV1WvB5p8SDp7qv1eenVFtYBanmr36mubJ9UqL1i36x2Gg+924sS2c/Vi+RO28e4uCt2wNna
  JayBWxctap1r1vdE5FtMy+zvzgrfmt9K16CQ+nBN6bJNAwKfG0ejHjEXHlS5n/NN6E782Umip
  ZLrR5gkTESz8Nj+wIe6f7XrkTfx1UrD/Ay9fzu215h3Jx1HzBP29fiSixFGckGmoxFxUnAgCP
  jtW8OwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-271.messagelabs.com!1622194863!149700!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14292 invoked from network); 28 May 2021 09:41:04 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-14.tower-271.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 May 2021 09:41:04 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 14S9ev0A008529
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Fri, 28 May 2021 10:41:03 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.18; Fri, 28 May 2021 10:40:55 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] common/xfs: Fix _require_scratch_xfs_shrink bug
Date:   Fri, 28 May 2021 17:41:10 +0800
Message-ID: <1622194870-2085-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since local declaration can't pass function return value, this
helper never detects whether kernel or xfsprogs supports
xfs shrink feature successfully. Fit it by separating declaration
and assignment of local variables.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 common/xfs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/xfs b/common/xfs
index d7f2a005..c5e39427 100644
--- a/common/xfs
+++ b/common/xfs
@@ -820,7 +820,8 @@ _require_scratch_xfs_shrink()
 	. $tmp.mkfs
 	_scratch_mount
 	# here just to check if kernel supports, no need do more extra work
-	local errmsg=$($XFS_GROWFS_PROG -D$((dblocks-1)) "$SCRATCH_MNT" 2>&1)
+	local errmsg
+	errmsg=$($XFS_GROWFS_PROG -D$((dblocks-1)) "$SCRATCH_MNT" 2>&1)
 	if [ "$?" -ne 0 ]; then
 		echo "$errmsg" | grep 'XFS_IOC_FSGROWFSDATA xfsctl failed: Invalid argument' > /dev/null && \
 			_notrun "kernel does not support shrinking"
-- 
2.27.0

