Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF9C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 07:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiEQHBV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 03:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiEQHBT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 03:01:19 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 157B412A9A
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 00:01:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E431010E6860
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 17:01:16 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqrCj-00Cy6v-3a
        for fstests@vger.kernel.org; Tue, 17 May 2022 17:01:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqrCj-005nje-1t
        for fstests@vger.kernel.org;
        Tue, 17 May 2022 17:01:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 00/13 V2] fstests: fixes and more fixes...
Date:   Tue, 17 May 2022 17:00:59 +1000
Message-Id: <20220517070111.1381936-1-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6283483d
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=_sXPY4dDgnF4B43GzmsA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi folks,

This is a rollup of the two patch series I sent yesterday titled:

[PATCH 0/3] fstests: test updates for XFS 5.19 kernel mods
[PATCH 0/3] fstests: more fixes...

I've fixed some patches, added documentation for those changes,
and added a bunch of patches to remove deprecated/broken tests that
should ahve been removed long ago.

I do not know if patches 9-11 will make it through vger this time -
they didn't as a single patch. They are titled:

[PATCH 09/12] xfs/018: remove deprecated test
[PATCH 10/12] xfs/081: remove deprecated test
[PATCH 11/12] xfs/082: remove deprecated test

and is thould be pretty obvious what they do from the title....

As for:

[PATCH 04/12] fstests: fix group list generation for whacky test

I've updated it to use $VALID_TEST_NAME so that it doesn't miss
names like xfs/191-input_validation as can be seen here:

$ sudo MOUNT_OPTIONS= ./check -b -s xfs -n -g mkfs
SECTION       -- xfs
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test2 5.18.0-rc7-dgc+ #1245 SMP PREEMPT_DYNAMIC Mon May 16 11:51:16 AEST 2022
MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/vdb
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/vdb /mnt/scratch

generic/405
shared/032
xfs/019
xfs/029
xfs/031
xfs/096
xfs/178
xfs/191-input-validation
xfs/260
xfs/279
xfs/284
xfs/292
xfs/419
xfs/500
xfs/504
xfs/522
xfs/523
xfs/524
xfs/525
xfs/526
xfs/543

And I've document the use of _begin_fstests by the build
infrastructure and the constraints that introduces into it's
definition in the README file section that documents how to define
test groups for a given test. That's all in:

[PATCH 05/12] README: document _begin_fstests better

These fixes address all the known internal fstests problems with the
new group list generation code. I still don't know why Darrick had
deprecated tests run inappropriately or marked as failed - I can't
reproduce anything like what he described and he gave me no details
of how to reproduce what he saw.

Cheers,

Dave.


