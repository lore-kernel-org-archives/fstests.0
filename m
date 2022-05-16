Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0419AC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 06:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiEPGIY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 02:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiEPGIO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 02:08:14 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D6A821244
        for <fstests@vger.kernel.org>; Sun, 15 May 2022 23:08:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A884210E666B
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 16:08:11 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqTtp-00CYbE-Du
        for fstests@vger.kernel.org; Mon, 16 May 2022 16:08:09 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqTtp-005QwC-CO
        for fstests@vger.kernel.org;
        Mon, 16 May 2022 16:08:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/3] fstests: test updates for XFS 5.19 kernel mods
Date:   Mon, 16 May 2022 16:08:04 +1000
Message-Id: <20220516060807.1295102-1-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6281ea4b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=P5S6GsJkM7BiONaRoHIA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

These are patches to fix test failures after upstream kernel changes
have been merged to the for-next branch. We've remove quota warning
functionality altogether, the inode fork format verification is
stricter, and there's new log format items we need to check sizes
of.

You'll need the latest kernel and the latest larp xfsprogs branch
from Allison's tree (will be merged in upcoming 5.19 xfsprogs cycle)
for these tests to pass now.

Cheers,

Dave.


