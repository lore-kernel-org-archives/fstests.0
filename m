Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C49C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 07:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiEQHtQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 03:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiEQHtN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 03:49:13 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CA544476B
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 00:49:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 98D2E10E6948
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 17:49:11 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqrx8-00Cyph-Fm
        for fstests@vger.kernel.org; Tue, 17 May 2022 17:49:10 +1000
Date:   Tue, 17 May 2022 17:49:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 00/13 V2] fstests: fixes and more fixes...
Message-ID: <20220517074910.GO2306852@dread.disaster.area>
References: <20220517070111.1381936-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517070111.1381936-1-david@fromorbit.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62835377
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=nYphOlj6hp-Y2tvEzRQA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 05:00:59PM +1000, Dave Chinner wrote:
> Hi folks,
> 
> This is a rollup of the two patch series I sent yesterday titled:
> 
> [PATCH 0/3] fstests: test updates for XFS 5.19 kernel mods
> [PATCH 0/3] fstests: more fixes...
> 
> I've fixed some patches, added documentation for those changes,
> and added a bunch of patches to remove deprecated/broken tests that
> should ahve been removed long ago.
> 
> I do not know if patches 9-11 will make it through vger this time -
> they didn't as a single patch. They are titled:
> 
> [PATCH 09/12] xfs/018: remove deprecated test
> [PATCH 10/12] xfs/081: remove deprecated test
> [PATCH 11/12] xfs/082: remove deprecated test
> 
> and is thould be pretty obvious what they do from the title....

Ok, it appears as though even separated vger still won't let a
single one of them through

Zorro, all these patches are 'git rm' commands

git rm tests/xfs/018*
git commit
git rm tests/xfs/081*
git commit
git rm tests/xfs/082*
git commit

I'm happy for you to just run them yourself, or do you want me to
send a pull request for them?

/me realises he hasn't updated his kernel.org fstests tree for 4
years....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
