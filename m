Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F60C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 23:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiEXXe5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 19:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiEXXe4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 19:34:56 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8649753E00
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 16:34:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 96A1110E6DCA;
        Wed, 25 May 2022 09:34:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nte3A-00G0zE-V2; Wed, 25 May 2022 09:34:52 +1000
Date:   Wed, 25 May 2022 09:34:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
Message-ID: <20220524233452.GP2306852@dread.disaster.area>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
 <20220524122703.GL2306852@dread.disaster.area>
 <CAOQ4uxifd8gee1JLG1FN9fF3aSsVeSEuxFqjAf4D8ruCciXWYg@mail.gmail.com>
 <20220524132428.GO2306852@dread.disaster.area>
 <CAOQ4uxhWCKb8_pKU4CCE5Nv2qTqge-AyGBdoX2isrBui4cHdqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhWCKb8_pKU4CCE5Nv2qTqge-AyGBdoX2isrBui4cHdqA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=628d6b9e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=w-SJuSB5juA6Xxk9lIEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 05:17:44PM +0300, Amir Goldstein wrote:
> On Tue, May 24, 2022 at 4:24 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Tue, May 24, 2022 at 03:55:47PM +0300, Amir Goldstein wrote:
> The work you did is huge and impressive and the review is not easy.

I disagree - it's not huge or impressive, it's just 4 hours of
*basic grunt work*. It's not difficult, it's not complex, it's just
time consuming. *Anyone* can do this.

The problem fstests has is *nobody* is doing these sorts of
maintenance tasks. We keep adding more tests and with them mountains
of technical debt, yet nobody wants to take any responsibility for
addressing the technical debt.

I'm doing this because over the past year auto group runtimes on my
test machines have increased by about 40%. What took a little over 2
hours is now taking 3.5 hours on the same machines running on the
same hardware with the same VM configs. That's not sustainable - we
have to address the problems that ever increasing number of tests is
causing, otherwise fstests slowly loses it's utility for filesysetm
developers. Iteration speed is everything when developing new code,
and fstests runtime is now my biggest impediment to ongoing
productivity.

Everyone should be looking to improve fstests infrastructure and
address tests that take too long on their systems. I've haven't got
to that yet, but about a dozen tests are now responsible for 30% of
the total auto group runtime. Those tests need to be refined so they
don't take 5-10 minutes to run each - they need to be adjusted to
work with TIME_FACTOR and/or LOAD_FACTOR so that they run in a
minute on normal tests and can then run for long times/under high
load when asked to do so with TIME_FACTOR/LOAD_FACTOR.

This is the day-to-day maintenance stuff that just isn't getting
done. Creating new tests is all well and good, but they don't come
for free. As the test count goes up, everyone needs to do their
little bit to streamline the way tests run. Otherwise we just end up
where we are now with ongoing runtime creep and no easy way to
address it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
