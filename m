Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA64C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 12:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiEXMKH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 08:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiEXMKG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 08:10:06 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41BBC68FAA
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:10:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0108E53453E;
        Tue, 24 May 2022 22:10:03 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntTMP-00FpAo-VA; Tue, 24 May 2022 22:10:01 +1000
Date:   Tue, 24 May 2022 22:10:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 1/8] generic/038: kill background threads on interrupt
Message-ID: <20220524121001.GK2306852@dread.disaster.area>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-2-david@fromorbit.com>
 <CAOQ4uxhqGEYgMYGuFsFV_AtuwyJhpzRrZw2rYDo-Dn_xziOYZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhqGEYgMYGuFsFV_AtuwyJhpzRrZw2rYDo-Dn_xziOYZw@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=628ccb1c
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=ZNksrta2xhSAYCPKWqIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 12:41:25PM +0300, Amir Goldstein wrote:
> On Tue, May 24, 2022 at 12:12 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > When I ctrl-c g/038, it either does nothing or it leaves processes
> > running in the background. It is not cleaning up it's background
> > processes correctly, so add kill vectors into the cleanup. Make sure
> > we only kill in the cleanup trap if the background processes are
> > running.
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/generic/038 | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/tests/generic/038 b/tests/generic/038
> > index c6cea94e..0462ea13 100755
> > --- a/tests/generic/038
> > +++ b/tests/generic/038
> > @@ -36,6 +36,10 @@ _begin_fstest auto stress trim
> >  # Override the default cleanup function.
> >  _cleanup()
> >  {
> > +       [ -n "${create_pids}" ] && kill ${create_pids[@]}
> > +       [ -n "${fallocate_pids}" ] && kill ${fallocate_pids[@]}
> > +       [ -n "${trim_pids}" ] && kill ${trim_pids[@]}
> > +       wait
> 
> Following the pattern of recently fixed generic/019,
> Please redirect stderr of kill to /dev/null

No. Redirecting errors to /dev/null to hide them is poor behaviour
- g/019 does not test if the pids variables are still valid even
though they get unset. Hence the normal exit trap
runs an empty `kill` command which outputs a help message. The
redirect to /dev/null hides this broken behaviour - it's poor,
buggy code, and an example how buggy and broken a lot of the cleanup
code actually is.

The code above will not run kill with an empty pid list, hence it
should not fail when it is run. If it does fail then we've got a
problem that needs to be captured and analysed and so redirecting
that error to /dev/null is exactly the wrong thing to be doing.

> and I think we would rather not wait in cleanup callbacks
> which could potentially block forever?

We do that in many, many tests - that's how we stop the test leaving
background processes running after the test exits. And if it hangs
here waiting on a hung process, then as a developer using this to
find bugs in my code, I really do want the test to hang hard so I
notice it and can capture the failure and analyse it.

Leaving a warm corpse to post-morten is the desired behaviour of a
failed test.

> >         rm -fr $tmp
> 
> I suppose another patch is going to replace that with the proper _cleanup()?
> Patches from vger have been VERY slowly trickling into my mailbox.

Not in this patch series. When I tackle the generic tests I'll
address these bugs. This patch is just fixing broken ctrl-c
behaviour.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
