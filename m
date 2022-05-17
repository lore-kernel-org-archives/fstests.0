Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1934FC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 21:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiEQVjX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 17:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiEQVjW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 17:39:22 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF8CB4133F
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 14:39:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 3489A10E6AA9
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 07:39:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nr4uU-00DD43-Es
        for fstests@vger.kernel.org; Wed, 18 May 2022 07:39:18 +1000
Date:   Wed, 18 May 2022 07:39:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 00/13 V2] fstests: fixes and more fixes...
Message-ID: <20220517213918.GP2306852@dread.disaster.area>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517074910.GO2306852@dread.disaster.area>
 <20220517082409.anf5f5wg3yoldpki@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517082409.anf5f5wg3yoldpki@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62841608
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=E1JkVgTRlL2h0Uy7SIEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 04:24:09PM +0800, Zorro Lang wrote:
> On Tue, May 17, 2022 at 05:49:10PM +1000, Dave Chinner wrote:
> > On Tue, May 17, 2022 at 05:00:59PM +1000, Dave Chinner wrote:
> > > Hi folks,
> > > 
> > > This is a rollup of the two patch series I sent yesterday titled:
> > > 
> > > [PATCH 0/3] fstests: test updates for XFS 5.19 kernel mods
> > > [PATCH 0/3] fstests: more fixes...
> > > 
> > > I've fixed some patches, added documentation for those changes,
> > > and added a bunch of patches to remove deprecated/broken tests that
> > > should ahve been removed long ago.
> > > 
> > > I do not know if patches 9-11 will make it through vger this time -
> > > they didn't as a single patch. They are titled:
> 
> No, they didn't.
> 
> > > 
> > > [PATCH 09/12] xfs/018: remove deprecated test
> > > [PATCH 10/12] xfs/081: remove deprecated test
> > > [PATCH 11/12] xfs/082: remove deprecated test
> > > 
> > > and is thould be pretty obvious what they do from the title....
> > 
> > Ok, it appears as though even separated vger still won't let a
> > single one of them through
> > 
> > Zorro, all these patches are 'git rm' commands
> > 
> > git rm tests/xfs/018*
> > git commit
> > git rm tests/xfs/081*
> > git commit
> > git rm tests/xfs/082*
> > git commit
> > 
> > I'm happy for you to just run them yourself, or do you want me to
> > send a pull request for them?
> 
> Sure, I don't run this 3 cases either. As they're xfs specific cases, so if both
> of you and Darrick agree to remove them entirely, I'm glad to help that :)
> 
> And how about remove them in single one commit/patch? Likes:
> ---
> [PATCH] fstests: remove xfs deprecated test
> 
> Remove xfs/018, xfs/081 and xfs/082 entirely, as they're deprecated
> and obsolete for long time.
> ---

Fine by me. That's exactly what the first patch I attempted to send
was.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
