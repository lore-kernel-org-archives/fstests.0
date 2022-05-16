Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B1C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 08:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiEPI7b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiEPI73 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 04:59:29 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F1F01C902
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 01:59:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9378E10E6A73
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 18:59:25 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqWZY-00CbZO-0S
        for fstests@vger.kernel.org; Mon, 16 May 2022 18:59:24 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqWZX-005U46-VR
        for fstests@vger.kernel.org;
        Mon, 16 May 2022 18:59:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/3] fstests: more fixes...
Date:   Mon, 16 May 2022 18:59:18 +1000
Message-Id: <20220516085922.1306879-1-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6282126e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=TaHBvDkn_wZAEWSdJ2cA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

Another couple of fixes for test failures I see in my local test
environments.  The g/081 failure (DM vs DAX issue) has been around
for a long while, I've only just got around to writing a _notrun fix
for it.

Darrick also noticed an issue with the new group list creation code,
so there's a fix for that, too.

Cheers,

Dave.

