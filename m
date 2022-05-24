Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44396C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 13:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiEXNHw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 09:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiEXNHv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 09:07:51 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 387E892D18
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 06:07:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0F5E110E6AAA;
        Tue, 24 May 2022 23:07:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntUGH-00FqAp-B1; Tue, 24 May 2022 23:07:45 +1000
Date:   Tue, 24 May 2022 23:07:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 6/8] fstests: consolidate no cleanup test setup
Message-ID: <20220524130745.GN2306852@dread.disaster.area>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-7-david@fromorbit.com>
 <CAOQ4uxg9L2kcnWsVO_bmLK7N9M1VgiEbYVgjkym4P7MB0DoX2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg9L2kcnWsVO_bmLK7N9M1VgiEbYVgjkym4P7MB0DoX2g@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=628cd8a3
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=SUe3QKap5zjqsWnMLe0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 03:22:45PM +0300, Amir Goldstein wrote:
> On Tue, May 24, 2022 at 2:42 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Many of the XFS fuzzer tests define a "no cleanup" cleanup function.
> > Consolidate this in common/preamble and deduplicate all the tests
> > using this setup.
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  common/preamble | 9 +++++++++
> >  tests/xfs/083   | 5 -----
> >  tests/xfs/085   | 5 -----
> >  tests/xfs/086   | 5 -----
> >  tests/xfs/087   | 5 -----
> >  tests/xfs/088   | 5 -----
> >  tests/xfs/089   | 5 -----
> >  tests/xfs/091   | 5 -----
> >  tests/xfs/093   | 5 -----
> >  tests/xfs/097   | 5 -----
> >  tests/xfs/098   | 5 -----
> >  tests/xfs/099   | 5 -----
> >  tests/xfs/100   | 5 -----
> >  tests/xfs/101   | 5 -----
> >  tests/xfs/102   | 5 -----
> >  tests/xfs/105   | 5 -----
> >  tests/xfs/112   | 5 -----
> >  tests/xfs/113   | 5 -----
> >  tests/xfs/117   | 5 -----
> >  tests/xfs/120   | 5 -----
> >  tests/xfs/123   | 5 -----
> >  tests/xfs/124   | 5 -----
> >  tests/xfs/125   | 5 -----
> >  tests/xfs/126   | 5 -----
> >  tests/xfs/130   | 5 -----
> >  25 files changed, 9 insertions(+), 120 deletions(-)
> >
> 
> I propose to use a dedicated helper _unregister_cleanup to opt out
> of _cleanup and still leave _cleanup implicit for all the rest of the tests,
> but I will not stop merging this cleanup on account of this suggestion.
> It could be done by a followup cleanup as well, so unless you want to
> take my suggestion

Cart before the horse.  There's another 1000 tests I haven't even
looked at yet, and there's still a heap of work to derive
commonality from the remaining 100 xfs tests that have a random
assortment of loop, local, dm, etc cleanup functions.

I'm trying to focus on cleaning up and deduplicating the tests, not
whether there's an exactly optimal API for a specific cleanup
function. Once everything is deduplicated, changing the cleanup API
is a much, much simpler proposition. So that's the first prioirty
and trivialities like "_register_cleanup _no_cleanup" vs
"_unregister_cleanup" aren't even on my radar.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
