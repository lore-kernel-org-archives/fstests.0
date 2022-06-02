Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCBC43334
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiFBAbf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiFBAbd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:31:33 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8C0F29B2C2
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:31:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 204CB5EC494
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 10:31:30 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkK-001b7I-Rl
        for fstests@vger.kernel.org; Thu, 02 Jun 2022 10:31:28 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkK-00CBb2-QA
        for fstests@vger.kernel.org;
        Thu, 02 Jun 2022 10:31:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: fstests: new tests and various fixes
Date:   Thu,  2 Jun 2022 10:31:18 +1000
Message-Id: <20220602003126.2903779-1-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=629804e2
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=JPEYwPQDsx4A:10 a=FB3-nn5Wd31QrmdKgUwA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

This is the current set of test modifications I've been running at
the end of the 5.19 merge cycle. This series:

- adds a LARP test
- adds better _begin_fstests documentation
- fixes problematic use of DM devices on DAX capable bdevs
- fixes test interruption issues
- works around a new systemd/mount malfeature
- converts a long running test to use TIME_FACTOR
- fixes a TIME_FACTOR scaling bug

With these, my test machines running the current 5.19-rc0+XFS for-next
tree with default and rmapbt=1 configs pass the autogroup with zero
test failures.

Cheers,

Dave.

