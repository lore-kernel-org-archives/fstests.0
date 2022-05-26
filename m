Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD8EC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 23:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346986AbiEZXjz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 May 2022 19:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiEZXjy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 May 2022 19:39:54 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A51039CC91
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 16:39:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5894B52C1E4;
        Fri, 27 May 2022 09:39:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nuN53-00GoEp-VE; Fri, 27 May 2022 09:39:49 +1000
Date:   Fri, 27 May 2022 09:39:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
Message-ID: <20220526233949.GB3923443@dread.disaster.area>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
 <20220524171336.pyoomozstpygnkjt@zlang-mailbox>
 <20220526150417.bw3zpwiqcm5fkysn@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526150417.bw3zpwiqcm5fkysn@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62900fc7
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=u_7UY2rsIc8I6M98PosA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 26, 2022 at 11:04:17PM +0800, Zorro Lang wrote:
> On Wed, May 25, 2022 at 01:13:36AM +0800, Zorro Lang wrote:
> > On Tue, May 24, 2022 at 01:42:15PM +0300, Amir Goldstein wrote:
> > > On Tue, May 24, 2022 at 12:41 PM Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > >
> > > > Use a local cleanup function and _register_cleanup properly.
> > > >
> > > > Remove local cleanups that just do what the standard _cleanup and
> > > > test exist does.
> > > >
> > > > Remove local cleanups that just remove test files and then do
> > > > standard _cleanup functionality.
> > > 
> > > As I mentioned in response to the cover letter, the call to _cleanup()
> > > can and I think should be chained implicitly, but I am still waiting
> > > for your response regarding the tests where generic _cleanup is not
> > > desired.
> > > 
> > > >
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > >  tests/xfs/004     |  7 -------
> > > >  tests/xfs/006     |  7 ++++---
> > 
> > [snap]
> > 
> > > > diff --git a/tests/xfs/006 b/tests/xfs/006
> > > > index cecceaa3..fd8d8071 100755
> > > > --- a/tests/xfs/006
> > > > +++ b/tests/xfs/006
> > > > @@ -11,11 +11,10 @@
> > > >  _begin_fstest auto quick mount eio
> > > >
> > > >  # Override the default cleanup function.
> > > > -_cleanup()
> > > > +_dmerror_cleanup()
> > > >  {
> > > > -       cd /
> > > > -       rm -f $tmp.*
> > > >         _dmerror_cleanup
> > > 
> > > That looks recursive.
> > 
> > Yes, but this _dmerror_cleanup() won't be run. This function will be covered by
> > the _dmerror_cleanup() in common/dmerror, when this case ". ./common/dmerror"
> > several lines later. So the later _cleanup won't be run. So this place and other
> > places similar with this need to change.
> 
> Hi Dave,
> 
> Are you going to fix this issue or making more changes on this patchset?
> If not, I'll merge this patchset tomorrow (Friday) by changing above
> _dmerror_cleanup to _dm_error_cleanup. Then give merged patches a regression
> on Saturday. What do you think?

I posted this patchset as an RFC, not as a candidate for merging.
It's not ready for merging yet.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
