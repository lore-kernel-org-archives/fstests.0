Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8193EC433FE
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 01:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiETBXn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbiETBXm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 21:23:42 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 635B42982F
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:23:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E70435345E3
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 11:23:39 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nrrMf-00E40T-Qa
        for fstests@vger.kernel.org; Fri, 20 May 2022 11:23:37 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nrrMf-006TK4-PB
        for fstests@vger.kernel.org;
        Fri, 20 May 2022 11:23:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/2] fstests: fix a major test setup performance regression
Date:   Fri, 20 May 2022 11:23:34 +1000
Message-Id: <20220520012336.1542637-1-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6286ed9c
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=1CqNd04cS_X3JLjlcdcA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

I've been seeing symptoms of this issue described in patch 2 for
most of this merge cycle, and it's slowly been getting worse, to
the point where I had to fix it to be able to get any amount of
testing done. Turns out we're doing something that is not smart
with XFS test setup, and recent changes to mkfs.xfs caused that
to be exposed. These patches fix it.

The first patch is a cleanup - no test should be including common/rc
directly anymore - _being_fstest() does that now. The second patch
fixes the XFS issues in init_rc() which is called from _begin_fstest
when is sources common/rc....

Cheers,

Dave.


